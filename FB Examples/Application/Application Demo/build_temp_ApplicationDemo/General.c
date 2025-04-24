
#import "FBtoC.h"
#import "Runtime.h"

#define kMaxStringLen 255

enum { kMaxStringStackLevel = 64 };

Str255			gFBStrStk[kMaxStringStackLevel];		// string stack
SInt16	        gFBStk;									// index to string stack (for volatile see <http://www.gnu.org/software/autoconf/manual/html_node/Volatile-Objects.html>)
Str255			gReturnedString;						// return value from functions: myStringFn$, PSleft, PSinkey, PSstr...
/*
 Stash for string arguments passed to Toolbox functions.
 Single-level, i.e. doesn't allow nested calls.
 */
Str255		gFBTStk[16];		// toolbox parameter stack;  16 is max #parameters allowed by FBtoC
SInt8		gFBTStkP;

UInt8		gPSDefStrSize = sizeof( SInt32 );		// default defstr long

#if SILENCE_CLANG_WARNINGS
int gPSDefTabStops = 16;                    // default def tab value
#else // SILENCE_CLANG_WARNINGS
UInt8		gPSDefTabStops = 16;					// default def tab value
#endif // SILENCE_CLANG_WARNINGS

Boolean		gFBLeadingSpace = true;
UInt16		gFBPrintPos;							// see PrintStatement
char		gFBUsingSymbols[4] = ".,;$";			// default def using chars
UInt32		gFBNextData;							// support for data/read/restore

#define kMaxGosubLevel  1024
#if USE_SJLJ_FOR_GOSUB_RETURN
jmp_buf gReturnEnv[1024];
#else
UInt16		gReturnLabelNum[kMaxGosubLevel];
#endif
UInt16		gReturnLevel;

#define     kMaxSelectLevel 10
long        gSelectL[kMaxSelectLevel];
double      gSelectD[kMaxSelectLevel];
Str255      gSelectS[kMaxSelectLevel];
CFTypeRef   gSelectCF[kMaxSelectLevel];

OSStatus	gFBSysError;   // for syserror   18-Nov-2007 BW

volatile Boolean  gFBSndBusy; // see Subs Sound.incl //2023-Dec-22 Brian

StringPtr STACK_PUSH( void )
{
    if ( gFBStk >= kMaxStringStackLevel ) {
//        CFStringRef format = CFSTR("Pascal String stack index ( gFBStk ) exceeds string stack size of %d. FBtoC will terminate" );
//        CFStringRef msg    = CFStringCreateWithFormat( kCFAllocatorDefault, 0, format, kMaxStringStackLevel );
        CFStringRef msg = CFStringCreateWithFormat( kCFAllocatorDefault, 0, CFSTR("Pascal String stack index ( gFBStk ) exceeds string stack size of %d. FutureBasic will terminate"), kMaxStringStackLevel );// 20201230 bw

        CFStringRef info   = CFSTR("If 'Source File Combining'( in Build Settings ) is turned OFF, try setting to Medium or Maximum");
        FBFullStop( msg, info, true ); //2023-Dec-22 Brian update to true 
        CFRelease( msg );
    }
    ++gFBStk;
    return gFBStrStk[gFBStk];
}

///////////////////////////////////////////////////////////
//        prototypes           //
///////////////////////////////////////////////////////////

void DebugPrintStackLevel( void );
StringPtr PSstr( const double n );
//StringPtr PSstr( const double n, SInt8 maxDigits );// added second param 20210125 bw
CFStringRef CopyDblToString( const double user_supplied_number );
CFStringRef FBStr( const double user_supplied_number );// 20231222 bw
void	FBKillDynamicArray( const int dynArrayNum );
void	FBGrowDynamicArray( const int dynArrayNum, const long index ); //2023-Nov-15 Brian
void FBSwap( void* p1, void* p2, const int bytes );
StringPtr PScstr( Str255 s );


///////////////////////////////////////////////////////////
//  stringlist localizablity   //
///////////////////////////////////////////////////////////

StringPtr PSltrl( char * inCString, char * commentForGenstrings __attribute__ ((__unused__)) )
{
    /*
     One piece of the localization jigsaw.
     PSltrl() is structured like CFCopyLocalizedString(), so that
     it works with genstrings. For example:
     $ genstrings -macRoman -s PSltrl *.c
     Unlike CFCopyLocalizedString(), it takes a C string key, and
     returns the corresponding (possibly localized) value as a Pascal string.
     */
    static Str255	sReturnedString;
    CFStringRef		key, value;
    
    key = CFStringCreateWithCString( kCFAllocatorDefault, inCString, kCFStringEncodingMacRoman );
    value = CFBundleCopyLocalizedString( CFBundleGetMainBundle(), key, key, NULL );
    CFRelease( key );
    CFStringGetPascalString( value, sReturnedString, 256, kCFStringEncodingMacRoman );
    CFRelease( value );
    return sReturnedString;
}


StringPtr PSltrr( char * inCString, char * commentForGenstrings __attribute__ ((__unused__)) )
{
    static Str255	sReturnedString;
    CFStringRef		key, value;
    
    key = CFStringCreateWithCString( kCFAllocatorDefault, inCString, kCFStringEncodingMacRoman );
    value = CFBundleCopyLocalizedString( CFBundleGetMainBundle(), key, key, CFSTR( "Runtime") );
    CFRelease( key );
    CFStringGetPascalString( value, sReturnedString, 256, kCFStringEncodingMacRoman );
    CFRelease( value );
    return sReturnedString;
}

///////////////////////////////////////////////////////////
//  used if _debugPrintStringStackLevel //
///////////////////////////////////////////////////////////
void DebugPrintStackLevel( void )
{ printf( "gFBStk = %d\n", gFBStk ); }



///////////////////////////////////////////////////////////
//     dynamic array support   //
///////////////////////////////////////////////////////////

#ifndef PAGE_SIZE
#define PAGE_SIZE 4096
#define PAGE_MASK 4095
#endif


DynArrayInfo gFBDynArrayInfo[kMaxNumDynArrays];

void FBKillDynamicArray( const int dynArrayNum ) __attribute__ ((noinline));
void FBKillDynamicArray( const int dynArrayNum )
{
    if ( gFBDynArrayInfo[dynArrayNum].base ) free( gFBDynArrayInfo[dynArrayNum].base );
    gFBDynArrayInfo[dynArrayNum].base = NULL;
    gFBDynArrayInfo[dynArrayNum].maxIndex = 0;
    gFBDynArrayInfo[dynArrayNum].lastElem = -1;
}

//2023-Nov-15 Brian
void FBGrowDynamicArray( const int dynArrayNum, const long index ) __attribute__ ((noinline));
void FBGrowDynamicArray( const int dynArrayNum, const long index )
{
    long ourPageSize = 0, ourPageMask = 0;
    long oldSize;
    
    /*
     Allocate or enlarge a dynamic array.
     Called from FBDynamicArrayRecord() and FBDynamicArray() in ArrayIndices.h  if required.
     */
    
    if ( index < 0 || index == INT_MAX ) { // common mistakes in FB programming
        //2022-Jan-10 Brian
        FBFullStop( (__bridge CFStringRef)[NSString stringWithFormat:@"Bad index value (%ld)\nin FBGrowDynamicArray() (ref %d)\n",index, dynArrayNum], CFSTR(""), true );
        
        /*
         char *buf;
         asprintf( &buf, "Bad index (%d) while growing dynamic array (ref %d)\n", index, dynArrayNum );
         FBFatalRuntimeError( buf );
         */
    }
        
    //long ourPageSize = 0, ourPageMask = 0; //2023-Nov-15 Brian // moved to top of function to suppress clang warning 20250303 bw

    //2023-Nov-15 Brian - Page size on Intel is 4kB but on Apple Silicon it's 16kB
    if ( PAGE_SIZE < LONG_MAX ) ourPageSize = (long)PAGE_SIZE;  // make sure page size and mask aren't too big for the 'long' type
    if ( PAGE_MASK < LONG_MAX ) ourPageMask = (long)PAGE_MASK;
    if ( ourPageSize > 0 && ourPageMask > 0 ) {   // if the page size is
        // make the new size a multiple of the page size (typically 4096 bytes)
        long	 newMaxIndex = ( ( (index + 1)*gFBDynArrayInfo[dynArrayNum].elemSize + ourPageSize ) & ~ourPageMask)/gFBDynArrayInfo[dynArrayNum].elemSize;
        long     newSize		= newMaxIndex*gFBDynArrayInfo[dynArrayNum].elemSize;
        
        if ( gFBDynArrayInfo[dynArrayNum].base == NULL ) {
            
#if SILENCE_CLANG_WARNINGS
            gFBDynArrayInfo[dynArrayNum].base = calloc( 1, (unsigned long)newSize ); // allocate from scratch
#else // SILENCE_CLANG_WARNINGS
            gFBDynArrayInfo[dynArrayNum].base = calloc( 1, newSize ); // allocate from scratch
#endif // SILENCE_CLANG_WARNINGS
            
        } else {
            
#if SILENCE_CLANG_WARNINGS
            gFBDynArrayInfo[dynArrayNum].base = realloc( gFBDynArrayInfo[dynArrayNum].base, (unsigned long)newSize ); // enlarge
#else // SILENCE_CLANG_WARNINGS
            gFBDynArrayInfo[dynArrayNum].base = realloc( gFBDynArrayInfo[dynArrayNum].base, newSize ); // enlarge
#endif // SILENCE_CLANG_WARNINGS

            oldSize = gFBDynArrayInfo[dynArrayNum].maxIndex*gFBDynArrayInfo[dynArrayNum].elemSize;
            
#if SILENCE_CLANG_WARNINGS
            bzero((char *)gFBDynArrayInfo[dynArrayNum].base + oldSize, newSize - oldSize);
#else // SILENCE_CLANG_WARNINGS
            bzero( gFBDynArrayInfo[dynArrayNum].base + oldSize, newSize - oldSize );
#endif // SILENCE_CLANG_WARNINGS

        }
        gFBDynArrayInfo[dynArrayNum].maxIndex = newMaxIndex;
    } else {
        NSString *msg = [NSString stringWithFormat:@"FBGrowDynamicArray() runtime failure\nPAGE_SIZE(%ld) or PAGE_MASK(%ld) is zero\n",ourPageSize, ourPageMask];
        FBFullStop( (__bridge CFStringRef)msg, CFSTR(""), true );
    }
}

#if 1 // CFFILE_OPEN

void FBWriteDynamic( int fileID, int dynArrayNum ) {
    //int        itemSize, nextIndex, size;
    long    itemSize, nextIndex, size; //2023-Nov-15 Brian

    void *    base;
    
    itemSize  = gFBDynArrayInfo[dynArrayNum].elemSize;
    base      = gFBDynArrayInfo[dynArrayNum].base;
    nextIndex = gFBDynArrayInfo[dynArrayNum].lastElem + 1;
    size      = nextIndex*itemSize;
    if ( base ) {
        //FBWriteSwapLong( size, fileID ); //2022-Jan-10 Brian - swap not needed, so just call FBWriteFile() directly.
        //FBWriteFile( fileID, &size, sizeof(UInt32) );
        //======================================================================================
        //2023-Nov-15 Brian
        // When a dynamic array is written to a file, it includes the size of the data in bytes.
        // The size is written first followed by the data in 'base'.
        // This updated code writes the size in the first eight bytes of the file.
        // Formally it was writtn in four bytes ( via the sizeof(UInt32) above )
        //======================================================================================

        FBWriteFile( fileID, &size, sizeof(long), NULL ); //2023-Nov-15 Brian
        FBWriteFile( fileID, base, size, NULL );
    } else {
        NSString *msg = [NSString stringWithFormat:@"FBWriteDynamic() runtime failure\ngFBDynArrayInfo[%d].base is zero\n",dynArrayNum];
        FBFullStop( (__bridge CFStringRef)msg, CFSTR(""), true );
        //FBWriteFile( fileID, &base, 4 );
    }
}
#else // CFFILE_OPEN

