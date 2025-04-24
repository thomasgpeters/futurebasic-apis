/*
 CAEmitterCell.m
 
 Bernie Wylde
 */

#import "CAEmitterCell.h"

// Create
CAEmitterCell *CAEmitterCellInit( void )
{ return [CAEmitterCell emitterCell]; }

// Content
id CAEmitterCellContents( CAEmitterCell *ref )
{ return [ref contents]; }

void CAEmitterCellSetContents( CAEmitterCell *ref, id contents )
{ [ref setContents:contents]; }

CGRect CAEmitterCellContentsRect( CAEmitterCell *ref )
{ return [ref contentsRect]; }

void CAEmitterCellSetContentsRect( CAEmitterCell *ref, CGRect rect )
{ [ref setContentsRect:rect]; }

CFArrayRef CAEmitterCellEmitterCells( CAEmitterCell *ref )
{ return (__bridge CFArrayRef)[ref emitterCells]; }

void CAEmitterCellSetEmitterCells( CAEmitterCell *ref, CFArrayRef cells )
{ [ref setEmitterCells:(__bridge NSArray *)cells]; }

// Visual attributes
BOOL CAEmitterCellIsEnabled( CAEmitterCell *ref )
{ return [ref isEnabled]; }

void CAEmitterCellSetEnabled( CAEmitterCell *ref, BOOL flag )
{ [ref setEnabled:flag]; }

NSColor *CAEmitterCellColor( CAEmitterCell *ref )
{
    CGColorRef col = [ref color];
    if ( col ) return [NSColor colorWithCGColor:col];
    return nil;
}

void CAEmitterCellSetColor( CAEmitterCell *ref, NSColor *col )
{ [ref setColor:[col CGColor]]; }

float CAEmitterCellRedRange( CAEmitterCell *ref )
{ return [ref redRange]; }

void CAEmitterCellSetRedRange( CAEmitterCell *ref, float value )
{ [ref setRedRange:value]; }

float CAEmitterCellGreenRange( CAEmitterCell *ref )
{ return [ref greenRange]; }

void CAEmitterCellSetGreenRange( CAEmitterCell *ref, float value )
{ [ref setGreenRange:value]; }

float CAEmitterCellBlueRange( CAEmitterCell *ref )
{ return [ref blueRange]; }

void CAEmitterCellSetBlueRange( CAEmitterCell *ref, float value )
{ [ref setBlueRange:value]; }

float CAEmitterCellAlphaRange( CAEmitterCell *ref )
{ return [ref alphaRange]; }

void CAEmitterCellSetAlphaRange( CAEmitterCell *ref, float value )
{ [ref setAlphaRange:value]; }

float CAEmitterCellRedSpeed( CAEmitterCell *ref )
{ return [ref redSpeed]; }

void CAEmitterCellSetRedSpeed( CAEmitterCell *ref, float value )
{ [ref setRedSpeed:value]; }

float CAEmitterCellGreenSpeed( CAEmitterCell *ref )
{ return [ref greenSpeed]; }

void CAEmitterCellSetGreenSpeed( CAEmitterCell *ref, float value )
{ [ref setGreenSpeed:value]; }

float CAEmitterCellBlueSpeed( CAEmitterCell *ref )
{ return [ref blueSpeed]; }

void CAEmitterCellSetBlueSpeed( CAEmitterCell *ref, float value )
{ [ref setBlueSpeed:value]; }

float CAEmitterCellAlphaSpeed( CAEmitterCell *ref )
{ return [ref alphaSpeed]; }

void CAEmitterCellSetAlphaSpeed( CAEmitterCell *ref, float value )
{ [ref setAlphaSpeed:value]; }

CFStringRef CAEmitterCellMagnificationFilter( CAEmitterCell *ref )
{ return (__bridge CFStringRef)[ref magnificationFilter]; }

void CAEmitterCellSetMagnificationFilter( CAEmitterCell *ref, CFStringRef filter )
{ [ref setMagnificationFilter:(__bridge NSString *)filter]; }

CFStringRef CAEmitterCellMinificationFilter( CAEmitterCell *ref )
{ return (__bridge CFStringRef)[ref minificationFilter]; }

void CAEmitterCellSetMinificationFilter( CAEmitterCell *ref, CFStringRef filter )
{ [ref setMinificationFilter:(__bridge NSString *)filter]; }

float CAEmitterCellMinificationFilterBias( CAEmitterCell *ref )
{ return [ref minificationFilterBias]; }

void CAEmitterCellSetMinificationFilterBias( CAEmitterCell *ref, float value )
{ [ref setMinificationFilterBias:value]; }

CGFloat CAEmitterCellScale( CAEmitterCell *ref )
{ return [ref scale]; }

void CAEmitterCellSetScale( CAEmitterCell *ref, CGFloat value )
{ [ref setScale:value]; }

CGFloat CAEmitterCellScaleRange( CAEmitterCell *ref )
{ return [ref scaleRange]; }

