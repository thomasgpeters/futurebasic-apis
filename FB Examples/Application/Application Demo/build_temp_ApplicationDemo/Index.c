
// prefix header, with public (user-code-reachable) struct and typedef declarations
// some of these functions are toolbox referenced in CFIndex.incl within build_goodies

#import "FBtoC.h"
#import "Runtime.h"

/*
 *  FBtoCIndex.c
 *
 */
///////////////////////////////////////////////////
//   index$ stuff          //
///////////////////////////////////////////////////

//------------------------------------------------------------------------------
// Private
//------------------------------------------------------------------------------

#define  kFBIndexMaxArray 9

CFMutableArrayRef gFBIndex[kFBIndexMaxArray + 1];

static CFMutableArrayRef CFIndexGetArray_priv( CFIndex indexID )
{
	if ( indexID < 0 || indexID > kFBIndexMaxArray ) indexID = 0;
	return gFBIndex[indexID];
}


static void CFIndexSetArray_priv( CFIndex indexID, CFMutableArrayRef array )
{
	if ( indexID < 0 || indexID > kFBIndexMaxArray ) indexID = 0;
	gFBIndex[indexID] = array;
}


static void CFIndexReleaseArray_priv( CFIndex indexID )
{
	CFMutableArrayRef array = CFIndexGetArray_priv( indexID );
	if ( array ) {
		CFRelease( array );
		CFIndexSetArray_priv( indexID, 0 );
	}
}


//------------------------------------------------------------------------------
// User
//------------------------------------------------------------------------------

CFMutableArrayRef CFIndexGetArrayRef( CFIndex indexID )
{ return CFIndexGetArray_priv( indexID ); }


CFIndex CFIndexGetCount( CFIndex indexID )
{
	CFMutableArrayRef array = CFIndexGetArray_priv( indexID );
	if ( array ) return CFArrayGetCount( array );
	return 0;
}

void CFIndexSet( CFIndex indexID, CFIndex element, Str255 pStr )
{
	CFStringRef	string;
	
	CFMutableArrayRef array = CFIndexGetArray_priv( indexID );
	if ( !array ) {
		array = CFArrayCreateMutable( NULL, 0, &kCFTypeArrayCallBacks );
		CFIndexSetArray_priv( indexID, array );
	}
	if ( array ) {
		CFIndex count = CFArrayGetCount( array );
		while ( count < element ) {
			string = CFStringCreateWithPascalString( NULL, "\p", kCFStringEncodingMacRoman );
			if ( string ) {
				CFArrayAppendValue( array, string );
				CFRelease( string );
			}
			count++;
		}
		string = CFStringCreateWithPascalString( NULL, pStr, kCFStringEncodingMacRoman );
		if ( string ) {
			CFArraySetValueAtIndex( array, element, string );
			CFRelease( string );
		}
	}
}


/*
 index$( element [, indexID] ) = string
 */
void FBIndexSet( CFIndex element, CFIndex indexID, Str255 pStr )
{ CFIndexSet( indexID, element, pStr ); }


StringPtr CFIndexGet( CFIndex indexID, CFIndex element )
{
	gReturnedString[0] = 0;
	
	CFMutableArrayRef array = CFIndexGetArray_priv( indexID );
	if ( array ) {
		if ( element < CFArrayGetCount( array ) ) {
			CFStringGetPascalString( CFArrayGetValueAtIndex( array, element ), gReturnedString, 256, kCFStringEncodingMacRoman );
		}
	}
	return gReturnedString;
}


/*
 string = index$( element [, indexID] )
 */
StringPtr FBIndexGet( CFIndex element, CFIndex indexID )
{ return CFIndexGet( indexID, element ); }

void CFIndexInsert( CFIndex indexID, CFIndex element, Str255 pStr )
{
	CFStringRef	string;
		
	CFMutableArrayRef array = CFIndexGetArray_priv( indexID );
	if ( !array ) {
		array = CFArrayCreateMutable( NULL, 0, &kCFTypeArrayCallBacks );
		CFIndexSetArray_priv( indexID, array );
	}
	if ( array ) {
		CFIndex count = CFArrayGetCount( array );
		if ( element <= count ) {
			string = CFStringCreateWithPascalString( NULL, pStr, kCFStringEncodingMacRoman );
			if ( string ) {
				CFArrayInsertValueAtIndex( array, element, string );
				CFRelease( string );
			}
		} else {
			CFIndexSet( indexID, element, pStr );
		}
	}
}


/*
 index$ I( element [, indexID] ) = string
 */
void FBIndexI( CFIndex element, CFIndex indexID, Str255 pStr )
{ CFIndexInsert( indexID, element, pStr ); }


void CFIndexDelete( CFIndex indexID, CFIndex element )
{
	CFMutableArrayRef array = CFIndexGetArray_priv( indexID );
	if ( array ) {
		if ( element < CFArrayGetCount( array ) ) CFArrayRemoveValueAtIndex( array, element );
	}
}


/*
 index$ D( element [, indexID] )
 */
