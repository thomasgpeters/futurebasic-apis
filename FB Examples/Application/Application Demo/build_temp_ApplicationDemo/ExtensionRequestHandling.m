/*
 ExtensionRequestHandling.m

 Bernie Wylde
 */

#import "ExtensionRequestHandling.h"


void ExtensionRequestHandlingBeginRequestWithExtensionContext( id<NSExtensionRequestHandling> ref, NSExtensionContext *context )
{ [ref beginRequestWithExtensionContext:context]; }

