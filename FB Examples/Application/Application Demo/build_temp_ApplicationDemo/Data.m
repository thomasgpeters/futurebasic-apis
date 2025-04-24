/*
 Data.m

 Bernie Wylde
 */

#import "Data.h"

// Class
Class DataClass( void )
{ return [NSData class]; }

// - create -
CFDataRef DataWithBytes( void *bytes, NSUInteger length )
{ return (__bridge CFDataRef)[NSData dataWithBytes:bytes length:length]; }

// - read -
CFDataRef DataWithContentsOfURL( CFURLRef url, NSDataReadingOptions options, NSError **err )
{ return (__bridge CFDataRef)[NSData dataWithContentsOfURL:(__bridge NSURL *)url options:options error:err]; }

// - write -
BOOL DataWriteToURL( CFDataRef ref, CFURLRef url, NSDataWritingOptions options, NSError **err )
{ return [(__bridge NSData *)ref writeToURL:(__bridge NSURL *)url options:options error:err]; }

// Encoding/decoding Base64 representation
CFDataRef DataWithBase64EncodedString( CFStringRef string, NSDataBase64DecodingOptions options )
{
#if __has_feature(objc_arc)
    return (__bridge CFDataRef)[[NSData alloc] initWithBase64EncodedString:(__bridge NSString *)string options:options];
#else
    return (__bridge CFDataRef)[[[NSData alloc] initWithBase64EncodedString:(__bridge NSString *)string options:options] autorelease];
#endif
}

CFDataRef DataBase64EncodedData( CFDataRef ref, NSDataBase64EncodingOptions options )
{ return (__bridge CFDataRef)[(__bridge NSData *)ref base64EncodedDataWithOptions:options]; }

CFStringRef DataBase64EncodedString( CFDataRef ref, NSDataBase64EncodingOptions options )
{ return (__bridge CFStringRef)[(__bridge NSData *)ref base64EncodedStringWithOptions:options]; }

// - access bytes -
void *DataBytes( CFDataRef ref )
{ return (void *)[(__bridge NSData *)ref bytes]; }

void DataEnumerateByteRanges( CFDataRef ref, CUI_DataEnumerateByteRangesCallbackType callback, void *userData )
{
    [(__bridge NSData *)ref enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        (*callback)(ref,bytes,NSRangeToCFRange(byteRange),stop,userData);
    }];
}

void DataGetBytes( CFDataRef ref, void *buffer, NSUInteger length )
{ [(__bridge NSData *)ref getBytes:buffer length:length]; }

void DataGetBytesInRange( CFDataRef ref, void *buffer, CFRange range )
{ [(__bridge NSData *)ref getBytes:buffer range:NSRangeFromCFRange(range)]; }

// - find -
CFDataRef DataSubdata( CFDataRef ref, CFRange range )
{ return (__bridge CFDataRef)[(__bridge NSData *)ref subdataWithRange:NSRangeFromCFRange(range)]; }

CFRange DataRangeOfData( CFDataRef ref, CFDataRef dataToFind, NSDataSearchOptions searchOptions, CFRange searchRange )
{
    NSRange range = [(__bridge NSData *)ref rangeOfData:(__bridge NSData *)dataToFind options:searchOptions range:NSRangeFromCFRange(searchRange)];
    return NSRangeToCFRange( range );
}

// - test -
BOOL DataIsEqual( CFDataRef ref1, CFDataRef ref2 )
{ return [(__bridge NSData *)ref1 isEqualToData:(__bridge NSData *)ref2]; }

NSUInteger DataLength( CFDataRef ref )
{ return [(__bridge NSData *)ref length]; }

// - description -
CFStringRef DataDescription( CFDataRef ref )
{ return (__bridge CFStringRef)[(__bridge NSData *)ref description]; }

// Compress and decompress
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CFDataRef DataCompressedDataUsingAlgorithm( CFDataRef ref, NSDataCompressionAlgorithm algorithm, NSError **err )
{ return (__bridge CFDataRef)[(__bridge NSData *)ref compressedDataUsingAlgorithm:algorithm error:err]; }

