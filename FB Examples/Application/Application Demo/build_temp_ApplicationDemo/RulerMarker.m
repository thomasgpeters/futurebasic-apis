/*
 RulerMarker.m

 Bernie Wylde
 */

#import "RulerMarker.h"
// Class
Class RulerMarkerClass( void )
{ return [NSRulerMarker class]; }

// Create
NSRulerMarker *RulerMarkerWithRulerView( NSRulerView *ruler, CGFloat location, NSImage *image, CGPoint imageOrigin )
{
#if __has_feature(objc_arc)
    return [[NSRulerMarker alloc] initWithRulerView:ruler markerLocation:location image:image imageOrigin:NSPointFromCGPoint(imageOrigin)];
#else
    return [[[NSRulerMarker alloc] initWithRulerView:ruler markerLocation:location image:image imageOrigin:NSPointFromCGPoint(imageOrigin)] autorelease];
#endif
}

// Ruler view
NSRulerView *RulerMarkerRuler( NSRulerMarker *ref )
{ return [ref ruler]; }

// Image
NSImage *RulerMarkerImage( NSRulerMarker *ref )
{ return [ref image]; }

void RulerMarkerSetImage( NSRulerMarker *ref, NSImage *image )
{ [ref setImage:image]; }

CGPoint RulerMarkerImageOrigin( NSRulerMarker *ref )
{ return NSPointToCGPoint([ref imageOrigin]); }

void RulerMarkerSetImageOrigin( NSRulerMarker *ref, CGPoint origin )
{ [ref setImageOrigin:NSPointFromCGPoint(origin)]; }

CGRect RulerMarkerImageRectInRuler( NSRulerMarker *ref )
{ return NSRectToCGRect([ref imageRectInRuler]); }

CGFloat RulerMarkerThicknessRequiredInRuler( NSRulerMarker *ref )
{ return [ref thicknessRequiredInRuler]; }

// Movability
BOOL RulerMarkerIsMovable( NSRulerMarker *ref )
{ return [ref isMovable]; }

void RulerMarkerSetMovable( NSRulerMarker *ref, BOOL flag )
{ [ref setMovable:flag]; }

BOOL RulerMarkerIsRemovable( NSRulerMarker *ref )
{ return [ref isRemovable]; }

void RulerMarkerSetRemovable( NSRulerMarker *ref, BOOL flag )
{ [ref setRemovable:flag]; }

// Location
CGFloat RulerMarkerLocation( NSRulerMarker *ref )
{ return [ref markerLocation]; }

void RulerMarkerSetLocation( NSRulerMarker *ref, CGFloat location )
{ [ref setMarkerLocation:location]; }

// Represented object
CFTypeRef RulerMarkerRepresentedObject( NSRulerMarker *ref )
{ return (__bridge CFTypeRef)[ref representedObject]; }

void RulerMarkerSetRepresentedObject( NSRulerMarker *ref, CFTypeRef obj )
{ [ref setRepresentedObject:(__bridge id)obj]; }

// Drawing and event handling
void RulerMarkerDrawRect( NSRulerMarker *ref, CGRect r )
{ [ref drawRect:NSRectFromCGRect(r)]; }

BOOL RulerMarkerisDragging( NSRulerMarker *ref )
{ return [ref isDragging]; }

