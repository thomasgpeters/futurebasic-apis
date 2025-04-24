/*
 SegmentedControl.m

 Bernie Wylde
 */

#import "SegmentedControl.h"

@implementation SegmentedControlSC
- (void)drawRect:(NSRect)dirtyRect {
    CUI_ViewSubclassDrawRect( self, dirtyRect );
    if ( !DialogEventBool() ) [super drawRect:dirtyRect];
}

- (void)resetCursorRects {
    CUI_ViewSubclassResetCursorRects( self );
}

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

// Class
Class SegmentedControlClass( void )
{ return [NSSegmentedControl class]; }

NSSegmentedControl *SegmentedControlWithTag( NSInteger tag )
{ return (NSSegmentedControl *)CUI_ValidateViewKindOfClass( tag, [NSSegmentedControl class] ); }

BOOL SegmentedControlExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSSegmentedControl class] ); }


// Behavior
NSSegmentSwitchTracking SegmentedControlTrackingMode( NSInteger tag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c trackingMode];
    return 0;
}

void SegmentedControlSetTrackingMode( NSInteger tag, NSSegmentSwitchTracking mode )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setTrackingMode:mode];
}

NSSegmentStyle SegmentedControlStyle( NSInteger tag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c segmentStyle];
    return 0;
}

void SegmentedControlSetStyle( NSInteger tag, NSSegmentStyle style )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setSegmentStyle:style];
}

// Number of segments
NSInteger SegmentedControlSegmentCount( NSInteger tag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c segmentCount];
    return 0;
}

void SegmentedControlSetSegmentCount( NSInteger tag, NSInteger count )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setSegmentCount:count];
}

// Text
CFStringRef SegmentedControlLabelForSegment( NSInteger tag, NSInteger index )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return (__bridge CFStringRef)[c labelForSegment:index];
    return nil;
}

void SegmentedControlSetSegmentLabel( NSInteger tag, NSInteger index, CFStringRef string )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setLabel:(__bridge NSString *)string forSegment:index];
}

NSTextAlignment SegmentedControlSegmentAlignment( NSInteger tag, NSInteger index )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c alignmentForSegment:index];
    return 0;
}

void SegmentedControlSetSegmentAlignment( NSInteger tag, NSInteger index, NSTextAlignment value )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setAlignment:value forSegment:index];
}

// Image
NSImage *SegmentedControlImageForSegment( NSInteger tag, NSInteger index )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c imageForSegment:index];
    return nil;
}

void SegmentedControlSetSegmentImage( NSInteger tag, NSInteger index, NSImage *image )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setImage:image forSegment:index];
}

NSImageScaling SegmentedControlImageScaling( NSInteger tag, NSInteger index )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c imageScalingForSegment:index];
    return 0;
}

void SegmentedControlSetImageScaling( NSInteger tag, NSInteger index, NSImageScaling scaling )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setImageScaling:scaling forSegment:index];
}

// Menu
NSMenu *SegmentedControlMenuForSegment( NSInteger tag, NSInteger index )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c menuForSegment:index];
    return nil;
}

void SegmentedControlSetSegmentMenu( NSInteger tag, NSInteger index, NSMenu *menu )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setMenu:menu forSegment:index];
}

void SegmentedControlSetSegmentMenuIndex( NSInteger tag, NSInteger index, NSInteger menuIndex )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) {
        NSMenu *menu = MenuAtIndex( menuIndex );
        if ( menu ) {
            [c setMenu:menu forSegment:index];
        }
    }
}

BOOL SegmentedControlSegmentShowsMenuIndicator( NSInteger tag, NSInteger index )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c showsMenuIndicatorForSegment:index];
    return NO;
}

void SegmentedControlSetSegmentShowsMenuIndicator( NSInteger tag, NSInteger index, BOOL flag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setShowsMenuIndicator:flag forSegment:index];
}

BOOL SegmentedControlIsSpringLoaded( NSInteger tag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c isSpringLoaded];
    return NO;
}

void SegmentedControlSetSpringLoaded( NSInteger tag, BOOL flag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setSpringLoaded:flag];
}

// Selected segment
NSInteger SegmentedControlSelectedSegment( NSInteger tag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c selectedSegment];
    return -1;
}

NSInteger SegmentedControlIndexOfSelectedItem( NSInteger tag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c indexOfSelectedItem];
    return 0;
}

BOOL SegmentedControlSelectSegmentWithTag( NSInteger ctrlTag, NSInteger segTag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( ctrlTag );
    if ( c ) return [c selectSegmentWithTag:segTag];
    return NO;
}

void SegmentedControlSetSegmentSelected( NSInteger tag, NSInteger index, BOOL flag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setSelected:flag forSegment:index];
}

BOOL SegmentedControlIsSegmentSelected( NSInteger tag, NSInteger index )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c isSelectedForSegment:index];
    return NO;
}

NSColor *SegmentedControlSelectedSegmentBezelColor( NSInteger tag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c selectedSegmentBezelColor];
    return nil;
}

void SegmentedControlSetSelectedSegmentBezelColor( NSInteger tag, NSColor *col )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setSelectedSegmentBezelColor:col];
}

double SegmentedControlDoubleValueForSelectedSegment( NSInteger tag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c doubleValueForSelectedSegment];
    return 0.0;
}

// Spacing
CGFloat SegmentedControlSegmentWidth( NSInteger tag, NSInteger index )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c widthForSegment:index];
    return 0.0;
}

