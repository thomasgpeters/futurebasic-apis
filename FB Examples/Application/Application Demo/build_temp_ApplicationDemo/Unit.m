/*
 Unit.m

 Bernie Wylde
 */

#import "Unit.h"



#pragma mark - Unit
// Class
Class UnitClass( void )
{ return [NSUnit class]; }

// Create
NSUnit *UnitWithSymbol( CFStringRef symbol )
{
    NSUnit *unit = [[NSUnit alloc] initWithSymbol:(__bridge NSString *)symbol];
#if !__has_feature(objc_arc)
    [unit autorelease];
#endif
    return unit;
}

// Properties
CFStringRef UnitSymbol( NSUnit *ref )
{ return (__bridge CFStringRef)[ref symbol]; }


#pragma mark - UnitConverter
// Class
Class UnitConverterClass( void )
{ return [NSUnitConverter class]; }

// Convert between units
double UnitConverterBaseUnitValueFromValue( NSUnitConverter *ref, double value )
{ return [ref baseUnitValueFromValue:value]; }

double UnitConverterValueFromBaseUnitValue( NSUnitConverter *ref, double value )
{ return [ref valueFromBaseUnitValue:value]; }



#pragma mark - UnitConverterLinear
// Class
Class UnitConverterLinearClass( void )
{ return [NSUnitConverterLinear class]; }

// Create
NSUnitConverterLinear *UnitConverterLinearWithCoefficient( double coefficient )
{
    NSUnitConverterLinear *unit = [[NSUnitConverterLinear alloc] initWithCoefficient:coefficient];
#if !__has_feature(objc_arc)
    [unit autorelease];
#endif
    return unit;
}

NSUnitConverterLinear *UnitConverterLinearWithCoefficientAndConstant( double coefficient, double constant )
{
    NSUnitConverterLinear *unit = [[NSUnitConverterLinear alloc] initWithCoefficient:coefficient constant:constant];
#if !__has_feature(objc_arc)
    [unit autorelease];
#endif
    return unit;
}

// Linear parmaeters
double UnitConverterLinearCoefficient( NSUnitConverterLinear *ref )
{ return [ref coefficient]; }

double UnitConverterLinearConstant( NSUnitConverterLinear *ref )
{ return [ref constant]; }


#pragma mark - Dimension
// Class
Class DimensionClass( void )
{ return [NSDimension class]; }

// Create
NSDimension *DimensionWithSymbol( CFStringRef symbol, NSUnitConverter *converter )
{
    NSDimension *dim = [[NSDimension alloc] initWithSymbol:(__bridge NSString *)symbol converter:converter];
#if !__has_feature(objc_arc)
    [dim autorelease];
#endif
    return dim;
}

// Unit converter
NSUnitConverter *DimensionConverter( NSDimension *ref )
{ return [ref converter]; }

// Base unit
NSUnit *DimensionBaseUnit( void )
{ return [NSDimension baseUnit]; }



#pragma mark - UnitAcceleration
// Class
Class UnitAccelerationClass( void )
{ return [NSUnitAcceleration class]; }

// Base unit
NSUnitAcceleration *UnitAccelerationBaseUnit( void )
{ return [NSUnitAcceleration baseUnit]; }

// Predefined units
NSUnitAcceleration *UnitAccelerationMetersPerSecondSquared( void )
{ return [NSUnitAcceleration metersPerSecondSquared]; }

NSUnitAcceleration *UnitAccelerationGravity( void )
{ return [NSUnitAcceleration gravity]; }



#pragma mark - UnitAngle
// Class
Class UnitAngleClass( void )
{ return [NSUnitAngle class]; }

// Base unit
NSUnitAngle *UnitAngleBaseUnit( void )
{ return [NSUnitAngle baseUnit]; }

// Predefined units
NSUnitAngle *UnitAngleDegrees( void )
{ return [NSUnitAngle degrees]; }

NSUnitAngle *UnitAngleArcMinutes( void )
{ return [NSUnitAngle arcMinutes]; }

NSUnitAngle *UnitAngleArcSeconds( void )
{ return [NSUnitAngle arcSeconds]; }

NSUnitAngle *UnitAngleRadians( void )
{ return [NSUnitAngle radians]; }

NSUnitAngle *UnitAngleGradians( void )
{ return [NSUnitAngle gradians]; }

