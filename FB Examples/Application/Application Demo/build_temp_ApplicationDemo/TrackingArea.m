/*
 TrackingArea.m

 Bernie Wylde
 */

#import "TrackingArea.h"

// Class
Class TrackingAreaClass( void )
{ return [NSTrackingArea class]; }

// Init
NSTrackingArea *TrackingAreaWithRect( CGRect r, NSTrackingAreaOptions options, NSInteger ownerTag, CFDictionaryRef userInfo )
{
    NSView *owner = CUI_ViewWithTag( ownerTag );
    return [[NSTrackingArea alloc] initWithRect:NSRectFromCGRect(r) options:options owner:owner userInfo:(__bridge NSDictionary *)userInfo];
}

// Attributes
NSTrackingAreaOptions TrackingAreaOptions( NSTrackingArea *ref )
{ return [ref options]; }

NSInteger TrackingAreaOwner( NSTrackingArea *ref )
{
    id owner = [ref owner];
    if ( owner ) return CUI_ViewTag(owner);
    return 0;
}

CGRect TrackingAreaRect( NSTrackingArea *ref )
{ return NSRectToCGRect([ref rect]); }

CFDictionaryRef TrackingAreaUserInfo( NSTrackingArea *ref )
{ return (__bridge CFDictionaryRef)[ref userInfo]; }

