//
//  BitVector.m
//
//  Bernie Wylde

#import "BitVector.h"

// Create
CFBitVectorRef BitVectorWithBytes( const UInt8 *bytes, NSInteger numBits )
{
#if __has_feature(objc_arc)
    return CFBitVectorCreate( kCFAllocatorDefault, bytes, numBits);
#else
    return (CFBitVectorRef)[(id)CFBitVectorCreate( kCFAllocatorDefault, bytes, numBits) autorelease];
#endif
}

CFBitVectorRef BitVectorWithBitVector( CFBitVectorRef bv )
{
#if __has_feature(objc_arc)
    return CFBitVectorCreateCopy( kCFAllocatorDefault, bv );
#else
    return (CFBitVectorRef)[(id)CFBitVectorCreateCopy( kCFAllocatorDefault, bv ) autorelease];
#endif
}

// Info
BOOL BitVectorContainsBit( CFBitVectorRef bv, CFRange range, CFBit value )
{ return CFBitVectorContainsBit( bv, range, value ); }

CFBit BitVectorBitAtIndex( CFBitVectorRef bv, NSInteger idx )
{ return CFBitVectorGetBitAtIndex( bv, idx ); }

void BitVectorGetBits( CFBitVectorRef bv, CFRange range, UInt8 *bytes )
{ CFBitVectorGetBits( bv, range, bytes ); }

NSInteger BitVectorCount( CFBitVectorRef bv )
{ return CFBitVectorGetCount( bv ); }

NSInteger BitVectorCountOfBit( CFBitVectorRef bv, CFRange range, CFBit value )
{ return CFBitVectorGetCountOfBit( bv, range, value ); }

NSInteger BitVectorFirstIndexOfBit( CFBitVectorRef bv, CFRange range, CFBit value )
{ return CFBitVectorGetFirstIndexOfBit( bv, range, value ); }

NSInteger BitVectorLastIndexOfBit( CFBitVectorRef bv, CFRange range, CFBit value )
{ return CFBitVectorGetLastIndexOfBit( bv, range, value ); }

// TypeID
CFTypeID BitVectorTypeID( void )
{ return CFBitVectorGetTypeID(); }

// Custom
//CFBitVectorRef BitVectorWithIntegerValue( NSInteger value )
//{ return (CFBitVectorRef)[(id)CFBitVectorCreate( kCFAllocatorDefault, (UInt8 *)&value, sizeof(NSInteger)) autorelease]; }
//
//NSInteger BitVectorIntegerValue( CFBitVectorRef bv )
//{
//    NSInteger value = 0;
//    NSUInteger count = CFBitVectorGetCount(bv);
//    if ( count <= sizeof(NSInteger) ) {
//        CFBitVectorGetBits( bv, CFRangeMake(0,count), (UInt8 *)&value );
//    }
//    return value;
//}


#pragma mark - mutable bit vector

// Create
CFMutableBitVectorRef MutableBitVectorWithCapacity( NSInteger capacity )
{
#if __has_feature(objc_arc)
    return CFBitVectorCreateMutable( kCFAllocatorDefault, capacity );
#else
    return (CFMutableBitVectorRef)[(id)CFBitVectorCreateMutable( kCFAllocatorDefault, capacity ) autorelease];
#endif
}
                                                             
CFMutableBitVectorRef MutableBitVectorWithBitVector( NSInteger capacity, CFBitVectorRef bv )
{
#if __has_feature(objc_arc)
    return CFBitVectorCreateMutableCopy( kCFAllocatorDefault, capacity, bv );
#else
    return (CFMutableBitVectorRef)[(id)CFBitVectorCreateMutableCopy( kCFAllocatorDefault, capacity, bv ) autorelease];
#endif
}

// Modify
void MutableBitVectorFlipBitAtIndex( CFMutableBitVectorRef bv, NSInteger idx )
{ CFBitVectorFlipBitAtIndex( bv, idx ); }

void MutableBitVectorFlipBits( CFMutableBitVectorRef bv, CFRange range )
{ CFBitVectorFlipBits( bv, range ); }

void MutableBitVectorSetAllBits( CFMutableBitVectorRef bv, CFBit value )
{ CFBitVectorSetAllBits( bv, value ); }

void MutableBitVectorSetBitAtIndex( CFMutableBitVectorRef bv, NSInteger idx, CFBit value )
{ CFBitVectorSetBitAtIndex( bv, idx, value ); }

void MutableBitVectorSetBits( CFMutableBitVectorRef bv, CFRange range, CFBit value )
{ CFBitVectorSetBits( bv, range, value ); }

void MutableBitVectorSetCount( CFMutableBitVectorRef bv, NSInteger count )
{ CFBitVectorSetCount( bv, count ); }

// Custom
//CFMutableBitVectorRef MutableBitVectorWithIntegerValue( NSInteger value )
//{
//    CFBitVectorRef bv = (CFBitVectorRef)[(id)CFBitVectorCreate( kCFAllocatorDefault, (UInt8 *)&value, sizeof(NSInteger)) autorelease];
//    return (CFMutableBitVectorRef)[(id)CFBitVectorCreateMutableCopy( kCFAllocatorDefault, sizeof(NSInteger), bv ) autorelease];
//}

//void MutableBitVectorSetIntegerValue( CFMutableBitVectorRef bv, NSInteger value )
//{
//    NSUInteger count = CFBitVectorGetCount(bv);
//    if ( count >= sizeof(NSInteger) ) {
//        CFBitVectorSetAllBits( bv, 0 );
//        
//    }
//}

