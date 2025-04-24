
//  AppThings.c

#import "FBtoC.h"
#import "Runtime.h"
#import "AppThings.h"// 20230616 bw
#import "CUI_AppDelegate.h"
#import "CocoaUI.h"

#define kMajorRel        10
#define kMinorRel        7
#define kFBBufferCount   6
#define kToBuffer        1000 // buffer numbers start at 1000. i.e. 1000, 1001, 1002 etc.

//FBBoolean			gFBQuit; //2023-Dec-22 Brian
unsigned char		gFBFloatMaxDigits = 10;

///////////////////////////////////////////////////
//          print to window/file                 //
///////////////////////////////////////////////////

long            gFBWidth = -1; // default -1 (_textWrap)
//long            gFBWidthLprint = -1; // default -1 (_textWrap)
int             gFBRoute;  //2022-Jan-11 Brian

#if 0

void FBFullStop( CFStringRef msg, CFStringRef info, Boolean fatal )// moved to here from AppThings.m 20230616 bw //2023-Dec-22 Brian changed to Boolean
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:(__bridge NSString *)msg];
    [alert setInformativeText:(__bridge NSString *)info];
    if ( fatal ) {
        [alert setAlertStyle:NSCriticalAlertStyle];
        [alert addButtonWithTitle:NSLocalizedStringFromTable( @"Quit",@"Runtime",@"FBFullStop" )];
        [alert addButtonWithTitle:NSLocalizedStringFromTable( @"Crash",@"Runtime",@"FBFullStop" )];
    } else {
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert addButtonWithTitle:NSLocalizedStringFromTable( @"Stop",@"Runtime",@"FBFullStop" )];
        [alert addButtonWithTitle:NSLocalizedStringFromTable( @"Continue",@"Runtime",@"FBFullStop" )];
        [alert addButtonWithTitle:NSLocalizedStringFromTable( @"Crash",@"Runtime",@"FBFullStop" )];
    }
    //NSModalResponse response = [alert runModal];
    
    [alert beginSheetModalForWindow:[NSApp keyWindow] completionHandler:^(NSModalResponse returnCode) {
         switch (returnCode) {
            case NSAlertSecondButtonReturn:
                break;
            case NSAlertFirstButtonReturn:
                [NSApp terminate:nil];
                break;
            case NSAlertThirdButtonReturn:
                abort();// 20210407 brian
                break;
            default:
                break;
         }
         }];

//    if ( response == NSAlertFirstButtonReturn ) [NSApp terminate:nil];
//    if ( fatal || response == NSAlertThirdButtonReturn ) abort();// 20210407 brian
//#if !__has_feature(objc_arc)
//    [alert release];
//#endif
}

#else
void FBFullStop( CFStringRef msg, CFStringRef info, Boolean fatal )// moved to here from AppThings.m 20230616 bw //2023-Dec-22 Brian changed to Boolean
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:(__bridge NSString *)msg];
    [alert setInformativeText:(__bridge NSString *)info];
    if ( fatal ) {
        [alert setAlertStyle:NSCriticalAlertStyle];
        [alert addButtonWithTitle:NSLocalizedStringFromTable( @"Quit",@"Runtime",@"FBFullStop" )];
        [alert addButtonWithTitle:NSLocalizedStringFromTable( @"Crash",@"Runtime",@"FBFullStop" )];
    } else {
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert addButtonWithTitle:NSLocalizedStringFromTable( @"Stop",@"Runtime",@"FBFullStop" )];
        [alert addButtonWithTitle:NSLocalizedStringFromTable( @"Continue",@"Runtime",@"FBFullStop" )];
        [alert addButtonWithTitle:NSLocalizedStringFromTable( @"Crash",@"Runtime",@"FBFullStop" )];
    }
    NSModalResponse response = [alert runModal];
    if ( response == NSAlertFirstButtonReturn ) [NSApp terminate:nil];
    if ( fatal || response == NSAlertThirdButtonReturn ) abort();// 20210407 brian
#if !__has_feature(objc_arc)
    [alert release];
#endif
}

#endif

/*
char* FBCheckBuffer( long  bytes2add )
{
    long              oldSize;
    Handle hnld = gFBBuffer[gFBRoute -  kToBuffer];
    if ( hnld == 0 ) {
        hnld = NewHandle( bytes2add );
        gFBBuffer[gFBRoute -  kToBuffer] = hnld;
        oldSize = 0;
    } else {
        oldSize = GetHandleSize( hnld );
        SetHandleSize( hnld, oldSize + bytes2add );
    }
    return *hnld + oldSize;
}
*/

