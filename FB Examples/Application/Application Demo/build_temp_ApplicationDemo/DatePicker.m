/*
 DatePicker.m

 Bernie Wylde
 */

#import "DatePicker.h"

#pragma mark - subclass
@implementation DatePickerSC
- (void)drawRect:(NSRect)dirtyRect {
    CUI_ViewSubclassDrawRect( self, dirtyRect );
    if ( !DialogEventBool() ) [super drawRect:dirtyRect];
}

- (BOOL)acceptsFirstResponder {
    DialogEventSetBool(YES);
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

// Class
Class DatePickerClass( void )
{ return [NSDatePicker class]; }

NSDatePicker *DatePickerWithTag( NSInteger tag )
{ return (NSDatePicker *)CUI_ValidateViewKindOfClass( tag, [NSDatePicker class] ); }

BOOL DatePickerExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSDatePicker class] ); }


// - configure -
BOOL DatePickerIsBezeled( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return [picker isBezeled];
    return NO;
}

void DatePickerSetBezeled( NSInteger tag, BOOL flag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setBezeled:flag];
}

BOOL DatePickerIsBordered( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return [picker isBordered];
    return NO;
}

void DatePickerSetBordered( NSInteger tag, BOOL flag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setBordered:flag];
}

NSColor *DatePickerBackgroundColor( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return [picker backgroundColor];
    return nil;
}

void DatePickerSetBackgroundColor( NSInteger tag, NSColor *col )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setBackgroundColor:col];
}

BOOL DatePickerDrawsBackground( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return [picker drawsBackground];
    return NO;
}

void DatePickerSetDrawsBackground( NSInteger tag, BOOL flag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setDrawsBackground:flag];
}

NSColor *DatePickerTextColor( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return [picker textColor];
    return nil;
}

void DatePickerSetTextColor( NSInteger tag, NSColor *col )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setTextColor:col];
}

NSDatePickerStyle DatePickerStyle( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return [picker datePickerStyle];
    return 0;
}

void DatePickerSetStyle( NSInteger tag, NSDatePickerStyle style )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setDatePickerStyle:style];
}

// delegate

NSDatePickerElementFlags DatePickerElements( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return [picker datePickerElements];
    return 0;
}

void DatePickerSetElements( NSInteger tag, NSDatePickerElementFlags elements )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setDatePickerElements:elements];
}

// - range and mode -
CFCalendarRef DatePickerCalendar( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return (__bridge CFCalendarRef)[picker calendar];
    return nil;
}

void DatePickerSetCalendar( NSInteger tag, CFCalendarRef cal )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setCalendar:(__bridge NSCalendar *)cal];
}

CFLocaleRef DatePickerLocale( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return (__bridge CFLocaleRef)[picker locale];
    return nil;
}

void DatePickerSetLocale( NSInteger tag, CFLocaleRef locale )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setLocale:(__bridge NSLocale *)locale];
}

NSDatePickerMode DatePickerMode( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return [picker datePickerMode];
    return 0;
}

void DatePickerSetMode( NSInteger tag, NSInteger mode )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setDatePickerMode:mode];
}

CFTimeZoneRef DatePickerTimeZone( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return (__bridge CFTimeZoneRef)[picker timeZone];
    return nil;
}

void DatePickerSetTimeZone( NSInteger tag, CFTimeZoneRef zone )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setTimeZone:(__bridge NSTimeZone *)zone];
}

// - values -
CFDateRef DatePickerDateValue( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return (__bridge CFDateRef)[picker dateValue];
    return NULL;
}

void DatePickerSetDateValue( NSInteger tag, CFDateRef dt )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setDateValue:(__bridge NSDate *)dt];
}

CFTimeInterval DatePickerTimeInterval( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return [picker timeInterval];
    return 0.0;
}

void DatePickerSetTimeInterval( NSInteger tag, CFTimeInterval ti )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setTimeInterval:ti];
}

// - constraining -
CFDateRef DatePickerMinDate( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return (__bridge CFDateRef)[picker minDate];
    return NULL;
}

void DatePickerSetMinDate( NSInteger tag, CFDateRef dt )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setMinDate:(__bridge NSDate *)dt];
}

CFDateRef DatePickerMaxDate( NSInteger tag )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) return (__bridge CFDateRef)[picker maxDate];
    return NULL;
}

void DatePickerSetMaxDate( NSInteger tag, CFDateRef dt )
{
    NSDatePicker *picker = DatePickerWithTag( tag );
    if ( picker ) [picker setMaxDate:(__bridge NSDate *)dt];
}


// Init
NSDatePicker *DatePickerInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    BOOL emptyRect = NSIsEmptyRect( rect );
    if ( emptyRect ) rect = NSMakeRect( 20, 20, 99, 27 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSDatePicker *picker;
#if __has_feature(objc_arc)
    if ( subclass ) {
        picker = [[DatePickerSC alloc] initWithFrame:rect];
    } else {
        picker = [[NSDatePicker alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        picker = [[[DatePickerSC alloc] initWithFrame:rect] autorelease];
    } else {
        picker = [[[NSDatePicker alloc] initWithFrame:rect] autorelease];
    }
#endif
    
    // draws background
    [picker setDrawsBackground:YES];

    // elements
    [picker setDatePickerElements:NSYearMonthDayDatePickerElementFlag];

    // size to fit
    if ( emptyRect ) [picker sizeToFit];

    // tag
    [picker setTag:inTag];
    
    // target/action
    [picker setTarget:CUI_ControlTargetObj()];
    [picker setAction:@selector(controlAction:)];
    
    return picker;
}

// Statement
void CUI_DatePicker( NSInteger inTag, NSInteger inEnabled, CFDateRef inDate, CGRect inRect, NSInteger inStyle, NSInteger inElements, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSDate *date = (__bridge NSDate *)inDate;
    NSRect rect = NSRectFromCGRect( inRect );
    BOOL emptyRect = NSIsEmptyRect( rect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSDatePicker *picker = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !picker ) {
            picker = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( picker ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, picker, [NSDatePicker class] ) ) {
                return;
            }

            // enabled
            if ( inEnabled != kFBParamMissing ) [picker setEnabled:(BOOL)inEnabled];
            
            // date
            if ( date ) [picker setDateValue:date];
            
            // rect
            if ( !emptyRect ) [picker setFrame:rect];
            
            // style
            if ( inStyle != kFBParamMissing ) [picker setDatePickerStyle:inStyle];
            
            // elements
            if ( inElements != kFBParamMissing ) [picker setDatePickerElements:inElements];
            
        } else {            // create
             // init
            picker = DatePickerInit( inTag, inRect );
            
            // default autoresizing
            [picker setAutoresizingMask:NSViewMinYMargin];
             
            // enabled
            if ( inEnabled != kFBParamMissing ) [picker setEnabled:(BOOL)inEnabled];
            
            // date
            if ( date ) [picker setDateValue:date];
            
            // style
            if ( inStyle != kFBParamMissing ) [picker setDatePickerStyle:inStyle];
            
            // elements
            if ( inElements != kFBParamMissing ) [picker setDatePickerElements:inElements];

            // size to fit
            if ( emptyRect ) [picker sizeToFit];
            
            // wndTag
            [picker setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:picker];
            } else {
                [contentView addSubview:picker];
            }

        }
        
        [picker setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