NSUnitAngle *UnitAngleRevolutions( void )
{ return [NSUnitAngle revolutions]; }



#pragma mark - UnitArea
// Class
Class UnitAreaClass( void )
{ return [NSUnitArea class]; }

// Base unit
NSUnitArea *UnitAreaBaseUnit( void )
{ return [NSUnitArea baseUnit]; }

// Predefined units
NSUnitArea *UnitAreaSquareMegameters( void )
{ return [NSUnitArea squareMegameters]; }

NSUnitArea *UnitAreaSquareKilometers( void )
{ return [NSUnitArea squareKilometers]; }

NSUnitArea *UnitAreaSquareMeters( void )
{ return [NSUnitArea squareMeters]; }

NSUnitArea *UnitAreaSquareCentimeters( void )
{ return [NSUnitArea squareCentimeters]; }

NSUnitArea *UnitAreaSquareMillimeters( void )
{ return [NSUnitArea squareMillimeters]; }

NSUnitArea *UnitAreaSquareMicrometers( void )
{ return [NSUnitArea squareMicrometers]; }

NSUnitArea *UnitAreaSquareNanometers( void )
{ return [NSUnitArea squareNanometers]; }

NSUnitArea *UnitAreaSquareInches( void )
{ return [NSUnitArea squareInches]; }

NSUnitArea *UnitAreaSquareFeet( void )
{ return [NSUnitArea squareFeet]; }

NSUnitArea *UnitAreaSquareYards( void )
{ return [NSUnitArea squareYards]; }

NSUnitArea *UnitAreaSquareMiles( void )
{ return [NSUnitArea squareMiles]; }

NSUnitArea *UnitAreaAcres( void )
{ return [NSUnitArea acres]; }

NSUnitArea *UnitAreaAres( void )
{ return [NSUnitArea ares]; }

NSUnitArea *UnitAreaHectares( void )
{ return [NSUnitArea hectares]; }



#pragma mark - UnitConcentrationMass
// Class
Class UnitConcentrationMassClass( void )
{ return [NSUnitConcentrationMass class]; }

// Base unit
NSUnitConcentrationMass *UnitConcentrationMassBaseUnit( void )
{ return [NSUnitConcentrationMass baseUnit]; }

// Predefined units
NSUnitConcentrationMass *UnitConcentrationMassGramsPerLiter( void )
{ return [NSUnitConcentrationMass gramsPerLiter]; }

NSUnitConcentrationMass *UnitConcentrationMassMilligramsPerDeciliter( void )
{ return [NSUnitConcentrationMass milligramsPerDeciliter]; }

NSUnitConcentrationMass *UnitConcentrationMassMillimolesPerLiterWithGramsPerMole( double gramsPerMole )
{ return [NSUnitConcentrationMass millimolesPerLiterWithGramsPerMole:gramsPerMole]; }



#pragma mark - UnitDispersion
// Class
Class UnitDispersionClass( void )
{ return [NSUnitDispersion class]; }

// Base unit
NSUnitDispersion *UnitDispersionBaseUnit( void )
{ return [NSUnitDispersion baseUnit]; }

// Predefined units
NSUnitDispersion *UnitDispersionPartsPerMillion( void )
{ return [NSUnitDispersion partsPerMillion]; }



#pragma mark - UnitDuration
// Class
Class UnitDurationClass( void )
{ return [NSUnitDuration class]; }

// Base unit
NSUnitDuration *UnitDurationBaseUnit( void )
{ return [NSUnitDuration baseUnit]; }

// Predefined units
NSUnitDuration *UnitDurationSeconds( void )
{ return [NSUnitDuration seconds]; }

NSUnitDuration *UnitDurationMinutes( void )
{ return [NSUnitDuration minutes]; }

NSUnitDuration *UnitDurationHours( void )
{ return [NSUnitDuration hours]; }

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
NSUnitDuration *UnitDurationMicroseconds( void )
{ return [NSUnitDuration microseconds]; }

NSUnitDuration *UnitDurationMilliseconds( void )
{ return [NSUnitDuration milliseconds]; }

NSUnitDuration *UnitDurationNanoseconds( void )
{ return [NSUnitDuration nanoseconds]; }

NSUnitDuration *UnitDurationPicoseconds( void )
{ return [NSUnitDuration picoseconds]; }
#endif// 101500