void FBIndexD( CFIndex element, CFIndex indexID )
{ CFIndexDelete( indexID, element ); }


CFIndex CFIndexFind( CFIndex indexID, CFIndex startElement, Str255 pStr )
{
	CFRange		range;
	CFIndex		element = -1;
		
	CFMutableArrayRef array = CFIndexGetArray_priv( indexID );
	if ( array ) {
		CFIndex count = CFArrayGetCount( array );
		if ( startElement < count ) {
			CFStringRef stringToFind = CFStringCreateWithPascalString( NULL, pStr, kCFStringEncodingMacRoman );
			if ( stringToFind ) {
				CFIndex i = startElement;
				do {
					range = CFStringFind( CFArrayGetValueAtIndex( array, i ), stringToFind, 0 );
					i++;
				}
				while ( ( range.location == kCFNotFound ) && ( i < count ) );
				if ( range.location != kCFNotFound ) element = i - 1;
				CFRelease( stringToFind );
			}
		}
	}
	return element;
}


/*
 foundElement = indexf( stringToFind [, startElement [,indexID]] )
 */
CFIndex FBIndexF( Str255 pStr, CFIndex startElement, CFIndex indexID )
{
	gFBStk--; // keep stack happy
	return CFIndexFind( indexID, startElement, pStr );
}


/*
 clear -1
 clear index$ [indexID]
 */
void CFIndexClear( CFIndex indexID )
{
	CFIndex	i;

	if ( indexID < 0 ) {
		for ( i = 0; i <= kFBIndexMaxArray; i++ ) CFIndexReleaseArray_priv( i );
	} else {
		CFIndexReleaseArray_priv( indexID );
	}
}


CFComparisonResult CFIndexCompareFunction( const void *val1, const void *val2, void *context  __attribute__ ((__unused__)) )
{ return CFStringCompare( val1, val2, kCFCompareCaseInsensitive ); }


void CFIndexSort( CFIndex indexID )
{
	CFMutableArrayRef array = CFIndexGetArray_priv( indexID );
	if ( array ) CFArraySortValues( array, CFRangeMake( 0, CFArrayGetCount( array ) ), CFIndexCompareFunction, 0 );	
}


void CFIndexAppend( CFIndex indexID, Str255 pStr )
{
	CFMutableArrayRef array = CFIndexGetArray_priv( indexID );
	if ( !array ) {
		array = CFArrayCreateMutable( NULL, 0, &kCFTypeArrayCallBacks );
		CFIndexSetArray_priv( indexID, array );
	}
	if ( array ) {
		CFStringRef string = CFStringCreateWithPascalString( NULL, pStr, kCFStringEncodingMacRoman );
		if ( string ) {
			CFArrayAppendValue( array, string );
			CFRelease( string );
		}	
	}
}

Boolean CFIndexWrite( CFIndex indexID, CFURLRef url )
{
    Boolean result = false;
    CFMutableArrayRef array = CFIndexGetArray_priv( indexID );
    if ( array ) {
        result = [(__bridge NSArray *)array writeToURL:(__bridge NSURL *)url error:nil];
    }
    return result;
} 


Boolean CFIndexWriteAll( CFURLRef url )
{
    CFMutableArrayRef   array;
	CFIndex             index;
	Boolean             result = false;
	
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:0];
    if ( tempArray ) {
        for ( index = 0; index <= kFBIndexMaxArray; index++ ) {
            array = CFIndexGetArray_priv( index );
            if ( array ) {
                [tempArray addObject:(__bridge NSArray *)array];
            } else {
                [tempArray addObject:@[]];// empty array
            }
        }
        result = [tempArray writeToURL:(__bridge NSURL *)url error:nil];
    }
    return result;
}


Boolean CFIndexRead( CFIndex indexID,  CFURLRef inURL )
{
    Boolean	 result = false;
    CFMutableArrayRef array = CFIndexGetArray_priv( indexID );
    if ( !array ) {
        NSURL *url = (__bridge NSURL *)inURL;
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithContentsOfURL:url error:nil];
        CFIndexSetArray_priv( indexID, (__bridge CFMutableArrayRef)tempArray );
    }
	return result;
} 


Boolean CFIndexReadAll( CFURLRef url )
{
	Boolean result = false;
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithContentsOfURL:(__bridge NSURL *)url];
    if ( tempArray ) {
        NSInteger count = [tempArray count];
        if ( count == kFBIndexMaxArray + 1 ) {
            for ( NSInteger index = 0; index < count; index++ ) {
                NSMutableArray *array = [[tempArray objectAtIndex:index] mutableCopy];
                CFIndexReleaseArray_priv( index );
                CFIndexSetArray_priv( index, (__bridge CFMutableArrayRef)array );
            }
        }
    }
	return result;
}


/*
 info = mem( expr ) 
 */
CFIndex FBMem( long expr )
{
	if ( expr < 0 ) {
		return( 0 ); // rp:20100226 
	} else {
		CFIndex	indexID = ( expr % 10 );
		expr -= indexID;
		if ( expr == 10 ) return CFIndexGetCount( indexID );
	}
	return 0;
}

