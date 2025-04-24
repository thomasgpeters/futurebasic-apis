/*
 Box.m
 
 Bernie Wylde
 */

#import "Box.h"

#pragma mark - subclass
@implementation BoxSC
- (void)drawRect:(NSRect)dirtyRect {
    CUI_ViewSubclassDrawRect( self, dirtyRect );
    if ( !DialogEventBool() ) [super drawRect:dirtyRect];
}

- (BOOL)acceptsFirstResponder {
    DialogEventSetBool(NO);
    CUI_ViewSubclassAcceptsFirstResponder( self );
    return DialogEventBool();
}

- (void)mouseDown:(NSEvent *)event {
    CUI_ViewSubclassMouseDown( self, event );
    if ( !DialogEventBool() ) [super mouseDown:event];
}

- (void)mouseUp:(NSEvent *)event {
    CUI_ViewSubclassMouseUp( self, event );
}

- (void)mouseEntered:(NSEvent *)event {
    CUI_ViewSubclassMouseEntered( self, event );
}

- (void)mouseExited:(NSEvent *)event {
    CUI_ViewSubclassMouseExited( self, event );
}

- (void)mouseDragged:(NSEvent *)event {
    CUI_ViewSubclassMouseDragged( self, event );
}

- (void)mouseMoved:(NSEvent *)event {
    CUI_ViewSubclassMouseMoved( self, event );
}

- (void)rightMouseDown:(NSEvent *)event {
    CUI_ViewSubclassRightMouseDown( self, event );
    if ( !DialogEventBool() ) [super rightMouseDown:event];
}

- (void)rightMouseUp:(NSEvent *)event {
    CUI_ViewSubclassRightMouseUp( self, event );
}

- (void)rightMouseDragged:(NSEvent *)event {
    CUI_ViewSubclassRightMouseDragged( self, event );
}

- (void)keyDown:(NSEvent *)event {
    CUI_ViewSubclassKeyDown( self, event );
    if ( !DialogEventBool() ) [super keyDown:event];
}

- (void)keyUp:(NSEvent *)event {
    CUI_ViewSubclassKeyUp( self, event );
}

- (void)flagsChanged:(NSEvent *)event {
    CUI_ViewSubclassFlagsChanged( self, event );
}

- (void)resetCursorRects {
    CUI_ViewSubclassResetCursorRects( self );
}

//- (void)updateTrackingAreas {
//    CUI_ViewSubclassUpdateTrackingAreas( self );
//    [super updateTrackingAreas];
//}

- (BOOL)wantsUpdateLayer {
    return CUI_ViewSubclassWantsUpdateLayer( self );
}

- (void)updateLayer {
    CUI_ViewSubclassUpdateLayer( self );
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CUI_ViewSubclassAwakeFromNib(self);
}

#pragma mark - menu
- (NSMenu *)menuForEvent:(NSEvent*)theEvent {
    CUI_ViewSubclassMenuForEvent( self, theEvent );
    return DialogEventNSMenu();
}
@end


@implementation NSBox (Additions)
@dynamic tagNumber;
- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}
- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end


#pragma mark - functions
// Class
Class BoxClass( void )
{ return [NSBox class]; }

NSBox *BoxWithTag( NSInteger tag )
{ return (NSBox *)CUI_ValidateViewKindOfClass( tag, [NSBox class] ); }

BOOL BoxExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSBox class] ); }


void BoxSetBorderType( NSInteger tag, NSBorderType type )
{
    NSBox *view = BoxWithTag( tag );
    if ( view ) [(NSBox *)view setBorderType:type];
}

void BoxSetTitlePosition( NSInteger tag, NSTitlePosition position )
{
    NSBox *view = BoxWithTag( tag );
    if ( view ) [(NSBox *)view setTitlePosition:position];
}

void BoxSetBorderColor( NSInteger tag, NSColor *col )
{
    NSBox *view = BoxWithTag( tag );
    if ( view ) [(NSBox *)view setBorderColor:col];
}

void BoxSetFillColor( NSInteger tag, NSColor *col )
{
    NSBox *view = BoxWithTag( tag );
    if ( view ) [(NSBox *)view setFillColor:col];
}

void BoxSetBorderWidth( NSInteger tag, CGFloat width )
{
    NSBox *view = BoxWithTag( tag );
    if ( view ) [(NSBox *)view setBorderWidth:width];
}

void BoxSetCornerRadius( NSInteger tag, CGFloat radius )
{
    NSBox *view = BoxWithTag( tag );
    if ( view ) [(NSBox *)view setCornerRadius:radius];
}

void BoxSetTransparent( NSInteger tag, BOOL flag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) [box setTransparent:flag];
}

void BoxSetTitleFont( NSInteger tag, CFTypeRef inFont )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) {
        NSFont *font = CUI_FixFont( (const void *)inFont );
        [box setTitleFont:font];
    }
}

void BoxSizeToFit( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) [box sizeToFit];
}

