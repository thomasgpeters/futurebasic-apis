/*
 Enumerator.m

 Bernie Wylde
 */

#import "Enumerator.h"

// Class
Class EnumeratorClass( void )
{ return [NSEnumerator class]; }

CFArrayRef EnumeratorAllObjects( NSEnumerator *ref )
{ return (__bridge CFArrayRef)[ref allObjects]; }

CFTypeRef EnumeratorNextObject( NSEnumerator *ref )
{ return (__bridge CFTypeRef)[ref nextObject]; }


#pragma mark = FastEnumeration
// Enumeration
NSUInteger FastEnumerationCountByEnumeratingWithState( id<NSFastEnumeration> ref, NSFastEnumerationState *state, id *buffer, NSUInteger count )
{ return [ref countByEnumeratingWithState:state objects:buffer count:count]; }