CFDataRef DataDecompressedDataUsingAlgorithm( CFDataRef ref, NSDataCompressionAlgorithm algorithm, NSError **err )
{ return (__bridge CFDataRef)[(__bridge NSData *)ref decompressedDataUsingAlgorithm:algorithm error:err]; }
#endif// 101500


#pragma mark - mutable data
// Class
Class MutableDataClass( void )
{ return [NSMutableData class]; }

// - create -
CFMutableDataRef MutableDataNew( void )
{
#if __has_feature(objc_arc)
    return (__bridge CFMutableDataRef)[NSMutableData new];
#else
    return (__bridge CFMutableDataRef)[[NSMutableData new] autorelease];
#endif
}

CFMutableDataRef MutableDataWithCapacity( NSUInteger size )
{ return (__bridge CFMutableDataRef)[NSMutableData dataWithCapacity:size]; }

CFMutableDataRef MutableDataWithLength( NSUInteger length )
{ return (__bridge CFMutableDataRef)[NSMutableData dataWithLength:length]; }

CFMutableDataRef MutableDataWithBytes( void *bytes, NSUInteger length )
{ return (__bridge CFMutableDataRef)[NSMutableData dataWithBytes:bytes length:length]; }

CFMutableDataRef MutableDataWithContentsOfURL( CFURLRef url, NSDataReadingOptions options, NSError **err )
{ return (__bridge CFMutableDataRef)[NSMutableData dataWithContentsOfURL:(__bridge NSURL *)url options:options error:err]; }

// - access -
void *MutableDataBytes( CFMutableDataRef ref )
{ return [(__bridge NSMutableData *)ref mutableBytes]; }

// - length -
void MutableDataSetLength( CFMutableDataRef ref, NSUInteger length )
{ [(__bridge NSMutableData *)ref setLength:length]; }

// - add -
void MutableDataAppendBytes( CFMutableDataRef ref, void *bytes, NSUInteger length )
{ [(__bridge NSMutableData *)ref appendBytes:bytes length:length]; }

void MutableDataAppendData( CFMutableDataRef ref1, CFDataRef ref2 )
{ [(__bridge NSMutableData *)ref1 appendData:(__bridge NSData *)ref2]; }

void MutableDataIncreaseLengthBy( CFMutableDataRef ref, NSUInteger extraLength )
{ [(__bridge NSMutableData *)ref increaseLengthBy:extraLength]; }

// - modify -
void MutableDataReplaceBytesInRange( CFMutableDataRef ref, void *replacementBytes, CFRange range )
{ [(__bridge NSMutableData *)ref replaceBytesInRange:NSRangeFromCFRange(range) withBytes:replacementBytes]; }

void MutableDataReplaceBytesWithLength( CFMutableDataRef ref, void *replacementBytes, CFRange range, NSUInteger length )
{ [(__bridge NSMutableData *)ref replaceBytesInRange:NSRangeFromCFRange(range) withBytes:replacementBytes length:length]; }

void MutableDataResetBytesInRange( CFMutableDataRef ref, CFRange range )
{ [(__bridge NSMutableData *)ref resetBytesInRange:NSRangeFromCFRange(range)]; }

void MutableDataSetData( CFMutableDataRef ref1, CFDataRef ref2 )
{ [(__bridge NSMutableData *)ref1 setData:(__bridge NSData *)ref2]; }

// Compress and decompress
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
BOOL MutableDataCompressUsingAlgorithm( CFMutableDataRef ref, NSDataCompressionAlgorithm algorithm, NSError **err )
{ return [(__bridge NSMutableData *)ref compressUsingAlgorithm:algorithm error:err]; }

BOOL MutableDataDecompressUsingAlgorithm( CFMutableDataRef ref, NSDataCompressionAlgorithm algorithm, NSError **err )
{ return [(__bridge NSMutableData *)ref decompressUsingAlgorithm:algorithm error:err]; }
#endif//101500