NSView *BoxContentView( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return [box contentView];
    return nil;
}

void BoxSetContentView( NSInteger tag, NSView *aView )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) [box setContentView:aView];
}

CGSize BoxContentViewMargins( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return NSSizeToCGSize([box contentViewMargins]);
    return CGSizeZero;
}

void BoxSetContentViewMargins( NSInteger tag, CGSize size )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) [box setContentViewMargins:NSSizeFromCGSize(size)];
}

CGRect BoxBorderRect( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return NSRectToCGRect([box borderRect]);
    return CGRectZero;
}

NSBoxType BoxType( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return [box boxType];
    return 0;
}

void BoxSetType( NSInteger tag, NSBoxType type )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) [box setBoxType:type];
}

NSBorderType BoxBorderType( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return [box borderType];
    return 0;
}

BOOL BoxIsTransparent( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return [box isTransparent];
    return NO;
}

CFStringRef BoxTitle( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return (__bridge CFStringRef)[box title];
    return nil;
}

void BoxSetTitle( NSInteger tag, CFStringRef title )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) [box setTitle:(__bridge NSString *)title];
}

CFTypeRef BoxTitleFont( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return (__bridge CFTypeRef)[box titleFont];
    return nil;
}

NSTitlePosition BoxTitlePosition( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return [box titlePosition];
    return 0;
}

CGRect BoxTitleRect( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return NSRectToCGRect([box titleRect]);
    return CGRectZero;
}

NSColor *BoxBorderColor( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return [box borderColor];
    return nil;
}

CGFloat BoxBorderWidth( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return [box borderWidth];
    return 0.0;
}

CGFloat BoxCornerRadius( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return [box cornerRadius];
    return 0.0;
}

NSColor *BoxFillColor( NSInteger tag )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) return [box fillColor];
    return nil;
}

void BoxSetFrameFromContentFrame( NSInteger tag, CGRect contentFrame )
{
    NSBox *box = BoxWithTag( tag );
    if ( box ) [box setFrameFromContentFrame:NSRectFromCGRect(contentFrame)];
}





// custom
void BoxSetTitleFontWithName( NSInteger tag, CFStringRef inName, CGFloat size )
{
    BOOL usePrevFont = NO;
    NSString *name = (__bridge NSString *)inName;
    NSBox *box = BoxWithTag( tag );
    if ( box ) {
        if ( name ) {
            usePrevFont = ( [name length] == 0 );
        } else {
            usePrevFont = YES;
        }
        if ( usePrevFont ) name = [[box titleFont] fontName];
        if ( (int)size == 0 ) size = [[box titleFont] pointSize];
        
        //        [box setTitleFont:[NSFont fontWithName:(__bridge NSString *)name size:size]];
        //        CTFontRef font = CTFontCreateWithName( (__bridge CFStringRef)name, size, NULL );
        //        [box setTitleFont:(NSFont *)font];
        //        CFRelease(font);
        
        [box setTitleFont:[NSFont fontWithName:name size:size]];
    }
}


// Init
NSBox *BoxInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) {
        rect = NSMakeRect( 17, 16, 177, 114 );
    }

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSBox *box;
#if __has_feature(objc_arc)
    if ( subclass ) {
        box = [[BoxSC alloc] initWithFrame:rect];
    } else {
        box = [[NSBox alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        box = [[[BoxSC alloc] initWithFrame:rect] autorelease];
    } else {
        box = [[[NSBox alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [box release];
//#endif
    
    // tag
    [box setTag:inTag];
    
    return box;
}

// statement
void CUI_Box( NSInteger inTag, CFStringRef inTitle, CGRect inRect, NSInteger inType, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSString *title = (__bridge NSString *)inTitle;
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        
        NSBox *box = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !box ) {
            box = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( box ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);
            
            // make sure it's same view class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, box, [NSBox class] ) ) {
                return;
            }

            // title
            if ( title ) {
                [box setTitle:title];
            } else {
                //[box setTitlePosition:NSNoTitle];
            }

            // rect
            if ( !NSIsEmptyRect( rect ) ) [box setFrame:rect];
            
            // type
            if ( inType != kFBParamMissing ) [box setBoxType:inType];
            
        } else {        // create
            box = BoxInit( inTag, inRect );
             
            // default autoresizing
            [box setAutoresizingMask:NSViewMinYMargin];
                        
            // title
            if ( title ) {
                [box setTitle:title];
            } else {
                [box setTitlePosition:NSNoTitle];
            }
            
            // type
            if ( inType != kFBParamMissing ) [box setBoxType:inType];
            
            // wndTag
            [box setWndTag:inWndTag];
            
            // if superview flag set, add box to superview stack
            if ( CUI_IsSuperview() ) CUI_AddSuperview( box );

            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview == box ) {
                superview = CUI_PenultimateSuperview();
            }

            if ( superview ) {
                [superview addSubview:box];
            } else {
                [contentView addSubview:box];
            }

        }
        
        [box setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}


