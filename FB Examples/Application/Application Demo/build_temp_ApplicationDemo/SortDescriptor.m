/*
 SortDescriptor.m

 Bernie Wylde
 */

#import "SortDescriptor.h"

// Class
Class SortDescriptorClass( void )
{ return [NSSortDescriptor class]; }

// - init -
NSSortDescriptor *SortDescriptorWithKey( CFStringRef key, BOOL ascending )
{ return [NSSortDescriptor sortDescriptorWithKey:(__bridge NSString *)key ascending:ascending]; }

NSSortDescriptor *SortDescriptorWithKeyAndSelector( CFStringRef key, BOOL ascending, CFStringRef selector )
{ return [NSSortDescriptor sortDescriptorWithKey:(__bridge NSString *)key ascending:ascending selector:NSSelectorFromString((__bridge NSString *)selector)]; }

// - info -
BOOL SortDescriptorAscending( NSSortDescriptor *ref )
{ return [ref ascending]; }

CFStringRef SortDescriptorKey( NSSortDescriptor *ref )
{ return (__bridge CFStringRef)[ref key]; }

// - using -
NSComparisonResult SortDescriptorCompare( NSSortDescriptor *ref, CFTypeRef obj1, CFTypeRef obj2 )
{ return [ref compareObject:(__bridge id)obj1 toObject:(__bridge id)obj2]; }

NSSortDescriptor *SortDescriptorReversedSortDescriptor( NSSortDescriptor *ref )
{ return [ref reversedSortDescriptor]; }

void SortDescriptorAllowEvaluation( NSSortDescriptor *ref )
{ [ref allowEvaluation]; }

