/*
 IndexPath.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class IndexPathClass( void );

// - create -
NSIndexPath *IndexPathWithIndex( NSUInteger value );
NSIndexPath *IndexPathWithIndexes( NSUInteger *indexes, NSUInteger length );

// - special node names -
NSIndexPath *IndexPathForItemInSection( NSInteger item, NSInteger section );
NSInteger IndexPathSection( NSIndexPath *ref );
NSInteger IndexPathItem( NSIndexPath *ref );

// - counting nodes -
NSUInteger IndexPathLength( NSIndexPath *ref );

// - adding and removing nodes -
NSIndexPath *IndexPathByAddingIndex( NSIndexPath *ref, NSUInteger index );
NSIndexPath *IndexPathByRemovingLastIndex( NSIndexPath *ref );

// - compare -
NSComparisonResult IndexPathCompare( NSIndexPath *path1, NSIndexPath *path2 );

// - working with indexes -
NSUInteger IndexPathIndexAtPosition( NSIndexPath *ref, NSUInteger position );

void IndexPathGetIndexes( NSIndexPath *ref, NSUInteger *indexes, CFRange range );

