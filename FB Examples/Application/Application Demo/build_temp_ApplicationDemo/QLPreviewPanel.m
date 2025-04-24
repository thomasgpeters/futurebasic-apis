/*
 QLPreviewPanel.m

 Bernie Wylde
 */

#import "QLPreviewPanel.h"

@implementation CUI_QLPreviewPanelDelegate

- (NSInteger)numberOfPreviewItemsInPreviewPanel:(QLPreviewPanel *)panel {
    DialogEventSetLong(0);
    CallUserDefinedOnDialogFunction( qlPreviewPanelNumberOfItems, 0, 0, (__bridge CFTypeRef)panel );
    return DialogEventLong();
}

- (id<QLPreviewItem>)previewPanel:(QLPreviewPanel *)panel previewItemAtIndex:(NSInteger)index {
    DialogEventSetNSURL(nil);
    CallUserDefinedOnDialogFunction( qlPreviewPanelItemAtIndex, index, 0, (__bridge CFTypeRef)panel );
    return DialogEventNSURL();
}

- (BOOL)acceptsPreviewPanelControl:(QLPreviewPanel *)panel {
    return YES;
}

- (void)beginPreviewPanelControl:(QLPreviewPanel *)panel {
    panel.dataSource = self;
    panel.delegate = self;
}

- (void)endPreviewPanelControl:(QLPreviewPanel *)panel {
    panel.dataSource = nil;
    panel.delegate = nil;
}
@end

CUI_QLPreviewPanelDelegate *CUI_QLPreviewPanelDelegateObj( void )
{
    static CUI_QLPreviewPanelDelegate *sCUI_QLPreviewPanelDelegate = nil;
    if ( !sCUI_QLPreviewPanelDelegate ) sCUI_QLPreviewPanelDelegate = [[CUI_QLPreviewPanelDelegate alloc] init];
    return sCUI_QLPreviewPanelDelegate;
}

// Shared panel
QLPreviewPanel *QLPreviewPanelShared( void )
{ return [QLPreviewPanel sharedPreviewPanel]; }

BOOL QLPreviewPanelExists( void )
{ return [QLPreviewPanel sharedPreviewPanelExists]; }

// Controller
CFTypeRef QLPreviewPanelCurrentController( void )
{ return (__bridge CFTypeRef)[[QLPreviewPanel sharedPreviewPanel] currentController]; }

void QLPreviewPanelUpdateController( void )
{ [[QLPreviewPanel sharedPreviewPanel] updateController]; }

// Items
id<QLPreviewPanelDataSource> QLPreviewPanelDataSource( void );
void QLPreviewPanelSetDataSource( id<QLPreviewPanelDataSource> obj );

void QLPreviewPanelReloadData( void )
{ [[QLPreviewPanel sharedPreviewPanel] reloadData]; }

void QLPreviewPanelRefreshCurrentPreviewItem( void );
NSInteger QLPreviewPanelCurrentPreviewItemIndex( void );
void QLPreviewPanelSetCurrentPreviewItemIndex( NSInteger index );
id<QLPreviewItem> QLPreviewPanelCurrentPreviewItem( void );
CFTypeRef QLPreviewPanelDisplayState( void );
void QLPreviewPanelSetDisplayState( CFTypeRef state );

// Full screen mode
BOOL QLPreviewPanelEnterFullScreenMode( NSScreen *screen, CFDictionaryRef options );
void QLPreviewPanelExitFullScreenMode( CFDictionaryRef options );
BOOL QLPreviewPanelIsInFullScreenMode( void );

// Custom
void QLPreviewPanelShow( void )
{
    CUI_QLPreviewPanelDelegateObj();
    [[QLPreviewPanel sharedPreviewPanel] makeKeyAndOrderFront:nil];
}

void QLPreviewPanelHide( void )
{ [[QLPreviewPanel sharedPreviewPanel] orderOut:nil]; }

void QLPreviewPanelToggle( void )
{
    CUI_QLPreviewPanelDelegate *delegate = CUI_QLPreviewPanelDelegateObj();
    QLPreviewPanel *panel = [QLPreviewPanel sharedPreviewPanel];
    if ( [QLPreviewPanel sharedPreviewPanelExists] && [panel isVisible] ) {
        [panel orderOut:nil];
    } else {
        [panel setDelegate:delegate];
        [panel setDataSource:delegate];
        [panel reloadData];
        [panel makeKeyAndOrderFront:nil];
    }
}
