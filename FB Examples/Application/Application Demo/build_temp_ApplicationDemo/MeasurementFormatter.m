/*
 MeasurementFormatter.m

 Bernie Wylde
 */

#import "MeasurementFormatter.h"


// Class
Class MeasurementFormatterClass( void )
{ return [NSMeasurementFormatter class]; }

// Create
NSMeasurementFormatter *MeasurementFormatterInit( void )
{
#if __has_feature(objc_arc)
    return [[NSMeasurementFormatter alloc] init];
#else
    return [[[NSMeasurementFormatter alloc] init] autorelease];
#endif
}

NSMeasurementFormatter *MeasurementFormatterWithUnitOptions( NSMeasurementFormatterUnitOptions options )
{
#if __has_feature(objc_arc)
    NSMeasurementFormatter *formatter = [[NSMeasurementFormatter alloc] init];
#else
    NSMeasurementFormatter *formatter = [[[NSMeasurementFormatter alloc] init] autorelease];
#endif
    [formatter setUnitOptions:options];
    return formatter;
}

NSMeasurementFormatter *MeasurementFormatterWithUnitOptionsAndStyle( NSMeasurementFormatterUnitOptions options, NSFormattingUnitStyle style )
{
#if __has_feature(objc_arc)
    NSMeasurementFormatter *formatter = [[NSMeasurementFormatter alloc] init];
#else
    NSMeasurementFormatter *formatter = [[[NSMeasurementFormatter alloc] init] autorelease];
#endif
    [formatter setUnitOptions:options];
    [formatter setUnitStyle:style];
    return formatter;
}

// Format
NSMeasurementFormatterUnitOptions MeasurementFormatterUnitOptions( NSMeasurementFormatter *ref )
{ return [ref unitOptions]; }

void MeasurementFormatterSetUnitOptions( NSMeasurementFormatter *ref, NSMeasurementFormatterUnitOptions options )
{ [ref setUnitOptions:options]; }

NSFormattingUnitStyle MeasurementFormatterUnitStyle( NSMeasurementFormatter *ref )
{ return [ref unitStyle]; }

void MeasurementFormatterSetUnitStyle( NSMeasurementFormatter *ref, NSFormattingUnitStyle style )
{ [ref setUnitStyle:style]; }

CFLocaleRef MeasurementFormatterLocale( NSMeasurementFormatter *ref )
{ return (__bridge CFLocaleRef)[ref locale]; }

void MeasurementFormatterSetLocale( NSMeasurementFormatter *ref, CFLocaleRef locale )
{ [ref setLocale:(__bridge NSLocale *)locale]; }

NSNumberFormatter *MeasurementFormatterNumberFormatter( NSMeasurementFormatter *ref )
{ return [ref numberFormatter]; }

void MeasurementFormatterSetNumberFormatter( NSMeasurementFormatter *ref, NSNumberFormatter *numFormatter )
{ [ref setNumberFormatter:numFormatter]; }

// Convert
CFStringRef MeasurementFormatterStringFromMeasurement( NSMeasurementFormatter *ref, NSMeasurement *measurement )
{ return (__bridge CFStringRef)[ref stringFromMeasurement:measurement]; }

CFStringRef MeasurementFormatterStringFromUnit( NSMeasurementFormatter *ref, NSUnit *unit )
{ return (__bridge CFStringRef)[ref stringFromUnit:unit]; }


