/*
 PressureConfiguration.m

 Bernie Wylde
 */

#import "PressureConfiguration.h"


// Class
Class PressureConfigurationClass( void )
{ return [NSPressureConfiguration class]; }

// Create
NSPressureConfiguration *PressureConfigurationWithBehavior( NSPressureBehavior behavior )
{
#if __has_feature(objc_arc)
    return [[NSPressureConfiguration alloc] initWithPressureBehavior:behavior];
#else
    return [[[NSPressureConfiguration alloc] initWithPressureBehavior:behavior] autorelease];
#endif
}

void PressureConfigurationSet( NSPressureConfiguration *ref )
{ [ref set]; }

// Properties
NSPressureBehavior PressureConfigurationBehavior( NSPressureConfiguration *ref )
{ return [ref pressureBehavior]; }