void FBWriteDynamic( int fileID, int dynArrayNum ) {
    //int		itemSize, nextIndex, size;
    long    itemSize, nextIndex, size; //2023-Nov-15 Brian

    void *	base;
    
    itemSize  = gFBDynArrayInfo[dynArrayNum].elemSize;
    base      = gFBDynArrayInfo[dynArrayNum].base;
    nextIndex = gFBDynArrayInfo[dynArrayNum].lastElem + 1;
    size      = nextIndex*itemSize;
    if ( base ) {
        //FBWriteSwapLong( size, fileID ); //2022-Jan-10 Brian - swap not needed, so just call FBWriteFile() directly.
        //FBWriteFile( fileID, &size, sizeof(UInt32) );
        //======================================================================================
        //2023-Nov-15 Brian
        // When a dynamic array is written to a file, it includes the size of the data in bytes.
        // The size is written first followed by the data in 'base'.
        // This updated code writes the size in the first eight bytes of the file.
        // Formally it was writtn in four bytes ( via the sizeof(UInt32) above )
        //======================================================================================

        FBWriteFile( fileID, &size, sizeof(long) ); //2023-Nov-15 Brian
        FBWriteFile( fileID, base, size );
    } else {
        NSString *msg = [NSString stringWithFormat:@"FBWriteDynamic() runtime failure\ngFBDynArrayInfo[%d].base is zero\n",dynArrayNum];
        FBFullStop( (__bridge CFStringRef)msg, CFSTR(""), true );
        //FBWriteFile( fileID, &base, 4 );
    }
}

#endif // CFFILE_OPEN


void FBReadDynamic( int fileID, int dynArrayNum ) {
    //int		itemSize, itemCount, size;
    long    itemSize, itemCount, size; //2023-Nov-15 Brian
    void *	base;
    
    itemSize = gFBDynArrayInfo[dynArrayNum].elemSize;
    base     = gFBDynArrayInfo[dynArrayNum].base;
    if ( base ) { free( base ); }
    
#if SILENCE_CLANG_WARNINGS
    size     = FBReadSwapLong( (unsigned int)fileID );
    base     = (void*)( malloc( (unsigned long)size ) );
    FBReadFile( fileID, base, false, (UInt64)size );
#else // SILENCE_CLANG_WARNINGS
    size     = FBReadSwapLong( fileID );
    base     = (void*)( malloc( size ) );
    FBReadFile( fileID, base, false, size );
#endif // SILENCE_CLANG_WARNINGS

    if ( size % itemSize ) {
        //FBStopMsg( PSstrcpy( TO_STACK, PSltrr ( "read dynamic: array element size does not match target", "FBReadDynamic" ) ), 0 );
        CFStringRef e1 = CFStringCreateCopy( NULL, CFSTR( "READ DYNAMIC: array element size does not match target" ) );
        CFStringRef e2 = CFStringCreateCopy( NULL, CFSTR( "Was the file created with WRITE DYNAMIC?" ) );
        FBFullStop( e1, e2, false );
        CFRelease( e1 );
        CFRelease( e2 );
        free( base );
    } else {
        itemCount = size/itemSize;
        gFBDynArrayInfo[dynArrayNum].base = base;
        gFBDynArrayInfo[dynArrayNum].maxIndex = itemCount;
        gFBDynArrayInfo[dynArrayNum].lastElem = itemCount - 1;
    }
}




///////////////////////////////////////////////////////////
//  swap                       //
///////////////////////////////////////////////////////////

void FBSwap( void* p1, void* p2, const int bytes ) __attribute__ ((noinline));
void FBSwap( void* p1, void* p2, const int bytes )
{
    UInt8	swap1;
    UInt16	swap2;
    UInt32	swap4;
    UInt64	swap8;
    char	buffer[256];
    void*	tmp;
    
    switch ( bytes ) {
        case 1  : swap1 = *(UInt8*)p1;  *(UInt8*)p1 =  *(UInt8*)p2;  *(UInt8*)p2  = swap1; break;
        case 2  : swap2 = *(UInt16*)p1; *(UInt16*)p1 = *(UInt16*)p2; *(UInt16*)p2 = swap2; break;
        case 4  : swap4 = *(UInt32*)p1; *(UInt32*)p1 = *(UInt32*)p2; *(UInt32*)p2 = swap4; break;
        case 8  : swap8 = *(UInt64*)p1; *(UInt64*)p1 = *(UInt64*)p2; *(UInt64*)p2 = swap8; break;
        default :
            if ( bytes <= 256) 	{ // faster than malloc and will cover most cases
                memmove( &buffer, p1, bytes );  // Brian 01-August-2014
                memmove( p1, p2, bytes );  // Brian 01-August-2014
                memmove( p2, &buffer, bytes );  // Brian 01-August-2014
            } else {
                
#if SILENCE_CLANG_WARNINGS
                tmp = malloc( (unsigned long)bytes );
#else // SILENCE_CLANG_WARNINGS
                tmp = malloc( bytes );
#endif // SILENCE_CLANG_WARNINGS
                
                memmove( tmp, p1, bytes );  // Brian 01-August-2014
                memmove( p1, p2, bytes );  // Brian 01-August-2014
                memmove( p2, tmp, bytes );  // Brian 01-August-2014
                free( tmp );
            }
    }
}



///////////////////////////////////////////////////////////
// C string <-> Pascal string  //
///////////////////////////////////////////////////////////

StringPtr PScstr( Str255 s ) __attribute__ ((noinline));
StringPtr PScstr( Str255 s )
{
    //Convert Pascal to C string, in place
    UInt8	len, k = 0;
    
    len = s[0];
    while ( k < len && k < kMaxStringLen ) {
        s[k] = s[k + 1];
        if( s[k] == 0 )  s[k] = 1;
        k++;
    }
    s[k] = 0; // 0-terminate
    return s;
}

//Convert C to Pascal string, in place
StringPtr CSpstr( char * s ) __attribute__ ((noinline));
StringPtr CSpstr( char * s )
{
#if SILENCE_CLANG_WARNINGS
    size_t len = strlen( s );
    size_t k = 0;
#else // SILENCE_CLANG_WARNINGS
    UInt8	len = strlen( s );
    UInt8	k = 0;
#endif // SILENCE_CLANG_WARNINGS
    
    if ( len >= kMaxStringLen ) len = kMaxStringLen;
    k = len;
    while ( k > 0 ) {
        s[k] = s[k - 1];
        k--;
    }
    
#if SILENCE_CLANG_WARNINGS
    s[0] = (char)len;
#else // SILENCE_CLANG_WARNINGS
    s[0] = len;
#endif // SILENCE_CLANG_WARNINGS

    return (StringPtr)s;
}


///////////////////////////////////////////////////////////////
//   functions that return a StringPtr to Pascal FB string   //
///////////////////////////////////////////////////////////////

StringPtr PSstrcpy ( StringPtr dest, ConstStr255Param source )
{
    memmove( dest, &source[0], source[0] + 1 );  // Brian 01-August-2014
    return dest;
}


StringPtr PSstrcat( StringPtr dest, ConstStr255Param appendStr)
{
    
#if SILENCE_CLANG_WARNINGS
    unsigned char destSize = *(unsigned char*)dest;
    unsigned char appendSize = appendStr[0];
#else // SILENCE_CLANG_WARNINGS
    SInt16 destSize = *(unsigned char*)dest;
    SInt16 appendSize = appendStr[0];
#endif // SILENCE_CLANG_WARNINGS
    
    StringPtr         origDestPtr = dest;
    
    if ( destSize + appendSize > 255 ) {
        appendSize = 255 - destSize;
    }
    *(unsigned char*)dest = destSize + appendSize;
    dest += destSize + 1;
    memmove( dest, &appendStr[1], appendSize );  // Brian 01-August-2014
    return (origDestPtr );
}


// size-limited form of PSstrcpy()
#if SILENCE_CLANG_WARNINGS

StringPtr PSstrcpyn( StringPtr dest, ConstStr255Param source, const unsigned char destSize ) __attribute__ ((noinline));
StringPtr PSstrcpyn( StringPtr dest, ConstStr255Param source, const unsigned char destSize )
{
    unsigned char   charsToCopy = *source;
    unsigned char * origDestAddr = dest;
    
    if ( charsToCopy > destSize - 1 ) { charsToCopy = destSize - 1; }
    *dest = charsToCopy;
    while ( charsToCopy ) {
        *(++dest) = *(++source);
        charsToCopy--;
    }
    return origDestAddr;
}

#else // SILENCE_CLANG_WARNINGS

StringPtr PSstrcpyn( StringPtr dest, ConstStr255Param source, const int destSize ) __attribute__ ((noinline));
StringPtr PSstrcpyn( StringPtr dest, ConstStr255Param source, const int destSize )
{
    unsigned char   charsToCopy = *source;
    unsigned char * origDestAddr = dest;
    
    if ( charsToCopy > destSize - 1 ) { charsToCopy = destSize - 1; }
    *dest = charsToCopy;
    while ( charsToCopy ) {
        *(++dest) = *(++source);
        charsToCopy--;
    }
    return origDestAddr;
}

#endif // SILENCE_CLANG_WARNINGS


// size-limited form of PLstrcat

#if SILENCE_CLANG_WARNINGS

StringPtr PSstrcatn( StringPtr dest, ConstStr255Param source, const unsigned char destSize ) __attribute__ ((noinline));
StringPtr PSstrcatn( StringPtr dest, ConstStr255Param source, const unsigned char destSize )
{
    unsigned char   charsToCopy;
    unsigned char * origDestAddr = dest;
    
    charsToCopy = *source;
    if ( charsToCopy > destSize - *dest - 1 ) { charsToCopy = destSize - *dest - 1; }
    dest += *dest;                    // so we append at end of existing dest string
    *origDestAddr += charsToCopy;    // length of result
    while ( charsToCopy ) {
        *(++dest) = *(++source);
        charsToCopy--;
    }
    return origDestAddr;
}

#else // SILENCE_CLANG_WARNINGS

StringPtr PSstrcatn( StringPtr dest, ConstStr255Param source, const int destSize ) __attribute__ ((noinline));
StringPtr PSstrcatn( StringPtr dest, ConstStr255Param source, const int destSize )
{
    unsigned char   charsToCopy;
    unsigned char * origDestAddr = dest;
    
    charsToCopy = *source;
    if ( charsToCopy > destSize - *dest - 1 ) { charsToCopy = destSize - *dest - 1; }
    dest += *dest;					// so we append at end of existing dest string
    *origDestAddr += charsToCopy;	// length of result
    while ( charsToCopy ) {
        *(++dest) = *(++source);
        charsToCopy--;
    }
    return origDestAddr;
}

#endif // SILENCE_CLANG_WARNINGS

void PSdeftab( const int tabstops )
{
    //def tab [=] value
    if ( tabstops < 1 ) {
        gPSDefTabStops = 1;
    } else if ( tabstops > 255 ) {
        gPSDefTabStops = 255;
    } else {
        gPSDefTabStops = tabstops;
    }
}


//def using [=] long
//Bugs: - Possible endian issues
void FBDefUsing( const SInt32 formatchars)
{
    int j;
    UInt8 *address;
    address = (UInt8*)&formatchars ;
    for ( j = 0; j < 4; j++ ) {
        gFBUsingSymbols[j] = *(address++);
    }
}


/*
 using formatstring; number
 
 Bugs:
 - Preserved FB's mysterious decision to do using "-$###.##";12.4 as $-12.40 instead of -$12.40
 - dvalue = 123456.789: print using "-#-#,##,##.##"; dvalue is  1-2,34,56.79 here but -1-2,34,56.79 in FB: latter "fixed" instead of obeyed
 - Differs from FB in output where DEF USING has been used, but Robin says this is right and FB is wrong.
 E.g. with DEF USING _"^!;&"
 Format                        FB            C            Comment
 USING "$***.##"; 12.34        $*12^34        &*12^34        FB is not honouring user-set currency symbol with * format
 USING "$###";12345            $???        &???        FB ignores localisation settings when errors
 USING "+##.#";1234.5        +??.?        +??^?        Ditto
 */
