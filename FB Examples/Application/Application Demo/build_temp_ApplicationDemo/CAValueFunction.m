/*
  CAValueFunction.m

  Bernie Wylde 20180828
*/

#import "CAValueFunction.h"

// Create
CAValueFunctionRef CAValueFunctionWithName( CFStringRef name )
{ return [CAValueFunction functionWithName:(__bridge NSString *)name]; }

CFStringRef CAValueFunctionname( CAValueFunctionRef ref )// lowercase 'n' to avoid clash with var type
{ return (__bridge CFStringRef)[ref name]; }

