/*
 RulerMarker.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class RulerMarkerClass( void );

// Create
NSRulerMarker *RulerMarkerWithRulerView( NSRulerView *ruler, CGFloat location, NSImage *image, CGPoint imageOrigin );

// Ruler view
NSRulerView *RulerMarkerRuler( NSRulerMarker *ref );

// Image
NSImage *RulerMarkerImage( NSRulerMarker *ref );
void RulerMarkerSetImage( NSRulerMarker *ref, NSImage *image );
CGPoint RulerMarkerImageOrigin( NSRulerMarker *ref );
void RulerMarkerSetImageOrigin( NSRulerMarker *ref, CGPoint origin );
CGRect RulerMarkerImageRectInRuler( NSRulerMarker *ref );
CGFloat RulerMarkerThicknessRequiredInRuler( NSRulerMarker *ref );

// Movability
BOOL RulerMarkerIsMovable( NSRulerMarker *ref );
void RulerMarkerSetMovable( NSRulerMarker *ref, BOOL flag );
BOOL RulerMarkerIsRemovable( NSRulerMarker *ref );
void RulerMarkerSetRemovable( NSRulerMarker *ref, BOOL flag );

// Location
CGFloat RulerMarkerLocation( NSRulerMarker *ref );
void RulerMarkerSetLocation( NSRulerMarker *ref, CGFloat location );

// Represented object
CFTypeRef RulerMarkerRepresentedObject( NSRulerMarker *ref );
void RulerMarkerSetRepresentedObject( NSRulerMarker *ref, CFTypeRef obj );

// Drawing and event handling
void RulerMarkerDrawRect( NSRulerMarker *ref, CGRect r );
BOOL RulerMarkerisDragging( NSRulerMarker *ref );