StringPtr PSusing( Str255 format, const double n )
{
    Str255	result;
    short	fdecimal = 0, ndecimal, npos, fpos, fdigits = 0, ndigits = 0, decimalplaces = 0, isign = 0, idollar = 0;
    short	fmtlen = format[0], chars, j, xpos, fexp, nexp = 0, fexchars = 0, nexchars = 0;
    Boolean	negative = false, scientific = false;
    double	num, rounded, multiplier, divisor = 1.0, power;
    char	fillchar = ' ', xchar = 0, formatchar;
    char	buffer[256];
    char	localcurrency = gFBUsingSymbols[3], thousandschar = gFBUsingSymbols[1];
    char	decimalchar = gFBUsingSymbols[0];
    
    gFBStk--;

    if ( copysign( 1.0, n ) < 0.0 ) {
        negative = true;
        num = -n;
    } else {
        num = n;
    }
    
    // -------------------------------------------------------------------------
    // Find the decimal point and the number of integer digits & decimal places:
    
    for ( j = 1; j <= fmtlen; j++ ) {
        formatchar = format[j];
        if ( formatchar == '.' ) {
            if ( fdecimal == 0 ) fdecimal = j;
        } else if ( formatchar == '#' || formatchar == '*' ) {
            if ( fdecimal > 0 ) decimalplaces++; else fdigits++;
        }
    }
    if ( fdecimal == 0 ) fdecimal = fmtlen + 1;
    
    // ----------------------------------------------------
    // Sort out the interaction between $, +/- and # vs * formats:
    // FB does +$ and -$ same as $- and $+, e.g. $-123.45 (a poor decision?) - but only for '#' not '*' format strings.
    // It also shifts $ and sign to abut digits, again for '#' but not '*'
    
    // First, find out if it's a # or * format, and get position of $/sign special chars, & swap latter if required.
    // We assume some degree of sense and just accept the first # or * found:
    
    for ( j = 1; j <= fmtlen; j++ ) {
        switch( format[j] ) {
            case '#':
                j = fmtlen;
                break;
            case '*':
                fillchar = '*';
                j = fmtlen;
                break;
            case '$':
                if ( idollar == 0 ) idollar = j;
                break;
            case '+':
                if ( isign == 0 ) isign = j;
                break;
            case '-':
                if ( isign == 0 ) isign = j;
                break;
#if SILENCE_CLANG_WARNINGS
            default:
                break;
#endif // SILENCE_CLANG_WARNINGS
        }
    }
    
    //---------------------
    //Now do the formatting:
    
    if ( format[fmtlen] == '^' ) {
        scientific = true;
        if (num > 0.0 ) {
            power = log10( num );
            power = floor( power );
            divisor = pow( 10.0, power);
            num = num/divisor;
        }
        fexp = fmtlen;
        while ( format[fexp-1] == '^' ) fexp--;
        fexchars = fmtlen - fexp + 1;
    } else {
        fexp = fmtlen + 1;
    }
    
    // If n's precision exceeds number of formatted decimals we'll get wrong answer unless we round to desired precision first:
    
    multiplier = pow( 10.0, decimalplaces );
    rounded = rint( num * multiplier );
    num = rounded / multiplier;
    
    // Though rounded, we still have to force minimum decimals in sprintf to ensure we have all the digits requested:
    if ( !scientific ) {
        chars = sprintf( buffer, "%.*f", decimalplaces, num );
        nexp = chars + 1;
    } else {
        num = num * divisor;
        chars = sprintf( buffer, "%.*E" , decimalplaces, num );
        for ( j = 0; j < chars; j++ ) {
            if ( buffer[j] == 'E' ) {
                nexp = j;
                break;
            }
        }
        nexchars = chars - nexp;
    }
    
    // Find the decimal point in preliminary formatted number:
    if ( decimalplaces == 0  ) ndecimal = chars; else ndecimal = chars + 1;
    for ( j = 0; j < chars; j++ ) {
        if ( buffer[j] == '.' ) {
            ndecimal = j;
            break;
        } else {
            ndigits++;
        }
    }
    
    // Adjust formatting according to exceptions:
    if ( ndigits > fdigits )	{										// if overflow, don't suppress - if +ve (this is what FB does{
        isign = 0;
    } else if ( fillchar == ' ' && !scientific ) {
        if ( idollar == 2 && isign == 1 ) {								// fix ordering: FB always does dollar then +/- with # formats
            isign = 2;
            idollar = 1;
            format[isign] = format[idollar];
            format[idollar] = '$';
        } else if ( isign == 0 && negative ) {						// FB shows sign if it can
            isign = idollar + 1;
            format[isign] = '-';
        }
    } else {														// *** or scientific format
        if ( isign == 0 && negative ) format[idollar + 1] = '?';		// another FB idiosyncracy
    }
    
    // Now fill the integer part of the format string, backwards from decimal:
    npos	= ndecimal - 1;
    fpos	= fdecimal - 1;
    while( fpos > 0 ) {
        formatchar = format[fpos];
        if ( formatchar == '#' || formatchar == '*' )	{ // digit placement
            if ( ndigits <= fdigits ) {
                if ( npos >= 0 ) result[fpos] = buffer[npos]; else result[fpos] = fillchar;
            } else {
                result[fpos] = '?';
            }
            npos--;
        } else if ( formatchar == ',' ) {
            if ( npos >= 0 ) result[fpos] = thousandschar; else result[fpos] = fillchar;
        } else if ( fpos == isign || fpos == idollar ) {
            switch ( formatchar ) {
                case '+':
                    if ( negative ) xchar = '-'; else xchar = '+';
                    break;
                case '-':
                    if ( !negative ) {
                        xchar = ' ';
                    } else if ( npos >= 0 ) {	// possible if result is -ve but no - in original format string
                        xchar = '?';
                        npos--;
                    } else {
                        xchar = '-';
                    }
                    break;
                case '$':
                    xchar = localcurrency;
#if SILENCE_CLANG_WARNINGS
                    break;
                default:
                    break;
#endif // SILENCE_CLANG_WARNINGS
            }
            if ( fillchar == ' ' )	{	// move to abut numerals if there's space before them
                xpos = fpos;
                while ( result[xpos + 1] == ' ' ) xpos++;
                if ( xpos > fpos) {
                    result[xpos] = xchar;
                    xchar = ' ';
                }
            }
            result[fpos] = xchar;
        } else {					// put in whatever the user wants
            result[fpos] = format[fpos];
        }
        
        fpos--;
    }					// end of digit insertion ( left of decimal)
    
    
    if ( fdecimal <= fmtlen ) {	// show decimals
        result[fdecimal] = decimalchar;		// internationalise
        fpos = fdecimal + 1;
        npos = ndecimal + 1;
        
        while ( fpos <= fmtlen ) {
            formatchar = format[fpos];
            if ( formatchar == '#' || formatchar == '*' ) {
                if ( ndigits > fdigits ) {
                    result[fpos] = '?';
                } else if ( npos < nexp ) {
                    result[fpos] = buffer[npos];
                    npos++;
                } else {
                    result[fpos] = '0';
                }
            } else if ( fpos >= fexp ) {
                if ( fpos <= fexp + 1 || fexchars == nexchars ) {
                    result[fpos] = buffer[npos];
                    npos++;
                } else if ( fexchars > nexchars ) {			// exponent needs leading zeroes
                    result[fpos] = '0';
                    nexchars++;
                } else {								// fexchars < nexchars: strip any leading zeroes from latter if can
                    while ( buffer[npos] == '0' && nexchars > fexchars ) {
                        npos++;
                        nexchars--;
                    }
                    result[fpos] = buffer[npos];
                    npos++;
                }
            }
            else if ( formatchar == '.' ) {			// FB replaces extra "decimals" with DEF USING setting too
                result[fpos] = decimalchar;
            } else {
                result[fpos] = formatchar;
            }
            fpos++;
        }
    }
    result[0] = fmtlen;
    
    return PSstrcpy( gReturnedString, result );
}

CFStringRef CFUsing( CFStringRef format, double n )// 20210131 bw
{
    Str255 s;
    StringPtr pString;
    NSString *outString;
    
    CFStringGetPascalString( format, (void *)&s, 256, kCFStringEncodingMacRoman );
    pString = PSusing( s, n );
#if SILENCE_CLANG_WARNINGS
    outString = [NSString stringWithFormat:(NSString *)@"%.*s", pString[0], &pString[1]];
#else // SILENCE_CLANG_WARNINGS
    outString = [NSString stringWithFormat:@"%.*s",pString[0],&pString[1]];
#endif // SILENCE_CLANG_WARNINGS
    return (__bridge CFStringRef)outString;
}

// left$( s, n )
StringPtr PSleft( ConstStr255Param s, SInt16 n ) __attribute__ ((noinline));
StringPtr PSleft( ConstStr255Param s, SInt16 n )
{
    gFBStk--;
    if ( n < 0 ) n = 0;
    if ( n > s[0] ) n = s[0];
    memmove( &gReturnedString[1], &s[1], n );  // Brian 01-August-2014( replaced BlockMoveData )
    gReturnedString[0] = n;
    return gReturnedString;
}

// right$( s, n )
StringPtr PSright( ConstStr255Param s, SInt16 n ) __attribute__ ((noinline));
StringPtr PSright( ConstStr255Param s, SInt16 n )
{
    SInt16 len = s[0];
    
    gFBStk--;
    if ( n < 0 ) n = 0;
    if ( n > len ) n = len;
    //BlockMoveData( &s[1 + len - n], &gReturnedString[1], n );
    memmove( &gReturnedString[1], &s[1 + len - n], n );  // Brian 01-August-2014
    gReturnedString[0] = n;
    return gReturnedString;
}

// Now honors a numChars value equal to zero instead of returning the
// entire string-- Brian 20151113
//

//mid$( s, p, n )  (string, startpos, number)
StringPtr PSmid( ConstStr255Param string, SInt16 startPos, SInt16 numChars ) __attribute__ ((noinline));
StringPtr PSmid( ConstStr255Param string, SInt16 startPos, SInt16 numChars )
{
    SInt16 len = string[0];
    
    gFBStk--;
    if ( numChars < 0 ) numChars = 0;
    if ( numChars > len ) numChars = len;                   // if numChars > len string use len of string
    if ( startPos < 1 ) {
        startPos = 1;										// treat startPos < 1 as 1
    } else if ( startPos > len || numChars == 0 ) {			// startPos is > length of string OR numChars equal zero - return null string
        gReturnedString[0] = 0;
        return gReturnedString;
    } else if ( len + 1 - startPos < numChars ) {  		    // if startPos + numChars is > len of string go from startPos to end of string
        numChars = len - startPos + 1;
    }
    //BlockMoveData( &string[startPos], &gReturnedString[1], numChars );
    memmove( &gReturnedString[1], &string[startPos], numChars );  // Brian 01-August-2014
    gReturnedString[0] = numChars;
    return gReturnedString;
}

extern SInt8 gFBUpperChar[256];

StringPtr PSucase( ConstStr255Param  s )
{
    // ucase$( s )
    
    unsigned char * outAddr;
    unsigned char   len;
    
    gFBStk--;
    outAddr = gReturnedString;
    len = *s;
    *outAddr = len;
    while ( len ) {
        *(++outAddr) = gFBUpperChar[*(++s)];
        len--;
    }
    return gReturnedString;
}


StringPtr PSstring( SInt16 n, UInt8 theChar )
{
    // string$( n, theChar )    also used for chr$ and space$
    
    if ( n < 0  || n > kMaxStringLen )  n = 0;
    gReturnedString[0] = n;
    while ( n ) {
        gReturnedString[n--] = theChar;
    }
    return gReturnedString;
}

StringPtr PSstringstr( SInt16 n, ConstStr255Param s )
{
    //	 string$( n, theStr$ )
    
    gFBStk--;
    if ( n < 0  || n > kMaxStringLen )  n = 0;
    gReturnedString[0] = n;
    while ( n ) {
        gReturnedString[n--] = s[1];
    }
    return gReturnedString;
}


StringPtr PSstrampersand( Handle h, int index )
{
    //str&( h, index )
    
    int offset = 2, nElements = 0;
    
    gReturnedString[0] = 0;
    if ( h ) {
        nElements =  *(short*)(*h);
        //		nElements = CFSwapInt32BigToHost( nElements );// :rdp:20101213
        if ( index <= nElements) {
            while ( index-- > 1 ) {
                offset += 1 + *(unsigned char*)(*h + offset);
            }
            PSstrcpy ( gReturnedString, (ConstStr255Param)(*h + offset) );
        }
    }
    return gReturnedString;
}


StringPtr PSstrhash( const int resID, const int index  )
{
    //str#( resID, index )
    return PSstrampersand( GetResource( 'STR#', resID ), index );
}




