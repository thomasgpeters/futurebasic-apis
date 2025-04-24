/*
 PressureConfiguration.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class PressureConfigurationClass( void );

// Create
NSPressureConfiguration *PressureConfigurationWithBehavior( NSPressureBehavior behavior );
void PressureConfigurationSet( NSPressureConfiguration *ref );

// Properties
NSPressureBehavior PressureConfigurationBehavior( NSPressureConfiguration *ref );

