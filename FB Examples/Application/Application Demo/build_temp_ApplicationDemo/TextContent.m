/*
 TextContent.m

 Bernie Wylde
 */

#import "TextContent.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000

CFStringRef TextContentType( id<NSTextContent> ref )
{ return (__bridge CFStringRef)[ref contentType]; }

void TextContentSetType( id<NSTextContent> ref, CFStringRef type )
{ [ref setContentType:(__bridge NSString *)type]; }

#endif
