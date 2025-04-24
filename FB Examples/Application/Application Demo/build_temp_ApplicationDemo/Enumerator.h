/*
 Enumerator.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class EnumeratorClass( void );

CFArrayRef EnumeratorAllObjects( NSEnumerator *ref );
CFTypeRef EnumeratorNextObject( NSEnumerator *ref );


#pragma mark = FastEnumeration
// Enumeration
NSUInteger FastEnumerationCountByEnumeratingWithState( id<NSFastEnumeration> ref, NSFastEnumerationState *state, id *buffer, NSUInteger count );
