/*
 CAReplicatorLayer.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// - init -
CAReplicatorLayer *CAReplicatorLayerInit( void );

// - display -
NSInteger CAReplicatorLayerInstanceCount( CAReplicatorLayer *layer );
void CAReplicatorLayerSetInstanceCount( CAReplicatorLayer *layer, NSInteger count );
CFTimeInterval CAReplicatorLayerInstanceDelay( CAReplicatorLayer *layer );
void CAReplicatorLayerSetInstanceDelay( CAReplicatorLayer *layer, CFTimeInterval delay );
CATransform3D CAReplicatorLayerInstanceTransform( CAReplicatorLayer *layer );
void CAReplicatorLayerSetInstanceTransform( CAReplicatorLayer *layer, CATransform3D t );

// - geometry -
BOOL CAReplicatorLayerPreservesDepth( CAReplicatorLayer *layer );
void CAReplicatorLayerSetPreservesDepth( CAReplicatorLayer *layer, BOOL flag );

// - color -
NSColor *CAReplicatorLayerInstanceColor( CAReplicatorLayer *layer );
void CAReplicatorLayerSetInstanceColor( CAReplicatorLayer *layer, NSColor *col );
float CAReplicatorLayerInstanceRedOffset( CAReplicatorLayer *layer );
void CAReplicatorLayerSetInstanceRedOffset( CAReplicatorLayer *layer, float offset );
float CAReplicatorLayerInstanceGreenOffset( CAReplicatorLayer *layer );
void CAReplicatorLayerSetInstanceGreenOffset( CAReplicatorLayer *layer, float offset );
float CAReplicatorLayerInstanceBlueOffset( CAReplicatorLayer *layer );
void CAReplicatorLayerSetInstanceBlueOffset( CAReplicatorLayer *layer, float offset );
float CAReplicatorLayerInstanceAlphaOffset( CAReplicatorLayer *layer );
void CAReplicatorLayerSetInstanceAlphaOffset( CAReplicatorLayer *layer, float offset );
