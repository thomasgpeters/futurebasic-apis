/*
 Data.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_DataEnumerateByteRangesCallbackType)(CFDataRef,const void*,CFRange,BOOL*,void*);

// Class
Class DataClass( void );

// - create -
CFDataRef DataWithBytes( void *bytes, NSUInteger length );

// - read -
CFDataRef DataWithContentsOfURL( CFURLRef url, NSDataReadingOptions options, NSError **err );

// - write -
BOOL DataWriteToURL( CFDataRef ref, CFURLRef url, NSDataWritingOptions options, NSError **err );

// Encoding/decoding Base64 representation
CFDataRef DataWithBase64EncodedString( CFStringRef string, NSDataBase64DecodingOptions options );
CFDataRef DataBase64EncodedData( CFDataRef ref, NSDataBase64EncodingOptions options );
CFStringRef DataBase64EncodedString( CFDataRef ref, NSDataBase64EncodingOptions options );

// - access bytes -
void *DataBytes( CFDataRef ref );
void DataEnumerateByteRanges( CFDataRef ref, CUI_DataEnumerateByteRangesCallbackType callback, void *userData );
void DataGetBytes( CFDataRef ref, void *buffer, NSUInteger length );
void DataGetBytesInRange( CFDataRef ref, void *buffer, CFRange range );

// - find -
CFDataRef DataSubdata( CFDataRef ref, CFRange range );
CFRange DataRangeOfData( CFDataRef ref, CFDataRef dataToFind, NSDataSearchOptions searchOptions, CFRange searchRange );

// - test -
BOOL DataIsEqual( CFDataRef ref1, CFDataRef ref2 );
NSUInteger DataLength( CFDataRef ref );

// - description -
CFStringRef DataDescription( CFDataRef ref );

// Compress and decompress
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
CFDataRef DataCompressedDataUsingAlgorithm( CFDataRef ref, NSDataCompressionAlgorithm algorithm, NSError **err );
API_AVAILABLE(macos(10.15))
CFDataRef DataDecompressedDataUsingAlgorithm( CFDataRef ref, NSDataCompressionAlgorithm algorithm, NSError **err );
#endif// 101500

#pragma mark - mutable data
// Class
Class MutableDataClass( void );

// - create -
CFMutableDataRef MutableDataNew( void );
CFMutableDataRef MutableDataWithCapacity( NSUInteger size );
CFMutableDataRef MutableDataWithLength( NSUInteger length );
CFMutableDataRef MutableDataWithBytes( void *bytes, NSUInteger length );
CFMutableDataRef MutableDataWithContentsOfURL( CFURLRef url, NSDataReadingOptions options, NSError **err );

// - access -
void *MutableDataBytes( CFMutableDataRef ref );

// - length -
void MutableDataSetLength( CFMutableDataRef ref, NSUInteger length );

// - add -
void MutableDataAppendBytes( CFMutableDataRef ref, void *bytes, NSUInteger length );
void MutableDataAppendData( CFMutableDataRef ref1, CFDataRef ref2 );
void MutableDataIncreaseLengthBy( CFMutableDataRef ref, NSUInteger extraLength );

// - modify -
void MutableDataReplaceBytesInRange( CFMutableDataRef ref, void *replacementBytes, CFRange range );
void MutableDataReplaceBytesWithLength( CFMutableDataRef ref, void *replacementBytes, CFRange range, NSUInteger length );
void MutableDataResetBytesInRange( CFMutableDataRef ref, CFRange range );
void MutableDataSetData( CFMutableDataRef ref1, CFDataRef ref2 );

// Compress and decompress
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
BOOL MutableDataCompressUsingAlgorithm( CFMutableDataRef ref, NSDataCompressionAlgorithm algorithm, NSError **err );
API_AVAILABLE(macos(10.15))
BOOL MutableDataDecompressUsingAlgorithm( CFMutableDataRef ref, NSDataCompressionAlgorithm algorithm, NSError **err );
#endif//101500
