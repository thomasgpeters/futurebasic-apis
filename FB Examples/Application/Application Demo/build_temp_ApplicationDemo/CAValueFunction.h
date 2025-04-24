/*
  CAValueFunction.h

  Bernie Wylde 20180828
*/

#import "CocoaUI.h"

// Create
CAValueFunctionRef CAValueFunctionWithName( CFStringRef name );

// Properties
CFStringRef CAValueFunctionname( CAValueFunctionRef ref );// lowercase 'n' to avoid clash with var type
