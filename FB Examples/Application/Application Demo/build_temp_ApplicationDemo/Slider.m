/*
 Slider.m

 Bernie Wylde
 */

#import "Slider.h"

@implementation SliderObject
@end

@implementation SliderSC
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
Class SliderClass( void )
{ return [NSSlider class]; }

NSSlider *SliderWithTag( NSInteger tag )
{ return (NSSlider *)CUI_ValidateViewKindOfClass( tag, [NSSlider class] ); }

BOOL SliderExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSSlider class] ); }


// - create -

// - appearance -
NSSliderType SliderType( NSInteger tag )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [[slider cell] sliderType];
    return 0;
}

void SliderSetType( NSInteger tag, NSSliderType type )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) [[slider cell] setSliderType:type];
}

double SliderAltIncrementValue( NSInteger tag )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [slider altIncrementValue];
    return 0.0;
}

void SliderSetAltIncrementValue( NSInteger tag, double value )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) [slider setAltIncrementValue:value];
}

CGFloat SliderKnobThickness( NSInteger tag )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [slider knobThickness];
    return 0.0;
}

BOOL SliderIsVertical( NSInteger tag )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [slider isVertical];
    return NO;
}

// - limits -
double SliderMaxValue( NSInteger tag )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [slider maxValue];
    return 0.0;
}

void SliderSetMaxValue( NSInteger tag, double value )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) [slider setMaxValue:value];
}

double SliderMinValue( NSInteger tag )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [slider minValue];
    return 0.0;
}

void SliderSetMinValue( NSInteger tag, double value )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) [slider setMinValue:value];
}

// - mouse events -

// - tick marks -
BOOL SliderAllowsTickMarkValuesOnly( NSInteger tag )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [slider allowsTickMarkValuesOnly];
    return NO;
}

void SliderSetAllowsTickMarkValuesOnly( NSInteger tag, BOOL flag )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) [slider setAllowsTickMarkValuesOnly:flag];
}

double SliderClosestTickMarkValueToValue( NSInteger tag, double value )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [slider closestTickMarkValueToValue:value];
    return 0.0;
}

NSInteger SliderIndexOfTickMarkAtPoint( NSInteger tag, CGPoint pt )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [slider indexOfTickMarkAtPoint:NSPointFromCGPoint(pt)];
    return 0;
}

NSInteger SliderNumberOfTickMarks( NSInteger tag )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [slider numberOfTickMarks];
    return 0;
}

void SliderSetNumberOfTickMarks( NSInteger tag, NSInteger value )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) [slider setNumberOfTickMarks:value];
}

CGRect SliderRectOfTickMarkAtIndex( NSInteger tag, NSInteger index )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return NSRectToCGRect([slider rectOfTickMarkAtIndex:index]);
    return CGRectZero;
}

NSTickMarkPosition SliderTickMarkPosition( NSInteger tag )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [slider tickMarkPosition];
    return 0;
}

void SliderSetTickMarkPosition( NSInteger tag, NSTickMarkPosition position )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) [slider setTickMarkPosition:position];
}

double SliderTickMarkValueAtIndex( NSInteger tag, NSInteger index )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [slider tickMarkValueAtIndex:index];
    return 0.0;
}

// Instance properties
NSColor *SliderTrackFillColor( NSInteger tag )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) return [slider trackFillColor];
    return nil;
}

void SliderSetTrackFillColor( NSInteger tag, NSColor *col )
{
    NSSlider *slider = SliderWithTag( tag );
    if ( slider ) [slider setTrackFillColor:col];
}

