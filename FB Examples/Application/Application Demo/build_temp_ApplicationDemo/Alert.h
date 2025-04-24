/*
 Alert.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

// dialog events
enum {
    alertDidEnd = 1000,
    alertShowHelp
};

@interface CUI_AlertDelegate : NSObject <NSAlertDelegate>
@property (nonatomic,assign) NSInteger lastSuppressionButtonState;
@end

CUI_AlertDelegate *CUI_AlertDelegateObj( void );

NSAlert *CUI_AlertWithTag( NSInteger tag, BOOL create );
void CUI_AlertAdd( NSAlert *alert );
void CUI_AlertRemove( NSAlert *alert );

@interface NSAlert (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;
@property (nonatomic,retain) NSNumber *sheetNumber;

- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
- (BOOL)sheet;
- (void)setSheet:(BOOL)sheet;

@end

// Class
Class AlertClass( void );

NSAlert *AlertWithTag( NSInteger tag );
BOOL AlertExists( NSInteger tag );

// Configure
void AlertLayout( NSInteger tag );
NSAlertStyle AlertStyle( NSInteger tag );
void AlertSetStyle( NSInteger tag, NSAlertStyle style );

//NSView *AlertAccessoryView( NSInteger alertTag );
CFTypeRef AlertAccessoryView( NSInteger alertTag );
void AlertSetAccessoryView( NSInteger alertTag, NSInteger viewTag );
BOOL AlertShowsHelp( NSInteger tag );
void AlertSetShowsHelp( NSInteger tag, BOOL flag );
CFStringRef AlertHelpAnchor( NSInteger tag );
void AlertSetHelpAnchor( NSInteger tag, CFStringRef anchorName );

NSButton *AlertSuppressionButton( NSInteger tag );
BOOL AlertShowsSuppressionButton( NSInteger tag );
void AlertSetShowsSuppressionButton( NSInteger tag, BOOL flag );
NSCellStateValue AlertSuppressionButtonState( NSInteger tag );
void AlertSuppressionButtonSetState( NSInteger tag, NSCellStateValue value );
CFStringRef AlertSuppressionButtonTitle( NSInteger tag );
void AlertSuppressionButtonSetTitle( NSInteger tag, CFStringRef title );

CFStringRef AlertInformativeText( NSInteger tag );
void AlertSetInformativeText( NSInteger tag, CFStringRef string );
CFStringRef AlertMessageText( NSInteger tag );
void AlertSetMessageText( NSInteger tag, CFStringRef string );
NSImage *AlertIcon( NSInteger tag );
void AlertSetIcon( NSInteger tag, CFTypeRef inImage );
void AlertSetIconNamed( NSInteger tag, CFStringRef imageName );

// Buttons
CFArrayRef AlertButtons( NSInteger tag );
void AlertAddButtonWithTitle( NSInteger tag, CFStringRef title );

// Window
NSWindow *AlertWindow( NSInteger tag );


// custom
void AlertClose( NSInteger tag );
void AlertRemove( NSInteger tag );
void AlertButtonSetKeyEquivalent( NSInteger alertTag, NSUInteger btnIndex, CFStringRef key );
void AlertButtonSetKeyEquivalentModifierMask( NSInteger alertTag, NSUInteger btnIndex, NSUInteger mask );
void AlertButtonsSetHidden( NSInteger tag, BOOL flag );


NSAlert *AlertInit( NSInteger inTag );

// FB statement
NSInteger CUI_Alert( NSInteger inTag, NSInteger inStyle, CFTypeRef inMsg, CFStringRef inInfo, CFTypeRef inButtonTitles, NSInteger inSheetFlag );
