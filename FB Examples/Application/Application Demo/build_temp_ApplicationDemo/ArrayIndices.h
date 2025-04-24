
#import "FBtoC.h"
#import "Runtime.h"

// static inline functions

///////////////////////////////////////////////////////////
//                 array bounds checking                 //
///////////////////////////////////////////////////////////

/*
 All non-dynamic array references come here if bounds checking is enabled.
 */


/*
 'unsigned' here ensures that negative indices (in the FB source) are illegal.
*/

/*
static inline int ChkBounds( const unsigned int index, const unsigned int maxIndex, const int lineNum, ConstStr255Param fileName )
{
    if ( index > maxIndex ) FBReportRangeError( index, lineNum, maxIndex, fileName );
    return index;
}
*/

/*
  Brian & Bernie 7-Apr-2016 - when FBtoC generates calls to ChkBounds(), it now passes a CFStringRef for the last ( fileName ) parameter
 
*/

static inline int ChkBounds( const unsigned int index, const unsigned int maxIndex, const int lineNum, CFStringRef fileName ) {
    if ( index > maxIndex ) {
        FBReportRangeError( index, lineNum, maxIndex, fileName );
    }
    return index;
}

///////////////////////////////////////////////////////////
//                 dynamic array support                 //
///////////////////////////////////////////////////////////

/*
 All dynamic array references come here.
 Signed/unsigned casts ensure that 'negative' indices are illegal.
 */
static inline void * FBDynamicArray( const int dynArrayNum, const unsigned long index ) { //2023-Nov-15 Brian
    // if the requested array access is beyond the current array size, enlarge it accomodate. 2022-Jan-10 Brian
	if ( index >= (unsigned)gFBDynArrayInfo[dynArrayNum].maxIndex ) FBGrowDynamicArray( dynArrayNum, index ); // grow only if required
    
    if ( (signed)index > (signed)gFBDynArrayInfo[dynArrayNum].lastElem ) gFBDynArrayInfo[dynArrayNum].lastElem = index;
        
    return gFBDynArrayInfo[dynArrayNum].base + index * gFBDynArrayInfo[dynArrayNum].elemSize; // pointer to the element referenced
}


static inline void * FBDynamicArrayRecord( const int dynArrayNum, const unsigned long index, const unsigned long fieldOffset ) { //2023-Nov-16 Brian
    // this function is identical to FBDynamicArray() above except for the fieldOffset within the record to the pointer. 2022-Jan-10 Brian
    // which means the final calculated pointer address is that record field.
    return FBDynamicArray( dynArrayNum, index ) + fieldOffset;
    
	//if ( index >= (unsigned)gFBDynArrayInfo[dynArrayNum].maxIndex ) FBGrowDynamicArray( dynArrayNum, index ); // grow only if required
    //if ( (signed)index > (signed)gFBDynArrayInfo[dynArrayNum].lastElem ) gFBDynArrayInfo[dynArrayNum].lastElem = index;
	//return gFBDynArrayInfo[dynArrayNum].base + index * gFBDynArrayInfo[dynArrayNum].elemSize + fieldOffset; // pointer to the element referenced
}