// Init
NSSlider *SliderInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 18, 17, 19, 96 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSSlider *slider;
#if __has_feature(objc_arc)
    if ( subclass ) {
        slider = [[SliderSC alloc] initWithFrame:rect];
    } else {
        slider = [[NSSlider alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        slider = [[[SliderSC alloc] initWithFrame:rect] autorelease];
    } else {
        slider = [[[NSSlider alloc] initWithFrame:rect] autorelease];
    }
#endif
    
    // tag
    [slider setTag:inTag];

    // min
    [slider setMinValue:0.0];

    // max
    [slider setMaxValue:100.0];

    // value
    [slider setDoubleValue:0.0];
    
    // continuous
    [slider setContinuous:NO];

    // target/action
    [slider setTarget:CUI_ControlTargetObj()];
    [slider setAction:@selector(controlAction:)];

    return slider;
}

// Statement
void CUI_Slider( NSInteger inTag, NSInteger inEnabled, double inValue, CGRect inRect, double inMinValue, double inMaxValue, NSInteger inTickMarks, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    NSView *contentView = nil;
    NSSlider *slider = nil;
    
    // find slider in the output window or the front window
    if ( w ) {
        contentView = CUI_TargetContentView( w );
        slider = CUI_ViewSubviewWithTag( contentView, inTag );
        if ( !slider ) {
            slider = TitlebarAccessoryViewWithTag( inTag );
        }
    }
    
    // not in a window, so look in menus
    if ( !slider ) {
        slider = CUI_FindViewInAnyMenu( inTag );
        if ( slider ) {
            w = nil;
            inWndTag = 0;
        }
    }
    
#if 1
    if ( slider ) {     // already exists
        // clear subclass flag
        CUI_SetSubclassFlag(NO);

        // make sure it's correct class
        if ( !CUI_ValidateViewClass( inWndTag, inTag, slider, [NSSlider class] ) ) {
            return;
        }

        // enabled
        if ( inEnabled != kFBParamMissing ) [slider setEnabled:(BOOL)inEnabled];
        
        // min
        if ( (int)inMinValue != kFBParamMissing ) [slider setMinValue:inMinValue];
        double minValue = [slider minValue];
        
        // max
        if ( (int)inMaxValue != kFBParamMissing ) [slider setMaxValue:inMaxValue];
        double maxValue = [slider maxValue];

        // value
        if ( (int)inValue != kFBParamMissing ) {
            if ( inValue >= minValue && inValue <= maxValue ) [slider setDoubleValue:inValue];
        }
        
        // rect
        if ( !NSIsEmptyRect( rect ) ) [slider setFrame:rect];
        
        // tick marks
        if ( inTickMarks != kFBParamMissing ) [slider setNumberOfTickMarks:inTickMarks];
        
    } else {
        if ( w ) {
            // init
            slider = SliderInit( inTag, inRect );
            
            // rect
            if ( NSIsEmptyRect( rect ) ) {
                if ( inTickMarks > 0 ) {
                    rect = NSMakeRect( 18, 17, 24, 96 );
                } else {
                    rect = NSMakeRect( 18, 17, 19, 96 );
                }
                [slider setFrame:rect];
            }
            
            // default autoresizing
            [slider setAutoresizingMask:NSViewMinYMargin];
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [slider setEnabled:(BOOL)inEnabled];
            
            // min
            if ( (int)inMinValue != kFBParamMissing ) [slider setMinValue:inMinValue];
            
            // max
            if ( (int)inMaxValue != kFBParamMissing ) [slider setMaxValue:inMaxValue];
            
            // value
            if ( (int)inValue != kFBParamMissing ) {
                if ( inValue <= [slider maxValue] ) [slider setDoubleValue:inValue];
            }

            // tick marks
            if ( inTickMarks == kFBParamMissing ) inTickMarks = 0;
            [slider setNumberOfTickMarks:inTickMarks];
            
            // wndTag
            if ( w ) {
                [slider setWndTag:inWndTag];
            }
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:slider];
            } else {
                [contentView addSubview:slider];
            }
        } else {
            CUI_ShowWindowDoesNotExistAlert( inWndTag );
        }
    }
    
    if ( slider ) [slider setHidden:!show];
    
#else
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSSlider *slider = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !slider ) {
            slider = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( slider ) {     // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, slider, [NSSlider class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [slider setEnabled:(BOOL)inEnabled];
            
            // min
            if ( (int)inMinValue != kFBParamMissing ) [slider setMinValue:inMinValue];
            double minValue = [slider minValue];
            
            // max
            if ( (int)inMaxValue != kFBParamMissing ) [slider setMaxValue:inMaxValue];
            double maxValue = [slider maxValue];

            // value
            if ( (int)inValue != kFBParamMissing ) {
                if ( inValue >= minValue && inValue <= maxValue ) [slider setDoubleValue:inValue];
            }
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [slider setFrame:rect];
            
            // tick marks
            if ( inTickMarks != kFBParamMissing ) [slider setNumberOfTickMarks:inTickMarks];
            
        } else {
            // init
            slider = SliderInit( inTag, inRect );
            
            // rect
            if ( NSIsEmptyRect( rect ) ) {
                if ( inTickMarks > 0 ) {
                    rect = NSMakeRect( 18, 17, 24, 96 );
                } else {
                    rect = NSMakeRect( 18, 17, 19, 96 );
                }
                [slider setFrame:rect];
            }
            
            // default autoresizing
            [slider setAutoresizingMask:NSViewMinYMargin];
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [slider setEnabled:(BOOL)inEnabled];
            
            // min
            if ( (int)inMinValue != kFBParamMissing ) [slider setMinValue:inMinValue];
            
            // max
            if ( (int)inMaxValue != kFBParamMissing ) [slider setMaxValue:inMaxValue];
            
            // value
            if ( (int)inValue != kFBParamMissing ) {
                if ( inValue <= [slider maxValue] ) [slider setDoubleValue:inValue];
            }

            // tick marks
            if ( inTickMarks == kFBParamMissing ) inTickMarks = 0;
            [slider setNumberOfTickMarks:inTickMarks];
            
            // wndTag
            [slider setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:slider];
            } else {
                [contentView addSubview:slider];
            }

        }
        
        [slider setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
#endif
}

