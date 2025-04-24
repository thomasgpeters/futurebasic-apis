/*
 SortDescriptor.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class SortDescriptorClass( void );

// - init -
NSSortDescriptor *SortDescriptorWithKey( CFStringRef key, BOOL ascending );
NSSortDescriptor *SortDescriptorWithKeyAndSelector( CFStringRef key, BOOL ascending, CFStringRef selector );

// - info -
BOOL SortDescriptorAscending( NSSortDescriptor *ref );
CFStringRef SortDescriptorKey( NSSortDescriptor *ref );

// - using -
NSComparisonResult SortDescriptorCompare( NSSortDescriptor *ref, CFTypeRef obj1, CFTypeRef obj2 );
NSSortDescriptor *SortDescriptorReversedSortDescriptor( NSSortDescriptor *ref );

void SortDescriptorAllowEvaluation( NSSortDescriptor *ref );