void PrintCR( void ) // comment out contents for now. Need to remove use of PrintCR() 2021-Jan-15 Brian
{
    if ( gFBRoute == 0 ) {// print to window 20211115 bw
        CUI_PrintToWindowPrintStatement( @"", NULL );
    } else if ( gFBRoute == 128 )  { // _toPrinter
        
    } else if ( gFBRoute >= kToBuffer ) {
        //FBAddCharacterToBuffer( 13 );
    } else { // gFBRoute 1 to 127 and 129 to 255 represent files
        FBFilePrintCR();
    }
}

void FBRoute( int where )
{ gFBRoute = where; }

/* 2021-Jan-15 Brian
void FBAddStringToBuffer( Str255  string_p )
{
    Str255 string;  PSstrcpy( string, string_p );
    --gFBStk;
    char *tempPtr = FBCheckBuffer( string[0] );
    BlockMoveData( &string[1], tempPtr, string[0] );
}
*/
void FBPrintString( Str255  s )
{
    if ( gFBRoute == 0 )    {    // _toScreen
    } else if ( gFBRoute == 128    )  { // _toPrinter
       
    } else if ( gFBRoute >= kToBuffer ) { // _toBuffer
        //FBAddStringToBuffer( PSstrcpy( STACK_PUSH(), s ) );   // FBtoC rejects the ROUTE statement now, so a 'route _toBuffer' is not possible
                                                                // and this line of code should not execute, so it's commented out. Brian 20191011
    }else {                        // fileID
        FBFilePrintString( PSstrcpy( STACK_PUSH(), s ) );
    }
    --gFBStk;
}
/* 2021-Jan-15 Brian
void FBAddCharacterToBuffer( short  c )
{
    char *tempPtr = FBCheckBuffer( 1 );
    *tempPtr = c;
}
*/


///////////////////////////////////////////////////
//             AppleEvents //
///////////////////////////////////////////////////

OSErr FBAEHandleQuit( AppleEvent __attribute__ ((__unused__)) *theAppleEvent, AppleEvent __attribute__ ((__unused__)) *reply, long __attribute__ ((__unused__))  myAEFlags )
{
    exit( 0 );
}

//void FBInitAEEvents( void )
//{ AEInstallEventHandler( kCoreEventClass, kAEQuitApplication, (AEEventHandlerUPP)FBAEHandleQuit, 0, false ); }

static AEEventHandlerUPP sHandler = (AEEventHandlerUPP)(void *)FBAEHandleQuit; // make static to silence clang warning 20250302 bw
void FBInitAEEvents( void )
{ AEInstallEventHandler( kCoreEventClass, kAEQuitApplication, sHandler, 0, false ); } // s20250302 bw

///////////////////////////////////////////////////
//            HandleEvents emulation             //
///////////////////////////////////////////////////
void FBHandleEvents( void )
{ CUI_AppRun(); }


///////////////////////////////////////////////////
//          print to window/file                 //
///////////////////////////////////////////////////
const Boolean gNumberLeadingSpace = true;

void FBAddLeadingSpace( char * sPtr )
{
    char *sPtrM;
    if ( gNumberLeadingSpace ) {
        if ( *(sPtr + 1) != '-'  ) {
            sPtrM = sPtr + *sPtr;
            *sPtr = *sPtr + 1;
            while ( sPtrM > sPtr ) {
                *(sPtrM + 1) = *sPtrM;
                sPtrM--;
            }
            *(sPtr + 1) = ' ';
        }
    }
}

void PrintLong( const SInt64 theNumber, NSString *nextArg )
{
    if ( gFBRoute == 0 ) { // print to window 20211115 bw
        CUI_PrintToWindowPrintStatement( @(theNumber), nextArg, NULL );
    } else {
        Str255  string;
        string[0] = sprintf( (char*)&string + 1, "%lld", theNumber);
        FBAddLeadingSpace( (char*)&string );
        FBPrintString( PSstrcpy( STACK_PUSH(), string ) );
    }
}

