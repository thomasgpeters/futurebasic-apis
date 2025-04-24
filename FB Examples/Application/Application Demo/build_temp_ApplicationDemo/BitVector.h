//
//  BitVector.h
//
//  Bernie Wylde

#import <Cocoa/Cocoa.h>

// Create
CFBitVectorRef BitVectorWithBytes( const UInt8 *bytes, NSInteger numBits );
CFBitVectorRef BitVectorWithBitVector( CFBitVectorRef bv );

// Info
BOOL BitVectorContainsBit( CFBitVectorRef bv, CFRange range, CFBit value );
CFBit BitVectorBitAtIndex( CFBitVectorRef bv, NSInteger idx );
void BitVectorGetBits( CFBitVectorRef bv, CFRange range, UInt8 *bytes );
NSInteger BitVectorCount( CFBitVectorRef bv );
NSInteger BitVectorCountOfBit( CFBitVectorRef bv, CFRange range, CFBit value );
NSInteger BitVectorFirstIndexOfBit( CFBitVectorRef bv, CFRange range, CFBit value );
NSInteger BitVectorLastIndexOfBit( CFBitVectorRef bv, CFRange range, CFBit value );

// TypeID
CFTypeID BitVectorTypeID( void );

// Custom
//CFBitVectorRef BitVectorWithIntegerValue( NSInteger value );
//NSInteger BitVectorIntegerValue( CFBitVectorRef bv );


#pragma mark - MutableBitVector

// Create
CFMutableBitVectorRef MutableBitVectorWithCapacity( NSInteger capacity );
CFMutableBitVectorRef MutableBitVectorWithBitVector( NSInteger capacity, CFBitVectorRef bv );

// Modify
void MutableBitVectorFlipBitAtIndex( CFMutableBitVectorRef bv, NSInteger idx );
void MutableBitVectorFlipBits( CFMutableBitVectorRef bv, CFRange range );
void MutableBitVectorSetAllBits( CFMutableBitVectorRef bv, CFBit value );
void MutableBitVectorSetBitAtIndex( CFMutableBitVectorRef bv, NSInteger idx, CFBit value );
void MutableBitVectorSetBits( CFMutableBitVectorRef bv, CFRange range, CFBit value );
void MutableBitVectorSetCount( CFMutableBitVectorRef bv, NSInteger count );

// Custom
//CFMutableBitVectorRef MutableBitVectorWithIntegerValue( NSInteger value );
//void MutableBitVectorSetIntegerValue( CFMutableBitVectorRef bv, NSInteger value );