#pragma mark - UnitElectricCharge
// Class
Class UnitElectricChargeClass( void )
{ return [NSUnitElectricCharge class]; }

// Base unit
NSUnitElectricCharge *UnitElectricChargeBaseUnit( void )
{ return [NSUnitElectricCharge baseUnit]; }

// Predefined units
NSUnitElectricCharge *UnitElectricChargeCoulombs( void )
{ return [NSUnitElectricCharge coulombs]; }

NSUnitElectricCharge *UnitElectricChargeMegaampereHours( void )
{ return [NSUnitElectricCharge megaampereHours]; }

NSUnitElectricCharge *UnitElectricChargeKiloampereHours( void )
{ return [NSUnitElectricCharge kiloampereHours]; }

NSUnitElectricCharge *UnitElectricChargeAmpereHours( void )
{ return [NSUnitElectricCharge ampereHours]; }

NSUnitElectricCharge *UnitElectricChargeMilliampereHours( void )
{ return [NSUnitElectricCharge milliampereHours]; }

NSUnitElectricCharge *UnitElectricChargeMicroampereHours( void )
{ return [NSUnitElectricCharge microampereHours]; }



#pragma mark - UnitElectricCurrent
// Class
Class UnitElectricCurrentClass( void )
{ return [NSUnitElectricCurrent class]; }

// Base unit
NSUnitElectricCurrent *UnitElectricCurrentBaseUnit( void )
{ return [NSUnitElectricCurrent baseUnit]; }

// Predefined units
NSUnitElectricCurrent *UnitElectricCurrentMegaamperes( void )
{ return [NSUnitElectricCurrent megaamperes]; }

NSUnitElectricCurrent *UnitElectricCurrentKiloamperes( void )
{ return [NSUnitElectricCurrent kiloamperes]; }

NSUnitElectricCurrent *UnitElectricCurrentAmperes( void )
{ return [NSUnitElectricCurrent amperes]; }

NSUnitElectricCurrent *UnitElectricCurrentMilliamperes( void )
{ return [NSUnitElectricCurrent milliamperes]; }

NSUnitElectricCurrent *UnitElectricCurrentMicroamperes( void )
{ return [NSUnitElectricCurrent microamperes]; }



#pragma mark - UnitElectriPotentialDifference
// Class
Class UnitElectricPotentialDifferenceClass( void )
{ return [NSUnitElectricPotentialDifference class]; }

// Base unit
NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceBaseUnit( void )
{ return [NSUnitElectricPotentialDifference baseUnit]; }

// Predefined units
NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceMegavolts( void )
{ return [NSUnitElectricPotentialDifference megavolts]; }

NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceKilovolts( void )
{ return [NSUnitElectricPotentialDifference kilovolts]; }

NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceVolts( void )
{ return [NSUnitElectricPotentialDifference volts]; }

NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceMillivolts( void )
{ return [NSUnitElectricPotentialDifference millivolts]; }

NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceMicrovolts( void )
{ return [NSUnitElectricPotentialDifference microvolts]; }



#pragma mark - UnitElectricResistance
// Class
Class UnitElectricResistanceClass( void )
{ return [NSUnitElectricResistance class]; }

// Base unit
NSUnitElectricResistance *UnitElectricResistanceBaseUnit( void )
{ return [NSUnitElectricResistance baseUnit]; }

// Predefined units
NSUnitElectricResistance *UnitElectricResistanceMegaohms( void )
{ return [NSUnitElectricResistance megaohms]; }

NSUnitElectricResistance *UnitElectricResistanceKiloohms( void )
{ return [NSUnitElectricResistance kiloohms]; }

NSUnitElectricResistance *UnitElectricResistanceOhms( void )
{ return [NSUnitElectricResistance ohms]; }

NSUnitElectricResistance *UnitElectricResistanceMilliohms( void )
{ return [NSUnitElectricResistance milliohms]; }

NSUnitElectricResistance *UnitElectricResistanceMicroohms( void )
{ return [NSUnitElectricResistance microohms]; }



#pragma mark - UnitEnergy
// Class
Class UnitEnergyClass( void )
{ return [NSUnitEnergy class]; }

// Base unit
NSUnitEnergy *UnitEnergyBaseUnit( void )
{ return [NSUnitEnergy baseUnit]; }

