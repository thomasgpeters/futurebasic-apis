/*
 DockTile.m

 Bernie Wylde
 */

#import "DockTile.h"

// Class
Class DockTileClass( void )
{ return [NSDockTile class]; }

NSView *DockTileContentView( NSDockTile *ref )
{ return [ref contentView]; }

void DockTileSetContentView( NSDockTile *ref, NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [ref setContentView:view];
}

CGSize DockTileSize( NSDockTile *ref )
{ return NSSizeToCGSize([ref size]); }

CFTypeRef DockTileOwner( NSDockTile *ref )
{ return (__bridge CFTypeRef)[ref owner]; }

BOOL DockTileShowsApplicationBadge( NSDockTile *ref )
{ return [ref showsApplicationBadge]; }

void DockTileSetShowsApplicationBadge( NSDockTile *ref, BOOL flag )
{ [ref setShowsApplicationBadge:flag]; }

CFStringRef DockTileBadgeLabel( NSDockTile *ref )
{ return (__bridge CFStringRef)[ref badgeLabel]; }

void DockTileSetBadgeLabel( NSDockTile *ref, CFStringRef label )
{ [ref setBadgeLabel:(__bridge NSString *)label]; }

void DockTileDisplay( NSDockTile *ref )
{ [ref display]; }

