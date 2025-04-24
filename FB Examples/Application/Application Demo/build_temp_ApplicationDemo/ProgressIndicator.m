/*
 ProgressIndicator.m

 Bernie Wylde
 */

#import "ProgressIndicator.h"

@implementation ProgressIndicatorObject
@end

#pragma mark - subclass
@implementation ProgressIndicatorSC
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


@implementation NSProgressIndicator (Additions)
@dynamic tagNumber;

- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

// Class
Class ProgressIndicatorClass( void )
{ return [NSProgressIndicator class]; }

NSProgressIndicator *ProgressIndicatorWithTag( NSInteger tag )
{ return (NSProgressIndicator *)CUI_ValidateViewKindOfClass( tag, [NSProgressIndicator class] ); }

BOOL ProgressIndicatorExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSProgressIndicator class] ); }


// - animating -
void ProgressIndicatorStartAnimation( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) [c startAnimation:nil];
}

void ProgressIndicatorStopAnimation( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) [c stopAnimation:nil];
}

BOOL ProgressIndicatorUsesThreadedAnimation( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) return [c usesThreadedAnimation];
    return NO;
}

void ProgressIndicatorSetUsesThreadedAnimation( NSInteger tag, BOOL flag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) [c setUsesThreadedAnimation:flag];
}

// - advancing -
void ProgressIndicatorIncrementBy( NSInteger tag, double delta )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) [c incrementBy:delta];
}

double ProgressIndicatorDoubleValue( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) return [c doubleValue];
    return 0.0;
}

void ProgressIndicatorSetDoubleValue( NSInteger tag, double value )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    [c setDoubleValue:value];
}

double ProgressIndicatorMinValue( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) return [c minValue];
    return 0.0;
}

void ProgressIndicatorSetMinValue( NSInteger tag, double value )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    [c setMinValue:value];
}

double ProgressIndicatorMaxValue( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) return [c maxValue];
    return 0.0;
}

void ProgressIndicatorSetMaxValue( NSInteger tag, double value )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    [c setMaxValue:value];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSProgress *ProgressIndicatorObservedProgress( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) return [c observedProgress];
    return nil;
}

void ProgressIndicatorSetObservedProgress( NSInteger tag, NSProgress *progress )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) [c setObservedProgress:progress];
}
#endif// 140000

// - appearance -
NSControlSize ProgressIndicatorControlSize( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) return [c controlSize];
    return 0;
}

void ProgressIndicatorSetControlSize( NSInteger tag, NSControlSize size )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) [c setControlSize:size];
}

NSControlTint ProgressIndicatorControlTint( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) return [c controlTint];
    return 0;
}

void ProgressIndicatorSetControlTint( NSInteger tag, NSControlTint tint )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) [c setControlTint:tint];
}

BOOL ProgressIndicatorIsBezeled( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) return [c isBezeled];
    return NO;
}

void ProgressIndicatorSetBezeled( NSInteger tag, BOOL flag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) [c setBezeled:flag];
}

BOOL ProgressIndicatorIsIndeterminate( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) return [c isIndeterminate];
    return NO;
}

void ProgressIndicatorSetIndeterminate( NSInteger tag, BOOL flag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) [c setIndeterminate:flag];
}

NSUInteger ProgressIndicatorStyle( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) return [c style];
    return 0;
}

void ProgressIndicatorSetStyle( NSInteger tag, NSUInteger style )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) [c setStyle:style];
}

void ProgressIndicatorSizeToFit( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) [c sizeToFit];
}

BOOL ProgressIndicatorIsDisplayedWhenStopped( NSInteger tag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) return [c isDisplayedWhenStopped];
    return NO;
}

void ProgressIndicatorSetDisplayedWhenStopped( NSInteger tag, BOOL flag )
{
    NSProgressIndicator *c = ProgressIndicatorWithTag( tag );
    if ( c ) [c setDisplayedWhenStopped:flag];
}




