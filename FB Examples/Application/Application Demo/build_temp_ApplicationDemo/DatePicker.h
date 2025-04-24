/*
 DatePicker.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "DialogEvent.h"
//#import "View.h"
//#import "Window.h"

@interface CUI_DatePickerTarget : NSObject
@end

#pragma mark - subclass
@interface DatePickerSC : NSDatePicker
@end

// Class
Class DatePickerClass( void );

NSDatePicker *DatePickerWithTag( NSInteger tag );
BOOL DatePickerExists( NSInteger tag );

// - configure -
BOOL DatePickerIsBezeled( NSInteger tag );
void DatePickerSetBezeled( NSInteger tag, BOOL flag );
BOOL DatePickerIsBordered( NSInteger tag );
void DatePickerSetBordered( NSInteger tag, BOOL flag );
NSColor *DatePickerBackgroundColor( NSInteger tag );
void DatePickerSetBackgroundColor( NSInteger tag, NSColor *col );
BOOL DatePickerDrawsBackground( NSInteger tag );
void DatePickerSetDrawsBackground( NSInteger tag, BOOL flag );
NSColor *DatePickerTextColor( NSInteger tag );
void DatePickerSetTextColor( NSInteger tag, NSColor *col );
NSDatePickerStyle DatePickerStyle( NSInteger tag );
void DatePickerSetStyle( NSInteger tag, NSDatePickerStyle style );
// delegate
NSDatePickerElementFlags DatePickerElements( NSInteger tag );
void DatePickerSetElements( NSInteger tag, NSDatePickerElementFlags elements );

// - range and mode -
CFCalendarRef DatePickerCalendar( NSInteger tag );
void DatePickerSetCalendar( NSInteger tag, CFCalendarRef cal );
CFLocaleRef DatePickerLocale( NSInteger tag );
void DatePickerSetLocale( NSInteger tag, CFLocaleRef locale );
NSDatePickerMode DatePickerMode( NSInteger tag );
void DatePickerSetMode( NSInteger tag, NSInteger mode );
CFTimeZoneRef DatePickerTimeZone( NSInteger tag );
void DatePickerSetTimeZone( NSInteger tag, CFTimeZoneRef zone );

// - values -
CFDateRef DatePickerDateValue( NSInteger tag );
void DatePickerSetDateValue( NSInteger tag, CFDateRef dt );
CFTimeInterval DatePickerTimeInterval( NSInteger tag );
void DatePickerSetTimeInterval( NSInteger tag, CFTimeInterval ti );

// - constraining -
CFDateRef DatePickerMinDate( NSInteger tag );
void DatePickerSetMinDate( NSInteger tag, CFDateRef dt );
CFDateRef DatePickerMaxDate( NSInteger tag );
void DatePickerSetMaxDate( NSInteger tag, CFDateRef dt );

// Init
NSDatePicker *DatePickerInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_DatePicker( NSInteger inTag, NSInteger inEnabled, CFDateRef inDate, CGRect inRect, NSInteger inStyle, NSInteger inElements, NSInteger inWndTag );