// Predefined units
NSUnitEnergy *UnitEnergyKilojoules( void )
{ return [NSUnitEnergy kilojoules]; }

NSUnitEnergy *UnitEnergyJoules( void )
{ return [NSUnitEnergy joules]; }

NSUnitEnergy *UnitEnergyKilocalories( void )
{ return [NSUnitEnergy kilocalories]; }

NSUnitEnergy *UnitEnergyCalories( void )
{ return [NSUnitEnergy calories]; }

NSUnitEnergy *UnitEnergyKilowattHours( void )
{ return [NSUnitEnergy kilowattHours]; }



#pragma mark - UnitFrequency
// Class
Class UnitFrequencyClass( void )
{ return [NSUnitFrequency class]; }

// Base unit
NSUnitFrequency *UnitFrequencyBaseUnit( void )
{ return [NSUnitFrequency baseUnit]; }

// Predefined units
NSUnitFrequency *UnitFrequencyTerahertz( void )
{ return [NSUnitFrequency terahertz]; }

NSUnitFrequency *UnitFrequencyGigahertz( void )
{ return [NSUnitFrequency gigahertz]; }

NSUnitFrequency *UnitFrequencyMegahertz( void )
{ return [NSUnitFrequency megahertz]; }

NSUnitFrequency *UnitFrequencyKilohertz( void )
{ return [NSUnitFrequency kilohertz]; }

NSUnitFrequency *UnitFrequencyHertz( void )
{ return [NSUnitFrequency hertz]; }

NSUnitFrequency *UnitFrequencyMillihertz( void )
{ return [NSUnitFrequency millihertz]; }

NSUnitFrequency *UnitFrequencyMicrohertz( void )
{ return [NSUnitFrequency microhertz]; }

