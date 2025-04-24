/*
 QLPreviewPanel.h

 Bernie Wylde
 */


#import "CocoaUI.h"

@interface CUI_QLPreviewPanelDelegate : NSObject <QLPreviewPanelDelegate,QLPreviewPanelDataSource>
@end

// dialog events
enum {
    qlPreviewPanelNumberOfItems = 4700,
    qlPreviewPanelItemAtIndex
};

CUI_QLPreviewPanelDelegate *CUI_QLPreviewPanelDelegateObj( void );

// Shared panel
QLPreviewPanel *QLPreviewPanelShared( void );
BOOL QLPreviewPanelExists( void );

// Controller
CFTypeRef QLPreviewPanelCurrentController( void );
void QLPreviewPanelUpdateController( void );

// Items
id<QLPreviewPanelDataSource> QLPreviewPanelDataSource( void );
void QLPreviewPanelSetDataSource( id<QLPreviewPanelDataSource> obj );
void QLPreviewPanelReloadData( void );
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
void QLPreviewPanelShow( void );
void QLPreviewPanelHide( void );
void QLPreviewPanelToggle( void );
