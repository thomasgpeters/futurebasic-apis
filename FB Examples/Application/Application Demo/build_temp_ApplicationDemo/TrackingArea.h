/*
 TrackingArea.h

 Bernie Wylde
 */


#import "CocoaUI.h"

#import "View.h"

// Class
Class TrackingAreaClass( void );

// Init
NSTrackingArea *TrackingAreaWithRect( CGRect r, NSTrackingAreaOptions options, NSInteger ownerTag, CFDictionaryRef userInfo );

// Attributes
NSTrackingAreaOptions TrackingAreaOptions( NSTrackingArea *ref );
NSInteger TrackingAreaOwner( NSTrackingArea *ref );
CGRect TrackingAreaRect( NSTrackingArea *ref );
CFDictionaryRef TrackingAreaUserInfo( NSTrackingArea *ref );
