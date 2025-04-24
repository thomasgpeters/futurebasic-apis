/*
 Measurement.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class MeasurementClass( void );

// Create
NSMeasurement *MeasurementWithDoubleValue( double value, NSUnit *unit );

// Unit and value
NSUnit *MeasurementUnit( NSMeasurement *ref );
double MeasurementDoubleValue( NSMeasurement *ref );

// Convert
BOOL MeasurementCanBeConvertedToUnit( NSMeasurement *ref, NSUnit *unit );
NSMeasurement *MeasurementByConvertingToUnit( NSMeasurement *ref, NSUnit *unit );

// Operating on measurements
NSMeasurement *MeasurementByAddingMeasurement( NSMeasurement *ref1, NSMeasurement *ref2 );
NSMeasurement *MeasurementBySubtractingMeasurement( NSMeasurement *ref1, NSMeasurement *ref2 );


