/*
 DockTile.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class DockTileClass( void );

NSView *DockTileContentView( NSDockTile *ref );
void DockTileSetContentView( NSDockTile *ref, NSInteger tag );

CGSize DockTileSize( NSDockTile *ref );
CFTypeRef DockTileOwner( NSDockTile *ref );

BOOL DockTileShowsApplicationBadge( NSDockTile *ref );
void DockTileSetShowsApplicationBadge( NSDockTile *ref, BOOL flag );
CFStringRef DockTileBadgeLabel( NSDockTile *ref );
void DockTileSetBadgeLabel( NSDockTile *ref, CFStringRef label );

void DockTileDisplay( NSDockTile *ref );

