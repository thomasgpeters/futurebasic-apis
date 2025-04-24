/*
 OpenPanel.h

 Bernie Wylde
 */

#import "CocoaUI.h"

static NSMutableArray *sCUI_OpenPanels;
static long sCUI_OuptutWindowTag; // 20250312

// dialog events
enum {
    openPanelDidEnd = 2800,
    openPanelSelectionDidChange = savePanelSelectionDidChange,
    openPanelDidChangeToDirectoryURL = savePanelDidChangeToDirectoryURL,
    openPanelShouldEnableURL = savePanelShouldEnableURL,
    openPanelValidateURL = savePanelValidateURL
};

@interface NSOpenPanel (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;
@property (nonatomic,retain) NSNumber *sheetNumber;

- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
- (BOOL)sheet;
- (void)setSheet:(BOOL)sheet;
@end

#pragma mark - private
NSInteger CUI_OpenPanelContainingAccessorySubview( NSOpenPanel *op, id parentView, id view );
NSInteger CUI_OpenPanelContainingAccessoryView( id view );
void CUI_OpenPanelSetAccessoryViewWndTag( NSInteger opTag, id superview );


#pragma mark - public
// Class
Class OpenPanelClass( void );

NSOpenPanel *CUI_OpenPanelWithTag( NSInteger tag, BOOL create );
void CUI_OpenPanelAdd( NSOpenPanel *op );
void CUI_OpenPanelRemove( NSOpenPanel *op );


NSOpenPanel *OpenPanelWithTag( NSInteger tag );
BOOL OpenPanelExists( NSInteger tag );

// Configure
BOOL OpenPanelCanChooseFiles( NSInteger tag );
void OpenPanelSetCanChooseFiles( NSInteger tag, BOOL flag );
BOOL OpenPanelCanChooseDirectories( NSInteger tag );
void OpenPanelSetCanChooseDirectories( NSInteger tag, BOOL flag );
BOOL OpenPanelResolvesAliases( NSInteger tag );
void OpenPanelSetResolvesAliases( NSInteger tag, BOOL flag );
BOOL OpenPanelAllowsMultipleSelection( NSInteger tag );
void OpenPanelSetAllowsMultipleSelection( NSInteger tag, BOOL flag );

// User selection
CFArrayRef OpenPanelURLs( NSInteger tag );

// Ubiquitous documents
BOOL OpenPanelCanDownloadUbiquitousContents( NSInteger tag );
void OpenPanelSetCanDownloadUbiquitousContents( NSInteger tag, BOOL flag );
BOOL OpenPanelCanResolveUbiquitousConflicts( NSInteger tag );
void OpenPanelSetCanResolveUbiquitousConflicts( NSInteger tag, BOOL flag );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
CFArrayRef OpenPanelAllowedContentTypes( NSInteger tag );
API_AVAILABLE(macos(11.0))
void OpenPanelSetAllowedContentTypes( NSInteger tag, CFArrayRef types );
#endif// 110000

// Instance properties
BOOL OpenPanelIsAccessoryViewDisclosed( NSInteger tag );
void OpenPanelSetAccessoryViewDisclosed( NSInteger tag, BOOL flag );


// Convenience - SavePanel duplicates -
// Configure
NSView *OpenPanelAccessoryView( NSInteger tag );
void OpenPanelSetAccessoryView( NSInteger tag, NSView *ref );
CFStringRef OpenPanelTitle( NSInteger tag );
void OpenPanelSetTitle( NSInteger tag, CFStringRef title );
CFStringRef OpenPanelPrompt( NSInteger tag );
void OpenPanelSetPrompt( NSInteger tag, CFStringRef prompt );
CFStringRef OpenPanelMessage( NSInteger tag );
void OpenPanelSetMessage( NSInteger tag, CFStringRef message );
BOOL OpenPanelCanCreateDirectories( NSInteger tag );
void OpenPanelSetCanCreateDirectories( NSInteger tag, BOOL flag );
BOOL OpenPanelShowsHiddenFiles( NSInteger tag );
void OpenPanelSetShowsHiddenFiles( NSInteger tag, BOOL flag );

// Panel content
CFURLRef OpenPanelDirectoryURL( NSInteger tag );
void OpenPanelSetDirectoryURL( NSInteger tag, CFURLRef url );
CFArrayRef OpenPanelAllowedFileTypes( NSInteger tag );
void OpenPanelSetAllowedFileTypes( NSInteger tag, CFArrayRef fileTypes );
BOOL OpenPanelAllowsOtherFileTypes( NSInteger tag );
void OpenPanelSetAllowsOtherFileTypes( NSInteger tag, BOOL flag );
BOOL OpenPanelTreatsFilePackagesAsDirectories( NSInteger tag );
void OpenPanelSetTreatsFilePackagesAsDirectories( NSInteger tag, BOOL flag );

// Running
void OpenPanelBeginSheetModal( NSInteger tag, NSInteger wndTag, CUI_OpenSavePanelCallbackType callback, void *userData );
void OpenPanelBegin( NSInteger tag, CUI_OpenSavePanelCallbackType callback, void *userData );
NSInteger OpenPanelRunModal( NSInteger tag );
void OpenPanelValidateVisibleColumns( NSInteger tag );

// User selection
CFURLRef OpenPanelURL( NSInteger tag );

// Actions
void OpenPanelOK( NSInteger tag );
void OpenPanelCancel( NSInteger tag );

// Custom
void OpenPanelRemove( NSInteger tag );

id CUI_OpenPanelSetDialogEventObjects( NSOpenPanel *op, NSInteger response );

// Init
NSOpenPanel *OpenPanelInit( NSInteger inTag );

// statement/function
CFTypeRef CUI_OpenPanel( NSInteger inTag, CFStringRef inMsg, CFTypeRef inFileTypes, CFStringRef inPrompt, CFURLRef inDirURL, NSInteger inSheetFlag );

