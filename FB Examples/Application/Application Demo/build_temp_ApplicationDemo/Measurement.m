/*
 Measurement.m

 Bernie Wylde
 */

#import "Measurement.h"


// Class
Class MeasurementClass( void )
{ return [NSMeasurement class]; }

// Create
NSMeasurement *MeasurementWithDoubleValue( double value, NSUnit *unit )
{
#if __has_feature(objc_arc)
    return [[NSMeasurement alloc] initWithDoubleValue:value unit:unit];
#else
    return [[[NSMeasurement alloc] initWithDoubleValue:value unit:unit] autorelease];
#endif
}

// Unit and value
NSUnit *MeasurementUnit( NSMeasurement *ref )
{ return [ref unit]; }

double MeasurementDoubleValue( NSMeasurement *ref )
{ return [ref doubleValue]; }

// Convert
BOOL MeasurementCanBeConvertedToUnit( NSMeasurement *ref, NSUnit *unit )
{ return [ref canBeConvertedToUnit:unit]; }

NSMeasurement *MeasurementByConvertingToUnit( NSMeasurement *ref, NSUnit *unit )
{ return [ref measurementByConvertingToUnit:unit]; }

// Operating on measurements
NSMeasurement *MeasurementByAddingMeasurement( NSMeasurement *ref1, NSMeasurement *ref2 )
{ return [ref1 measurementByAddingMeasurement:ref2]; }

NSMeasurement *MeasurementBySubtractingMeasurement( NSMeasurement *ref1, NSMeasurement *ref2 )
{ return [ref1 measurementBySubtractingMeasurement:ref2]; }


