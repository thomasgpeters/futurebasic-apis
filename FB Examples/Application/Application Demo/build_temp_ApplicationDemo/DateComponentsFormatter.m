/*
 DateComponentsFormatter.m

 Bernie Wylde
 */

#import "DateComponentsFormatter.h"


// Class
Class DateComponentsFormatterClass( void )
{ return [NSDateComponentsFormatter class]; }

// Formatting values
CFStringRef DateComponentsFormatterStringFromDateComponents( NSDateComponentsFormatter *ref, NSDateComponents *dc )
{ return (__bridge CFStringRef)[ref stringFromDateComponents:dc]; }

CFStringRef DateComponentsFormatterStringForObjectValue( NSDateComponentsFormatter *ref, CFTypeRef obj )
{ return (__bridge CFStringRef)[ref stringForObjectValue:(__bridge id)obj]; }

CFStringRef DateComponentsFormatterStringFromDate( NSDateComponentsFormatter *ref, CFDateRef startDate, CFDateRef endDate )
{ return (__bridge CFStringRef)[ref stringFromDate:(__bridge NSDate *)startDate toDate:(__bridge NSDate *)endDate]; }

CFStringRef DateComponentsFormatterStringFromTimeInterval( NSDateComponentsFormatter *ref, CFTimeInterval interval )
{ return (__bridge CFStringRef)[ref stringFromTimeInterval:(NSTimeInterval)interval]; }

CFStringRef DateComponentsFormatterLocalizedStringFromDateComponents( NSDateComponents *dc, NSDateComponentsFormatterUnitsStyle style )
{ return (__bridge CFStringRef)[NSDateComponentsFormatter localizedStringFromDateComponents:dc unitsStyle:style]; }

// Configure formatter options
NSCalendarUnit DateComponentsFormatterAllowedUnits( NSDateComponentsFormatter *ref )
{ return [ref allowedUnits]; }

void DateComponentsFormatterSetAllowedUnits( NSDateComponentsFormatter *ref, NSCalendarUnit units )
{ [ref setAllowedUnits:units]; }

BOOL DateComponentsFormatterAllowsFractionalUnits( NSDateComponentsFormatter *ref )
{ return [ref allowsFractionalUnits]; }

void DateComponentsFormatterSetAllowsFractionalUnits( NSDateComponentsFormatter *ref, BOOL flag )
{ [ref setAllowsFractionalUnits:flag]; }

CFCalendarRef DateComponentsFormatterCalendar( NSDateComponentsFormatter *ref )
{ return (__bridge CFCalendarRef)[ref calendar]; }

void DateComponentsFormatterSetCalendar( NSDateComponentsFormatter *ref, CFCalendarRef cal )
{ [ref setCalendar:(__bridge NSCalendar *)cal]; }

BOOL DateComponentsFormatterCollapsesLargstUnit( NSDateComponentsFormatter *ref )
{ return [ref collapsesLargestUnit]; }

void DateComponentsFormatterSetCollapsesLargstUnit( NSDateComponentsFormatter *ref, BOOL flag )
{ [ref setCollapsesLargestUnit:flag]; }

BOOL DateComponentsFormatterIncludesApproximationPhrase( NSDateComponentsFormatter *ref )
{ return [ref includesApproximationPhrase]; }

void DateComponentsFormatterSetIncludesApproximationPhrase( NSDateComponentsFormatter *ref, BOOL flag )
{ [ref setIncludesApproximationPhrase:flag]; }

BOOL DateComponentsFormatterIncludesTimeRemainingPhrase( NSDateComponentsFormatter *ref )
{ return [ref includesTimeRemainingPhrase]; }

void DateComponentsFormatterSetIncludesTimeRemainingPhrase( NSDateComponentsFormatter *ref, BOOL flag )
{ [ref setIncludesTimeRemainingPhrase:flag]; }

NSInteger DateComponentsFormatterMaximumUnitCount( NSDateComponentsFormatter *ref )
{ return [ref maximumUnitCount]; }

void DateComponentsFormatterSetMaximumUnitCount( NSDateComponentsFormatter *ref, NSInteger count )
{ [ref setMaximumUnitCount:count]; }

NSDateComponentsFormatterUnitsStyle DateComponentsFormatterUnitsStyle( NSDateComponentsFormatter *ref )
{ return [ref unitsStyle]; }

void DateComponentsFormatterSetUnitsStyle( NSDateComponentsFormatter *ref, NSDateComponentsFormatterUnitsStyle style )
{ [ref setUnitsStyle:style]; }

NSDateComponentsFormatterZeroFormattingBehavior DateComponentsFormatterZeroFormattingBehavior( NSDateComponentsFormatter *ref )
{ return [ref zeroFormattingBehavior]; }

void DateComponentsFormatterSetZeroFormattingBehavior( NSDateComponentsFormatter *ref, NSDateComponentsFormatterZeroFormattingBehavior behavior )
{ [ref setZeroFormattingBehavior:behavior]; }

// Instance properties
NSFormattingContext DateComponentsFormatterFormattingContext( NSDateComponentsFormatter *ref )
{ return [ref formattingContext]; }

void DateComponentsFormatterSetFormattingContext( NSDateComponentsFormatter *ref, NSFormattingContext ctx )
{ [ref setFormattingContext:ctx]; }

CFDateRef DateComponentsFormatterReferenceDate( NSDateComponentsFormatter *ref )
{ return (__bridge CFDateRef)[ref referenceDate]; }

void DateComponentsFormatterSetReferenceDate( NSDateComponentsFormatter *ref, CFDateRef dt )
{ [ref setReferenceDate:(__bridge NSDate *)dt]; }

// Instance methods
BOOL DateComponentsFormatterGetObjectValue( NSDateComponentsFormatter *ref, CFTypeRef *obj, CFStringRef string, CFStringRef *errorDescription )
{
    id tempObj = nil;
    NSString *tempErrorDescription = nil;
    BOOL flag = [ref getObjectValue:&tempObj forString:(__bridge NSString *)string errorDescription:&tempErrorDescription];
    if ( obj ) *obj = (__bridge CFTypeRef)tempObj;
    if ( errorDescription ) *errorDescription = (__bridge CFStringRef)tempErrorDescription;
    return flag;
}

