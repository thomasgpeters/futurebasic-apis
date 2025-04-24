/*
 LevelIndicator.m

 Bernie Wylde
 */

#import "LevelIndicator.h"

#pragma mark - subclass
@implementation LevelIndicatorSC
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
Class LevelIndicatorClass( void )
{ return [NSLevelIndicator class]; }

NSLevelIndicator *LevelIndicatorWithTag( NSInteger tag )
{ return (NSLevelIndicator *)CUI_ValidateViewKindOfClass( tag, [NSLevelIndicator class] ); }

BOOL LevelIndicatorExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSLevelIndicator class] ); }


// - range -
double LevelIndicatorMinValue( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind minValue];
    return 0.0;
}

void LevelIndicatorSetMinValue( NSInteger tag, double value )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setMinValue:value];
    
}

double LevelIndicatorMaxValue( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind maxValue];
    return 0.0;
}

void LevelIndicatorSetMaxValue( NSInteger tag, double value )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setMaxValue:value];
    
}

double LevelIndicatorWarningValue( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind warningValue];
    return 0.0;
}

void LevelIndicatorSetWarningValue( NSInteger tag, double value )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setWarningValue:value];
    
}

double LevelIndicatorCriticalValue( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind criticalValue];
    return 0.0;
}

void LevelIndicatorSetCriticalValue( NSInteger tag, double value )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setCriticalValue:value];
    
}

// - tick marks and style -
NSTickMarkPosition LevelIndicatorTickMarkPosition( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind tickMarkPosition];
    return 0;
}

void LevelIndicatorSetTickMarkPosition( NSInteger tag, NSTickMarkPosition position )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setTickMarkPosition:position];
}

NSInteger LevelIndicatorNumberOfTickMarks( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind numberOfTickMarks];
    return 0;
}

void LevelIndicatorSetNumberOfTickMarks( NSInteger tag, NSInteger tickMarks )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setNumberOfTickMarks:tickMarks];
}

NSInteger LevelIndicatorNumberOfMajorTickMarks( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind numberOfMajorTickMarks];
    return 0;
}
void LevelIndicatorSetNumberOfMajorTickMarks( NSInteger tag, NSInteger tickMarks )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setNumberOfMajorTickMarks:tickMarks];
}

CGRect LevelIndicatorRectOfTickMarkAtIndex( NSInteger tag, NSInteger index )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return NSRectToCGRect([ind rectOfTickMarkAtIndex:index]);
    return CGRectZero;
}

NSLevelIndicatorStyle LevelIndicatorStyle( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind levelIndicatorStyle];
    return 0;
}

void LevelIndicatorSetStyle( NSInteger tag, NSLevelIndicatorStyle style )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setLevelIndicatorStyle:style];
}


// - instance properties -
BOOL LevelIndicatorIsEditable( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [[ind cell] isEditable];
    return NO;
}

void LevelIndicatorSetEditable( NSInteger tag, BOOL flag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) {
        [[ind cell] setEditable:flag];
        if ( flag ) {
            [ind setTarget:CUI_ControlTargetObj()];
            [ind setAction:@selector(controlAction:)];
        } else {
            [ind setTarget:nil];
            [ind setAction:nil];
        }
    }
}

NSImage *LevelIndicatorImage( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [[ind cell] image];
    return nil;
}

void LevelIndicatorSetImage( NSInteger tag, CFTypeRef inImage )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) {
        NSImage *image = CUI_FixImageValue( inImage );
        [[ind cell] setImage:image];
    }
}

void LevelIndicatorSetImageNamed( NSInteger tag, CFStringRef imageName )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) {
        if ( imageName ) {
            NSImage *image = CUI_ImageResource( (__bridge NSString *)imageName );
            if ( image ) [[ind cell] setImage:image];
        }
    }
}




NSColor *LevelIndicatorCriticalFillColor( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind criticalFillColor];
    return nil;
}

void LevelIndicatorSetCriticalFillColor( NSInteger tag, NSColor *col )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setCriticalFillColor:col];
}

BOOL LevelIndicatorDrawsTieredCapacityLevels( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind drawsTieredCapacityLevels];
    return NO;
}

void LevelIndicatorSetDrawsTieredCapacityLevels( NSInteger tag, BOOL flag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setDrawsTieredCapacityLevels:flag];
}

NSColor *LevelIndicatorFillColor( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind fillColor];
    return nil;
}

void LevelIndicatorSetFillColor( NSInteger tag, NSColor *col )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setFillColor:col];
}

NSLevelIndicatorPlaceholderVisibility LevelIndicatorPlaceholderVisibility( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind placeholderVisibility];
    return 0;
}

void LevelIndicatorSetPlaceholderVisibility( NSInteger tag, NSLevelIndicatorPlaceholderVisibility visibility )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setPlaceholderVisibility:visibility];
}

NSImage *LevelIndicatorRatingImage( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind ratingImage];
    return nil;
}

void LevelIndicatorSetRatingImage( NSInteger tag, CFTypeRef inImage )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) {
        NSImage *image = CUI_FixImageValue( inImage );
        [ind setRatingImage:image];
    }
}

NSImage *LevelIndicatorRatingPlaceholderImage( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind ratingPlaceholderImage];
    return nil;
}

