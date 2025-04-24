/*
 Button.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

#import "Control.h"
#import "DialogEvent.h"
#import "View.h"
#import "Window.h"

#pragma mark - subclass
@interface ButtonSC : NSButton
@end

#pragma mark - functions
// Class
Class ButtonClass( void );

NSButton *ButtonWithTag( NSInteger tag );
BOOL ButtonExists( NSInteger tag );

// Configure
NSButtonType ButtonType( NSInteger tag );
void ButtonSetType( NSInteger tag, NSButtonType type );
void ButtonGetPeriodicDelay( NSInteger tag, float *delay, float *interval );
void ButtonSetPeriodicDelay( NSInteger tag, float delay, float interval );
CFStringRef ButtonAlternateTitle( NSInteger tag );
void ButtonSetAlternateTitle( NSInteger tag, CFStringRef title );
CFAttributedStringRef ButtonAttributedTitle( NSInteger tag );
void ButtonSetAttributedTitle( NSInteger tag, CFAttributedStringRef title );
CFAttributedStringRef ButtonAttributedAlternateTitle( NSInteger tag );
void ButtonSetAttributedAlternateTitle( NSInteger tag, CFAttributedStringRef title );
CFStringRef ButtonTitle( NSInteger tag );
void ButtonSetTitle( NSInteger tag, CFStringRef title );
NSSound *ButtonSound( NSInteger tag);
void ButtonSetSound( NSInteger tag, NSSound *snd );
void ButtonSetSoundNamed( NSInteger tag, CFStringRef sndName );
BOOL ButtonIsSpringLoaded( NSInteger tag );
void ButtonSetSpringLoaded( NSInteger tag, BOOL flag );
NSInteger ButtonMaxAcceleratorLevel( NSInteger tag );
void ButtonSetMaxAcceleratorLevel( NSInteger tag, NSInteger level );

// Image
NSImage *ButtonImage( NSInteger tag );
void ButtonSetImage( NSInteger tag, CFTypeRef inImage );
void ButtonSetImageNamed( NSInteger tag, CFStringRef imageName );
NSImage *ButtonAlternateImage( NSInteger tag );
void ButtonSetAlternateImage( NSInteger tag, CFTypeRef inImage );
void ButtonSetAlternateImageNamed( NSInteger tag, CFStringRef imageName );
NSCellImagePosition ButtonImagePosition( NSInteger tag );
void ButtonSetImagePosition( NSInteger tag, NSCellImagePosition position );
BOOL ButtonIsBordered( NSInteger tag );
void ButtonSetBordered( NSInteger tag, BOOL flag );
BOOL ButtonIsTransparent( NSInteger tag );
void ButtonSetTransparent( NSInteger tag, BOOL flag );
NSBezelStyle ButtonBezelStyle( NSInteger tag );
void ButtonSetBezelStyle( NSInteger tag, NSBezelStyle style );

NSColor *ButtonBezelColor( NSInteger tag );
void ButtonSetBezelColor( NSInteger tag, NSColor *col );

BOOL ButtonShowsBorderOnlyWhileMouseInside( NSInteger tag );
void ButtonSetShowsBorderOnlyWhileMouseInside( NSInteger tag, BOOL flag );

BOOL ButtonImageHugsTitle( NSInteger tag );
void ButtonSetImageHugsTitle( NSInteger tag, BOOL flag );

NSImageScaling ButtonImageScaling( NSInteger tag );
void ButtonSetImageScaling( NSInteger tag, NSImageScaling scaling );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSImageSymbolConfiguration *ButtonSymbolConfiguration( NSInteger tag );
API_AVAILABLE(macos(11.0))
void ButtonSetSymbolConfiguration( NSInteger tag, NSImageSymbolConfiguration *config );
#endif// 110000

// State
BOOL ButtonAllowsMixedState( NSInteger tag );
void ButtonSetAllowsMixedState( NSInteger tag, BOOL flag );
NSCellStateValue ButtonState( NSInteger tag );
void ButtonSetState( NSInteger tag, NSCellStateValue state );
void ButtonSetNextState( NSInteger tag );
void ButtonHighlight( NSInteger tag, BOOL flag );

// Key equivalent
CFStringRef ButtonKeyEquivalent( NSInteger tag );
void ButtonSetKeyEquivalent( NSInteger tag, CFStringRef key );
NSUInteger ButtonKeyEquivalentModifierMask( NSInteger tag );
void ButtonSetKeyEquivalentModifierMask( NSInteger tag, NSUInteger mask );
BOOL ButtonPerformKeyEquivalent( NSInteger tag, NSEvent *key );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
NSColor *ButtonContentTintColor( NSInteger tag );
API_AVAILABLE(macos(10.14))
void ButtonSetContentTintColor( NSInteger tag, NSColor *col );
#endif// 101400

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
BOOL ButtonHasDestructiveAction( NSInteger tag );
API_AVAILABLE(macos(11.0))
void ButtonSetHasDestructiveAction( NSInteger tag, BOOL flag );
#endif// 110000

// -- NSButtonCell methods --
CFTypeRef ButtonKeyEquivalentFont( NSInteger tag );
void ButtonSetKeyEquivalentFont( NSInteger tag, CFTypeRef font );

void ButtonSetBackgroundColor( NSInteger tag, NSColor *col );
BOOL ButtonImageDimsWhenDisabled( NSInteger tag );
void ButtonSetImageDimsWhenDisabled( NSInteger tag, BOOL flag );
BOOL ButtonIsOpaque( NSInteger tag );
void ButtonSetHighlightsBy( NSInteger tag, NSUInteger mask );
void ButtonPerformClick( NSInteger tag );

// custom
void ButtonClose( NSInteger tag );
void ButtonSetTitleColor( NSInteger tag, NSColor *col );


// Init
NSButton *ButtonInit( NSInteger inTag, CGRect inRect );

#pragma mark - button statement
#if 1 // attributed title
void CUI_Button( NSInteger inTag, NSInteger inEnabled, NSInteger inState, CFTypeRef inTitle, CGRect inRect, NSInteger inType, NSInteger inStyle, NSInteger inWndTag );
void CUI_Checkbox( NSInteger inTag, NSInteger inEnabled, NSInteger inState, CFTypeRef inTitle, CGRect inRect, NSInteger inWndTag );
void CUI_RadioButton( NSInteger inTag, NSInteger inEnabled, NSInteger inState, CFTypeRef inTitle, CGRect inRect, NSInteger inWndTag );
#else // attributed title
void CUI_Button( NSInteger inTag, NSInteger inEnabled, NSInteger inState, CFStringRef inTitle, CGRect inRect, NSInteger inType, NSInteger inStyle, NSInteger inWndTag );
void CUI_Checkbox( NSInteger inTag, NSInteger inEnabled, NSInteger inState, CFStringRef inTitle, CGRect inRect, NSInteger inWndTag );
void CUI_RadioButton( NSInteger inTag, NSInteger inEnabled, NSInteger inState, CFStringRef inTitle, CGRect inRect, NSInteger inWndTag );
#endif // attributed title


#pragma mark - radiogroup
@interface CUI_RadioGroup : NSView
- (void)btnAction:(id)sender;
@end

//@interface CUI_RadioGroupSC : CUI_RadioGroup
//@end

NSButton *CUI_RadioGroupButtonAtIndex( NSInteger tag, NSUInteger index );
CUI_RadioGroup *RadioGroupWithTag( NSInteger tag );

// Configure group
BOOL RadioGroupIsEnabled( NSInteger tag );
void RadioGroupSetEnabled( NSInteger tag, BOOL flag );
NSInteger RadioGroupIndex( NSInteger tag );
void RadioGroupSetIndex( NSInteger tag, NSUInteger index );

// Buttons
NSButton *RadioGroupButtonAtIndex( NSInteger tag, NSUInteger index );
BOOL RadioGroupButtonIsEnabled( NSInteger tag, NSUInteger index );
void RadioGroupButtonSetEnabled( NSInteger tag, NSUInteger index, BOOL flag );
BOOL RadioGroupButtonIsHidden( NSInteger tag, NSUInteger index );
void RadioGroupButtonSetHidden( NSInteger tag, NSUInteger index, BOOL flag );
CFStringRef RadioGroupButtonTitle( NSInteger tag, NSUInteger index );
void RadioGroupButtonSetTitle( NSInteger tag, NSUInteger index, CFStringRef title );

// statement
void CUI_RadioGroupStatement( NSInteger inTag, NSInteger inEnabled, NSInteger inIndex, CFTypeRef inTitles, NSInteger inRows, NSInteger inCols, NSInteger inSize, CGSize inSpacing, CGPoint inOrigin, NSInteger inWndTag );

