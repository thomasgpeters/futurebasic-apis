/*
 UserDefaultsController.m

 Bernie Wylde
 */

#import "UserDefaultsController.h"

// Class
Class UserDefaultsControllerClass( void )
{ return [NSUserDefaultsController class]; }

// Shared instance
NSUserDefaultsController *UserDefaultsControllerShared( void )
{ return [NSUserDefaultsController sharedUserDefaultsController]; }

// Values
NSUserDefaults *UserDefaultsControllerDefaults( void )
{ return [[NSUserDefaultsController sharedUserDefaultsController] defaults]; }

CFDictionaryRef UserDefaultsControllerInitialValues( void )
{ return (__bridge CFDictionaryRef)[[NSUserDefaultsController sharedUserDefaultsController] initialValues]; }

void UserDefaultsControllerSetInitialValues( CFDictionaryRef values )
{
    NSMutableDictionary *dict = [(__bridge NSDictionary *)values mutableCopy];
    NSArray *keys = [dict allKeys];
    for ( NSString *key in keys ) {
        id obj = [dict objectForKey:key];
        if ( [obj isKindOfClass:[NSColor class]] ) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
            [dict setObject:data forKey:key];
        } else if ( [obj isKindOfClass:[NSFont class]] ) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
            [dict setObject:data forKey:key];
        }
    }
    [[NSUserDefaultsController sharedUserDefaultsController] setInitialValues:dict];
}

BOOL UserDefaultsControllerHasUnappliedChanges( void )
{ return [[NSUserDefaultsController sharedUserDefaultsController] hasUnappliedChanges]; }

BOOL UserDefaultsControllerAppliesImmediately( void )
{ return [[NSUserDefaultsController sharedUserDefaultsController] appliesImmediately]; }

void UserDefaultsControllerSetAppliesImmediately( BOOL flag )
{ [[NSUserDefaultsController sharedUserDefaultsController] setAppliesImmediately:flag]; }

CFTypeRef UserDefaultsControllerValues( void )
{ return (__bridge CFTypeRef)[[NSUserDefaultsController sharedUserDefaultsController] values]; }

void UserDefaultsControllerRevert( void )
{ [[NSUserDefaultsController sharedUserDefaultsController] revert:nil]; }

void UserDefaultsControllerRevertToInitialValues( void )
{ [[NSUserDefaultsController sharedUserDefaultsController] revertToInitialValues:nil]; }

void UserDefaultsControllerSave( void )
{ [(NSUserDefaultsController *)[NSUserDefaultsController sharedUserDefaultsController] save:nil]; }


// Convenience
void UserDefaultsControllerValuesSetValueForKey( CFTypeRef value, CFStringRef key )
{
    NSUserDefaultsController *udc = [NSUserDefaultsController sharedUserDefaultsController];
    id obj = (__bridge id)value;
    if ( [obj isKindOfClass:[NSColor class]] ) {
        NSData *dta = [NSKeyedArchiver archivedDataWithRootObject:obj];
        [[udc values] setValue:dta forKey:(__bridge NSString *)key];
    } else if ( [obj isKindOfClass:[NSFont class]] ) {
        NSData *dta = [NSKeyedArchiver archivedDataWithRootObject:obj];
        [[udc values] setValue:dta forKey:(__bridge NSString *)key];
    } else {
        [[udc values] setValue:obj forKey:(__bridge NSString *)key];
    }
}