NSUnitFrequency *UnitFrequencyNanohertz( void )
{ return [NSUnitFrequency nanohertz]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
NSUnitFrequency *UnitFrequencyFramesPerSecond( void )
{ return [NSUnitFrequency framesPerSecond]; }
#endif// 101500


#pragma mark - UnitFuelEfficiency
// Class
Class UnitFuelEfficiencyClass( void )
{ return [NSUnitFuelEfficiency class]; }

// Base unit
NSUnitFuelEfficiency *UnitFuelEfficiencyBaseUnit( void )
{ return [NSUnitFuelEfficiency baseUnit]; }

// Predefined units
NSUnitFuelEfficiency *UnitFuelEfficiencyMilesPerImperialGallon( void )
{ return [NSUnitFuelEfficiency milesPerImperialGallon]; }

NSUnitFuelEfficiency *UnitFuelEfficiencyLitersPer100Kilometers( void )
{ return [NSUnitFuelEfficiency litersPer100Kilometers]; }

NSUnitFuelEfficiency *UnitFuelEfficiencyMilesPerGallon( void )
{ return [NSUnitFuelEfficiency milesPerGallon]; }


#pragma mark - UnitInformationStorage
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500

// Class
Class UnitInformationStorageClass( void )
{ return [NSUnitInformationStorage class]; }

// Base unit
NSUnitInformationStorage *UnitInformationStorageBaseUnit( void )
{ return [NSUnitInformationStorage baseUnit]; }

// Predefined units
NSUnitInformationStorage *UnitInformationStorageBits( void )
{ return [NSUnitInformationStorage bits]; }

NSUnitInformationStorage *UnitInformationStorageBytes( void )
{  return [NSUnitInformationStorage bytes]; }

NSUnitInformationStorage *UnitInformationStorageExabits( void )
{ return [NSUnitInformationStorage exabits]; }

NSUnitInformationStorage *UnitInformationStorageExabytes( void )
{ return [NSUnitInformationStorage exabytes]; }

NSUnitInformationStorage *UnitInformationStorageExbibits( void )
{ return [NSUnitInformationStorage exbibits]; }

NSUnitInformationStorage *UnitInformationStorageExbibytes( void )
{ return [NSUnitInformationStorage exbibytes]; }

NSUnitInformationStorage *UnitInformationStorageGibibits( void )
{ return [NSUnitInformationStorage gibibits]; }

NSUnitInformationStorage *UnitInformationStorageGibibytes( void )
{ return [NSUnitInformationStorage gibibytes]; }

NSUnitInformationStorage *UnitInformationStorageGigabits( void )
{ return [NSUnitInformationStorage gigabits]; }

NSUnitInformationStorage *UnitInformationStorageGigabytes( void )
{ return [NSUnitInformationStorage gigabytes]; }

NSUnitInformationStorage *UnitInformationStorageKibibits( void )
{ return [NSUnitInformationStorage kibibits]; }

NSUnitInformationStorage *UnitInformationStorageKibibytes( void )
{ return [NSUnitInformationStorage kibibytes]; }

NSUnitInformationStorage *UnitInformationStorageKilobits( void )
{ return [NSUnitInformationStorage kilobits]; }

NSUnitInformationStorage *UnitInformationStorageKilobytes( void )
{ return [NSUnitInformationStorage kilobytes]; }

NSUnitInformationStorage *UnitInformationStorageMebibits( void )
{ return [NSUnitInformationStorage mebibits]; }

NSUnitInformationStorage *UnitInformationStorageMebibytes( void )
{ return [NSUnitInformationStorage mebibytes]; }

NSUnitInformationStorage *UnitInformationStorageMegabits( void )
{ return [NSUnitInformationStorage megabits]; }

NSUnitInformationStorage *UnitInformationStorageMegabytes( void )
{ return [NSUnitInformationStorage megabytes]; }

NSUnitInformationStorage *UnitInformationStorageNibbles( void )
{ return [NSUnitInformationStorage nibbles]; }

NSUnitInformationStorage *UnitInformationStoragePebibits( void )
{ return [NSUnitInformationStorage pebibits]; }

NSUnitInformationStorage *UnitInformationStoragePebibytes( void )
{ return [NSUnitInformationStorage pebibytes]; }

NSUnitInformationStorage *UnitInformationStoragePetabits( void )
{ return [NSUnitInformationStorage petabits]; }

NSUnitInformationStorage *UnitInformationStoragePetabytes( void )
{ return [NSUnitInformationStorage petabytes]; }

NSUnitInformationStorage *UnitInformationStorageTebibits( void )
{ return [NSUnitInformationStorage tebibits]; }

NSUnitInformationStorage *UnitInformationStorageTebibytes( void )
{ return [NSUnitInformationStorage tebibytes]; }

NSUnitInformationStorage *UnitInformationStorageTerabits( void )
{ return [NSUnitInformationStorage terabits]; }

NSUnitInformationStorage *UnitInformationStorageTerabytes( void )
{ return [NSUnitInformationStorage terabytes]; }

NSUnitInformationStorage *UnitInformationStorageYobibits( void )
{ return [NSUnitInformationStorage yobibits]; }

NSUnitInformationStorage *UnitInformationStorageYobibytes( void )
{ return [NSUnitInformationStorage yobibytes]; }

NSUnitInformationStorage *UnitInformationStorageYottabits( void )
{ return [NSUnitInformationStorage yottabits]; }

NSUnitInformationStorage *UnitInformationStorageYottabytes( void )
{ return [NSUnitInformationStorage yottabytes]; }

NSUnitInformationStorage *UnitInformationStorageZebibits( void )
{ return [NSUnitInformationStorage zebibits]; }

NSUnitInformationStorage *UnitInformationStorageZebibytes( void )
{ return [NSUnitInformationStorage zebibytes]; }

NSUnitInformationStorage *UnitInformationStorageZettabits( void )
{ return [NSUnitInformationStorage zettabits]; }

NSUnitInformationStorage *UnitInformationStorageZettabytes( void )
{ return [NSUnitInformationStorage zettabytes]; }
#endif// 101500


#pragma mark - UnitLength
// Class
Class UnitLengthClass( void )
{ return [NSUnitLength class]; }

// Base unit
NSUnitLength *UnitLengthBaseUnit( void )
{ return [NSUnitLength baseUnit]; }

// Predefined units
NSUnitLength *UnitLengthMegameters( void )
{ return [NSUnitLength megameters]; }

NSUnitLength *UnitLengthKilometers( void )
{ return [NSUnitLength kilometers]; }

NSUnitLength *UnitLengthHectometers( void )
{ return [NSUnitLength hectometers]; }

NSUnitLength *UnitLengthDecameters( void )
{ return [NSUnitLength decameters]; }

NSUnitLength *UnitLengthMeters( void )
{ return [NSUnitLength meters]; }

NSUnitLength *UnitLengthDecimeters( void )
{ return [NSUnitLength decimeters]; }

NSUnitLength *UnitLengthCentimeters( void )
{ return [NSUnitLength centimeters]; }

NSUnitLength *UnitLengthMillimeters( void )
{ return [NSUnitLength millimeters]; }

NSUnitLength *UnitLengthMicrometers( void )
{ return [NSUnitLength micrometers]; }

NSUnitLength *UnitLengthNanometers( void )
{ return [NSUnitLength nanometers]; }

NSUnitLength *UnitLengthPicometers( void )
{ return [NSUnitLength picometers]; }

NSUnitLength *UnitLengthInches( void )
{ return [NSUnitLength inches]; }

NSUnitLength *UnitLengthFeet( void )
{ return [NSUnitLength feet]; }

NSUnitLength *UnitLengthYards( void )
{ return [NSUnitLength yards]; }

NSUnitLength *UnitLengthMiles( void )
{ return [NSUnitLength miles]; }

NSUnitLength *UnitLengthScandinavianMiles( void )
{ return [NSUnitLength scandinavianMiles]; }

NSUnitLength *UnitLengthLightyears( void )
{ return [NSUnitLength lightyears]; }

NSUnitLength *UnitLengthNauticalMiles( void )
{ return [NSUnitLength nauticalMiles]; }

NSUnitLength *UnitLengthFathoms( void )
{ return [NSUnitLength fathoms]; }

NSUnitLength *UnitLengthFurlongs( void )
{ return [NSUnitLength furlongs]; }

NSUnitLength *UnitLengthAstronomicalUnits( void )
{ return [NSUnitLength astronomicalUnits]; }

NSUnitLength *UnitLengthParsecs( void )
{ return [NSUnitLength parsecs]; }



#pragma mark - UnitIlluminance
// Class
Class UnitIlluminanceClass( void )
{ return [NSUnitIlluminance class]; }

// Base unit
NSUnitIlluminance *UnitIlluminanceBaseUnit( void )
{ return [NSUnitIlluminance baseUnit]; }

// Predefined units
NSUnitIlluminance *UnitIlluminanceLux( void )
{ return [NSUnitIlluminance lux]; }



#pragma mark - UnitMass
// Class
Class UnitMassClass( void )
{ return [NSUnitMass class]; }

// Base unit
NSUnitMass *UnitMassBaseUnit( void )
{ return [NSUnitMass baseUnit]; }

// Predefined units
NSUnitMass *UnitMassKilograms( void )
{ return [NSUnitMass kilograms]; }

NSUnitMass *UnitMassGrams( void )
{ return [NSUnitMass grams]; }

NSUnitMass *UnitMassDecigrams( void )
{ return [NSUnitMass decigrams]; }

NSUnitMass *UnitMassCentigrams( void )
{ return [NSUnitMass centigrams]; }

NSUnitMass *UnitMassMilligrams( void )
{ return [NSUnitMass milligrams]; }

NSUnitMass *UnitMassMicrograms( void )
{ return [NSUnitMass micrograms]; }

NSUnitMass *UnitMassNanograms( void )
{ return [NSUnitMass nanograms]; }

NSUnitMass *UnitMassPicograms( void )
{ return [NSUnitMass picograms]; }

NSUnitMass *UnitMassOunces( void )
{ return [NSUnitMass ounces]; }

NSUnitMass *UnitMassPounds( void )
{ return [NSUnitMass poundsMass]; }

NSUnitMass *UnitMassStones( void )
{ return [NSUnitMass stones]; }

NSUnitMass *UnitMassMetricTons( void )
{ return [NSUnitMass metricTons]; }

NSUnitMass *UnitMassShortTons( void )
{ return [NSUnitMass shortTons]; }

NSUnitMass *UnitMassCarats( void )
{ return [NSUnitMass carats]; }

NSUnitMass *UnitMassOuncesTroy( void )
{ return [NSUnitMass ouncesTroy]; }

NSUnitMass *UnitMassSlugs( void )
{ return [NSUnitMass slugs]; }

// Type properties
NSUnitMass *UnitMassPoundsMass( void )
{ return [NSUnitMass poundsMass]; }



#pragma mark - UnitPower
// Class
Class UnitPowerClass( void )
{ return [NSUnitPower class]; }

// Base unit
NSUnitPower *UnitPowerBaseUnit( void )
{ return [NSUnitPower baseUnit]; }

// Predefined units
NSUnitPower *UnitPowerTerawatts( void )
{ return [NSUnitPower terawatts]; }

NSUnitPower *UnitPowerGigawatts( void )
{ return [NSUnitPower gigawatts]; }

NSUnitPower *UnitPowerMegawatts( void )
{ return [NSUnitPower megawatts]; }

NSUnitPower *UnitPowerKilowatts( void )
{ return [NSUnitPower kilowatts]; }

NSUnitPower *UnitPowerWatts( void )
{ return [NSUnitPower watts]; }

NSUnitPower *UnitPowerMilliwatts( void )
{ return [NSUnitPower milliwatts]; }

NSUnitPower *UnitPowerMicrowatts( void )
{ return [NSUnitPower microwatts]; }

NSUnitPower *UnitPowerNanowatts( void )
{ return [NSUnitPower nanowatts]; }

NSUnitPower *UnitPowerPicowatts( void )
{ return [NSUnitPower picowatts]; }

NSUnitPower *UnitPowerFemtowatts( void )
{ return [NSUnitPower femtowatts]; }

NSUnitPower *UnitPowerHorsepower( void )
{ return [NSUnitPower horsepower]; }



#pragma mark - UnitPressure
// Class
Class UnitPressureClass( void )
{ return [NSUnitPressure class]; }

// Base unit
NSUnitPressure *UnitPressureBaseUnit( void )
{ return [NSUnitPressure baseUnit]; }

// Predefined units
NSUnitPressure *UnitPressureNewtonsPerMeterSquared( void )
{ return [NSUnitPressure newtonsPerMetersSquared]; }
//{ return [NSUnitPressure newtonsPerMeterSquared]; }// ???

NSUnitPressure *UnitPressureGigapascals( void )
{ return [NSUnitPressure gigapascals]; }

NSUnitPressure *UnitPressureMegapascals( void )
{ return [NSUnitPressure megapascals]; }

NSUnitPressure *UnitPressureKilopascals( void )
{ return [NSUnitPressure kilopascals]; }

NSUnitPressure *UnitPressureHectopascals( void )
{ return [NSUnitPressure hectopascals]; }

NSUnitPressure *UnitPressureInchesOfMercury( void )
{ return [NSUnitPressure inchesOfMercury]; }

NSUnitPressure *UnitPressureBars( void )
{ return [NSUnitPressure bars]; }

NSUnitPressure *UnitPressureMillibars( void )
{ return [NSUnitPressure millibars]; }

NSUnitPressure *UnitPressureMillimetersOfMercury( void )
{ return [NSUnitPressure millimetersOfMercury]; }

NSUnitPressure *UnitPressurePoundsPerSquareInch( void )
{ return [NSUnitPressure poundsForcePerSquareInch]; }// ???

// Type properties
NSUnitPressure *UnitPressureNewtonsPerMetersSquared( void )
{ return [NSUnitPressure newtonsPerMetersSquared]; }

NSUnitPressure *UnitPressurePoundsForcePerSquareInch( void )
{ return [NSUnitPressure poundsForcePerSquareInch]; }



#pragma mark - UnitSpeed
// Class
Class UnitSpeedClass( void )
{ return [NSUnitSpeed class]; }

// Base unit
NSUnitSpeed *UnitSpeedBaseUnit( void )
{ return [NSUnitSpeed baseUnit]; }

// Predefined units
NSUnitSpeed *UnitSpeedMetersPerSecond( void )
{ return [NSUnitSpeed metersPerSecond]; }

NSUnitSpeed *UnitSpeedKilometersPerHour( void )
{ return [NSUnitSpeed kilometersPerHour]; }

NSUnitSpeed *UnitSpeedMilesPerHour( void )
{ return [NSUnitSpeed milesPerHour]; }

NSUnitSpeed *UnitSpeedKnots( void )
{ return [NSUnitSpeed knots]; }



#pragma mark - UnitTemperature
// Class
Class UnitTemperatureClass( void )
{ return [NSUnitTemperature class]; }

// Base unit
NSUnitTemperature *UnitTemperatureBaseUnit( void )
{ return [NSUnitTemperature baseUnit]; }

// Predefined units
NSUnitTemperature *UnitTemperatureKelvin( void )
{ return [NSUnitTemperature kelvin]; }

NSUnitTemperature *UnitTemperatureCelsius( void )
{ return [NSUnitTemperature celsius]; }

NSUnitTemperature *UnitTemperatureFahrenheit( void )
{ return [NSUnitTemperature fahrenheit]; }



#pragma mark - UnitVolume
// Class
Class UnitVolumeClass( void )
{ return [NSUnitVolume class]; }

// Base unit
NSUnitVolume *UnitVolumeBaseUnit( void )
{ return [NSUnitVolume baseUnit]; }

// Predefined units
NSUnitVolume *UnitVolumeMegaliters( void )
{ return [NSUnitVolume megaliters]; }

NSUnitVolume *UnitVolumeKiloliters( void )
{ return [NSUnitVolume kiloliters]; }

NSUnitVolume *UnitVolumeLiters( void )
{ return [NSUnitVolume liters]; }

NSUnitVolume *UnitVolumeDeciliters( void )
{ return [NSUnitVolume deciliters]; }

NSUnitVolume *UnitVolumeCentiliters( void )
{ return [NSUnitVolume centiliters]; }

NSUnitVolume *UnitVolumeMilliliters( void )
{ return [NSUnitVolume milliliters]; }

NSUnitVolume *UnitVolumeCubicKilometers( void )
{ return [NSUnitVolume cubicKilometers]; }

NSUnitVolume *UnitVolumeCubicMeters( void )
{ return [NSUnitVolume cubicMeters]; }

NSUnitVolume *UnitVolumeCubicDecimeters( void )
{ return [NSUnitVolume cubicDecimeters]; }

NSUnitVolume *UnitVolumeCubicCentimeters( void )
{ return [NSUnitVolume cubicCentimeters]; }

NSUnitVolume *UnitVolumeCubicMillimeters( void )
{ return [NSUnitVolume cubicMillimeters]; }

NSUnitVolume *UnitVolumeCubicInches( void )
{ return [NSUnitVolume cubicInches]; }

NSUnitVolume *UnitVolumeCubicFeet( void )
{ return [NSUnitVolume cubicFeet]; }

NSUnitVolume *UnitVolumeCubicYards( void )
{ return [NSUnitVolume cubicYards]; }

NSUnitVolume *UnitVolumeCubicMiles( void )
{ return [NSUnitVolume cubicMiles]; }

NSUnitVolume *UnitVolumeAcreFeet( void )
{ return [NSUnitVolume acreFeet]; }

NSUnitVolume *UnitVolumeBushels( void )
{ return [NSUnitVolume bushels]; }

NSUnitVolume *UnitVolumeTeaspoons( void )
{ return [NSUnitVolume teaspoons]; }

NSUnitVolume *UnitVolumeTablespoons( void )
{ return [NSUnitVolume tablespoons]; }

NSUnitVolume *UnitVolumeFluidOunces( void )
{ return [NSUnitVolume fluidOunces]; }

NSUnitVolume *UnitVolumeCups( void )
{ return [NSUnitVolume cups]; }

NSUnitVolume *UnitVolumePints( void )
{ return [NSUnitVolume pints]; }

NSUnitVolume *UnitVolumeQuarts( void )
{ return [NSUnitVolume quarts]; }

NSUnitVolume *UnitVolumeGallons( void )
{ return [NSUnitVolume gallons]; }

NSUnitVolume *UnitVolumeImperialTeaspoons( void )
{ return [NSUnitVolume imperialTeaspoons]; }

NSUnitVolume *UnitVolumeImperialTablespoons( void )
{ return [NSUnitVolume imperialTablespoons]; }

NSUnitVolume *UnitVolumeImperialFluidOunces( void )
{ return [NSUnitVolume imperialFluidOunces]; }

NSUnitVolume *UnitVolumeImperialPints( void )
{ return [NSUnitVolume imperialPints]; }

NSUnitVolume *UnitVolumeImperialQuarts( void )
{ return [NSUnitVolume imperialQuarts]; }

NSUnitVolume *UnitVolumeImperialGallons( void )
{ return [NSUnitVolume imperialGallons]; }

NSUnitVolume *UnitVolumeMetricCups( void )
{ return [NSUnitVolume metricCups]; }



