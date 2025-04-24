/*
 CAEmitterLayer.m
 
 Bernie Wylde
 */

#import "CAEmitterLayer.h"

// Init
CAEmitterLayer *CAEmitterLayerInit( void )
{ return [CAEmitterLayer layer]; }

// Particle emitter cells
CFArrayRef CAEmitterLayerEmitterCells( CAEmitterLayer *ref )
{ return (__bridge CFArrayRef)[ref emitterCells]; }

void CAEmitterLayerSetEmitterCells( CAEmitterLayerRef ref, CFArrayRef cells )
{ [ref setEmitterCells:(__bridge NSArray *)cells]; }

// Geometry
CFStringRef caEmitterLayerRenderMode( CAEmitterLayer *ref )
{ return (__bridge CFStringRef)[ref renderMode]; }

void CAEmitterLayerSetRenderMode( CAEmitterLayer *ref, CFStringRef mode )
{ [ref setRenderMode:(__bridge NSString *)mode]; }

CGPoint CAEmitterLayerEmitterPosition( CAEmitterLayer *ref )
{ return [ref emitterPosition]; }

void CAEmitterLayerSetEmitterPosition( CAEmitterLayer *ref, CGPoint position )
{ [ref setEmitterPosition:position]; }

CFStringRef caEmitterLayerEmitterShape( CAEmitterLayer *ref )
{ return (__bridge CFStringRef)[ref emitterShape]; }

void CAEmitterLayerSetEmitterShape( CAEmitterLayer *ref, CFStringRef shape )
{ [ref setEmitterShape:(__bridge NSString *)shape]; }

CGFloat caEmitterLayerEmitterZPosition( CAEmitterLayer *ref )
{ return [ref emitterZPosition]; }

void CAEmitterLayerSetEmitterZPosition( CAEmitterLayer *ref, CGFloat value )
{ [ref setEmitterZPosition:value]; }

CGFloat caEmitterLayerEmitterDepth( CAEmitterLayer *ref )
{ return [ref emitterDepth]; }

void CAEmitterLayerSetEmitterDepth( CAEmitterLayer *ref, CGFloat value )
{ [ref setEmitterDepth:value]; }

CGSize caEmitterLayerEmitterSize( CAEmitterLayer *ref )
{ return [ref emitterSize]; }

void CAEmitterLayerSetEmitterSize( CAEmitterLayer *ref, CGSize size )
{ [ref setEmitterSize:size]; }

// Attribute multipliers
float CAEmitterLayerScale( CAEmitterLayer *ref )
{ return [ref scale]; }

void CAEmitterLayerSetScale( CAEmitterLayer *ref, float value )
{ [ref setScale:value]; }

UInt32 CAEmitterLayerSeed( CAEmitterLayer *ref )
{ return [ref seed]; }

void CAEmitterLayerSetSeed( CAEmitterLayer *ref, UInt32 seed )
{ [ref setSeed:seed]; }

float CAEmitterLayerSpin( CAEmitterLayer *ref )
{ return [ref spin]; }

void CAEmitterLayerSetSpin( CAEmitterLayer *ref, float value )
{ [ref setSpin:value]; }

float CAEmitterLayerVelocity( CAEmitterLayer *ref )
{ return [ref velocity]; }

void CAEmitterLayerSetVelocity( CAEmitterLayer *ref, float value )
{ [ref setVelocity:value]; }

float CAEmitterLayerBirthRate( CAEmitterLayer *ref )
{ return [ref birthRate]; }

void CAEmitterLayerSetBirthRate( CAEmitterLayer *ref, float value )
{ [ref setBirthRate:value]; }

CFStringRef caEmitterLayerEmitterMode( CAEmitterLayer *ref )
{ return (__bridge CFStringRef)[ref emitterMode]; }

void CAEmitterLayerSetEmitterMode( CAEmitterLayer *ref, CFStringRef mode )
{ [ref setEmitterMode:(__bridge NSString *)mode]; }

float CAEmitterLayerLifetime( CAEmitterLayer *ref )
{ return [ref lifetime]; }

void CAEmitterLayerSetLifetime( CAEmitterLayer *ref, float value )
{ [ref setLifetime:value]; }

BOOL CAEmitterLayerPreservesDepth( CAEmitterLayer *ref )
{ return [ref preservesDepth]; }

void CAEmitterLayerSetPreservesDepth( CAEmitterLayer *ref, BOOL flag )
{ [ref setPreservesDepth:flag]; }