//StringPtr FBFloat2String( const double  theNum, long  style, long  digits )
//{
//    // adapted from FBFloat2String in Subs Compiler.incl
//    // style == 1, digits == 10 on entry
//    gFBStk++;
//    short             fpexp;
//    UInt8             nLen = 0;
//    Boolean           keepZeros = false;
//    Str255            theStr = {};
//    decform           myDecForm;
//    decimal           myDecimalRec;
//    
//    if ( digits < 0 ) digits = 0;
//    
//#if TARGET_RT_LITTLE_ENDIAN
//    fpexp =  (*(signed char*)((void*)&theNum + 7) << 8) + *(unsigned char*)((void*)&theNum + 6);
//#else
//    fpexp = *(short*)&theNum;
//#endif
//    fpexp = (fpexp & 0x7FF0) >> 4;
//    if ( fpexp ) fpexp -= 0x400;
//    
//    if ( style < 0 ) {       // 'using'  Note: we never call FBFloat2String for this; instead we call PSusing() -
//        style = style + 2; // -1 normal --> FIXEDDECIMAL, -2 --> FLOATDECIMAL
//        keepZeros = true;
//    } else {
//        if ( fpexp < -8 ) {        // < .01
//            style = 0;
//            digits--;
//        }
//        if ( fpexp >= 31 ) {  // > 9999999999
//            style = 0;
//            digits--;
//        }
//        if ( style && (fpexp > 0) ) {
//
//            if ( digits < 1 ) digits = 1; //need at least 1 past dp
//        }
//        if ( style == FIXEDDECIMAL ) {
//            digits -= (fpexp*12)/39;
//            if ( digits < 1 ) digits = 1;
//        }
//    }
//    
//    //fprintf( stderr, "FBFloat2String1 %g fpexp %d style %d digits %d  keepzeros %d\n", theNum,(int)fpexp, (int)style, (int)digits, (int)keepZeros );
//    myDecForm.style = style;  // FLOATDECIMAL 0   FIXEDDECIMAL  1
//    myDecForm.digits = digits;
//    num2dec( &myDecForm, theNum, &myDecimalRec );
//    if ( keepZeros == false && style == FLOATDECIMAL ) {
//        nLen = myDecimalRec.sig.length;
//        while ( myDecimalRec.sig.text[nLen - 1] == '0' ) {
//            nLen--;
//            myDecForm.digits--;
//            myDecimalRec.exp++;
//        }
//        myDecimalRec.sig.length = nLen;
//        myDecimalRec.sig.text[nLen] = 0;
//    }
//    
//    dec2str( &myDecForm, &myDecimalRec, (void*)&theStr + 1 );
//    
//    UInt8             plen = 1;
//    while ( theStr[plen] ) { plen++; }
//    *(char*)(&theStr) = plen - 1;
//    // theStr now a proper pascal string
//    nLen = theStr[0];
//    if ( keepZeros == false && style == FIXEDDECIMAL ) {
//        while ( *(char*)((void*)&theStr + nLen) == '0' ) { nLen--; } //remove trailing '0's
//        if ( *(char*)((void*)&theStr + nLen) == '.' ) nLen--; // remove trailing '.'
//        *(char*)(&theStr) = nLen;
//        FBAddLeadingSpace( (char*)&theStr );
//    }
//    
//    gFBStk--;
//    return PSstrcpy( gReturnedString, theStr );
//}


//void PrintFloat( const double  d )
//{ FBPrintString( PSstrcpy( STACK_PUSH(), FBFloat2String( d, FIXEDDECIMAL, gFBFloatMaxDigits ) ) ); }

// 20210124 brian
//void PrintFloat( const double  d )
//{ FBPrintString( PSstrcpy( STACK_PUSH(), PSstr( d, -1 ) ) ); }// added -1 second param 20210125 bw

void PrintFloat( const double  d, NSString *nextArg )
{
    if ( gFBRoute == 0 ) { // print to window 20211115 bw
        CUI_PrintToWindowPrintStatement( @(d), nextArg, NULL );
    } else {
        FBPrintString( PSstrcpy( STACK_PUSH(), PSstr( d ) ) );
    }
}

void PrintTab( __attribute__ ((unused)) long tabs )
{
    if ( gFBRoute == 0 ) {// print to window 20211115 bw
        CUI_PrintToWindowPrintStatement( @"\t", NULL );
    } else if ( gFBRoute == 128 ) {// _toPrinter
        
    } else if ( gFBRoute >= kToBuffer ) {   // should never execute because FBtoC disallows the ROUTE command // Brian 20191010
        //FBAddCharacterToBuffer( 44 );  // _","   // since won't execute, it's commented out. // Brian 20191010

    } else {        // gFBRoute 1 to 127 and 129 to 255 represent files
        FBFilePrintTab();
    }
}

void PrintSpc( long spc, NSString *nextArg )
{
    if ( gFBRoute == 0 ) {// print to window 20211115 bw
        NSString *string = [@"" stringByPaddingToLength:spc withString:@" " startingAtIndex:0];
        string = [string stringByAppendingString:nextArg];
        CUI_PrintToWindowPrintStatement( string, NULL );
    } else {
        while ( spc > 0 ) {
            FBPrintString( PSstrcpy( STACK_PUSH(), "\p " ) );
            spc--;
        }
    }
}

