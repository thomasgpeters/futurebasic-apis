/*
 StatusBarButton.h

 Bernie Wylde
 */

#import "CocoaUI.h"

typedef void (*CUI_StatusBarButtonCallbackType)(NSStatusBarButton *,void*);

@interface CUI_StatusBarButtonTarget : NSObject
@property (nonatomic,assign) CUI_StatusBarButtonCallbackType callback;
@property (nonatomic,assign) void *userData;
@end

// Class
Class StatusBarButtonClass( void );

BOOL StatusBarButtonAppearsDisabled( NSStatusBarButton *ref );
void StatusBarButtonSetAppearsDisabled( NSStatusBarButton *ref, BOOL flag );

