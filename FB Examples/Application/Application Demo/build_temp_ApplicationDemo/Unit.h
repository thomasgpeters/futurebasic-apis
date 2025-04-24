/*
 Unit.h

 Bernie Wylde
 */


#import "CocoaUI.h"


#pragma mark - Unit
// Class
Class UnitClass( void );

// Create
NSUnit *UnitWithSymbol( CFStringRef symbol );

// Properties
CFStringRef UnitSymbol( NSUnit *ref );


#pragma mark - UnitConverter
// Class
Class UnitConverterClass( void );

double UnitConverterBaseUnitValueFromValue( NSUnitConverter *ref, double value );
double UnitConverterValueFromBaseUnitValue( NSUnitConverter *ref, double value );



#pragma mark - UnitConverterLinear
// Class
Class UnitConverterLinearClass( void );

// Create
NSUnitConverterLinear *UnitConverterLinearWithCoefficient( double coefficient );
NSUnitConverterLinear *UnitConverterLinearWithCoefficientAndConstant( double coefficient, double constant );

// Linear parmaeters
double UnitConverterLinearCoefficient( NSUnitConverterLinear *ref );
double UnitConverterLinearConstant( NSUnitConverterLinear *ref );

#pragma mark - Dimension
// Class
Class DimensionClass( void );

// Create
NSDimension *DimensionWithSymbol( CFStringRef symbol, NSUnitConverter *converter );

// Unit converter
NSUnitConverter *DimensionConverter( NSDimension *ref );

// Base unit
NSUnit *DimensionBaseUnit( void );


#pragma mark - UnitAcceleration
// Class
Class UnitAccelerationClass( void );

// Base unit
NSUnitAcceleration *UnitAccelerationBaseUnit( void );

// Predefined units
NSUnitAcceleration *UnitAccelerationMetersPerSecondSquared( void );
NSUnitAcceleration *UnitAccelerationGravity( void );


#pragma mark - UnitAngle
// Class
Class UnitAngleClass( void );

// Base unit
NSUnitAngle *UnitAngleBaseUnit( void );

// Predefined units
NSUnitAngle *UnitAngleDegrees( void );
NSUnitAngle *UnitAngleArcMinutes( void );
NSUnitAngle *UnitAngleArcSeconds( void );
NSUnitAngle *UnitAngleRadians( void );
NSUnitAngle *UnitAngleGradians( void );
NSUnitAngle *UnitAngleRevolutions( void );


#pragma mark - UnitArea
// Class
Class UnitAreaClass( void );

// Base unit
NSUnitArea *UnitAreaBaseUnit( void );

// Predefined units
NSUnitArea *UnitAreaSquareMegameters( void );
NSUnitArea *UnitAreaSquareKilometers( void );
NSUnitArea *UnitAreaSquareMeters( void );
NSUnitArea *UnitAreaSquareCentimeters( void );
NSUnitArea *UnitAreaSquareMillimeters( void );
NSUnitArea *UnitAreaSquareMicrometers( void );
NSUnitArea *UnitAreaSquareNanometers( void );
NSUnitArea *UnitAreaSquareInches( void );
NSUnitArea *UnitAreaSquareFeet( void );
NSUnitArea *UnitAreaSquareYards( void );
NSUnitArea *UnitAreaSquareMiles( void );
NSUnitArea *UnitAreaAcres( void );
NSUnitArea *UnitAreaAres( void );
NSUnitArea *UnitAreaHectares( void );


#pragma mark - UnitConcentrationMass
// Class
Class UnitConcentrationMassClass( void );

// Base unit
NSUnitConcentrationMass *UnitConcentrationMassBaseUnit( void );

// Predefined units
NSUnitConcentrationMass *UnitConcentrationMassGramsPerLiter( void );
NSUnitConcentrationMass *UnitConcentrationMassMilligramsPerDeciliter( void );
NSUnitConcentrationMass *UnitConcentrationMassMillimolesPerLiterWithGramsPerMole( double gramsPerMole );


#pragma mark - UnitDispersion
// Class
Class UnitDispersionClass( void );

// Base unit
NSUnitDispersion *UnitDispersionBaseUnit( void );

// Predefined units
NSUnitDispersion *UnitDispersionPartsPerMillion( void );


#pragma mark - UnitDuration
// Class
Class UnitDurationClass( void );

// Base unit
NSUnitDuration *UnitDurationBaseUnit( void );

