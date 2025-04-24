/*
 SavePanel.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "DialogEvent.h"
//#import "Window.h"

static NSMutableArray *sCUI_SavePanels;

// dialog events
enum {
    savePanelDidEnd = 2900,
    savePanelUserEnteredFilename,// save,
    savePanelSelectionDidChange,// save, open
    savePanelDidChangeToDirectoryURL,// save, open
    savePanelWillExpand,// save
    savePanelShouldEnableURL,// save, open
    savePanelValidateURL,// save, open
    savePanelDisplayNameForType,
    savePanelDidSelectType
};

@interface CUI_OpenSavePanelDelegate : NSObject <NSOpenSavePanelDelegate>
@end

CUI_OpenSavePanelDelegate *CUI_OpenSavePanelDelegateObj( void );


@interface NSSavePanel (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;
@property (nonatomic,retain) NSNumber *sheetNumber;

- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
- (BOOL)sheet;
- (void)setSheet:(BOOL)sheet;
@end

typedef void (*CUI_OpenSavePanelCallbackType)(NSInteger,void*);


void CUI_SavePanelAdd( NSSavePanel *sp );
void CUI_SavePanelRemove( NSSavePanel *sp );
NSSavePanel *CUI_SavePanelWithTag( NSInteger tag, BOOL create );

#pragma mark - private
NSInteger CUI_SavePanelContainingAccessorySubview( NSSavePanel *op, id parentView, id view );
NSInteger CUI_SavePanelContainingAccessoryView( id view );

#pragma mark - public
// Class
Class SavePanelClass( void );

NSSavePanel *SavePanelWithTag( NSInteger tag );
BOOL SavePanelExists( NSInteger tag );

// Configure
NSView *SavePanelAccessoryView( NSInteger tag );
void SavePanelSetAccessoryView( NSInteger tag, NSView *ref );
CFStringRef SavePanelTitle( NSInteger tag );
void SavePanelSetTitle( NSInteger tag, CFStringRef title );
CFStringRef SavePanelPrompt( NSInteger tag );
void SavePanelSetPrompt( NSInteger tag, CFStringRef prompt );
CFStringRef SavePanelNameFieldLabel( NSInteger tag );
void SavePanelSetNameFieldLabel( NSInteger tag, CFStringRef label );
CFStringRef SavePanelMessage( NSInteger tag );
void SavePanelSetMessage( NSInteger tag, CFStringRef message );
BOOL SavePanelCanCreateDirectories( NSInteger tag );
void SavePanelSetCanCreateDirectories( NSInteger tag, BOOL flag );
BOOL SavePanelShowsHiddenFiles( NSInteger tag );
void SavePanelSetShowsHiddenFiles( NSInteger tag, BOOL flag );

BOOL SavePanelShowsTagField( NSInteger tag );
void SavePanelSetShowsTagField( NSInteger tag, BOOL flag );
CFArrayRef SavePanelTagNames( NSInteger tag );
void SavePanelSetTagNames( NSInteger tag, CFArrayRef tagNames );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
BOOL SavePanelShowsContentTypes( NSInteger tag );
API_AVAILABLE(macos(15.0))
void SavePanelSetShowsContentTypes( NSInteger tag, BOOL flag );
#endif // 150000

// Panel content
BOOL SavePanelIsExtensionHidden( NSInteger tag );
void SavePanelSetExtensionHidden( NSInteger tag, BOOL flag );
CFURLRef SavePanelDirectoryURL( NSInteger tag );
void SavePanelSetDirectoryURL( NSInteger tag, CFURLRef url );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
CFArrayRef SavePanelAllowedContentTypes( NSInteger tag );
API_AVAILABLE(macos(11.0))
void SavePanelSetAllowedContentTypes( NSInteger tag, CFArrayRef types );
#endif// 110000

BOOL SavePanelCanSelectHiddenExtension( NSInteger tag );
void SavePanelSetCanSelectHiddenExtension( NSInteger tag, BOOL flag );
CFArrayRef SavePanelAllowedFileTypes( NSInteger tag );
void SavePanelSetAllowedFileTypes( NSInteger tag, CFArrayRef fileTypes );
BOOL SavePanelAllowsOtherFileTypes( NSInteger tag );
void SavePanelSetAllowsOtherFileTypes( NSInteger tag, BOOL flag );
BOOL SavePanelTreatsFilePackagesAsDirectories( NSInteger tag );
void SavePanelSetTreatsFilePackagesAsDirectories( NSInteger tag, BOOL flag );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
UTType *SavePanelCurrentContentType( NSInteger tag );
API_AVAILABLE(macos(15.0))
void SavePanelSetCurrentContentType( NSInteger tag, UTType *type );
#endif // 150000

// Running
void SavePanelBeginSheetModal( NSInteger tag, NSInteger wndTag, CUI_OpenSavePanelCallbackType callback, void *userData );
void SavePanelBegin( NSInteger tag, CUI_OpenSavePanelCallbackType callback, void *userData );
NSInteger SavePanelRunModal( NSInteger tag );
void SavePanelValidateVisibleColumns( NSInteger tag );

// User selection
CFURLRef SavePanelURL( NSInteger tag );
BOOL SavePanelIsExpanded( NSInteger tag );
CFStringRef SavePanelNameFieldStringValue( NSInteger tag );
void SavePanelSetNameFieldStringValue( NSInteger tag, CFStringRef string );

// Actions
void SavePanelOK( NSInteger tag );
void SavePanelCancel( NSInteger tag );

// Custom
void SavePanelRemove( NSInteger tag );

id CUI_SavePanelSetDialogEventObjects( NSSavePanel *sp, NSInteger response );

// Init
NSSavePanel *SavePanelInit( NSInteger inTag );

// Statement
CFTypeRef CUI_SavePanel( NSInteger inTag, CFStringRef inMsg, CFTypeRef inFileTypes, CFStringRef inNameFieldString, CFStringRef inPrompt, CFURLRef inDirURL, NSInteger inSheetFlag );

