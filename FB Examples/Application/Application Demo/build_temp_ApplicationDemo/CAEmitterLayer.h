/*
 CAEmitterLayer.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

// Init
CAEmitterLayer *CAEmitterLayerInit( void );

// Particle emitter cells
CFArrayRef CAEmitterLayerEmitterCells( CAEmitterLayer *ref );
void CAEmitterLayerSetEmitterCells( CAEmitterLayerRef ref, CFArrayRef cells );

// Geometry
CFStringRef caEmitterLayerRenderMode( CAEmitterLayer *ref );
void CAEmitterLayerSetRenderMode( CAEmitterLayer *ref, CFStringRef mode );
CGPoint CAEmitterLayerEmitterPosition( CAEmitterLayer *ref );
void CAEmitterLayerSetEmitterPosition( CAEmitterLayer *ref, CGPoint position );
CFStringRef caEmitterLayerEmitterShape( CAEmitterLayer *ref );
void CAEmitterLayerSetEmitterShape( CAEmitterLayer *ref, CFStringRef shape );
CGFloat caEmitterLayerEmitterZPosition( CAEmitterLayer *ref );
void CAEmitterLayerSetEmitterZPosition( CAEmitterLayer *ref, CGFloat value );
CGFloat caEmitterLayerEmitterDepth( CAEmitterLayer *ref );
void CAEmitterLayerSetEmitterDepth( CAEmitterLayer *ref, CGFloat value );
CGSize caEmitterLayerEmitterSize( CAEmitterLayer *ref );
void CAEmitterLayerSetEmitterSize( CAEmitterLayer *ref, CGSize size );

// Attribute multipliers
float CAEmitterLayerScale( CAEmitterLayer *ref );
void CAEmitterLayerSetScale( CAEmitterLayer *ref, float value );
UInt32 CAEmitterLayerSeed( CAEmitterLayer *ref );
void CAEmitterLayerSetSeed( CAEmitterLayer *ref, UInt32 seed );
float CAEmitterLayerSpin( CAEmitterLayer *ref );
void CAEmitterLayerSetSpin( CAEmitterLayer *ref, float value );
float CAEmitterLayerVelocity( CAEmitterLayer *ref );
void CAEmitterLayerSetVelocity( CAEmitterLayer *ref, float value );
float CAEmitterLayerBirthRate( CAEmitterLayer *ref );
void CAEmitterLayerSetBirthRate( CAEmitterLayer *ref, float value );
CFStringRef caEmitterLayerEmitterMode( CAEmitterLayer *ref );
void CAEmitterLayerSetEmitterMode( CAEmitterLayer *ref, CFStringRef mode );
float CAEmitterLayerLifetime( CAEmitterLayer *ref );
void CAEmitterLayerSetLifetime( CAEmitterLayer *ref, float value );
BOOL CAEmitterLayerPreservesDepth( CAEmitterLayer *ref );
void CAEmitterLayerSetPreservesDepth( CAEmitterLayer *ref, BOOL flag );