// PSinput is used for FB's unix tool support
void PSinput( StringPtr s )
{
    //input  (if executable is run as Terminal command)
    s[0] = 0;
    if ( NULL != fgets( (char*)s, 256, stdin ) ) {
        CSpstr( (char*)s );
        if ( s[0] && s[s[0]] == 10 ) s[0]--; // strip lf
    }
}


StringPtr PSpstr( StringPtr p )
{
    //pstr$( p )
    return PSstrcpy( gReturnedString, p );
}


/*
 was CFStringRef GetFormattedDateTimeAsString( CFAbsoluteTime  at, CFStringRef formatStr )
 Replacement for PSdate
 */
CFStringRef DateFormatCreateStringWithAbsoluteTime( CFStringRef formatStr, CFAbsoluteTime at )
{
    CFStringRef outStr;
    CFLocaleRef locale = CFLocaleCopyCurrent();
    CFDateFormatterRef formatter = CFDateFormatterCreate( kCFAllocatorDefault, locale, kCFDateFormatterShortStyle, kCFDateFormatterNoStyle );
    CFRelease( locale );
    CFDateFormatterSetFormat( formatter, formatStr );
    outStr = CFDateFormatterCreateStringWithAbsoluteTime( kCFAllocatorDefault, formatter, at );
    CFRelease( formatter );
    return outStr;
}

/*
 Replacement for PStime
 */
StringPtr PSdatePStime( ConstStr255Param inPString)
{
    Str255	outPString = "\p";
    CFStringRef formatStr = CFStringCreateWithPascalString( kCFAllocatorDefault, inPString, kCFStringEncodingMacRoman );
    CFStringRef string = DateFormatCreateStringWithAbsoluteTime( formatStr, CFAbsoluteTimeGetCurrent() );
    CFRelease( formatStr );
    
    gFBStk--;
    CFStringGetPascalString( string, outPString, 256, kCFStringEncodingMacRoman );
    CFRelease( string );
    return PSstrcpy( gReturnedString, outPString );
}

CFStringRef DateCFString( CFStringRef formatStr )
{
    if ( !formatStr ) formatStr = CFSTR("");    // 20180731 bw
#if __has_feature(objc_arc)
    if ( CFStringGetLength( formatStr) ) {
        return DateFormatCreateStringWithAbsoluteTime( formatStr, CFAbsoluteTimeGetCurrent() );
    } else {
        return DateFormatCreateStringWithAbsoluteTime( CFSTR("MM/dd/yy"), CFAbsoluteTimeGetCurrent() );
    }
#else
    if ( CFStringGetLength( formatStr) ) {
        return (__bridge CFStringRef)[(__bridge NSString *)DateFormatCreateStringWithAbsoluteTime( formatStr, CFAbsoluteTimeGetCurrent() ) autorelease];
    } else {
        return (__bridge CFStringRef)[(__bridge NSString *)DateFormatCreateStringWithAbsoluteTime( CFSTR("MM/dd/yy"), CFAbsoluteTimeGetCurrent() ) autorelease];
    }
#endif
}

CFStringRef TimeCFString( CFStringRef formatStr )
{
    if ( !formatStr ) formatStr = CFSTR("");    // 20180731 bw
#if __has_feature(objc_arc)
    if ( CFStringGetLength( formatStr) ) {
        return DateFormatCreateStringWithAbsoluteTime( formatStr, CFAbsoluteTimeGetCurrent() );
    } else {
        return DateFormatCreateStringWithAbsoluteTime( CFSTR("HH:mm:ss"), CFAbsoluteTimeGetCurrent() );
    }
#else
    if ( CFStringGetLength( formatStr) ) {
        return (__bridge CFStringRef)[(__bridge NSString *)DateFormatCreateStringWithAbsoluteTime( formatStr, CFAbsoluteTimeGetCurrent() ) autorelease];
    } else {
        return (__bridge CFStringRef)[(__bridge NSString *)DateFormatCreateStringWithAbsoluteTime( CFSTR("HH:mm:ss"), CFAbsoluteTimeGetCurrent() ) autorelease];
    }
#endif
}

// InString(), LeftString(), RightString() and MidString() are copied from FB's translator source ( String & Char Utilities )
/*
 fn LeftString, fn RightString, fn MidString and fn InString are CFString replacements for
 FB's LEFT, RIGHT, MID and INSTR.
 20141120 Brian
 
 left$ & right$
 If numChars is less than or equal to zero, an empty string is returned.
 
 mid$
 if startPos is less than 1, it is set to 1 (0 for our CF functions)
 if numChars is less than or equal to zero, it is set to the length of the string.
 
 instr
 if startPos is less than 1, it is set to 1 (0 for our CF functions)
 */


//
// N.B.  Returning a ZERO position is a valid value and different from FB's INSTR which returns zero for not found. CFStrings start at position zero.
//       By comparison, pascal strings start at position one ( with position zero the length byte ).
//       Use of this function to replace FB's INSTR should be checked to make sure the logic does not rely on a zero return for not found.
//       This INSTR replacement returns NSNotFound for not found. NSNotFound can be different values depending on where it runs
//       Brian 20151011

//2023-Jul-18 Brian
SInt64 InString(  NSInteger startPos,  CFStringRef strToSearch, CFStringRef strToSearchFor, NSInteger searchOptions )
{
    NSRange myRange, inRange;
    SInt64 returnPos = NSNotFound;
    NSInteger hayStackLen = [(__bridge NSString*)strToSearch length];
    NSInteger needleLen = [(__bridge NSString*)strToSearchFor length];
    
    if ( searchOptions == kFBParamMissing ) searchOptions = NSLiteralSearch;
    
    if ( searchOptions & NSBackwardsSearch ) {
        if ( startPos < 0 || startPos >= hayStackLen ) startPos = hayStackLen - 1;
        myRange = NSMakeRange( 0, startPos + 1 );
    } else {
        if ( startPos < 0 ) startPos = 0;
        myRange = NSMakeRange( startPos, hayStackLen - startPos );
    }

    if ( startPos < hayStackLen && hayStackLen && needleLen ) {
        if ( searchOptions == kFBParamMissing ) searchOptions = NSLiteralSearch;
        inRange = [(__bridge NSString *)strToSearch rangeOfString:(__bridge NSString *)strToSearchFor options:searchOptions range:myRange];
        returnPos = inRange.location;
    }
    return returnPos;
}

CFStringRef RightString( CFStringRef inString, CFIndex howManyChars ) {
    
    CFStringRef s = CFSTR("");
    
    if ( howManyChars > 0 ) {
        NSInteger length = [(__bridge NSString*)inString length];
        if ( howManyChars > length ) howManyChars = length;
        s = (__bridge CFStringRef)[(__bridge NSString *)inString substringFromIndex:length - howManyChars];
    }
    return s;
}

CFStringRef LeftString( CFStringRef inString, CFIndex toIndex ) {
    
    CFStringRef s = CFSTR("");
    
    if ( toIndex > 0 ) {
        NSInteger length = [(__bridge NSString *)inString length];
        if ( toIndex > length ) toIndex = length;
        s = (__bridge CFStringRef)[(__bridge NSString *)inString substringToIndex:toIndex];
    }
    return s;
}

CFStringRef MidString( CFStringRef inString , CFIndex startPos, CFIndex howManyChars ) {
    CFStringRef s = CFSTR("");
    NSInteger length = [(__bridge NSString*)inString length];
    if ( startPos < 0 ) startPos = 0;
    if ( howManyChars < 0 ) howManyChars = length - startPos;
    if ( startPos < length ) {
        if ( startPos + howManyChars > length ) howManyChars = length - startPos;
        s = (__bridge CFStringRef)[(__bridge NSString *)inString substringWithRange: NSMakeRange( startPos, howManyChars )];
    }
    return s;
}

// mid( string, startPos, numChars ) = repString
// MidStatementCF( string, startPos, numChars, repString )
//void MidStatementCF( CFMutableStringRef inString, CFIndex startPos, CFIndex numChars, CFStringRef repString )
//{
//    if ( startPos < 0 ) return;// 20220712 bw
//    
//    NSString *string = (__bridge NSString *)inString;
//    NSString *replaceString = (__bridge NSString *)repString;
//    
//    CFIndex stringLength = [string length];
//    CFIndex replaceStringLength = [replaceString length];
//
//    if ( stringLength < 1 || replaceStringLength < 1 ) return;
//    if ( startPos >= stringLength ) return;
//    
//    if ( numChars > replaceStringLength ) numChars = replaceStringLength;
//    if ( (startPos + numChars) > stringLength ) numChars = stringLength - startPos;
//    if ( numChars < 1 ) return;
//
//    NSString *s1 = [string substringToIndex:startPos];
//    NSString *s2 = [replaceString substringToIndex:numChars];
//    NSString *s3 = [string substringFromIndex:startPos+numChars];
//    NSString *result = [NSString stringWithFormat:@"%@%@%@",s1,s2,s3];
//    
//    [(__bridge NSMutableString *)inString setString:result];
//}

void MidStatementCFString( CFMutableStringRef inString, NSInteger startPos, NSInteger numChars, CFStringRef inReplaceString )
{
    NSString *string, *replaceString, *s1, *s2, *s3, *result;
    CFIndex stringLength, replaceStringLength;
    
    if ( startPos < 0 ) return;
    
    string = (__bridge NSString *)inString;
    replaceString = (__bridge NSString *)inReplaceString;
    stringLength = [string length];
    replaceStringLength = [replaceString length];

    if ( stringLength < 1 || replaceStringLength < 1 ) return;
    if ( startPos >= stringLength ) return;
    
    if ( numChars > replaceStringLength ) numChars = replaceStringLength;
    if ( (startPos + numChars) > stringLength ) numChars = stringLength - startPos;
    if ( numChars < 1 ) return;

    s1 = [string substringToIndex:startPos];
    s2 = [replaceString substringToIndex:numChars];
    s3 = [string substringFromIndex:startPos+numChars];
    result = [NSString stringWithFormat:@"%@%@%@",s1,s2,s3];
    
    [(__bridge NSMutableString *)inString setString:result];
 }

//void MidStatementCFArray( CFMutableArrayRef inObj, NSInteger index, NSInteger length, CFTypeRef inRepObj )
//{
//    NSMutableArray *obj = (__bridge NSMutableArray *)inObj;
//    id repObj = (__bridge id)inRepObj;
//    
//    NSInteger count = [obj count];
//    if ( index < count ) {
//        if ( length != kFBParamMissing && CFGetTypeID(inRepObj) == CFArrayGetTypeID() ) {
//            NSInteger maxIndex = index + length - 1;
//            for ( id object in repObj ) {
//                obj[index] = object;
//                index++;
//                if ( index >= count || index > maxIndex ) break;
//            }
//        } else {
//            obj[index] = repObj;
//        }
//    }
//}
//
//void MidStatementCFDict( CFMutableDictionaryRef inObj, CFTypeRef inKey, CFTypeRef inRepObj )
//{
//    NSMutableDictionary *obj = (__bridge NSMutableDictionary *)inObj;
//    NSString *key = (__bridge NSString *)inKey;
//    id repObj = (__bridge id)inRepObj;
//    obj[key] = repObj;
//}


// Note: used by FBtoC source but FBtoC still generates calls to old PSHex() function
// Replacement for FB's hex$ - Brian 20160617
CFStringRef HexString( long num )
{
    UInt8 padLength;

    NSMutableString *hexStr = [NSMutableString stringWithCapacity:0];
    [hexStr appendFormat:@"%lX",num];// 20230901 bw

    padLength = gPSDefStrSize * 2; // honor the user defstr setting
    
    // Size returned string based on user defstr setting
    if ( num < 0 ) {
        [hexStr setString:(__bridge NSString *)RightString( (__bridge CFStringRef)hexStr, padLength )];
    } else {
        
        short length = [hexStr length];
        if ( length > padLength ) { // truncate to padLength
            [hexStr setString:(__bridge NSString *)RightString( (__bridge CFStringRef)hexStr, padLength )];
        } else {  // pre-pend leading zeros
            for ( ; length < padLength ; length++) {
                [hexStr insertString:@"0" atIndex:0];
            }
        }
    }
    return (__bridge CFStringRef)hexStr;
}

