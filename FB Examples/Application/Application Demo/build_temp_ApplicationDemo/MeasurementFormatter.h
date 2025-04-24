/*
 MeasurementFormatter.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class MeasurementFormatterClass( void );

// Create
NSMeasurementFormatter *MeasurementFormatterInit( void );
NSMeasurementFormatter *MeasurementFormatterWithUnitOptions( NSMeasurementFormatterUnitOptions options );
NSMeasurementFormatter *MeasurementFormatterWithUnitOptionsAndStyle( NSMeasurementFormatterUnitOptions options, NSFormattingUnitStyle style );

// Format
NSMeasurementFormatterUnitOptions MeasurementFormatterUnitOptions( NSMeasurementFormatter *ref );
void MeasurementFormatterSetUnitOptions( NSMeasurementFormatter *ref, NSMeasurementFormatterUnitOptions options );
NSFormattingUnitStyle MeasurementFormatterUnitStyle( NSMeasurementFormatter *ref );
void MeasurementFormatterSetUnitStyle( NSMeasurementFormatter *ref, NSFormattingUnitStyle style );
CFLocaleRef MeasurementFormatterLocale( NSMeasurementFormatter *ref );
void MeasurementFormatterSetLocale( NSMeasurementFormatter *ref, CFLocaleRef locale );
NSNumberFormatter *MeasurementFormatterNumberFormatter( NSMeasurementFormatter *ref );
void MeasurementFormatterSetNumberFormatter( NSMeasurementFormatter *ref, NSNumberFormatter *numFormatter );

// Convert
CFStringRef MeasurementFormatterStringFromMeasurement( NSMeasurementFormatter *ref, NSMeasurement *measurement );
CFStringRef MeasurementFormatterStringFromUnit( NSMeasurementFormatter *ref, NSUnit *unit );


