/*
 Panel.m

 Bernie Wylde
 */

#import "Panel.h"

#pragma mark - subclass
@implementation PanelSC
- (void)awakeFromNib {
    [super awakeFromNib];
    CUI_WindowSubclassAwakeFromNib(self);
}
@end


#pragma mark - additions
@implementation NSPanel (Additions)
@dynamic tagNumber;

- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

// Class
Class PanelClass( void )
{ return [NSPanel class]; }

NSPanel *PanelWithTag( NSInteger tag )
{
    NSPanel *panel = (NSPanel *)CUI_WindowWithTag( tag );
    if ( panel ) {
        if ( [panel isKindOfClass:[NSPanel class]] ) return panel;
    }
    return nil;
}

BOOL PanelExists( NSInteger tag )
{
    NSPanel *panel = (NSPanel *)CUI_WindowWithTag( tag );
    if ( panel ) {
        if ( [panel isKindOfClass:[NSPanel class]] ) return YES;
    }
    return NO;
}



void PanelSetFloatingPanel( NSInteger tag, BOOL flag )
{
    NSPanel *w = PanelWithTag( tag );
    if ( w ) [w setFloatingPanel:flag];
}

void PanelSetBecomesKeyOnlyIfNeeded( NSInteger tag, BOOL flag )
{
    NSPanel *w = PanelWithTag( tag );
    if ( w ) [w setBecomesKeyOnlyIfNeeded:flag];
}

void PanelSetWorksWhenModal( NSInteger tag, BOOL flag )
{
    NSPanel *w = PanelWithTag( tag );
    if ( w ) [w setWorksWhenModal:flag];
}


// Init
NSPanel *PanelInit( NSInteger inTag, CGRect inRect )
{
    BOOL center = NO;

    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) {
        rect = NSMakeRect( 0, 0, 276, 378 );
    }
//    else {
//        center = ( rect.origin.x == 0.0 && rect.origin.y == 0.0 );
//    }
    center = ( rect.origin.x == 0.0 && rect.origin.y == 0.0 );// change default position to centered rather than bottom left  20240805

    // style
    NSUInteger style = NSTitledWindowMask | NSClosableWindowMask | NSResizableWindowMask | NSUtilityWindowMask;

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSPanel *panel;
    if ( subclass ) {
        panel = [[PanelSC alloc] initWithContentRect:rect styleMask:style backing:NSBackingStoreBuffered defer:NO];
    } else {
        panel = [[NSPanel alloc] initWithContentRect:rect styleMask:style backing:NSBackingStoreBuffered defer:NO];
    }
    
    // floating panel
    [panel setFloatingPanel:YES];

    // content view
    //create content view subclass for intercepting content view drawRect:, etc. to issue dialog events.
    ContentViewSC *contentView = [[ContentViewSC alloc] initWithFrame:[[panel contentView] frame]];
    [panel setContentView:contentView];
    [contentView setIdentifier:[NSString stringWithFormat:@"%d",windowContentViewTag]];

    // key view loop
    [panel setAutorecalculatesKeyViewLoop:YES];
    
    // tag
    [panel setTag:inTag];

    // center
    if ( center ) [(NSWindow *)panel center];
    
    // title
    [panel setTitle:@"Untitled"];
    
    // delegate
    [panel setDelegate:CUI_WindowDelegateObj()];
    
    // add window to app delegate
    CUI_AppDelegateAddWindow( panel );

    return panel;
}

// Statement
void CUI_Panel( NSInteger inTag, CFStringRef inTitle, CGRect inRect, NSInteger inStyle )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
        
    if ( CUI_ObjectIsPopover( inTag ) ) return;
    
    NSString *title = (__bridge NSString *)inTitle;
    NSRect rect = NSRectFromCGRect( inRect );
    
    NSWindow *w = CUI_WindowWithTag( inTag );
    
    if ( w ) {      // exists
        // clear subclass flag
        CUI_SetSubclassFlag(NO);

        // title
        if ( title ) [w setTitle:title];
        
        // rect
        if ( !NSIsEmptyRect( rect ) ) {
            [w setFrame:[w frameRectForContentRect:rect] display:YES];
        }
        
        // style
        if ( (int)inStyle != kFBParamMissing ) [w setStyleMask:inStyle];
        
    } else {    // create
        // init
        w = PanelInit( inTag, inRect );

        // style
        if ( (int)inStyle != kFBParamMissing ) [w setStyleMask:inStyle];
                
        // title
        if ( title ) [w setTitle:title];
    }
    
    // show
    if ( show ) {
        [w makeKeyAndOrderFront:nil];
    } else {
        [w orderOut:nil];
    }
    
    CUI_OutputWindowSetTag( inTag );
}