// Predefined units
NSUnitDuration *UnitDurationSeconds( void );
NSUnitDuration *UnitDurationMinutes( void );
NSUnitDuration *UnitDurationHours( void );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
NSUnitDuration *UnitDurationMicroseconds( void );
API_AVAILABLE(macos(10.15))
NSUnitDuration *UnitDurationMilliseconds( void );
API_AVAILABLE(macos(10.15))
NSUnitDuration *UnitDurationNanoseconds( void );
API_AVAILABLE(macos(10.15))
NSUnitDuration *UnitDurationPicoseconds( void );
#endif// 101500


#pragma mark - UnitElectricCharge
// Class
Class UnitElectricChargeClass( void );

// Base unit
NSUnitElectricCharge *UnitElectricChargeBaseUnit( void );

// Predefined units
NSUnitElectricCharge *UnitElectricChargeCoulombs( void );
NSUnitElectricCharge *UnitElectricChargeMegaampereHours( void );
NSUnitElectricCharge *UnitElectricChargeKiloampereHours( void );
NSUnitElectricCharge *UnitElectricChargeAmpereHours( void );
NSUnitElectricCharge *UnitElectricChargeMilliampereHours( void );
NSUnitElectricCharge *UnitElectricChargeMicroampereHours( void );


#pragma mark - UnitElectricCurrent
// Class
Class UnitElectricCurrentClass( void );

// Base unit
NSUnitElectricCurrent *UnitElectricCurrentBaseUnit( void );

// Predefined units
NSUnitElectricCurrent *UnitElectricCurrentMegaamperes( void );
NSUnitElectricCurrent *UnitElectricCurrentKiloamperes( void );
NSUnitElectricCurrent *UnitElectricCurrentAmperes( void );
NSUnitElectricCurrent *UnitElectricCurrentMilliamperes( void );
NSUnitElectricCurrent *UnitElectricCurrentMicroamperes( void );


#pragma mark - UnitPotentialDifference
// Class
Class UnitElectricPotentialDifferenceClass( void );

// Base unit
NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceBaseUnit( void );

// Predefined units
NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceMegavolts( void );
NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceKilovolts( void );
NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceVolts( void );
NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceMillivolts( void );
NSUnitElectricPotentialDifference *UnitElectricPotentialDifferenceMicrovolts( void );


#pragma mark - UnitElectricResistance
// Class
Class UnitElectricResistanceClass( void );

// Base unit
NSUnitElectricResistance *UnitElectricResistanceBaseUnit( void );

// Predefined units
NSUnitElectricResistance *UnitElectricResistanceMegaohms( void );
NSUnitElectricResistance *UnitElectricResistanceKiloohms( void );
NSUnitElectricResistance *UnitElectricResistanceOhms( void );
NSUnitElectricResistance *UnitElectricResistanceMilliohms( void );
NSUnitElectricResistance *UnitElectricResistanceMicroohms( void );


#pragma mark - UnitEnergy
// Class
Class UnitEnergyClass( void );

// Base unit
NSUnitEnergy *UnitEnergyBaseUnit( void );

// Predefined units
NSUnitEnergy *UnitEnergyKilojoules( void );
NSUnitEnergy *UnitEnergyJoules( void );
NSUnitEnergy *UnitEnergyKilocalories( void );
NSUnitEnergy *UnitEnergyCalories( void );
NSUnitEnergy *UnitEnergyKilowattHours( void );


#pragma mark - UnitFrequency
// Class
Class UnitFrequencyClass( void );

// Base unit
NSUnitFrequency *UnitFrequencyBaseUnit( void );

// Predefined units
NSUnitFrequency *UnitFrequencyTerahertz( void );
NSUnitFrequency *UnitFrequencyGigahertz( void );
NSUnitFrequency *UnitFrequencyMegahertz( void );
NSUnitFrequency *UnitFrequencyKilohertz( void );
NSUnitFrequency *UnitFrequencyHertz( void );
NSUnitFrequency *UnitFrequencyMillihertz( void );
NSUnitFrequency *UnitFrequencyMicrohertz( void );
NSUnitFrequency *UnitFrequencyNanohertz( void );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
NSUnitFrequency *UnitFrequencyFramesPerSecond( void );
#endif// 101500


#pragma mark - UnitFuelEfficiency
// Class
Class UnitFuelEfficiencyClass( void );

// Base unit
NSUnitFuelEfficiency *UnitFuelEfficiencyBaseUnit( void );