// Init
NSProgressIndicator *ProgressIndicatorInit( NSInteger inTag, CGRect inRect, NSProgressIndicatorStyle inStyle )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) {
        if ( inStyle == NSProgressIndicatorBarStyle ) {
            rect = NSMakeRect( 20, 19, 100, 20 );
        } else {
            rect = NSMakeRect( 20, 20, 16, 16 );
        }
    }
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSProgressIndicator *ind;
#if __has_feature(objc_arc)
    if ( subclass ) {
        ind = [[ProgressIndicatorSC alloc] initWithFrame:rect];
    } else {
        ind = [[NSProgressIndicator alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        ind = [[[ProgressIndicatorSC alloc] initWithFrame:rect] autorelease];
    } else {
        ind = [[[NSProgressIndicator alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [ind autorelease];
//#endif
    
    // tag
    [ind setTag:inTag];

    // min
    [ind setMinValue:0.0];

    // max
    [ind setMaxValue:100.0];

    // value
    [ind setDoubleValue:0.0];
    
    // indeterminate
    [ind setIndeterminate:(inStyle == NSProgressIndicatorSpinningStyle)];
    
    // style
    [ind setStyle:inStyle];
    
    // displayWhenStopped
    [ind setDisplayedWhenStopped:YES];
    
    return ind;
}

void CUI_ProgressBar( NSInteger inTag, double inValue, CGRect inRect, double inMinValue, double inMaxValue, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSProgressIndicator *ind = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !ind ) {
            ind = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( ind ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, ind, [NSProgressIndicator class] ) ) {
                return;
            }

            // min
            if ( (int)inMinValue != kFBParamMissing ) [ind setMinValue:inMinValue];
            double minValue = [ind minValue];

            // max
            if ( (int)inMaxValue != kFBParamMissing ) [ind setMaxValue:inMaxValue];
            double maxValue = [ind maxValue];
            
            // value
            if ( (int)inValue != kFBParamMissing ) {
                if ( inValue >= minValue && inValue <= maxValue ) [ind setDoubleValue:inValue];
            }
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [ind setFrame:rect];
            
        } else {
            // init
            ind = ProgressIndicatorInit( inTag, inRect, NSProgressIndicatorBarStyle );
            
            // default autoresizing
            [ind setAutoresizingMask:NSViewMinYMargin];
            
            // min
            if ( (int)inMinValue != kFBParamMissing ) [ind setMinValue:inMinValue];
            
            // max
            if ( (int)inMaxValue != kFBParamMissing ) [ind setMaxValue:inMaxValue];
            
            // value
            if ( (int)inValue != kFBParamMissing ) {
                if ( inValue <= [ind maxValue] ) [ind setDoubleValue:inValue];
            }
            
            // wndTag
            [ind setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:ind];
            } else {
                [contentView addSubview:ind];
            }

        }
        
        [ind setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

void CUI_ProgressIndicator( NSInteger inTag, double inValue, CGRect inRect, double inMinValue, double inMaxValue, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSProgressIndicator *ind = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !ind ) {
            ind = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( ind ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, ind, [NSProgressIndicator class] ) ) {
                return;
            }

            // min
            if ( (int)inMinValue != kFBParamMissing ) [ind setMinValue:inMinValue];
            double minValue = [ind minValue];

            // max
            if ( (int)inMaxValue != kFBParamMissing ) [ind setMaxValue:inMaxValue];
            double maxValue = [ind maxValue];
            
            // value
            if ( (int)inValue != kFBParamMissing ) {
                if ( inValue >= minValue && inValue <= maxValue ) [ind setDoubleValue:inValue];
            }
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [ind setFrame:rect];
            
        } else {
            // init
            ind = ProgressIndicatorInit( inTag, inRect, NSProgressIndicatorSpinningStyle );
            
            // default autoresizing
            [ind setAutoresizingMask:NSViewMinYMargin];
            
            // min
            if ( (int)inMinValue != kFBParamMissing ) [ind setMinValue:inMinValue];
            
            // max
            if ( (int)inMaxValue != kFBParamMissing ) [ind setMaxValue:inMaxValue];
            
            // value
            if ( (int)inValue != kFBParamMissing ) {
                if ( inValue <= [ind maxValue] ) [ind setDoubleValue:inValue];
            }
                        
            // wndTag
            [ind setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:ind];
            } else {
                [contentView addSubview:ind];
            }

        }
        
        [ind setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}


#pragma mark - progressbar functions
// Class
Class ProgressBarClass( void )
{ return ProgressIndicatorClass(); }

NSProgressIndicator *ProgressBarWithTag( NSInteger tag )
{ return ProgressIndicatorWithTag( tag ); }

BOOL ProgressBarExists( NSInteger tag )
{ return ProgressIndicatorExists( tag ); }


// - animating -
void ProgressBarStartAnimation( NSInteger tag )
{ ProgressIndicatorStartAnimation( tag ); }

void ProgressBarStopAnimation( NSInteger tag )
{ ProgressIndicatorStopAnimation( tag ); }

BOOL ProgressBarUsesThreadedAnimation( NSInteger tag )
{ return ProgressIndicatorUsesThreadedAnimation( tag ); }

void ProgressBarSetUsesThreadedAnimation( NSInteger tag, BOOL flag )
{ ProgressIndicatorSetUsesThreadedAnimation( tag, flag ); }

// - advancing -
void ProgressBarIncrementBy( NSInteger tag, double delta )
{ ProgressIndicatorIncrementBy( tag, delta ); }

double ProgressBarDoubleValue( NSInteger tag )
{ return ProgressIndicatorDoubleValue( tag ); }

void ProgressBarSetDoubleValue( NSInteger tag, double value )
{ ProgressIndicatorSetDoubleValue( tag, value ); }

double ProgressBarMinValue( NSInteger tag )
{ return ProgressIndicatorMinValue( tag ); }

void ProgressBarSetMinValue( NSInteger tag, double value )
{ ProgressIndicatorSetMinValue( tag, value ); }

double ProgressBarMaxValue( NSInteger tag )
{ return ProgressIndicatorMaxValue( tag ); }

void ProgressBarSetMaxValue( NSInteger tag, double value )
{ ProgressIndicatorSetMaxValue( tag, value ); }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSProgress *ProgressBarObservedProgress( NSInteger tag )
{ return ProgressIndicatorObservedProgress( tag ); }

void ProgressBarSetObservedProgress( NSInteger tag, NSProgress *progress )
{ ProgressIndicatorSetObservedProgress( tag, progress ); }
#endif// 140000

// - appearance -
NSControlSize ProgressBarControlSize( NSInteger tag )
{ return ProgressIndicatorControlSize( tag ); }

void ProgressBarSetControlSize( NSInteger tag, NSControlSize size )
{ ProgressIndicatorSetControlSize( tag, size ); }

NSControlTint ProgressBarControlTint( NSInteger tag )
{ return ProgressIndicatorControlTint( tag ); }

void ProgressBarSetControlTint( NSInteger tag, NSControlTint tint )
{ ProgressIndicatorSetControlTint( tag, tint ); }

BOOL ProgressBarIsBezeled( NSInteger tag )
{ return ProgressIndicatorIsBezeled( tag ); }

void ProgressBarSetBezeled( NSInteger tag, BOOL flag )
{ ProgressIndicatorSetBezeled( tag, flag ); }

BOOL ProgressBarIsIndeterminate( NSInteger tag )
{ return ProgressIndicatorIsIndeterminate( tag ); }

void ProgressBarSetIndeterminate( NSInteger tag, BOOL flag )
{ ProgressIndicatorSetIndeterminate( tag, flag ); }

NSUInteger ProgressBarStyle( NSInteger tag )
{ return ProgressIndicatorStyle( tag ); }

void ProgressBarSetStyle( NSInteger tag, NSUInteger style )
{ ProgressIndicatorSetStyle( tag, style ); }

void ProgressBarSizeToFit( NSInteger tag )
{ ProgressIndicatorSizeToFit( tag ); }

BOOL ProgressBarIsDisplayedWhenStopped( NSInteger tag )
{ return ProgressIndicatorIsDisplayedWhenStopped( tag ); }

void ProgressBarSetDisplayedWhenStopped( NSInteger tag, BOOL flag )
{ ProgressIndicatorSetDisplayedWhenStopped( tag, flag ); }