// Brian 20200710 - CF replacment for FB's pascal-based bin$
CFStringRef BinString( long theBytes )
{
    int k = 0, size = gPSDefStrSize * 8;    // pick up defstr byte, defstr word, defstr short, defstr int, defstr long setting
    char *aCh=(char*)malloc( size + 1 );  // add 1 for null terminator
    while( size-- ) {
        aCh[k] = '0' + ( ( theBytes >> size ) & 1);
        k++;
    }
    aCh[k] = '\0';    // end of string terminator
    CFStringRef s;
    s = (__bridge CFStringRef)[NSString stringWithCString:(char *)aCh
                                                    encoding:NSMacOSRomanStringEncoding];
    free( aCh );
    
    return s;
}

// rewritten to allow long (8 byte) integers 20230106 bw
CFStringRef OctString( long theBytes )
{
    int size;
    switch ( gPSDefStrSize ) {
        case 1:
            size = 3;
            break;
        case 2:
            size = 6;
            break;
        case 8:// currently no different to the old 'long' 4-byte // 20230116 bw
        case 4:
        default:
            size = 11;
            break;
    }
    return (__bridge CFStringRef)[NSString stringWithFormat:@"%.*lo",size,theBytes];
}

CFStringRef SpaceCFString( long length )// 20210123 bw
{ return (__bridge CFStringRef)[@"" stringByPaddingToLength:length withString:@" " startingAtIndex:0]; }

CFStringRef LcaseCFString( CFStringRef string )// 20210123 bw
{ return (__bridge CFStringRef)[(__bridge NSString *)string lowercaseString]; }

CFStringRef UcaseCFString( CFStringRef string )// 20210123 bw
{ return (__bridge CFStringRef)[(__bridge NSString *)string uppercaseString]; }

CFStringRef MKIString( UInt32 n )
{
    NSMutableString *string = [NSMutableString stringWithCapacity:0];
    for ( int j = gPSDefStrSize; j >= 1; j-- ) {
        [string insertString:[NSString stringWithFormat:@"%C",(unichar)(n & 0xFF)] atIndex:0];
        n = n >> 8;
    }
    return (__bridge CFStringRef)string;
}

NSInteger LenCF( CFTypeRef obj ) // 20210127 bw
{
    if ( obj ) {// 20231107 bw
        // added other objects that respond to 'length' or 'count' // 20220623 bw
        if ( [(__bridge id)obj respondsToSelector:@selector(count)] ) {
            return [(__bridge id)obj count];
        } else if ( [(__bridge id)obj respondsToSelector:@selector(length)] ) {
            return [(__bridge id)obj length];
        } else {
            if ( CFGetTypeID(obj) == CFBagGetTypeID() ) {// NSBag doesn't exist so do it the CF way
                return CFBagGetCount(obj);
            }
        }
    }
    return 0;
}

// === 20250318 bw ===
NSInteger FB_Len( CFTypeRef obj, NSUInteger option )
{
    if ( [(__bridge id)obj isKindOfClass:[NSString class]] ) {
        switch ( option ) {
            case kLenUnicode:
                return StringUnicodeLength( obj );
            case kLenDefault:
            default:
                return LenCF( obj );
        }
    } else {
        return LenCF( obj );
    }
    return 0;
}
// === 20250318 bw ===

//unichar UCC_Function( CFStringRef inString, NSUInteger index )// 20240729 bw
//{
//    index = ABS(index);
//    NSString *string = (__bridge NSString *)inString;
//    if ( string ) {
//        if ( [string length] > index ) {
//            return [string characterAtIndex:index];
//        }
//    }
//    return 0;
//}

UInt32 UCC_Function( CFStringRef inString, NSUInteger charIndex ) // handles 32-bit unicode characters 20250315 bw
{
    charIndex = ABS(charIndex); // Ensure non-negative index
    NSString *string = (__bridge NSString *)inString;
    if (!string) return 0;

    NSUInteger length = [string length];
    NSUInteger unicodeCharCount = 0; // Count full Unicode characters
    NSUInteger utf16Index = 0; // Actual UTF-16 index

    while (utf16Index < length) {
        unichar high = [string characterAtIndex:utf16Index];

        // If high surrogate, ensure next index is available for a pair
        if (CFStringIsSurrogateHighCharacter(high) && (utf16Index + 1 < length)) {
            unichar low = [string characterAtIndex:utf16Index + 1];
            if (CFStringIsSurrogateLowCharacter(low)) {
                // This is a full surrogate pair (32-bit Unicode character)
                if (unicodeCharCount == charIndex) {
                    return ((high - 0xD800) << 10) + (low - 0xDC00) + 0x10000;
                }
                utf16Index += 2; // Move to the next Unicode character
                unicodeCharCount++;
                continue;
            }
        }

        // Single 16-bit Unicode character (BMP)
        if (unicodeCharCount == charIndex) {
            return (UInt32)high;
        }

        utf16Index++; // Move to the next character
        unicodeCharCount++;
    }

    return 0; // Index out of bounds
}


//CFStringRef UCS_Function( unichar chr )// 20240729 bw
//{ return (__bridge CFStringRef)[NSString stringWithFormat:@"%C",chr]; }

CFStringRef UCS_Function( UInt64 codePoint ) // handles 32-bit unicode characters 20250315 bw
{
   //if ( codePoint > 0x10FFFF ) return NULL; // Invalid Unicode code point

    // Create NSString from Unicode scalar (code point)
//    NSString *str = [[NSString alloc] initWithBytes:&codePoint length:sizeof(codePoint) encoding:NSUTF32LittleEndianStringEncoding];
//    return (__bridge CFStringRef)str;
    
    // For real Unicode, max is 0x10FFFF; higher values are beyond official Unicode range.
    if (codePoint > 0x10FFFF) return NULL; // Optionally limit to Unicode range

    uint32_t codePoint32 = (uint32_t)codePoint; // Trim to 32-bit if necessary

    NSString *str = [[NSString alloc] initWithBytes:&codePoint32
                                             length:sizeof(codePoint32)
                                           encoding:NSUTF32LittleEndianStringEncoding];
    return (__bridge CFStringRef)str;
}

CFStringRef UCS_Function2( UInt64 codePoint, ... )
{
    va_list ap;
    va_start(ap,codePoint);
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    while ( codePoint > 0 ) {
        [array addObject:@(codePoint)];
        codePoint = va_arg(ap,UInt64);
    }
    va_end(ap);
    return StringUnicodeWithCodePointsArray( (__bridge CFArrayRef)array );
}

///////////////////////////////////////////////////
//          Number to String Conversions         //
///////////////////////////////////////////////////

SInt16 STRLeadingSpace( void )
{
    /*
     Return user's FB preference re leading space in STR$() of positive numbers
     Bugs: there's no way to change gFBLeadingSpace
     */
    return gFBLeadingSpace;
}

void PSdefstr( const UInt8 length )
{
    //defstr long | word | byte <-->  4 | 2 | 1
    gPSDefStrSize = length;
}

//StringPtr PSstr( const double howMany )
//{
//    //str$( number )
//    return PSstrcpy( gReturnedString, FBFloat2String( howMany, FIXEDDECIMAL, gFBFloatMaxDigits ) );
//}

// PSstr() is str$()'s support. str$() returns a pascal string. 2021-Jan-23 Brian
// These changes avoid deprecated Apple calls inside FBFloat2String() ( such as dec2str() and num2Dec()  )
// Returned string should be the same as the old code.
// Note: FBFloat2String() has a bug: it pushes and pops the string stack pointer for no reason.
//StringPtr PSstr( const double howMany ) {
//    //str$( number )
//    Str255 pStr;
//
//    // strip off trailing ".00000 etc. "  2021-Jan-23 Brian
//    // prefix string with a space for positive numbers ( negative number has leading '-' ) like the older str$
//    NSString *str;
//    if ( howMany < 0.000000000000000 ) {
//        str = [NSString stringWithFormat:@"%.*lg",gFBFloatMaxDigits+1,howMany];
//    } else {
//        str = [NSString stringWithFormat:@" %.*lg",gFBFloatMaxDigits+1,howMany];
//    }
//    CFStringGetPascalString( (__bridge CFStringRef)str, (void*)&pStr, 256, kCFStringEncodingMacRoman );
//
//    return PSstrcpy( gReturnedString, pStr ); // copy pStr to global to enable safely passing back to caller
//    //return PSstrcpy( gReturnedString, FBFloat2String( howMany, FIXEDDECIMAL, gFBFloatMaxDigits ) ); 2021-Jan-23 Brian
//}

//CFStringRef StrCF( const double num, SInt8 maxDigits )// 20210125 bw
//{
//    //if ( maxDigits == -1 ) maxDigits = gFBFloatMaxDigits;
//    maxDigits = gFBFloatMaxDigits;
//
//    NSString *str;
//    if ( num < 0.000000000000000 ) {
//        str = [NSString stringWithFormat:@"%.*lg",maxDigits+2,num];
//    } else {
//        str = [NSString stringWithFormat:@" %.*lg",maxDigits+1,num];
//    }
//    return (__bridge CFStringRef)str;
//}

//StringPtr PSstr( const double howMany, SInt8 maxDigits )// optional maxDigits param 20210125 bw
//{
////    if ( maxDigits == -1 ) maxDigits = gFBFloatMaxDigits;
////
////    // strip off trailing ".00000 etc. "  2021-Jan-23 Brian
////    // prefix string with a space for positive numbers ( negative number has leading '-' ) like the older str$
////    NSString *str;
////    if ( howMany < 0.000000000000000 ) {
////        str = [NSString stringWithFormat:@"%.*lg",maxDigits+1,howMany];
////    } else {
////        str = [NSString stringWithFormat:@" %.*lg",maxDigits+1,howMany];
////    }
//
//    CFStringRef str = StrCF( howMany, maxDigits );
//    Str255 pStr;
//    CFStringGetPascalString( (__bridge CFStringRef)str, (void*)&pStr, 256, kCFStringEncodingMacRoman );
//    return PSstrcpy( gReturnedString, pStr ); // copy pStr to global to enable safely passing back to caller
//}

// PSstr() is str$()'s support. str$() returns a pascal string. 2021-Jan-23 Brian
// These changes avoid deprecated Apple calls inside FBFloat2String() ( such as dec2str() and num2Dec()  )
// Returned string should be the same as the old code.
// Note: FBFloat2String() has a bug: it pushes and pops the string stack pointer for no reason.
//StringPtr PSstr( const double howMany ) {
//    //str$( number )
//    Str255 pStr;
//
//    // strip off trailing ".00000 etc. "  2021-Jan-23 Brian
//    // prefix string with a space for positive numbers ( negative number has leading '-' ) like the older str$
//    NSString *str;
//        if ( howMany < 0.000000000000000 ) {
//            str = [NSString stringWithFormat:@"%.*lg",gFBFloatMaxDigits+2,howMany];   //<<<<<<< change to +2
//        } else {
//            str = [NSString stringWithFormat:@" %.*lg",gFBFloatMaxDigits+1,howMany];
//        }
//
//    CFStringGetPascalString( (__bridge CFStringRef)str, (void*)&pStr, 256, kCFStringEncodingMacRoman );
//
//    return PSstrcpy( gReturnedString, pStr ); // copy pStr to global to enable safely passing back to caller
//    //return PSstrcpy( gReturnedString, FBFloat2String( howMany, FIXEDDECIMAL, gFBFloatMaxDigits ) ); 2021-Jan-23 Brian
//}


