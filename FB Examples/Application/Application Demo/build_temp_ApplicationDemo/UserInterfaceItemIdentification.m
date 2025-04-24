/*
 UserInterfaceItemIdentification.m

 Bernie Wylde
 */

#import "UserInterfaceItemIdentification.h"

// Identifier
CFStringRef UserInterfaceItemIdentificationIdentifier( id<NSUserInterfaceItemIdentification> ref )
{ return (__bridge CFStringRef)[ref identifier]; }

void UserInterfaceItemIdentificationSetIdentifier( id<NSUserInterfaceItemIdentification> ref, CFStringRef identifier )
{ [ref setIdentifier:(__bridge NSString *)identifier]; }
