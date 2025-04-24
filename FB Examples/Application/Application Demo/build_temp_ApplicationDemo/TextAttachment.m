/*
 TextAttachment.m

 Bernie Wylde
 */

#import "TextAttachment.h"

// Class
Class TextAttachmentClass( void )
{ return [NSTextAttachment class]; }

// Init
NSTextAttachment *TextAttachmentInit( void )
{
#if __has_feature(objc_arc)
    return [[NSTextAttachment alloc] init];
#else
    return [[[NSTextAttachment alloc] init] autorelease];
#endif
}

NSTextAttachment *TextAttachmentWithFileWrapper( NSFileWrapper *fw )
{
#if __has_feature(objc_arc)
    return [[NSTextAttachment alloc] initWithFileWrapper:fw];
#else
    return [[[NSTextAttachment alloc] initWithFileWrapper:fw] autorelease];
#endif
}

NSTextAttachment *TextAttachmentWithData( CFDataRef dta, CFStringRef type )
{
#if __has_feature(objc_arc)
    return [[NSTextAttachment alloc] initWithData:(__bridge NSData *)dta ofType:(__bridge NSString *)type];
#else
    return [[[NSTextAttachment alloc] initWithData:(__bridge NSData *)dta ofType:(__bridge NSString *)type] autorelease];
#endif
}

// Contents
CGRect TextAttachmentBounds( NSTextAttachment *ref )
{ return NSRectToCGRect([ref bounds]); }

void TextAttachmentSetBounds( NSTextAttachment *ref, CGRect r )
{ [ref setBounds:NSRectFromCGRect(r)]; }

CFDataRef TextAttachmentContents( NSTextAttachment *ref )
{ return (__bridge CFDataRef)[ref contents]; }

void TextAttachmentSetContents( NSTextAttachment *ref, CFDataRef dta )
{ [ref setContents:(__bridge NSData *)dta]; }

CFStringRef TextAttachmentFileType( NSTextAttachment *ref )
{ return (__bridge CFStringRef)[ref fileType]; }

void TextAttachmentSetFileType( NSTextAttachment *ref, CFStringRef type )
{ [ref setFileType:(__bridge NSString *)type]; }

NSImage *TextAttachmentImage( NSTextAttachment *ref )
{ return [ref image]; }

void TextAttachmentSetImage( NSTextAttachment *ref, NSImage *image )
{ [ref setImage:image]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
BOOL TextAttachmentAllowsTextAttachmentView( NSTextAttachment *ref )
{ return [ref allowsTextAttachmentView]; }

void TextAttachmentSetAllowsTextAttachmentView( NSTextAttachment *ref, BOOL flag )
{ [ref setAllowsTextAttachmentView:flag]; }

BOOL TextAttachmentUsesTextAttachmentView( NSTextAttachment *ref )
{ return [ref usesTextAttachmentView]; }

CGFloat TextAttachmentLineLayoutPadding( NSTextAttachment *ref )
{ return [ref lineLayoutPadding]; }

void TextAttachmentSetLineLayoutPadding( NSTextAttachment *ref, CGFloat padding )
{ [ref setLineLayoutPadding:padding]; }
#endif// 120000

NSFileWrapper *TextAttachmentFileWrapper( NSTextAttachment *ref )
{ return [ref fileWrapper]; }

void TextAttachmentSetFileWrapper( NSTextAttachment *ref, NSFileWrapper *wrapper )
{ [ref setFileWrapper:wrapper]; }

// Cell
id<NSTextAttachmentCell> TextAttachmentCell( NSTextAttachment *ref )
{ return [ref attachmentCell]; }

void TextAttachmentSetCell( NSTextAttachment *ref, id<NSTextAttachmentCell> cell )
{ [ref setAttachmentCell:cell]; }

// Convenience methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
void TextAttachmentRegisterViewProviderClass( Class class, CFStringRef fileType )
{ [NSTextAttachment registerTextAttachmentViewProviderClass:class forFileType:(__bridge NSString *)fileType]; }

Class TextAttachmentViewProviderClass( CFStringRef fileType )
{ return [NSTextAttachment textAttachmentViewProviderClassForFileType:(__bridge NSString *)fileType]; }
#endif// 120000


#pragma mark - TextAttachmentCell
// Init
id<NSTextAttachmentCell> TextAttachmentCellWithImage( NSImage *image )
{
#if __has_feature(objc_arc)
    return [[NSTextAttachmentCell alloc] initImageCell:image];
#else
    return [[[NSTextAttachmentCell alloc] initImageCell:image] autorelease];
#endif
}

// Draw
void TextAttachmentCellDraw( id<NSTextAttachmentCell> ref, CGRect frame, NSInteger controlViewTag )
{
    NSView *view = ViewWithTag( controlViewTag );
    if ( view ) {
        [ref drawWithFrame:NSRectFromCGRect(frame) inView:view];
    }
}

void TextAttachmentCellDrawCharacterIndex( id<NSTextAttachmentCell> ref, CGRect frame, NSInteger controlViewTag, NSUInteger charIndex )
{
    NSView *view = ViewWithTag( controlViewTag );
    if ( view ) {
        [ref drawWithFrame:NSRectFromCGRect(frame) inView:view characterIndex:charIndex];
    }
}

void TextAttachmentCellDrawCharacterIndexLayoutManager( id<NSTextAttachmentCell> ref, CGRect frame, NSInteger controlViewTag, NSUInteger charIndex, NSLayoutManager *layoutManager )
{
    NSView *view = ViewWithTag( controlViewTag );
    if ( view ) {
        [ref drawWithFrame:NSRectFromCGRect(frame) inView:view characterIndex:charIndex layoutManager:layoutManager];
    }
}

void TextAttachmentCellHighlight( id<NSTextAttachmentCell> ref, BOOL highlight, CGRect frame, NSInteger controlViewTag )
{
    NSView *view = ViewWithTag( controlViewTag );
    if ( view ) {
        [ref highlight:highlight withFrame:NSRectFromCGRect(frame) inView:view];
    }
}

// Cell size and position
CGSize TextAttachmentCellSize( id<NSTextAttachmentCell> ref )
{ return NSSizeToCGSize([ref cellSize]); }

CGPoint TextAttachmentCellBaselineOffset( id<NSTextAttachmentCell> ref )
{ return NSPointToCGPoint([ref cellBaselineOffset]); }

CGRect TextAttachmentCellFrameForTextContainer( id<NSTextAttachmentCell> ref, NSTextContainer *tc, CGRect proposedLineFragment, CGPoint glyphPosition, NSUInteger charIndex )
{ return NSRectToCGRect([ref cellFrameForTextContainer:tc proposedLineFragment:NSRectFromCGRect(proposedLineFragment) glyphPosition:NSPointFromCGPoint(glyphPosition) characterIndex:charIndex]); }

// Set attachment
void TextAttachmentCellSetAttachment( id<NSTextAttachmentCell> ref, NSTextAttachment *attachment )
{ [ref setAttachment:attachment]; }