// PSstr() is str$()'s support code for returning a double as a pascal string. 2021-Jan-23 Brian
// These changes avoid deprecated Apple calls inside FBFloat2String() ( such as dec2str() and num2Dec()  )
// Returned string should be the same as the old code.
// Note: FBFloat2String() has a bug: it pushes and pops the string stack pointer for no reason.
CFStringRef CopyDblToString( const double user_supplied_number ) {
    double fracpart, intpart, epsilon = .000001f;
    NSString *format, *returnedString;
    fracpart = modf(user_supplied_number, &intpart);    // put integer part in intpart and fractional part in fracpart
    long integer = trunc(intpart);   // put the intpart inside an integer variable
    NSMutableString *mutDecStr = [NSMutableString stringWithCapacity:0];
    [mutDecStr appendFormat:@"%.*lf", gFBFloatMaxDigits, fracpart];  // hard code #digits  ( 10 ) in demo
    if ( !( fabs(fracpart - 0) < epsilon ) ) {  // process fractional only when non-zero ( user could submit only an integer such as 2849 ).
        format = @"%ld.%@";
        while ( [mutDecStr hasSuffix: @"0"] ) { // elminate trailing zeros that '%.*lf' generates ( i.e. 0.12345600000 )
            NSInteger idx = [mutDecStr length] - 1;
            [mutDecStr deleteCharactersInRange: NSMakeRange(idx, 1)];
        }
        while ( [mutDecStr hasPrefix:@"0"] || [mutDecStr hasPrefix:@"."] || [mutDecStr hasPrefix:@"-"]) {  // elminate '0.' and '-' at beginning of string
            BOOL brk = [mutDecStr hasPrefix:@"."];// if it's a decimal point, we'll break once it's been removed 20231220 bw
            [mutDecStr deleteCharactersInRange:NSMakeRange(0, 1)];
            if ( brk ) break;// it was a decimal point so break 20231220 bw
        }
    } else {
        format = @"%ld";
    }
    NSString *combo = [NSString stringWithFormat:format, integer, mutDecStr]; // put integer and fractional pieces back together as whole string

#if __has_feature(objc_arc)
    if ( [combo hasPrefix:@"-"] )
        returnedString = [NSString stringWithString:combo];
    else
        returnedString = [NSString stringWithFormat:@" %@", combo]; // prefix with space per old str$'s behavior if not a negative number
#else
    if ( [combo hasPrefix:@"-"] )
        returnedString = [[NSString stringWithString:combo]retain];
    else
        returnedString = [[NSString stringWithFormat:@" %@", combo]retain]; // prefix with space per old str$'s behavior if not a negative number
#endif
    
    return (__bridge CFStringRef)returnedString;
}

CFStringRef FBStr( const double user_supplied_number ) {// same as above but returns autoreleased string 20231222 bw
    double fracpart, intpart, epsilon = .000001f;
    NSString *format, *returnedString;
    fracpart = modf(user_supplied_number, &intpart);    // put integer part in intpart and fractional part in fracpart
    long integer = trunc(intpart);   // put the intpart inside an integer variable
    NSMutableString *mutDecStr = [NSMutableString stringWithCapacity:0];
    [mutDecStr appendFormat:@"%.*lf", gFBFloatMaxDigits, fracpart];  // hard code #digits  ( 10 ) in demo
    if ( !( fabs(fracpart - 0) < epsilon ) ) {  // process fractional only when non-zero ( user could submit only an integer such as 2849 ).
        format = @"%ld.%@";
        while ( [mutDecStr hasSuffix: @"0"] ) { // elminate trailing zeros that '%.*lf' generates ( i.e. 0.12345600000 )
            NSInteger idx = [mutDecStr length] - 1;
            [mutDecStr deleteCharactersInRange: NSMakeRange(idx, 1)];
        }
        while ( [mutDecStr hasPrefix:@"0"] || [mutDecStr hasPrefix:@"."] || [mutDecStr hasPrefix:@"-"]) {  // elminate '0.' and '-' at beginning of string
            BOOL brk = [mutDecStr hasPrefix:@"."];// if it's a decimal point, we'll break once it's been removed 20231220 bw
            [mutDecStr deleteCharactersInRange:NSMakeRange(0, 1)];
            if ( brk ) break;// it was a decimal point so break 20231220 bw
        }
    } else {
        format = @"%ld";
    }
    NSString *combo = [NSString stringWithFormat:format, integer, mutDecStr]; // put integer and fractional pieces back together as whole string
    if ( [combo hasPrefix:@"-"] )
        returnedString = [NSString stringWithString:combo];
    else
        returnedString = [NSString stringWithFormat:@" %@", combo]; // prefix with space per old str$'s behavior if not a negative number

    return (__bridge CFStringRef)returnedString;
}

// PSstr() is str$()'s support code for returning a double as a pascal string. 2021-Jan-23 Brian
// These changes avoid deprecated Apple calls inside FBFloat2String() ( such as dec2str() and num2Dec()  )
// Returned string should be the same as the old code.
// Note: FBFloat2String() has a bug: it pushes and pops the string stack pointer for no reason.
StringPtr PSstr( const double user_supplied_number ) {
    CFStringRef s = CopyDblToString( user_supplied_number );
    CFStringGetPascalString( s, (void*)&gReturnedString, 256, kCFStringEncodingMacRoman );
    CFRelease( s );
    return gReturnedString;
}


StringPtr PShex( long num )
{
    //hex$( number )
    
    SInt32		n;
    UInt8		i, c;
    
    c = gPSDefStrSize*2;
    gReturnedString[0] = c;
    for ( i = c; i >= 1; i-- ) {
        n = num & 0x0F;
        if ( n < 10 ) {
            n += (unsigned char)'0';
        } else {
            n += (unsigned char)'A' - 10;
        }
        gReturnedString[i] = n;
        num = num >> 4;
    }
    return gReturnedString;
}


StringPtr PSoct( long n )
{
    //oct$( number )
    Str63	s = "\p";
    SInt16	slen = 0, chars, first, digits, j;
    char	buffer [20];

    chars = sprintf( buffer, "%011lo", n );

    // # digits = 11, 6, 3 for defstr long, word, byte:
    digits = gPSDefStrSize*3;
    if ( gPSDefStrSize == 4 ) digits--;
    first = 11 - digits ;

    // Copy desired digits into result:
    for ( j = first; j < chars; j++ ) {
        slen++;
        s[slen] = buffer[j];
    }
    s[0] = slen;
    
//    Str63 s;
//    CFStringRef string = OctString( n );
//    CFStringGetPascalString( string, s, 63, kCFStringEncodingMacRoman );
    
    return PSstrcpy( gReturnedString, s );
}


StringPtr PSbin( long n )
{
    //bin$( number )
    
    Str63	s = "\p";
    SInt16	slen = 0, bitpos;
    long	num = n; //2023-Jul-18 Brian

    slen = gPSDefStrSize * 8;
    bitpos = slen;

    while ( bitpos > 0 ) {
        if ( (num % 2 )== 0 ) s[bitpos] = '0'; else s[bitpos] = '1';
        num  = num >> 1;
        bitpos--;
    }
    s[0] = slen;
    
//    Str127 s;
//    CFStringRef string = BinString( n );
//    CFStringGetPascalString( string, s, 127, kCFStringEncodingMacRoman );
    
    return PSstrcpy( gReturnedString, s );
}


StringPtr PSuns( const SInt32 n )
{
    // uns$( number )
    
    Str255	s = "\p";
    SInt16  slen = 0, j, spos, chars;
    char    buffer[256];
    long    num;
    
    // In FB, UNS$ has length 10, 5 or 3 for DEFSTR long, word or byte respectively:
    switch ( gPSDefStrSize ) {
        case 1:
            num = (n & 0xFF);
            slen = 3;
            break;
        case 2:
            num = (n & 0xFFFF);
            slen = 5;
            break;
        default:
            num = n;
            slen = 10;
    }
    
    chars = sprintf( buffer, "%010lu", num );
    
    spos = slen;
    
    // Copy required part into string:
    for ( j = chars - 1; j >= 0; j-- ) {
        s[spos] = buffer[j];
        spos--;
        if ( spos == 0 ) break;
    }
    s[0] = slen;
    return PSstrcpy( gReturnedString, s );
}



StringPtr PSmki( UInt32 n )
{
    // mki$( number )
    // Bug fix - Brian, 20100201. Wrong result when defstr word or defstr byte set.
    
    int   j;
    gReturnedString[0] = gPSDefStrSize;
    for ( j = gPSDefStrSize; j >= 1; j-- ) {
        gReturnedString[j] = n & 0xFF;
        n = n >> 8;
    }
    return gReturnedString;
}


///////////////////////////////////////////////////
//     arithmetic functions of Pascal strings    //
///////////////////////////////////////////////////


SInt8 FBPopCmpStr( Str255 s1, Str255 s2 )
{
    gFBStk -= 2;
    return strcmp( (char*)PScstr( s1 ), (char*)PScstr( s2 ) );
}

int CviCF( CFStringRef s )// 20210129 bw
{ return UTGetOSTypeFromString( s ); }

int FBcvi( ConstStr255Param s )
{
    // cvi$( s )// 20210129 bw
    int value = 0, n = s[0], j;
    gFBStk--;
    if ( n > 4 || n == 3 || n == 0) return 0; // like FB  runtime cvi
                                              // n is 1, 2 or 4
    for ( j = 1; j <= n; j++ ) {
        value = value << 8;
        value += s[j];
    }
    return value;
}


UInt8 PSlen( ConstStr255Param s )
{
    //len( s )
    gFBStk--;
    return s[0];
}


UInt8 PSasc( ConstStr255Param s )
{
    // asc( s )
    gFBStk--;
    if ( s[0] )
        return s[1];
    else
        return 0;
}



UInt8 PSinstr( int startPos, Str255 haystack, Str255 needle )
{
    // thanks to Jay Reeve
    gFBStk -= 2;
    int              foundPos = 0, chrNum = needle[0];
    
    --startPos;
    if ( startPos < 0 ) startPos = 0;
    while ( startPos + chrNum <= haystack[0] )  {
        while ( needle[chrNum] == haystack[startPos + chrNum] )  {
            --chrNum;
            if ( chrNum == 0 ) return (UInt8)startPos + 1;
        }
        chrNum = needle[0];
        ++startPos;
    }
    return (UInt8)foundPos;
}

SInt64 PSvalint( Str255 s )
{
    /*
     val&( string )
     
     Works for these tests
     '--------------------
     print "All 0:"
     print val&( "0" ),  val&( " 0  " ), val&( "&X0" ),  val&( "-0x0" ), val&( "4294967296" )
     print "All 1:"
     print val&( " &x1" ), val&( "0"+"1" ), val&( "&O1" ), val&( " &1" ), val&( "0x1" )
     print "All -1:"
     print val&( "  -1" ), val&( "-&O1" ), val&( " -&1" ), val&( "4294967295" ), val&( "0xffffffff" )
     print val&( "-0x1" )
     
     print val&( "5e3" ) // should be 5
     '--------------------
     
     Bugs:
     - absurdly complicated, but maybe it needs to be
     */
    gFBStk--;
    SInt64	sign = 1;
    int	start = 1, base, pos, end;
    while ( ' ' == s[start] ) start++;						// leading spaces
    if ( '-' == s[start] ) {
        sign = -1;	// adjust sign
        start++;	// skip over
    }
    
    switch ( s[start] )	{									// check first char of string to see if hex, oct, bin
        case '&' :
            switch ( s[start + 1] ) {
                case 'H' :
                case 'h' :									// hex
                    pos = start + 2;	base = 16;
                    break;
                case 'o' :
                case 'O' :									// octal
                    pos = start + 2;	base = 8;
                    break;
                case 'X' :
                case 'x' :									// binary
                    pos = start + 2;	base = 2;
                    break;
                default  :									// hex only with leading ampersand
                    pos = start + 1;	base = 16;
                    break;
            }
            PScstr( s );                  // convert pascal string to C string in place
            return sign*strtoull( (char*)s + pos - 1, NULL, base );      // base 2, 8 or 16
        case '0' :											// hex or decimal
            if ( s[start + 1] == 'x' || s[start + 1] == 'X' )
            {
                PScstr( s );								// convert pascal string to C string in place
                return sign*strtoull( (char*)s + start - 1, NULL, 16 );
            }
            // else fall through
        default :								// decimal
            end = start;
            while ( isdigit( s[end] ) ) end++;	// stop at first non-digit
            gFBStk++;							// pretend we are pushing s for PSmid
            s = PSmid( s, start, end - start );		// just the digit string
            if ( s[1] >= '0' && s[1] <= '9' )
            {
                PScstr( s );													// convert pascal string to C string in place
                return sign*strtoull( (char*)s , NULL, 10 );
            }
            else
                return 0;
    }
}

