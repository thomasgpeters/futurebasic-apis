/*
 PageLayout.h

 Bernie Wylde
 */


#import "CocoaUI.h"

#import "Window.h"

typedef void (*CUI_PageLayoutCallbackType)(NSPageLayout *,NSInteger,void *);

@interface CUI_PageLayoutDelegate : NSObject
@property (nonatomic,assign) CUI_PageLayoutCallbackType callback;
@end

CUI_PageLayoutDelegate *CUI_PageLayoutDelegateObj( void );

// Class
Class PageLayoutClass( void );

// - init -
NSPageLayout *PageLayoutInit( void );

// - dialog -
void PageLayoutBeginSheet( NSPageLayout *ref, NSPrintInfo *info, NSInteger wndTag, CUI_PageLayoutCallbackType callback, void *userData );
NSInteger PageLayoutRunModal( NSPageLayout *ref );
NSInteger PageLayoutRunModalWithPrintInfo( NSPageLayout *ref, NSPrintInfo *info );

// - customize -
void PageLayoutAddAccessoryController( NSPageLayout *ref, NSViewController *vc );
void PageLayoutRemoveAccessoryController( NSPageLayout *ref, NSViewController *vc );
CFArrayRef PageLayoutAccessoryControllers( NSPageLayout *ref );

// - printinfo -
NSPrintInfo *PageLayoutPrintInfo( NSPageLayout *ref );

