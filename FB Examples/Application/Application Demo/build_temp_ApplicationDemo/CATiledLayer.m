/*
 CATiledLayer.m

 Bernie Wylde
 */

#import "CATiledLayer.h"

// - init -
CATiledLayer *CATiledLayerInit( void )
{ return [CATiledLayer layer]; }

// - visual fade -
CFTimeInterval CATiledLayerFadeDuration( void )
{ return [CATiledLayer fadeDuration]; }

// - levels of detail -
NSUInteger CATiledLayerLevelsOfDetail( CATiledLayer *layer )
{ return [layer levelsOfDetail]; }

void CATiledLayerSetLevelsOfDetail( CATiledLayer *layer, NSUInteger levels )
{ [layer setLevelsOfDetail:levels]; }

NSUInteger CATiledLayerLevelsOfDetailBias( CATiledLayer *layer )
{ return [layer levelsOfDetailBias]; }

void CATiledLayerSetLevelsOfDetailBias( CATiledLayer *layer, NSUInteger levels )
{ [layer setLevelsOfDetailBias:levels]; }

// - tile size -
CGSize CATiledLayerTileSize( CATiledLayer *layer )
{ return [layer tileSize]; }

void CATiledLayerSetTileSize( CATiledLayer *layer, CGSize size )
{ [layer setTileSize:size]; }

