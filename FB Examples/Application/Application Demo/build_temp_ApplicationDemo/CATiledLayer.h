/*
 CATiledLayer.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// - init -
CATiledLayer *CATiledLayerInit( void );

// - visual fade -
CFTimeInterval CATiledLayerFadeDuration( void );

// - levels of detail -
NSUInteger CATiledLayerLevelsOfDetail( CATiledLayer *layer );
void CATiledLayerSetLevelsOfDetail( CATiledLayer *layer, NSUInteger levels );
NSUInteger CATiledLayerLevelsOfDetailBias( CATiledLayer *layer );
void CATiledLayerSetLevelsOfDetailBias( CATiledLayer *layer, NSUInteger levels );

// - tile size -
CGSize CATiledLayerTileSize( CATiledLayer *layer );
void CATiledLayerSetTileSize( CATiledLayer *layer, CGSize size );