void SegmentedControlSetSegmentWidth( NSInteger tag, NSInteger index, CGFloat value )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setWidth:value forSegment:index];
}

void SegmentedControlSetSegmentDistribution( NSInteger tag, NSSegmentDistribution value )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setSegmentDistribution:value];
}

// Enable
void SegmentedControlSetSegmentEnabled( NSInteger tag, NSInteger index, BOOL flag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setEnabled:flag forSegment:index];
}

BOOL SegmentedControlIsSegmentEnabled( NSInteger tag, NSInteger index )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c isEnabledForSegment:index];
    return NO;
}

// Tags and tooltips
NSInteger SegmentedControlSegmentTag( NSInteger tag, NSInteger index )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return [c tagForSegment:index];
    return 0;
}

void SegmentedControlSetSegmentTag( NSInteger tag, NSInteger index, NSInteger segTag )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setTag:segTag forSegment:index];
}

CFStringRef SegmentedControlSegmentToolTip( NSInteger tag, NSInteger index )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) return (__bridge CFStringRef)[c toolTipForSegment:index];
    return nil;
}

void SegmentedControlSetSegmentToolTip( NSInteger tag, NSInteger index, CFStringRef string )
{
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) [c setToolTip:(__bridge NSString *)string forSegment:index];
}


// Convenience
#if 1

void SegmentedControlSetSegment( NSInteger tag, NSInteger index, NSInteger enabled, CFStringRef label, NSImage *image, NSUInteger imageScaling, NSInteger width )
{
    
    NSSegmentedControl *c = SegmentedControlWithTag( tag );
    if ( c ) {
        NSSegmentedCell *cell = (NSSegmentedCell *)[c cell];
        
        // label
        if ( label ) [cell setLabel:(__bridge NSString *)label forSegment:index];
        
        // image
        if ( image ) {
            [cell setImage:image forSegment:index];
            
            // image scaling
            [cell setImageScaling:imageScaling forSegment:index];
        }
        
        // width
        if ( width ) [cell setWidth:width forSegment:index];
        
        // enabled
        [cell setEnabled:(BOOL)enabled forSegment:index];
    }
}

#else

void SegmentedControlSetSegment( NSInteger tag, NSInteger index, NSInteger enabled, CFStringRef label, NSImage *image, NSUInteger imageScaling, NSInteger width )
{
    // target window
    id w = CUI_OutputWindow();
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSSegmentedControl *c = CUI_ViewSubviewWithTag( contentView, tag );
        
        if ( !c ) {
            c = TitlebarAccessoryViewWithTag( tag );
        }
        
        if ( c ) {
            NSSegmentedCell *cell = (NSSegmentedCell *)[c cell];
            
            // label
            if ( label ) [cell setLabel:(__bridge NSString *)label forSegment:index];
            
            // image
            if ( image ) {
                [cell setImage:image forSegment:index];
                
                // image scaling
                [cell setImageScaling:imageScaling forSegment:index];
            }
            
            // width
            if ( width ) [cell setWidth:width forSegment:index];
            
            // enabled
            [cell setEnabled:(BOOL)enabled forSegment:index];
            
        }
    } else {
        CUI_ShowAlert( NSWarningAlertStyle, @"Window error.", @"Window does not exist." );
    }
}

#endif


// Init
NSSegmentedControl *SegmentedControlInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 18, 18, 104, 24 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSSegmentedControl *seg;
#if __has_feature(objc_arc)
    if ( subclass ) {
        seg = [[SegmentedControlSC alloc] initWithFrame:rect];
    } else {
        seg = [[NSSegmentedControl alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        seg = [[[SegmentedControlSC alloc] initWithFrame:rect] autorelease];
    } else {
        seg = [[[NSSegmentedControl alloc] initWithFrame:rect] autorelease];
    }
#endif
    
    // tag
    [seg setTag:inTag];

    // segment count
    [seg setSegmentCount:3];

    // target/action
    [seg setTarget:CUI_ControlTargetObj()];
    [seg setAction:@selector(controlAction:)];
    
    return seg;
}

void CUI_SegmentedControl( NSInteger inTag, NSInteger inEnabled, NSInteger inIndex, CGRect inRect, NSInteger inSegments, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSSegmentedControl *seg = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !seg ) {
            seg = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( seg ) {
            
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, seg, [NSSegmentedControl class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [seg setEnabled:(BOOL)inEnabled];
            
            // index
            if ( inIndex != kFBParamMissing ) [seg setSelected:YES forSegment:inIndex];
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [seg setFrame:rect];
            
        } else {
            // init
            seg = SegmentedControlInit( inTag, inRect );
            
            // default autoresizing
            [seg setAutoresizingMask:NSViewMinYMargin];
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [seg setEnabled:(BOOL)inEnabled];
            
            // segment count
            if ( inSegments != kFBParamMissing ) [seg setSegmentCount:inSegments];
            
            NSInteger count = [seg segmentCount];
            for ( NSInteger index = 0; index < count; index++ ) {
                [seg setWidth:rect.size.width/count forSegment:index];
            }
            
            // wndTag
            [seg setWndTag:inWndTag];
            
            // index
            if ( inIndex != kFBParamMissing ) [seg setSelected:YES forSegment:inIndex];
            
            // add to window/popover/superview
            NSView *superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:seg];
            } else {
                [contentView addSubview:seg];
            }
        }
        
        [seg setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