// 2021-Jan-15 Brian
void PrintContainerWnd( void  **ctnrVarPtr )
{
    SInt64            ctnrLength, p;
    UInt8             c;
    Str255            tempPStr;
    void             *ctnrPointer;
    
    ctnrPointer = *ctnrVarPtr;
    if ( ctnrPointer ) {
        ctnrLength = CtnrRequestedSize(ctnrPointer);
        p = 0;
        tempPStr[0] = 0;
        while ( p < ctnrLength ) {
            if ( tempPStr[0] == 255 ) {
                FBPrintString( PSstrcpy( STACK_PUSH(), tempPStr ) );
                tempPStr[0] = 0;
            }
            c = *(UInt8*)(ctnrPointer + p);
            p++;
            if ( c == 13 ) {
                FBPrintString( PSstrcpy( STACK_PUSH(), tempPStr ) );
                PrintCR();
                tempPStr[0] = 0;
            } else {
                tempPStr[++tempPStr[0]] = c;
            }
        }
        FBPrintString( PSstrcpy( STACK_PUSH(), tempPStr ) );
    }
}

//  Pos() returns only a File position via FBFileGetPos().  Brian 20190929
long Pos( long device )
{
    long vPos = 0;
    
    if ( device == 0 || device == 1 )  {  //_printDev or _anyDev

    } else if ( device >= kToBuffer ) {

    } else {
        vPos = FBFileGetPos();
    }
    return vPos;
}

void RuntimeErrMsg( StringPtr  msg )
{
    /*
     Called by EmbedButton etc in Subs Appearance Btns.incl
     and by FBEditDollarStatement()
     Supposed to be shown for a run but skipped in a built app, but FBtoC has no such concept
     */
    char string[256];
    //BlockMoveData( &msg[1], string, msg[0] );  // src >> dest
    memmove( string, &msg[1], msg[0] );          // dest <<< src
    string[msg[0]] = 0; // null-terminate
    fprintf( stderr, "%s\n", string ); // discreetly hidden from Joe Public
}

static CFStringRef FBCreateLineNumberMsg( const int lineNumber )
{
     // "At line xxxx."
    
    CFStringRef atLineString = (__bridge CFStringRef)NSLocalizedStringFromTable(@"At line",@"Runtime",@"FBCreateLineNumberMsg");
    CFStringRef msg = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@ %d"), atLineString, lineNumber );
    return msg;
}

void FBStopMsg( ConstStr255Param msg_p, const int  lineNumber )
{
    // FB 'stop'
     
    Str255 msg;  PSstrcpy( msg, msg_p );
    gFBStk--;
    
    CFStringRef msgString = CFStringCreateWithPascalString( kCFAllocatorDefault, msg, kCFStringEncodingUTF8 );// 20180611 bw

    CFStringRef lineNumString = FBCreateLineNumberMsg(lineNumber);
    
    FBFullStop( msgString, lineNumString, false );// 20201213 bw
    
    CFRelease( msgString );
    CFRelease( lineNumString );
    
}

void FBShutdown( void *msgPtr, Boolean cfType )
{
    // FB 'shutdown'
     
    if ( cfType ) {
        FBFullStop( msgPtr, (__bridge CFStringRef)NSLocalizedStringFromTable(@"The application must quit",@"Runtime",@"FBShutdown"), true );
    } else {
        Str255 msg;  PSstrcpy( msg, msgPtr );
        gFBStk--;
        CFStringRef msgString = CFStringCreateWithPascalString( kCFAllocatorDefault, msg, kCFStringEncodingMacRoman );
        FBFullStop( msgString, (__bridge CFStringRef)NSLocalizedStringFromTable(@"The application must quit",@"Runtime",@"FBShutdown"), true );
        CFRelease( msgString );
    }
}

void FBReportRangeError( const int  value, const int  lineNumber, const int  limit, CFStringRef fileName )
{
     //array bounds error
     
    CFStringRef atLineMsg = FBCreateLineNumberMsg( lineNumber );
    CFStringRef s1 = (__bridge CFStringRef)NSLocalizedStringFromTable(@" of ",@"Runtime",@"FBReportRangeError");
    CFStringRef s2 = (__bridge CFStringRef)NSLocalizedStringFromTable(@"Index ",@"Runtime",@"FBReportRangeError");
    CFStringRef s3 = (__bridge CFStringRef)NSLocalizedStringFromTable(@" is outside the DIM range 0 to",@"Runtime",@"FBReportRangeError");
    CFStringRef string = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%@%@\n%@%d%@ %d"),atLineMsg,s1,fileName,s2,value,s3,limit);
    CFRelease(atLineMsg);
    
    // get C string for fprintf
    char *buffer;
    CFIndex length = CFStringGetMaximumSizeForEncoding( CFStringGetLength( string ), kCFStringEncodingMacRoman ) + 1;
    buffer = malloc( length );
    CFStringGetCString( string, buffer, length, kCFStringEncodingMacRoman );
    fprintf( stderr, "Array bounds error:\n" );
    fprintf( stderr, "%s. [Type ctrl-C if process hangs]\n", buffer );//(UInt8 *)
    free( buffer );
    
    FBFullStop( (__bridge CFStringRef)NSLocalizedStringFromTable( @"Array bounds error",@"Runtime",@"FBReportRangeError"), string, true );
    CFRelease( string );
}