double PSval( Str255 s )
{
    /*
     val( expression )
     analyse string for base and convert into C (strtol or strtod)-understandable form if required:
     strtol/strtod don't care about leading spaces so leave them intact, but do care
     what lies between sign (if any) and start of real digits
     */
    gFBStk--;
    int		ichar = 1, base = 0, count = 0, strLen;
    char	thischar;
    
    strLen = s[0];
    while ( ichar <= strLen )
    {
        thischar = s[ichar];
        if ( base == 0 )
        {
            switch ( thischar )
            {
                case '&' :
                    switch ( s[ichar + 1])
                {
                    case 'H' :
                    case 'h' :									// hex
                        ichar += 2; base = 16;
                        break;
                    case 'o' :
                    case 'O' :									// octal
                        ichar += 2;	base = 8;
                        break;
                    case 'X' :
                    case 'x' :									// binary
                        ichar += 2;	base = 2;
                        break;
                    default  :									// hex only with leading ampersand
                        ichar++;	base = 16;
                        break;
                }
                    break;
                case '0' :											// hex or decimal
                    if ( s[ichar + 1] == 'x' || s[ichar + 1] == 'X' )
                    {
                        ichar += 2; base = 16;
                    } else {
                        base = 10;
                    }
                    break;
                default:
                    if ( (thischar >= '1' && thischar <= '9') || thischar == '.' ) base = 10;
            }
        }
        if ( ichar <= strLen )
        {
            count++;
            s[count] = s[ichar];
            ichar++;
        }
    }
    s[0] = count;
    PScstr( s );													// convert pascal string to C string in place
    if ( base == 10 ) {
        return strtod( (char*)s , NULL );
    } else {
        UInt64   longresult;
        double   dblresult;
        longresult = strtoull( (char*)s, NULL, base );
        dblresult  = longresult;
        if ( longresult > 0x7FFFFFFFFFFFFFFFULL ) dblresult = dblresult - 0xFFFFFFFFFFFFFFFFULL - 1; // ensure strings like "0x8000000000000000" give -ve result
        return dblresult;
    }
    
}

NSInteger FBIntVal( id obj )// 20220627 bw
{
    if ( [obj respondsToSelector:@selector(integerValue)] ) {
        return [obj integerValue];
    }
    return 0;
}

double FBDblVal( id obj )// 20220627 bw
{
    if ( [obj respondsToSelector:@selector(doubleValue)] ) {
        return [obj doubleValue];
    }
    return 0.0;
}

///////////////////////////////////////////////////
//                  mid$ statement               //
///////////////////////////////////////////////////

long MidStmt( void* strvPtr, long position, long length, Str255 s_p )
{
    Str255 s;  PSstrcpy( s, s_p );
    gFBStk -= 1;
    long              i, srcLen, dstLen;
    if ( position < 1 ) position = 1;
    
    srcLen = s[0];
    dstLen = *(unsigned char*)(strvPtr) - position + 1;
    if ( length > dstLen ) length = dstLen;
    if ( length > srcLen || length < 0 ) length = srcLen;
    strvPtr = (void*)( strvPtr + position );
    i = 1;
    do {
        *(unsigned char*)strvPtr = s[i];
        strvPtr++;
        i++;
    }
    while ( i <= length );
    return 0;
}


///////////////////////////////////////////////////
//               arithmetic functions            //
///////////////////////////////////////////////////

double frac( const double x )
{
    // frac
    return x - trunc( x );
}

double sgn( const double value )
{
    // sgn( expression )
    if ( value > 0.0 ) return 1.0;
    if ( value < 0.0 ) return -1.0;
    return 0.0;
}


SInt32 sgni( const SInt32 value )
{
    //sgni( expression )
    
    if ( value > 0 ) return 1;
    if ( value < 0 ) return -1;
    return 0;
}

SInt32 maybe(void) //2023-Jul-18 Brian
{
    //return ( rand() > RAND_MAX/2 ) ? -1: 0;
    return ( rand() > RAND_MAX/2 ) ? 1: 0;// changed -1 to 1 20240218 bw
}

long rnd( long minMax, long max )
{
    if ( max == kFBParamMissing ) {
        //return (long)arc4random_uniform( minMax ) + 1;
        if ( minMax == 0 ) return 1;
        double r = (double)rand()/((double)(RAND_MAX) + 1.0);
        return (int)(r*minMax) + 1;
    } else {
        if ( max < minMax ) return minMax;
        return arc4random_uniform( (max-minMax) + 1 ) + minMax;
    }
}

int FBmax( const SInt32 n1, const SInt32 n2 )
{
    // max( n1, n2 )
    return ( n1 > n2 ) ? n1: n2;
}

// Maybe we should be using 'nanosleep()' here instead? Brian 20170702
// struct timespec required, remaining; // remaining can be NULL if the caller doesn't need the remaining time.
/* Where the timespec struc looks like:
 time_t  tv_sec    Seconds.
 long    tv_nsec   Nanoseconds.   1 sec = 1,000,000,000 nanoseconds.
 
 When you pass a timespec struct to nanosleep(), it sleeps for the seconds *plus* the nanoseconds specified
 
 
 struct timespec required, remaining;
 required.tv_sec  = t;
 required.tv_nsec = 0;
 nanosleep(&required , &remaining);
 */
void FBDelay( const Duration delayTime )
{  // in delay ms   delay -µs   milliseconds
   // old code used deprecated MPLibraryIsLoaded() and MPDelayUntil 10.7. Brian 20170702
   // Deficiencies: code doesn't employ the 'remaining' option offered by nanosleep's second parameter.
    
    long nanoInMilli = 1000000;     // nanoseconds in a millisecond
    long milliInSec  = 1000;        // milliseconds in a second
    
    struct timespec required;
    required.tv_sec  = (long)delayTime / milliInSec;            // convert milliseconds to seconds
    required.tv_nsec = ( delayTime % milliInSec ) * nanoInMilli;  // convert remainder milliseconds to nanoseconds
    nanosleep(&required, NULL);                                   // sleep for seconds/nanoseconds. 'remaining' is unused and NULLed
}

///////////////////////////////////////////////////
//                    miscellaneous              //
///////////////////////////////////////////////////

// returns what the system sends.  Brian 05-May-2015
SInt32 OSVersion( void )
{
    NSArray *myarr = [[[NSProcessInfo processInfo] operatingSystemVersionString] componentsSeparatedByString:@" "];
    NSString  *cleanedString = [[myarr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"." withString:@""];
    return [cleanedString intValue]; //2022-Jan-10 Brian
}

NSInteger FBSystemFunction( const SInt32 expr ) //2023-Jul-18 Brian
{
    /*
     FBSystemFunction
     
     Updated 20170708 for general removal of old code.
     Only kFBScrnWidth, kFBScrnHeight, kFBSysVers and kFBAplActive are supported.
     Brian 20170708
     */
    CGRect    cgRect;
    NSInteger result = 0; //2023-Jul-18 Brian
    
    switch ( expr ) {
        case kFBScrnWidth:
            cgRect = CGDisplayBounds( CGMainDisplayID() );
            result = cgRect.size.width;
            break;
        case kFBScrnHeight:
            cgRect = CGDisplayBounds( CGMainDisplayID() );
            result = cgRect.size.height;
            break;
        case kFBSysVers: {
//          The following returns the OS version in the standard 101500 format - restored this code //2022-May-21 Brian
            NSOperatingSystemVersion vers = [[NSProcessInfo processInfo] operatingSystemVersion];// 20210508 bw
            result = [[NSString stringWithFormat:@"%.2ld%.2ld%.2ld",vers.majorVersion,vers.minorVersion,vers.patchVersion] integerValue];// 20210508 bw
            break;
        }
        case kFBAplActive: {
            NSRunningApplication *currentApp = [NSRunningApplication currentApplication]; // replaces old calls Brian 20170708
            if ( [currentApp isActive])
                result = 1;        // is front-most app
            else
                result = -1;       // is not front-most app
            break;
             }
        default:
            break;
    }
    return result;
}

void FBRunPath( CFStringRef pathToAppName )// Brian 20170703
{ [[NSWorkspace sharedWorkspace] launchApplication:(__bridge NSString *)pathToAppName]; }

void FBRunURL( CFURLRef url )// Brian 20170703
{ [[NSWorkspace sharedWorkspace] openURL:(__bridge NSURL *)url]; }

void FBRunPathURL( CFTypeRef obj )// 20231027 bw
{
    if ( CFGetTypeID( obj ) == CFStringGetTypeID() ) {
        [[NSWorkspace sharedWorkspace] launchApplication:(__bridge NSString *)obj];
    } else if ( CFGetTypeID( obj ) == CFURLGetTypeID() ) {
        [[NSWorkspace sharedWorkspace] openURL:(__bridge NSURL *)obj];
    } else {
        // not supported
    }
}

void FBPstrDollarStatement( void* address, void* s )
{ *(long*)address = (long)(s); }


#pragma mark - concat functions
static NSString *sFBConcatJoinString;

id FBConcatString( id obj, va_list ap )
{
    NSMutableString *mutString = [NSMutableString stringWithCapacity:0];
    while ( obj ) {
        if ( [sFBConcatJoinString length] > 0 && [mutString length] > 0 ) [mutString appendString:sFBConcatJoinString];
        
        if ( [obj isKindOfClass:[NSArray class]] ) {
            [mutString appendString:[(NSArray *)obj componentsJoinedByString:sFBConcatJoinString]];
        } else if ( [obj isKindOfClass:[NSOrderedSet class]] ) {
            [mutString appendString:[[(NSOrderedSet *)obj array] componentsJoinedByString:sFBConcatJoinString]];
        } else if ( [obj isKindOfClass:[NSAttributedString class]] ) {
            [mutString appendString:[(NSAttributedString *)obj string]];
        } else if ( [obj isKindOfClass:[NSSet class]] ) {
            [mutString appendString:[[(NSSet *)obj allObjects] componentsJoinedByString:sFBConcatJoinString]];
        } else if ( [obj isKindOfClass:[NSIndexSet class]] ) {
            [(NSIndexSet *)obj enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL __attribute__ ((__unused__)) * _Nonnull stop) {
                if ( [sFBConcatJoinString length] > 0 && [mutString length] > 0 ) {
                    if ( ![mutString hasSuffix:sFBConcatJoinString] ) [mutString appendString:sFBConcatJoinString];
                }
                [mutString appendString:[NSString stringWithFormat:@"%ld",idx]];
            }];
        } else if ( [obj isKindOfClass:[NSString class]] ) {
            [mutString appendString:obj];
        } else if ( [obj isKindOfClass:[NSNumber class]] ) {
            [mutString appendString:[obj stringValue]];
        } else {
            // ...
        }
        obj = va_arg(ap,id);
    }
    return [NSString stringWithString:mutString];
}

id FBConcatAttributedString( id obj, va_list ap )
{
    NSMutableAttributedString *mutString = [[[NSMutableAttributedString alloc] initWithString:@""] autorelease];
    while ( obj ) {
        if ( [obj isKindOfClass:[NSString class]] ) {
            [mutString appendAttributedString:[[[NSAttributedString alloc] initWithString:obj] autorelease]];
        } else if ( [obj isKindOfClass:[NSAttributedString class]] ) {
            [mutString appendAttributedString:obj];
        } else {
            // ...
        }
        obj = va_arg(ap,id);
    }
    return [[[NSAttributedString alloc] initWithAttributedString:mutString] autorelease];
}

id FBConcatArray( id obj, va_list ap )
{
    NSMutableArray *mutArray = [NSMutableArray arrayWithCapacity:0];
    while ( obj ) {
        if ( [obj isKindOfClass:[NSAttributedString class]] ) {
            [mutArray addObject:obj];
        } else if ( [obj isKindOfClass:[NSString class]] ) {
            [mutArray addObject:obj];
        } else if ( [obj isKindOfClass:[NSIndexSet class]] ) {
            [(NSIndexSet *)obj enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL __attribute__ ((__unused__)) * _Nonnull stop) {
             [mutArray addObject:@(idx)];
             }];
        } else if ( [obj isKindOfClass:[NSOrderedSet class]] ) {
            [mutArray addObjectsFromArray:[(NSOrderedSet *)obj array]];
        } else if ( [obj isKindOfClass:[NSSet class]] ) {
            [mutArray addObjectsFromArray:[(NSSet *)obj allObjects]];
        } else if ( [obj isKindOfClass:[NSArray class]] ) {
            [mutArray addObjectsFromArray:obj];
        } else if ( [obj isKindOfClass:[NSValue class]] ) {
            [mutArray addObject:obj];
        } else if ( [obj isKindOfClass:[NSNumber class]] ) {
            [mutArray addObject:obj];
        } else {
            // ...
        }
        obj = va_arg(ap,id);
    }
    return [NSArray arrayWithArray:mutArray];
}

