/*
 StatusBarButton.m

 Bernie Wylde
 */

#import "StatusBarButton.h"

@implementation CUI_StatusBarButtonTarget

- (void)action:(id)sender {
    if ( self.callback ) (*self.callback)(sender,self.userData);
}
@end

// Class
Class StatusBarButtonClass( void )
{ return [NSStatusBarButton class]; }

BOOL StatusBarButtonAppearsDisabled( NSStatusBarButton *ref )
{ return [ref appearsDisabled]; }

void StatusBarButtonSetAppearsDisabled( NSStatusBarButton *ref, BOOL flag )
{ [ref setAppearsDisabled:flag]; }
