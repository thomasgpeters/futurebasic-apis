/*
 CAEmitterCell.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

// Create
CAEmitterCell *CAEmitterCellInit( void );

// Content
id CAEmitterCellContents( CAEmitterCell *ref );
void CAEmitterCellSetContents( CAEmitterCell *ref, id contents );
CGRect CAEmitterCellContentsRect( CAEmitterCell *ref );
void CAEmitterCellSetContentsRect( CAEmitterCell *ref, CGRect rect );
CFArrayRef CAEmitterCellEmitterCells( CAEmitterCell *ref );
void CAEmitterCellSetEmitterCells( CAEmitterCell *ref, CFArrayRef cells );

// Visual attributes
BOOL CAEmitterCellIsEnabled( CAEmitterCell *ref );
void CAEmitterCellSetEnabled( CAEmitterCell *ref, BOOL flag );

NSColor *CAEmitterCellColor( CAEmitterCell *ref );
void CAEmitterCellSetColor( CAEmitterCell *ref, NSColor *col );

float CAEmitterCellRedRange( CAEmitterCell *ref );
void CAEmitterCellSetRedRange( CAEmitterCell *ref, float value );
float CAEmitterCellGreenRange( CAEmitterCell *ref );
void CAEmitterCellSetGreenRange( CAEmitterCell *ref, float value );
float CAEmitterCellBlueRange( CAEmitterCell *ref );
void CAEmitterCellSetBlueRange( CAEmitterCell *ref, float value );
float CAEmitterCellAlphaRange( CAEmitterCell *ref );
void CAEmitterCellSetAlphaRange( CAEmitterCell *ref, float value );
float CAEmitterCellRedSpeed( CAEmitterCell *ref );
void CAEmitterCellSetRedSpeed( CAEmitterCell *ref, float value );
float CAEmitterCellGreenSpeed( CAEmitterCell *ref );
void CAEmitterCellSetGreenSpeed( CAEmitterCell *ref, float value );
float CAEmitterCellBlueSpeed( CAEmitterCell *ref );
void CAEmitterCellSetBlueSpeed( CAEmitterCell *ref, float value );
float CAEmitterCellAlphaSpeed( CAEmitterCell *ref );
void CAEmitterCellSetAlphaSpeed( CAEmitterCell *ref, float value );
CFStringRef CAEmitterCellMagnificationFilter( CAEmitterCell *ref );
void CAEmitterCellSetMagnificationFilter( CAEmitterCell *ref, CFStringRef filter );
CFStringRef CAEmitterCellMinificationFilter( CAEmitterCell *ref );
void CAEmitterCellSetMinificationFilter( CAEmitterCell *ref, CFStringRef filter );
float CAEmitterCellMinificationFilterBias( CAEmitterCell *ref );
void CAEmitterCellSetMinificationFilterBias( CAEmitterCell *ref, float value );
CGFloat CAEmitterCellScale( CAEmitterCell *ref );
void CAEmitterCellSetScale( CAEmitterCell *ref, CGFloat value );
CGFloat CAEmitterCellScaleRange( CAEmitterCell *ref );
void CAEmitterCellSetScaleRange( CAEmitterCell *ref, CGFloat value );

CGFloat CAEmitterCellContentsScale( CAEmitterCell *ref );
void CAEmitterCellSetContentsScale( CAEmitterCell *ref, CGFloat value );

CFStringRef CAEmitterCellName( CAEmitterCell *ref );
void CAEmitterCellSetName( CAEmitterCell *ref, CFStringRef name );
CFDictionaryRef CAEmitterCellStyle( CAEmitterCell *ref );
void CAEmitterCellSetStyle( CAEmitterCell *ref, CFDictionaryRef style );

// Motion attributes
CGFloat CAEmitterCellSpin( CAEmitterCell *ref );
void CAEmitterCellSetSpin( CAEmitterCell *ref, CGFloat value );
CGFloat CAEmitterCellSpinRange( CAEmitterCell *ref );
void CAEmitterCellSetSpinRange( CAEmitterCell *ref, CGFloat value );
CGFloat CAEmitterCellEmissionLatitude( CAEmitterCell *ref );
void CAEmitterCellSetEmissionLatitude( CAEmitterCell *ref, CGFloat value );
CGFloat CAEmitterCellEmissionLongitude( CAEmitterCell *ref );
void CAEmitterCellSetEmissionLongitude( CAEmitterCell *ref, CGFloat value );
CGFloat CAEmitterCellEmissionRange( CAEmitterCell *ref );
void CAEmitterCellSetEmissionRange( CAEmitterCell *ref, CGFloat value );

// Temporal attributes
float CAEmitterCellLifetime( CAEmitterCell *ref );
void CAEmitterCellSetLifetime( CAEmitterCell *ref, float value );
float CAEmitterCellLifetimeRange( CAEmitterCell *ref );
void CAEmitterCellSetLifetimeRange( CAEmitterCell *ref, float value );
float CAEmitterCellBirthRate( CAEmitterCell *ref );
void CAEmitterCellSetBirthRate( CAEmitterCell *ref, float value );
CGFloat CAEmitterCellScaleSpeed( CAEmitterCell *ref );
void CAEmitterCellSetScaleSpeed( CAEmitterCell *ref, CGFloat value );
CGFloat CAEmitterCellVelocity( CAEmitterCell *ref );
void CAEmitterCellSetVelocity( CAEmitterCell *ref, CGFloat value );
CGFloat CAEmitterCellVelocityRange( CAEmitterCell *ref );
void CAEmitterCellSetVelocityRange( CAEmitterCell *ref, CGFloat value );
CGFloat CAEmitterCellXAcceleration( CAEmitterCell *ref );
void CAEmitterCellSetXAcceleration( CAEmitterCell *ref, CGFloat value );
CGFloat CAEmitterCellYAcceleration( CAEmitterCell *ref );
void CAEmitterCellSetYAcceleration( CAEmitterCell *ref, CGFloat value );
CGFloat CAEmitterCellZAcceleration( CAEmitterCell *ref );
void CAEmitterCellSetZAcceleration( CAEmitterCell *ref, CGFloat value );

// Key-value coding
id CAEmitterCellDefaultValueForKey( CFStringRef key );
BOOL CAEmitterCellShouldArchiveValueForKey( CAEmitterCell *ref, CFStringRef key );
