/*
 Pasteboard.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class PasteboardClass( void );

// create
NSPasteboard *PasteboardGeneral( void );
NSPasteboard *PasteboardByFilteringData( CFDataRef dta, CFStringRef type );
NSPasteboard *PasteboardByFilteringFile( CFStringRef filename );
NSPasteboard *PasteboardByFilteringTypesInPasteboard( NSPasteboard *pb );
NSPasteboard *PasteboardWithName( CFStringRef name );
NSPasteboard *PasteboardWithUniqueName( void );
void PasteboardReleaseGlobally( NSPasteboard *ref );

// writing data
NSInteger PasteboardRefClearContents( NSPasteboard *ref );
BOOL PasteboardRefWriteObjects( NSPasteboard *ref, CFArrayRef objects );
BOOL PasteboardRefSetDataForType( NSPasteboard *ref, CFDataRef dta, CFStringRef type );
BOOL PasteboardRefSetPropertyListForType( NSPasteboard *ref, CFTypeRef plist, CFStringRef type );
BOOL PasteboardRefSetStringForType( NSPasteboard *ref, CFStringRef string, CFStringRef type );

// reading data
CFArrayRef PasteboardRefItems( NSPasteboard *ref );
CFTypeRef PasteboardRefPropertyListForType( NSPasteboard *ref, CFStringRef type );
CFStringRef PasteboardRefStringForType( NSPasteboard *ref, CFStringRef type );

// validating contents
CFArrayRef PasteboardRefTypes( NSPasteboard *ref );

// pasteboard info
CFStringRef PasteboardRefName( NSPasteboard *ref );
NSInteger PasteboardRefChangeCount( NSPasteboard *ref );


// - convenience - these functions work on the general pasteboard
// writing data
NSInteger PasteboardClearContents( void );
BOOL PasteboardWriteObjects( CFArrayRef objects );
BOOL PasteboardSetStringForType( CFStringRef string, CFStringRef type );

// reading data
CFArrayRef PasteboardItems( void );
CFTypeRef PasteboardPropertyListForType( CFStringRef type );
CFStringRef PasteboardStringForType( CFStringRef type );

// validating contents
CFArrayRef PasteboardTypes( void );

// pasteboard info
CFStringRef PasteboardName( void );
NSInteger PasteboardChangeCount( void );

