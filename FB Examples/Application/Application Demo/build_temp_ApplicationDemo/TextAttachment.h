/*
 TextAttachment.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "View.h"

// Class
Class TextAttachmentClass( void );

// Init
NSTextAttachment *TextAttachmentInit( void );
NSTextAttachment *TextAttachmentWithFileWrapper( NSFileWrapper *fw );
NSTextAttachment *TextAttachmentWithData( CFDataRef dta, CFStringRef type );

// Contents
CGRect TextAttachmentBounds( NSTextAttachment *ref );
void TextAttachmentSetBounds( NSTextAttachment *ref, CGRect r );
CFDataRef TextAttachmentContents( NSTextAttachment *ref );
void TextAttachmentSetContents( NSTextAttachment *ref, CFDataRef dta );
CFStringRef TextAttachmentFileType( NSTextAttachment *ref );
void TextAttachmentSetFileType( NSTextAttachment *ref, CFStringRef type );
NSImage *TextAttachmentImage( NSTextAttachment *ref );
void TextAttachmentSetImage( NSTextAttachment *ref, NSImage *image );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
BOOL TextAttachmentAllowsTextAttachmentView( NSTextAttachment *ref );
API_AVAILABLE(macos(12.0))
void TextAttachmentSetAllowsTextAttachmentView( NSTextAttachment *ref, BOOL flag );
API_AVAILABLE(macos(12.0))
BOOL TextAttachmentUsesTextAttachmentView( NSTextAttachment *ref );
API_AVAILABLE(macos(12.0))
CGFloat TextAttachmentLineLayoutPadding( NSTextAttachment *ref );
API_AVAILABLE(macos(12.0))
void TextAttachmentSetLineLayoutPadding( NSTextAttachment *ref, CGFloat padding );
#endif// 120000

NSFileWrapper *TextAttachmentFileWrapper( NSTextAttachment *ref );
void TextAttachmentSetFileWrapper( NSTextAttachment *ref, NSFileWrapper *wrapper );

// Cell
id<NSTextAttachmentCell> TextAttachmentCell( NSTextAttachment *ref );
void TextAttachmentSetCell( NSTextAttachment *ref, id<NSTextAttachmentCell> cell );

// Convenience methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
API_AVAILABLE(macos(12.0))
void TextAttachmentRegisterViewProviderClass( Class class, CFStringRef fileType );
API_AVAILABLE(macos(12.0))
Class TextAttachmentViewProviderClass( CFStringRef fileType );
#endif// 120000

/*
 TextAttachmentCell
 */

// Init
id<NSTextAttachmentCell> TextAttachmentCellWithImage( NSImage *image );

// Draw
void TextAttachmentCellDraw( id<NSTextAttachmentCell> ref, CGRect frame, NSInteger controlViewTag );
void TextAttachmentCellDrawCharacterIndex( id<NSTextAttachmentCell> ref, CGRect frame, NSInteger controlViewTag, NSUInteger charIndex );
void TextAttachmentCellDrawCharacterIndexLayoutManager( id<NSTextAttachmentCell> ref, CGRect frame, NSInteger controlViewTag, NSUInteger charIndex, NSLayoutManager *layoutManager );
void TextAttachmentCellHighlight( id<NSTextAttachmentCell> ref, BOOL highlight, CGRect frame, NSInteger controlViewTag );

// Cell size and position
CGSize TextAttachmentCellSize( id<NSTextAttachmentCell> ref );
CGPoint TextAttachmentCellBaselineOffset( id<NSTextAttachmentCell> ref );
CGRect TextAttachmentCellFrameForTextContainer( id<NSTextAttachmentCell> ref, NSTextContainer *tc, CGRect proposedLineFragment, CGPoint glyphPosition, NSUInteger charIndex );

// Set attachment
void TextAttachmentCellSetAttachment( id<NSTextAttachmentCell> ref, NSTextAttachment *attachment );