id FBConcatDictionary( id obj, va_list ap )
{
    NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithCapacity:0];
    while ( obj ) {
        if ( [obj isKindOfClass:[NSDictionary class]] ) {
            [mutDict addEntriesFromDictionary:obj];
        } else {
            // ...
        }
        obj = va_arg(ap,id);
    }
    return [NSDictionary dictionaryWithDictionary:mutDict];
}

id FBConcatSet( id obj, va_list ap )
{
    NSMutableSet *mutSet = [NSMutableSet setWithCapacity:0];
    while ( obj ) {
        if ( [obj isKindOfClass:[NSArray class]] ) {
            [mutSet unionSet:[NSSet setWithArray:obj]];
        } else if ( [obj isKindOfClass:[NSString class]] ) {
            [mutSet addObject:obj];
        } else if ( [obj isKindOfClass:[NSAttributedString class]] ) {
            [mutSet addObject:[(NSAttributedString *)obj string]];
        } else if ( [obj isKindOfClass:[NSSet class]] ) {
            [mutSet unionSet:obj];
        } else if ( [obj isKindOfClass:[NSIndexSet class]] ) {
            [(NSIndexSet *)obj enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL __attribute__ ((__unused__)) * _Nonnull stop) {
             [mutSet addObject:@(idx)];
             }];
        } else if ( [obj isKindOfClass:[NSOrderedSet class]] ) {
            [mutSet addObjectsFromArray:[(NSOrderedSet *)obj array]];
        } else {
            // ...
        }
        obj = va_arg(ap,id);
    }
    return [NSSet setWithSet:mutSet];
}

id FBConcatOrderedSet( id obj, va_list ap )
{
    NSMutableOrderedSet *mutSet = [NSMutableOrderedSet orderedSetWithCapacity:0];
    while ( obj ) {
        if ( [obj isKindOfClass:[NSString class]] ) {
            [mutSet addObject:obj];
        } else if ( [obj isKindOfClass:[NSAttributedString class]] ) {
            [mutSet addObject:[(NSAttributedString *)obj string]];
        } else if ( [obj isKindOfClass:[NSArray class]] ) {
            [mutSet addObjectsFromArray:obj];
        } else if ( [obj isKindOfClass:[NSSet class]] ) {
            [mutSet addObjectsFromArray:[(NSSet *)obj allObjects]];
        } else if ( [obj isKindOfClass:[NSOrderedSet class]] ) {
            [mutSet unionOrderedSet:obj];
        } else if ( [obj isKindOfClass:[NSIndexSet class]] ) {
            [(NSIndexSet *)obj enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL __attribute__ ((__unused__)) * _Nonnull stop) {
             [mutSet addObject:@(idx)];
             }];
        } else if ( [obj isKindOfClass:[NSOrderedSet class]] ) {
            [mutSet addObjectsFromArray:[(NSOrderedSet *)obj array]];
        } else {
            // ...
        }
        obj = va_arg(ap,id);
    }
    return [NSOrderedSet orderedSetWithOrderedSet:mutSet];
}

id FBConcatCountedSet( id obj, va_list ap )
{
    NSCountedSet *countedSet = [[[NSCountedSet alloc] initWithCapacity:0] autorelease];
    while ( obj ) {
        if ( [obj isKindOfClass:[NSString class]] ) {
            [countedSet addObject:obj];
        } else if ( [obj isKindOfClass:[NSAttributedString class]] ) {
            [countedSet addObject:[(NSAttributedString *)obj string]];
        } else if ( [obj isKindOfClass:[NSArray class]] ) {
            [countedSet unionSet:[NSSet setWithArray:obj]];
        } else if ( [obj isKindOfClass:[NSIndexSet class]] ) {
            [(NSIndexSet *)obj enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL __attribute__ ((__unused__)) * _Nonnull stop) {
             [countedSet addObject:@(idx)];
             }];
        } else if ( [obj isKindOfClass:[NSSet class]] ) {
            [countedSet unionSet:obj];
        } else if ( [obj isKindOfClass:[NSOrderedSet class]] ) {
            [countedSet unionSet:[(NSOrderedSet *)obj set]];
        } else {
            // ...
        }
        obj = va_arg(ap,id);
    }
    return countedSet;
}

id FBConcatIndexSet( id obj, va_list ap )
{
    NSMutableIndexSet *mutSet = [NSMutableIndexSet indexSet];
    while ( obj ) {
        if ( [obj isKindOfClass:[NSIndexSet class]] ) {
            [mutSet addIndexes:obj];
        } else {
            // ...
        }
        obj = va_arg(ap,id);
    }
    return [[[NSIndexSet alloc] initWithIndexSet:mutSet] autorelease];
}

id FBConcatNumber( id obj, va_list ap )
{
    NSMutableString *mutString = [NSMutableString stringWithCapacity:0];
    while ( obj ) {
        if ( [obj isKindOfClass:[NSNumber class]] ) {
            [mutString appendString:[obj stringValue]];
        } else {
            // ...
        }
        obj = va_arg(ap,id);
    }
    return [NSString stringWithString:mutString];
}

CFTypeRef FBConcat( CFTypeRef inObj, ... )
{
    id outObj = nil;
    //sConcatSpcFlag = NO;
    va_list ap;
    va_start(ap,inObj);
    
    sFBConcatJoinString = @"";
    
    id obj = (__bridge id)inObj;
    
    if ( [obj isKindOfClass:[NSOrderedSet class]] ) {
        outObj = FBConcatOrderedSet( obj, ap );
    } else if ( [obj isKindOfClass:[NSCountedSet class]] ) {
        outObj = FBConcatCountedSet( obj, ap );
    } else if ( [obj isKindOfClass:[NSIndexSet class]] ) {
        outObj = FBConcatIndexSet( obj, ap );
    } else if ( [obj isKindOfClass:[NSAttributedString class]] ) {
        outObj = FBConcatAttributedString( obj, ap );
    } else if ( [obj isKindOfClass:[NSString class]] ) {
        outObj = FBConcatString( obj, ap );
    } else if ( [obj isKindOfClass:[NSArray class]] ) {
        outObj = FBConcatArray( obj, ap );
    } else if ( [obj isKindOfClass:[NSDictionary class]] ) {
        outObj = FBConcatDictionary( obj, ap );
    } else if ( [obj isKindOfClass:[NSSet class]] ) {
        outObj = FBConcatSet( obj, ap );
    } else if ( [obj isKindOfClass:[NSNumber class]] ) {
        outObj = FBConcatNumber( obj, ap );
    } else {
        // ...
    }

    va_end(ap);
    return (__bridge CFTypeRef)outObj;
}

CFTypeRef FBConcatJoin( CFTypeRef inObj, ... )
{
    id outObj = nil;
    va_list ap;
    va_start(ap,inObj);
    id obj = (__bridge id)inObj;
    sFBConcatJoinString = [NSString stringWithString:obj];
    obj = va_arg(ap,id);
    outObj = FBConcatString( obj, ap );
    va_end(ap);
    return (__bridge CFTypeRef)outObj;
}

#pragma mark - C string concat functions
//2024-Oct-1 Brian
//strcat( (char *)&buffer, va_arg( ap, char * ) ); //strcat rescans the destination string every time you add something to it, thus doing lots of unnecessary work
/*
char* FBConcatCStr(  char *s1,  ...) {
    char *myS1 = strdup( s1 );
    char *saveDup = myS1;
    va_list ap;            // declare argument list pointer.
    va_start( ap, s1 ); // tell 'ap' the name of the variable just before the elipsis.
    static char buffer[100000] = "";  // Arbitrary size. A static array must have a literals size i.e. [nnnn] and cannot use a variable [myCalculatedVarSize]
    strcpy((char *)buffer, ""); // clear the buffer between calls to FBConcaCStr
    char *p = buffer; // buffer is not directly assignable after initialization/declaration. Solves that plus supplies needed return address
    
    while ( myS1 != NULL) {
        p = stpcpy( (char *)p,  myS1);   //stpcpy returns the pointer to the terminating \0 which is an improved strcat().
        myS1 = va_arg( ap, char * );
    }
    //printf( "Buffer size: %ld \n", strlen(buffer) );
    va_end( ap );          // tell the macros we're done and allow them to clean up.
    free( saveDup );
    return buffer;         // called as a function, so return the buffer to the caller
}
 */
/*
void FBConcatCStr(  char *returnedVar, char *s1,  ...) {
    char *myS1 = strdup( s1 );
    char *saveDup = myS1;
    va_list ap;            // declare argument list pointer.
    va_start( ap, s1 ); // tell 'ap' the name of the variable just before the elipsis.
    //static char buffer[100000] = "";  // Arbitrary size. A static array must have a literals size i.e. [nnnn] and cannot use a variable [myCalculatedVarSize]
    //strcpy((char *)buffer, ""); // clear the buffer between calls to FBConcaCStr
    //char *p = buffer; // buffer is not directly assignable after initialization/declaration. Solves that plus supplies needed return address
    
    while ( myS1 != NULL) {
        returnedVar = stpcpy( (char *)returnedVar,  myS1);   //stpcpy returns the pointer to the terminating \0 which is an improved strcat().
        myS1 = va_arg( ap, char * );
    }
    //printf( "Buffer size: %ld \n", strlen(buffer) );
    va_end( ap );          // tell the macros we're done and allow them to clean up.
    free( saveDup );
    //return;
    //return buffer;         // called as a function, so return the buffer to the caller
}
 */
//2024-Oct-1 Brian
// A statement version, not a function.
// A static buffer ( i.e. static char buffer[100000] = "" )
// almost solves being able to return a value ( i.e. function ) but creates other issues
// when the function is called multiple times in succession ( as in a loop for example )
void FBConcatCStr(  char *returnedVar, const char *s1,  ...) {

    char *myS1 = strdup( s1 );
    char *saveDup = myS1;
    va_list ap;            // declare argument list pointer.
    va_start( ap, s1 ); // tell 'ap' the name of the variable just before the elipsis.
    //static char buffer[100000] = "";  // Arbitrary size. A static array must have a literal size i.e. [nnnn] and cannot use a variable [myCalculatedVarSize]
    //strcpy((char *)buffer, ""); // clear the buffer between calls to FBConcaCStr
    //char *p = buffer; // buffer is not directly assignable after initialization/declaration. Solves that plus supplies needed return address
    
    while ( myS1 != NULL) {
    //stpcpy is speedier than strcat() as it returns a pointer to returnVar's terminating \0. strcat(0) has to rescan.
        returnedVar = (char *)stpcpy( returnedVar,  myS1);
        myS1 = va_arg( ap, char * );
    }
    va_end( ap );          // tell the macros we're done and allow it to clean up.
    free( saveDup );
}

// append source string to end of dest string ( i.e. non-destructive ) 2024-Oct-10 Brian
void FBAppendCStr( size_t maxDestSize, char *dest, const char *src ) {  // pass in dest's max size so code can check overflow
    size_t srcSize  = strlen( (char *) src );
    size_t destSize = strlen( (char *) dest );
    
    // if dest string has enough room remaining to append all of the src string
    if ( ( srcSize + destSize ) < maxDestSize ) {
        stpcpy( dest + destSize, src );  // '+ destSize' to append to end of dest string
    } else {
    // else copy the portion of src that will append without overflowing dest string's max size
        stpncpy( dest + destSize, src, maxDestSize - destSize );
    } //strcat( dest, src );
}


#pragma mark - shortcut array getter & setter
// 20241008 bw
CFTypeRef FBShortcutArrayGetter( CFArrayRef inArray, NSInteger index )
{
    id obj = nil;
    NSArray *array = (__bridge NSArray *)inArray;
    // don't check for index out of bounds - let it crash 20241022 bw
//    NSInteger count = [array count];
//    if ( index >= 0 && index < count ) {
        obj = [array objectAtIndex:index];
//    } else {
//        // out of bounds!
//    }
    return (__bridge CFTypeRef)obj;
}

void FBShortcutArraySetter( CFMutableArrayRef inArray, NSInteger index, CFTypeRef inObj )
{
    NSMutableArray *array = (__bridge NSMutableArray *)inArray;
    id obj = (__bridge id)inObj;
    NSInteger count = [array count];
    if ( index == count ) {
        [array addObject:obj];
    } else if ( index >= 0 && index < count  ) {
        [array replaceObjectAtIndex:index withObject:obj];
    } else {
        // out of bounds!
    }
}

