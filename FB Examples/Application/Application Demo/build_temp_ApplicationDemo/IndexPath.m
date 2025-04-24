/*
 IndexPath.m

 Bernie Wylde
 */

#import "IndexPath.h"

// Class
Class IndexPathClass( void )
{ return [NSIndexPath class]; }

// - create -
NSIndexPath *IndexPathWithIndex( NSUInteger value )
{ return [NSIndexPath indexPathWithIndex:value]; }

NSIndexPath *IndexPathWithIndexes( NSUInteger *indexes, NSUInteger length )
{ return [NSIndexPath indexPathWithIndexes:indexes length:length]; }

// - special node names -
NSIndexPath *IndexPathForItemInSection( NSInteger item, NSInteger section )
{ return [NSIndexPath indexPathForItem:item inSection:section]; }

NSInteger IndexPathSection( NSIndexPath *ref )
{ return [ref section]; }

NSInteger IndexPathItem( NSIndexPath *ref )
{ return [ref item]; }

// - counting nodes -
NSUInteger IndexPathLength( NSIndexPath *ref )
{ return [ref length]; }

// - adding and removing nodes -
NSIndexPath *IndexPathByAddingIndex( NSIndexPath *ref, NSUInteger index )
{ return [ref indexPathByAddingIndex:index]; }

NSIndexPath *IndexPathByRemovingLastIndex( NSIndexPath *ref )
{ return [ref indexPathByRemovingLastIndex]; }

// - compare -
NSComparisonResult IndexPathCompare( NSIndexPath *path1, NSIndexPath *path2 )
{ return [path1 compare:path2]; }

// - working with indexes -
NSUInteger IndexPathIndexAtPosition( NSIndexPath *ref, NSUInteger position )
{ return [ref indexAtPosition:position]; }

void IndexPathGetIndexes( NSIndexPath *ref, NSUInteger *indexes, CFRange range )
{ [ref getIndexes:indexes range:NSRangeFromCFRange(range)]; }

