/*
 CATransform3D.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#pragma mark - Value additions
NSValue *ValueWithCATransform3D( CATransform3D t );
CATransform3D ValueCATransform3D( NSValue *ref );
