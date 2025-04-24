/*
 CATransform3D.m

 Bernie Wylde
 */

#import "CATransform3D.h"

#pragma mark - Value additions
NSValue *ValueWithCATransform3D( CATransform3D t )
{ return [NSValue valueWithCATransform3D:t]; }

CATransform3D ValueCATransform3D( NSValue *ref )
{ return [ref CATransform3DValue]; }
