/*
 Pasteboard.m

 Bernie Wylde
 */

#import "Pasteboard.h"

// Class
Class PasteboardClass( void )
{ return [NSPasteboard class]; }

// create
NSPasteboard *PasteboardGeneral( void )
{ return [NSPasteboard generalPasteboard]; }

NSPasteboard *PasteboardByFilteringData( CFDataRef dta, CFStringRef type )
{ return [NSPasteboard pasteboardByFilteringData:(__bridge NSData *)dta ofType:(__bridge NSString *)type]; }

NSPasteboard *PasteboardByFilteringFile( CFStringRef filename )
{ return [NSPasteboard pasteboardByFilteringFile:(__bridge NSString *)filename]; }

NSPasteboard *PasteboardByFilteringTypesInPasteboard( NSPasteboard *pb )
{ return [NSPasteboard pasteboardByFilteringTypesInPasteboard:pb]; }

NSPasteboard *PasteboardWithName( CFStringRef name )
{ return [NSPasteboard pasteboardWithName:(__bridge NSString *)name]; }

NSPasteboard *PasteboardWithUniqueName( void )
{ return [NSPasteboard pasteboardWithUniqueName]; }

void PasteboardReleaseGlobally( NSPasteboard *ref )
{ [ref releaseGlobally]; }

// writing data
NSInteger PasteboardRefClearContents( NSPasteboard *ref )
{ return [ref clearContents]; }

BOOL PasteboardRefWriteObjects( NSPasteboard *ref, CFArrayRef objects )
{ return [ref writeObjects:(__bridge NSArray *)objects]; }

BOOL PasteboardRefSetDataForType( NSPasteboard *ref, CFDataRef dta, CFStringRef type )
{ return [ref setData:(__bridge NSData *)dta forType:(__bridge NSString *)type]; }

BOOL PasteboardRefSetPropertyListForType( NSPasteboard *ref, CFTypeRef plist, CFStringRef type )
{ return [ref setPropertyList:(__bridge id)plist forType:(__bridge NSString *)type]; }

BOOL PasteboardRefSetStringForType( NSPasteboard *ref, CFStringRef string, CFStringRef type )
{ return [ref setString:(__bridge NSString *)string forType:(__bridge NSString *)type]; }

// reading data
CFArrayRef PasteboardRefItems( NSPasteboard *ref )
{ return (__bridge CFArrayRef)[ref pasteboardItems]; }

CFTypeRef PasteboardRefPropertyListForType( NSPasteboard *ref, CFStringRef type )
{ return (__bridge CFTypeRef)[ref propertyListForType:(__bridge NSString *)type]; }

CFStringRef PasteboardRefStringForType( NSPasteboard *ref, CFStringRef type )
{ return (__bridge CFStringRef)[ref stringForType:(__bridge NSString *)type]; }

// validating contents
CFArrayRef PasteboardRefTypes( NSPasteboard *ref )
{ return (__bridge CFArrayRef)[ref types]; }

// pasteboard info
CFStringRef PasteboardRefName( NSPasteboard *ref )
{ return (__bridge CFStringRef)[ref name]; }

NSInteger PasteboardRefChangeCount( NSPasteboard *ref )
{ return [ref changeCount]; }


// - convenience - these functions work on the general pasteboard
// writing data
NSInteger PasteboardClearContents( void )
{ return [[NSPasteboard generalPasteboard] clearContents]; }

BOOL PasteboardWriteObjects( CFArrayRef objects )
{ return [[NSPasteboard generalPasteboard] writeObjects:(__bridge NSArray *)objects]; }

BOOL PasteboardSetStringForType( CFStringRef string, CFStringRef type )
{ return [[NSPasteboard generalPasteboard] setString:(__bridge NSString *)string forType:(__bridge NSString *)type]; }

// reading data
CFArrayRef PasteboardItems( void )
{ return (__bridge CFArrayRef)[[NSPasteboard generalPasteboard] pasteboardItems]; }

CFTypeRef PasteboardPropertyListForType( CFStringRef type )
{ return (__bridge CFTypeRef)[[NSPasteboard generalPasteboard] propertyListForType:(__bridge NSString *)type]; }

CFStringRef PasteboardStringForType( CFStringRef type )
{ return (__bridge CFStringRef)[[NSPasteboard generalPasteboard] stringForType:(__bridge NSString *)type]; }

// validating contents
CFArrayRef PasteboardTypes( void )
{ return (__bridge CFArrayRef)[[NSPasteboard generalPasteboard] types]; }

// pasteboard info
CFStringRef PasteboardName( void )
{ return (__bridge CFStringRef)[[NSPasteboard generalPasteboard] name]; }

NSInteger PasteboardChangeCount( void )
{ return [[NSPasteboard generalPasteboard] changeCount]; }

