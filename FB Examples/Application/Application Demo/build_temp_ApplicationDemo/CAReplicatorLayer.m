/*
 CAReplicatorLayer.m

 Bernie Wylde
 */

#import "CAReplicatorLayer.h"

// - init -
CAReplicatorLayer *CAReplicatorLayerInit( void )
{ return [CAReplicatorLayer layer]; }

// - display -
NSInteger CAReplicatorLayerInstanceCount( CAReplicatorLayer *layer )
{ return [layer instanceCount]; }

void CAReplicatorLayerSetInstanceCount( CAReplicatorLayer *layer, NSInteger count )
{ [layer setInstanceCount:count]; }

CFTimeInterval CAReplicatorLayerInstanceDelay( CAReplicatorLayer *layer )
{ return [layer instanceDelay]; }

void CAReplicatorLayerSetInstanceDelay( CAReplicatorLayer *layer, CFTimeInterval delay )
{ [layer setInstanceDelay:delay]; }

CATransform3D CAReplicatorLayerInstanceTransform( CAReplicatorLayer *layer )
{ return [layer instanceTransform]; }

void CAReplicatorLayerSetInstanceTransform( CAReplicatorLayer *layer, CATransform3D t )
{ [layer setInstanceTransform:t]; }

// - geometry -
BOOL CAReplicatorLayerPreservesDepth( CAReplicatorLayer *layer )
{ return [layer preservesDepth]; }

void CAReplicatorLayerSetPreservesDepth( CAReplicatorLayer *layer, BOOL flag )
{ [layer setPreservesDepth:flag]; }

// - color -
NSColor *CAReplicatorLayerInstanceColor( CAReplicatorLayer *layer )
{ return [NSColor colorWithCGColor:[layer instanceColor]]; }

void CAReplicatorLayerSetInstanceColor( CAReplicatorLayer *layer, NSColor *col )
{ [layer setInstanceColor:[col CGColor]]; }

float CAReplicatorLayerInstanceRedOffset( CAReplicatorLayer *layer )
{ return [layer instanceRedOffset]; }

void CAReplicatorLayerSetInstanceRedOffset( CAReplicatorLayer *layer, float offset )
{ [layer setInstanceRedOffset:offset]; }

float CAReplicatorLayerInstanceGreenOffset( CAReplicatorLayer *layer )
{ return [layer instanceGreenOffset]; }

void CAReplicatorLayerSetInstanceGreenOffset( CAReplicatorLayer *layer, float offset )
{ [layer setInstanceGreenOffset:offset]; }

float CAReplicatorLayerInstanceBlueOffset( CAReplicatorLayer *layer )
{ return [layer instanceBlueOffset]; }

void CAReplicatorLayerSetInstanceBlueOffset( CAReplicatorLayer *layer, float offset )
{ [layer setInstanceBlueOffset:offset]; }

float CAReplicatorLayerInstanceAlphaOffset( CAReplicatorLayer *layer )
{ return [layer instanceAlphaOffset]; }

void CAReplicatorLayerSetInstanceAlphaOffset( CAReplicatorLayer *layer, float offset )
{ [layer setInstanceAlphaOffset:offset]; }