void CAEmitterCellSetScaleRange( CAEmitterCell *ref, CGFloat value )
{ [ref setScaleRange:value]; }

CGFloat CAEmitterCellContentsScale( CAEmitterCell *ref )
{ return [ref contentsScale]; }

void CAEmitterCellSetContentsScale( CAEmitterCell *ref, CGFloat value )
{ [ref setContentsScale:value]; }

CFStringRef CAEmitterCellName( CAEmitterCell *ref )
{ return (__bridge CFStringRef)[ref name]; }

void CAEmitterCellSetName( CAEmitterCell *ref, CFStringRef name )
{ [ref setName:(__bridge NSString *)name]; }

CFDictionaryRef CAEmitterCellStyle( CAEmitterCell *ref )
{ return (__bridge CFDictionaryRef)[ref style]; }

void CAEmitterCellSetStyle( CAEmitterCell *ref, CFDictionaryRef style )
{ [ref setStyle:(__bridge NSDictionary *)style]; }

// Motion attributes
CGFloat CAEmitterCellSpin( CAEmitterCell *ref )
{ return [ref spin]; }

void CAEmitterCellSetSpin( CAEmitterCell *ref, CGFloat value )
{ [ref setSpin:value]; }

CGFloat CAEmitterCellSpinRange( CAEmitterCell *ref )
{ return [ref spinRange]; }

void CAEmitterCellSetSpinRange( CAEmitterCell *ref, CGFloat value )
{ [ref setSpinRange:value]; }

CGFloat CAEmitterCellEmissionLatitude( CAEmitterCell *ref )
{ return [ref emissionLatitude]; }

void CAEmitterCellSetEmissionLatitude( CAEmitterCell *ref, CGFloat value )
{ [ref setEmissionLatitude:value]; }

CGFloat CAEmitterCellEmissionLongitude( CAEmitterCell *ref )
{ return [ref emissionLongitude]; }

void CAEmitterCellSetEmissionLongitude( CAEmitterCell *ref, CGFloat value )
{ [ref setEmissionLongitude:value]; }

CGFloat CAEmitterCellEmissionRange( CAEmitterCell *ref )
{ return [ref emissionRange]; }

void CAEmitterCellSetEmissionRange( CAEmitterCell *ref, CGFloat value )
{ [ref setEmissionRange:value]; }

// Temporal attributes
float CAEmitterCellLifetime( CAEmitterCell *ref )
{ return [ref lifetime]; }

void CAEmitterCellSetLifetime( CAEmitterCell *ref, float value )
{ [ref setLifetime:value]; }

float CAEmitterCellLifetimeRange( CAEmitterCell *ref )
{ return [ref lifetimeRange]; }

void CAEmitterCellSetLifetimeRange( CAEmitterCell *ref, float value )
{ [ref setLifetimeRange:value]; }

float CAEmitterCellBirthRate( CAEmitterCell *ref )
{ return [ref birthRate]; }

void CAEmitterCellSetBirthRate( CAEmitterCell *ref, float value )
{ [ref setBirthRate:value]; }

CGFloat CAEmitterCellScaleSpeed( CAEmitterCell *ref )
{ return [ref scaleSpeed]; }

void CAEmitterCellSetScaleSpeed( CAEmitterCell *ref, CGFloat value )
{ [ref setScaleSpeed:value]; }

CGFloat CAEmitterCellVelocity( CAEmitterCell *ref )
{ return [ref velocity]; }

void CAEmitterCellSetVelocity( CAEmitterCell *ref, CGFloat value )
{ [ref setVelocity:value]; }

CGFloat CAEmitterCellVelocityRange( CAEmitterCell *ref )
{ return [ref velocityRange]; }

void CAEmitterCellSetVelocityRange( CAEmitterCell *ref, CGFloat value )
{ [ref setVelocityRange:value]; }

CGFloat CAEmitterCellXAcceleration( CAEmitterCell *ref )
{ return [ref xAcceleration]; }

void CAEmitterCellSetXAcceleration( CAEmitterCell *ref, CGFloat value )
{ [ref setXAcceleration:value]; }

CGFloat CAEmitterCellYAcceleration( CAEmitterCell *ref )
{ return [ref yAcceleration]; }

void CAEmitterCellSetYAcceleration( CAEmitterCell *ref, CGFloat value )
{ [ref setYAcceleration:value]; }

CGFloat CAEmitterCellZAcceleration( CAEmitterCell *ref )
{ return [ref zAcceleration]; }

void CAEmitterCellSetZAcceleration( CAEmitterCell *ref, CGFloat value )
{ [ref setZAcceleration:value]; }

// Key-value coding
id CAEmitterCellDefaultValueForKey( CFStringRef key )
{ return [CAEmitterCell defaultValueForKey:(__bridge NSString *)key]; }

BOOL CAEmitterCellShouldArchiveValueForKey( CAEmitterCell *ref, CFStringRef key )
{ return [ref shouldArchiveValueForKey:(__bridge NSString *)key]; }
