/*
 DateComponentsFormatter.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class DateComponentsFormatterClass( void );

// Formatting values
CFStringRef DateComponentsFormatterStringFromDateComponents( NSDateComponentsFormatter *ref, NSDateComponents *dc );
CFStringRef DateComponentsFormatterStringForObjectValue( NSDateComponentsFormatter *ref, CFTypeRef obj );
CFStringRef DateComponentsFormatterStringFromDate( NSDateComponentsFormatter *ref, CFDateRef startDate, CFDateRef endDate );
CFStringRef DateComponentsFormatterStringFromTimeInterval( NSDateComponentsFormatter *ref, CFTimeInterval interval );
CFStringRef DateComponentsFormatterLocalizedStringFromDateComponents( NSDateComponents *dc, NSDateComponentsFormatterUnitsStyle style );

// Configure formatter options
NSCalendarUnit DateComponentsFormatterAllowedUnits( NSDateComponentsFormatter *ref );
void DateComponentsFormatterSetAllowedUnits( NSDateComponentsFormatter *ref, NSCalendarUnit units );
BOOL DateComponentsFormatterAllowsFractionalUnits( NSDateComponentsFormatter *ref );
void DateComponentsFormatterSetAllowsFractionalUnits( NSDateComponentsFormatter *ref, BOOL flag );
CFCalendarRef DateComponentsFormatterCalendar( NSDateComponentsFormatter *ref );
void DateComponentsFormatterSetCalendar( NSDateComponentsFormatter *ref, CFCalendarRef cal );
BOOL DateComponentsFormatterCollapsesLargstUnit( NSDateComponentsFormatter *ref );
void DateComponentsFormatterSetCollapsesLargstUnit( NSDateComponentsFormatter *ref, BOOL flag );
BOOL DateComponentsFormatterIncludesApproximationPhrase( NSDateComponentsFormatter *ref );
void DateComponentsFormatterSetIncludesApproximationPhrase( NSDateComponentsFormatter *ref, BOOL flag );
BOOL DateComponentsFormatterIncludesTimeRemainingPhrase( NSDateComponentsFormatter *ref );
void DateComponentsFormatterSetIncludesTimeRemainingPhrase( NSDateComponentsFormatter *ref, BOOL flag );
NSInteger DateComponentsFormatterMaximumUnitCount( NSDateComponentsFormatter *ref );
void DateComponentsFormatterSetMaximumUnitCount( NSDateComponentsFormatter *ref, NSInteger count );
NSDateComponentsFormatterUnitsStyle DateComponentsFormatterUnitsStyle( NSDateComponentsFormatter *ref );
void DateComponentsFormatterSetUnitsStyle( NSDateComponentsFormatter *ref, NSDateComponentsFormatterUnitsStyle style );
NSDateComponentsFormatterZeroFormattingBehavior DateComponentsFormatterZeroFormattingBehavior( NSDateComponentsFormatter *ref );
void DateComponentsFormatterSetZeroFormattingBehavior( NSDateComponentsFormatter *ref, NSDateComponentsFormatterZeroFormattingBehavior behavior );

// Instance properties
NSFormattingContext DateComponentsFormatterFormattingContext( NSDateComponentsFormatter *ref );
void DateComponentsFormatterSetFormattingContext( NSDateComponentsFormatter *ref, NSFormattingContext ctx );
CFDateRef DateComponentsFormatterReferenceDate( NSDateComponentsFormatter *ref );
void DateComponentsFormatterSetReferenceDate( NSDateComponentsFormatter *ref, CFDateRef dt );

// Instance methods
BOOL DateComponentsFormatterGetObjectValue( NSDateComponentsFormatter *ref, CFTypeRef *obj, CFStringRef string, CFStringRef *errorDescription );


