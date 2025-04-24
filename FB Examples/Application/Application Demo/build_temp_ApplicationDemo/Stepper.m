/*
 Stepper.m

 Bernie Wylde
 */

#import "Stepper.h"

@implementation StepperObject
@end

@implementation StepperSC
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
Class StepperClass( void )
{ return [NSStepper class]; }

NSStepper *StepperWithTag( NSInteger tag )
{ return (NSStepper *)CUI_ValidateViewKindOfClass( tag, [NSStepper class] ); }

BOOL StepperExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSStepper class] ); }


double StepperMaxValue( NSInteger tag )
{
    NSStepper *stepper = StepperWithTag( tag );
    if ( stepper ) return [stepper maxValue];
    return 0.0;
}

void StepperSetMaxValue( NSInteger tag, double value )
{
    NSStepper *stepper = StepperWithTag( tag );
    if ( stepper ) [stepper setMaxValue:value];
}

double StepperMinValue( NSInteger tag )
{
    NSStepper *stepper = StepperWithTag( tag );
    if ( stepper ) return [stepper minValue];
    return 0.0;
}

void StepperSetMinValue( NSInteger tag, double value )
{
    NSStepper *stepper = StepperWithTag( tag );
    if ( stepper ) [stepper setMinValue:value];
}

double StepperIncrement( NSInteger tag )
{
    NSStepper *stepper = StepperWithTag( tag );
    if ( stepper ) return [stepper increment];
    return 0.0;
}

void StepperSetIncrement( NSInteger tag, double increment )
{
    NSStepper *stepper = StepperWithTag( tag );
    if ( stepper ) [stepper setIncrement:increment];
}

BOOL StepperAutorepeat( NSInteger tag )
{
    NSStepper *stepper = StepperWithTag( tag );
    if ( stepper ) return [stepper autorepeat];
    return NO;
}

void StepperSetAutorepeat( NSInteger tag, BOOL flag )
{
    NSStepper *stepper = StepperWithTag( tag );
    if ( stepper ) [stepper setAutorepeat:flag];
}

BOOL StepperValueWraps( NSInteger tag )
{
    NSStepper *stepper = StepperWithTag( tag );
    if ( stepper ) return [stepper valueWraps];
    return NO;
}

void StepperSetValueWraps( NSInteger tag, BOOL flag )
{
    NSStepper *stepper = StepperWithTag( tag );
    if ( stepper ) [stepper setValueWraps:flag];
}


// Init
NSStepper *StepperInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 17, 18, 19, 27 );
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSStepper *stepper;
    
#if __has_feature(objc_arc)
    if ( subclass ) {
        stepper = [[StepperSC alloc] initWithFrame:rect];
    } else {
        stepper = [[NSStepper alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        stepper = [[[StepperSC alloc] initWithFrame:rect] autorelease];
    } else {
        stepper = [[[NSStepper alloc] initWithFrame:rect] autorelease];
    }
#endif
    
    // tag
    [stepper setTag:inTag];
    
    // min
    [stepper setMinValue:0.0];
    
    // max
    [stepper setMaxValue:100.0];
    
    // value
    [stepper setDoubleValue:0.0];
    
    // value wraps
    [stepper setValueWraps:NO];
    
    // target/action
    [stepper setTarget:CUI_ControlTargetObj()];
    [stepper setAction:@selector(controlAction:)];
    
    return stepper;
}


void CUI_Stepper( NSInteger inTag, NSInteger inEnabled, double inValue, CGRect inRect, double inMinValue, double inMaxValue, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSStepper *stepper = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !stepper ) {
            stepper = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( stepper ) {        // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, stepper, [NSStepper class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [stepper setEnabled:(BOOL)inEnabled];
            
            // min
            if ( (int)inMinValue != kFBParamMissing ) [stepper setMinValue:inMinValue];
            double minValue = [stepper minValue];
            
            // max
            if ( (int)inMaxValue != kFBParamMissing ) [stepper setMaxValue:inMaxValue];
            double maxValue = [stepper maxValue];

            // value
            if ( (int)inValue != kFBParamMissing ) {
                if ( inValue >= minValue && inValue <= maxValue ) [stepper setDoubleValue:inValue];
            }
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [stepper setFrame:rect];
            
        } else {
            // init
            stepper = StepperInit( inTag, inRect );
            
            // default autoresizing
            [stepper setAutoresizingMask:NSViewMinYMargin];
                        
            // enabled
            if ( inEnabled != kFBParamMissing ) [stepper setEnabled:(BOOL)inEnabled];
            
            // min
            if ( (int)inMinValue != kFBParamMissing ) {
                [stepper setMinValue:inMinValue];
            }
            
            // max
            if ( (int)inMaxValue != kFBParamMissing ) {
                [stepper setMaxValue:inMaxValue];
            }
            
            // value
            if ( (int)inValue != kFBParamMissing ) {
                if ( inValue <= [stepper maxValue] ) {
                    [stepper setDoubleValue:inValue];
                }
            }
            
            // wndTag
            [stepper setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:stepper];
            } else {
                [contentView addSubview:stepper];
            }

        }
        
        [stepper setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

