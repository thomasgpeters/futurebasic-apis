/*
 PageLayout.m

 Bernie Wylde
 */

#import "PageLayout.h"

static CUI_PageLayoutDelegate *sCUI_PageLayoutDelegate;

@implementation CUI_PageLayoutDelegate

- (void)pageLayoutDidEnd:(NSPageLayout *)pageLayout returnCode:(NSInteger)returnCode contextInfo:(void *)userData {
    if ( self.callback ) (*self.callback)(pageLayout,returnCode,userData);
}

@end

CUI_PageLayoutDelegate *CUI_PageLayoutDelegateObj( void )
{
    if ( !sCUI_PageLayoutDelegate ) sCUI_PageLayoutDelegate = [[CUI_PageLayoutDelegate alloc] init];
    return sCUI_PageLayoutDelegate;
}

// Class
Class PageLayoutClass( void )
{ return [NSPageLayout class]; }

// - init -
NSPageLayout *PageLayoutInit( void )
{ return [NSPageLayout pageLayout]; }

// - dialog -
void PageLayoutBeginSheet( NSPageLayout *ref, NSPrintInfo *info, NSInteger wndTag, CUI_PageLayoutCallbackType callback, void *userData )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        CUI_PageLayoutDelegate *delegate = CUI_PageLayoutDelegateObj();
        delegate.callback = callback;
        
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
        if (@available(macOS 14.0, *)) {
            [ref beginSheetUsingPrintInfo:info onWindow:w completionHandler:^(NSPageLayoutResult result) {
                if ( callback ) (*callback)(ref,result,userData);
            }];
        } else {
            [ref beginSheetWithPrintInfo:info modalForWindow:w delegate:delegate didEndSelector:@selector(pageLayoutDidEnd:returnCode:contextInfo:) contextInfo:userData];
        }
#else
        [ref beginSheetWithPrintInfo:info modalForWindow:w delegate:delegate didEndSelector:@selector(pageLayoutDidEnd:returnCode:contextInfo:) contextInfo:userData];
#endif
        
    }
}

NSInteger PageLayoutRunModal( NSPageLayout *ref )
{ return [ref runModal]; }

NSInteger PageLayoutRunModalWithPrintInfo( NSPageLayout *ref, NSPrintInfo *info )
{ return [ref runModalWithPrintInfo:info]; }

// - customize -
void PageLayoutAddAccessoryController( NSPageLayout *ref, NSViewController *vc )
{ [ref addAccessoryController:vc]; }

void PageLayoutRemoveAccessoryController( NSPageLayout *ref, NSViewController *vc )
{ [ref removeAccessoryController:vc]; }

CFArrayRef PageLayoutAccessoryControllers( NSPageLayout *ref )
{ return (__bridge CFArrayRef)[ref accessoryControllers]; }

// - printinfo -
NSPrintInfo *PageLayoutPrintInfo( NSPageLayout *ref )
{ return [ref printInfo]; }