// Predefined units
NSUnitFuelEfficiency *UnitFuelEfficiencyMilesPerImperialGallon( void );
NSUnitFuelEfficiency *UnitFuelEfficiencyLitersPer100Kilometers( void );
NSUnitFuelEfficiency *UnitFuelEfficiencyMilesPerGallon( void );


#pragma mark - UnitInformationStorage
// Class
API_AVAILABLE(macos(10.15))
Class UnitInformationStorageClass( void );

// Base unit
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageBaseUnit( void );

// Predefined units
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageBits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageBytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageExabits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageExabytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageExbibits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageExbibytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageGibibits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageGibibytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageGigabits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageGigabytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageKibibits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageKibibytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageKilobits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageKilobytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageMebibits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageMebibytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageMegabits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageMegabytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageNibbles( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStoragePebibits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStoragePebibytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStoragePetabits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStoragePetabytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageTebibits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageTebibytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageTerabits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageTerabytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageYobibits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageYobibytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageYottabits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageYottabytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageZebibits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageZebibytes( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageZettabits( void );
API_AVAILABLE(macos(10.15))
NSUnitInformationStorage *UnitInformationStorageZettabytes( void );
#endif// 101500


#pragma mark - UnitLength
// Class
Class UnitLengthClass( void );

// Base unit
NSUnitLength *UnitLengthBaseUnit( void );

// Predefined units
NSUnitLength *UnitLengthMegameters( void );
NSUnitLength *UnitLengthKilometers( void );
NSUnitLength *UnitLengthHectometers( void );
NSUnitLength *UnitLengthDecameters( void );
NSUnitLength *UnitLengthMeters( void );
NSUnitLength *UnitLengthDecimeters( void );
NSUnitLength *UnitLengthCentimeters( void );
NSUnitLength *UnitLengthMillimeters( void );
NSUnitLength *UnitLengthMicrometers( void );
NSUnitLength *UnitLengthNanometers( void );
NSUnitLength *UnitLengthPicometers( void );
NSUnitLength *UnitLengthInches( void );
NSUnitLength *UnitLengthFeet( void );
NSUnitLength *UnitLengthYards( void );
NSUnitLength *UnitLengthMiles( void );
NSUnitLength *UnitLengthScandinavianMiles( void );
NSUnitLength *UnitLengthLightyears( void );
NSUnitLength *UnitLengthNauticalMiles( void );
NSUnitLength *UnitLengthFathoms( void );
NSUnitLength *UnitLengthFurlongs( void );
NSUnitLength *UnitLengthAstronomicalUnits( void );
NSUnitLength *UnitLengthParsecs( void );


#pragma mark - UnitIlluminance
// Class
Class UnitIlluminanceClass( void );

// Base unit
NSUnitIlluminance *UnitIlluminanceBaseUnit( void );

// Predefined units
NSUnitIlluminance *UnitIlluminanceLux( void );


#pragma mark - UnitMass
// Class
Class UnitMassClass( void );

// Base unit
NSUnitMass *UnitMassBaseUnit( void );

// Predefined units
NSUnitMass *UnitMassKilograms( void );
NSUnitMass *UnitMassGrams( void );
NSUnitMass *UnitMassDecigrams( void );
NSUnitMass *UnitMassCentigrams( void );
NSUnitMass *UnitMassMilligrams( void );
NSUnitMass *UnitMassMicrograms( void );
NSUnitMass *UnitMassNanograms( void );
NSUnitMass *UnitMassPicograms( void );
NSUnitMass *UnitMassOunces( void );
NSUnitMass *UnitMassPounds( void );
NSUnitMass *UnitMassStones( void );
NSUnitMass *UnitMassMetricTons( void );
NSUnitMass *UnitMassShortTons( void );
NSUnitMass *UnitMassCarats( void );
NSUnitMass *UnitMassOuncesTroy( void );
NSUnitMass *UnitMassSlugs( void );

// Type properties
NSUnitMass *UnitMassPoundsMass( void );


#pragma mark - UnitPower
// Class
Class UnitPowerClass( void );

// Base unit
NSUnitPower *UnitPowerBaseUnit( void );

// Predefined units
NSUnitPower *UnitPowerTerawatts( void );
NSUnitPower *UnitPowerGigawatts( void );
NSUnitPower *UnitPowerMegawatts( void );
NSUnitPower *UnitPowerKilowatts( void );
NSUnitPower *UnitPowerWatts( void );
NSUnitPower *UnitPowerMilliwatts( void );
NSUnitPower *UnitPowerMicrowatts( void );
NSUnitPower *UnitPowerNanowatts( void );
NSUnitPower *UnitPowerPicowatts( void );
NSUnitPower *UnitPowerFemtowatts( void );
NSUnitPower *UnitPowerHorsepower( void );


#pragma mark - UnitPressure
// Class
Class UnitPressureClass( void );

// Base unit
NSUnitPressure *UnitPressureBaseUnit( void );

// Predefined units
NSUnitPressure *UnitPressureNewtonsPerMeterSquared( void );
NSUnitPressure *UnitPressureGigapascals( void );
NSUnitPressure *UnitPressureMegapascals( void );
NSUnitPressure *UnitPressureKilopascals( void );
NSUnitPressure *UnitPressureHectopascals( void );
NSUnitPressure *UnitPressureInchesOfMercury( void );
NSUnitPressure *UnitPressureBars( void );
NSUnitPressure *UnitPressureMillibars( void );
NSUnitPressure *UnitPressureMillimetersOfMercury( void );
NSUnitPressure *UnitPressurePoundsPerSquareInch( void );

// Type properties
NSUnitPressure *UnitPressureNewtonsPerMetersSquared( void );
NSUnitPressure *UnitPressurePoundsForcePerSquareInch( void );


#pragma mark - UnitSpeed
// Class
Class UnitSpeedClass( void );

// Base unit
NSUnitSpeed *UnitSpeedBaseUnit( void );

// Predefined units
NSUnitSpeed *UnitSpeedMetersPerSecond( void );
NSUnitSpeed *UnitSpeedKilometersPerHour( void );
NSUnitSpeed *UnitSpeedMilesPerHour( void );
NSUnitSpeed *UnitSpeedKnots( void );


#pragma mark - UnitTemperature
// Class
Class UnitTemperatureClass( void );

// Base unit
NSUnitTemperature *UnitTemperatureBaseUnit( void );

// Predefined units
NSUnitTemperature *UnitTemperatureKelvin( void );
NSUnitTemperature *UnitTemperatureCelsius( void );
NSUnitTemperature *UnitTemperatureFahrenheit( void );


#pragma mark - UnitVolume
// Class
Class UnitVolumeClass( void );

// Base unit
NSUnitVolume *UnitVolumeBaseUnit( void );

// Predefined units
NSUnitVolume *UnitVolumeMegaliters( void );
NSUnitVolume *UnitVolumeKiloliters( void );
NSUnitVolume *UnitVolumeLiters( void );
NSUnitVolume *UnitVolumeDeciliters( void );
NSUnitVolume *UnitVolumeCentiliters( void );
NSUnitVolume *UnitVolumeMilliliters( void );
NSUnitVolume *UnitVolumeCubicKilometers( void );
NSUnitVolume *UnitVolumeCubicMeters( void );
NSUnitVolume *UnitVolumeCubicDecimeters( void );
NSUnitVolume *UnitVolumeCubicCentimeters( void );
NSUnitVolume *UnitVolumeCubicMillimeters( void );
NSUnitVolume *UnitVolumeCubicInches( void );
NSUnitVolume *UnitVolumeCubicFeet( void );
NSUnitVolume *UnitVolumeCubicYards( void );
NSUnitVolume *UnitVolumeCubicMiles( void );
NSUnitVolume *UnitVolumeAcreFeet( void );
NSUnitVolume *UnitVolumeBushels( void );
NSUnitVolume *UnitVolumeTeaspoons( void );
NSUnitVolume *UnitVolumeTablespoons( void );
NSUnitVolume *UnitVolumeFluidOunces( void );
NSUnitVolume *UnitVolumeCups( void );
NSUnitVolume *UnitVolumePints( void );
NSUnitVolume *UnitVolumeQuarts( void );
NSUnitVolume *UnitVolumeGallons( void );
NSUnitVolume *UnitVolumeImperialTeaspoons( void );
NSUnitVolume *UnitVolumeImperialTablespoons( void );
NSUnitVolume *UnitVolumeImperialFluidOunces( void );
NSUnitVolume *UnitVolumeImperialPints( void );
NSUnitVolume *UnitVolumeImperialQuarts( void );
NSUnitVolume *UnitVolumeImperialGallons( void );
NSUnitVolume *UnitVolumeMetricCups( void );