void LevelIndicatorSetRatingPlaceholderImage( NSInteger tag, CFTypeRef inImage )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) {
        NSImage *image = CUI_FixImageValue( inImage );
        [ind setRatingPlaceholderImage:image];
    }
}

void LevelIndicatorSetRatingPlaceholderImageNamed( NSInteger tag, CFStringRef imageName )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) {
        if ( imageName ) {
            NSImage *image = CUI_ImageResource( (__bridge NSString *)imageName );
            if ( image ) [ind setRatingPlaceholderImage:image];
        }
    }
}

NSColor *LevelIndicatorWarningFillColor( NSInteger tag )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) return [ind warningFillColor];
    return nil;
}

void LevelIndicatorSetWarningFillColor( NSInteger tag, NSColor *col )
{
    NSLevelIndicator *ind = LevelIndicatorWithTag( tag );
    if ( ind ) [ind setWarningFillColor:col];
}


// Init
NSLevelIndicator *LevelIndicatorInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) {
        rect = NSMakeRect( 20, 18, 96, 18 );
    }
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSLevelIndicator *ind;
#if __has_feature(objc_arc)
    if ( subclass ) {
        ind = [[LevelIndicatorSC alloc] initWithFrame:rect];
    } else {
        ind = [[NSLevelIndicator alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        ind = [[[LevelIndicatorSC alloc] initWithFrame:rect] autorelease];
    } else {
        ind = [[[NSLevelIndicator alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [ind autorelease];
//#endif
    
    // min
    [ind setMinValue:0.0];

    // max
    [ind setMaxValue:2.0];

    // value
    [ind setDoubleValue:2.0];

    // tag
    [ind setTag:inTag];
    
    return ind;
}


void CUI_LevelIndicator( NSInteger inTag, NSInteger inEnabled, double inValue, CGRect inRect, double inMinValue, double inMaxValue, double inWarningValue, double inCriticalValue, NSInteger inTickMarks, NSInteger inMajorTickMarks, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSLevelIndicator *ind = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !ind ) {
            ind = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( ind ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, ind, [NSLevelIndicator class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [ind setEnabled:(BOOL)inEnabled];
            
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
            
            // warning
            if ( (int)inWarningValue != kFBParamMissing ) [ind setWarningValue:inWarningValue];
            
            // critical
            if ( (int)inCriticalValue != kFBParamMissing ) [ind setCriticalValue:inCriticalValue];
            
            // rect
//            if ( !NSIsEmptyRect( rect ) ) [ind setFrame:rect];
            if ( !NSEqualRects( rect, NSZeroRect ) ) [ind setFrame:rect];

            // tick marks
//            if ( inTickMarks ) {
//                [ind setNumberOfTickMarks:inTickMarks];
//                [ind setNumberOfMajorTickMarks:inMajorTickMarks];
//            }
            
            if ( inTickMarks != kFBParamMissing ) {
                [ind setNumberOfTickMarks:inTickMarks];
                if ( inMajorTickMarks != kFBParamMissing ) {
                    [ind setNumberOfMajorTickMarks:inMajorTickMarks];
                }
            }
            
        } else {
            // tick marks
            if ( inTickMarks == kFBParamMissing ) inTickMarks = 0;
            if ( inTickMarks > 0 ) {
                if ( inMajorTickMarks == kFBParamMissing ) inMajorTickMarks = 0;
            }
            
            // rect
//            if ( NSIsEmptyRect( rect ) ) {
//                if ( inTickMarks ) {
//                    rect = NSMakeRect( 20, 18, 96, 25 );
//                } else {
//                    rect = NSMakeRect( 20, 18, 96, 18 );
//                }
//            }
            
            if ( NSEqualRects( rect, NSZeroRect ) ) {
                if ( inTickMarks != kFBParamMissing ) {
                    rect = NSMakeRect( 20, 18, 96, 25 );
                } else {
                    rect = NSMakeRect( 20, 18, 96, 18 );
                }
            }

            // init
            ind = LevelIndicatorInit( inTag, NSRectToCGRect(rect) );

            // default autoresizing
            [ind setAutoresizingMask:NSViewMinYMargin];
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [ind setEnabled:(BOOL)inEnabled];
            
            // min
            if ( (int)inMinValue != kFBParamMissing ) [ind setMinValue:inMinValue];
            
            // max
            if ( (int)inMaxValue != kFBParamMissing ) [ind setMaxValue:inMaxValue];

            // value
            if ( (int)inValue != kFBParamMissing ) [ind setDoubleValue:inValue];

            // warning
            if ( (int)inWarningValue != kFBParamMissing ) [ind setWarningValue:inWarningValue];
            
            // critical
            if ( (int)inCriticalValue != kFBParamMissing ) [ind setCriticalValue:inCriticalValue];
            
            // tick marks
//            if ( inTickMarks ) {
//                [ind setNumberOfTickMarks:inTickMarks];
//                [ind setNumberOfMajorTickMarks:inMajorTickMarks];
//            }
            
            if ( inTickMarks != kFBParamMissing ) {
                [ind setNumberOfTickMarks:inTickMarks];
                if ( inMajorTickMarks != kFBParamMissing ) {
                    [ind setNumberOfMajorTickMarks:inMajorTickMarks];
                }
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

