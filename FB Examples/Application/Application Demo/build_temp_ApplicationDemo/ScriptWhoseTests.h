/*
 ScriptWhoseTests.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#pragma mark - ScriptWhoseTest
// Create
NSScriptWhoseTest *ScriptWhoseTestInit( void );

// Evaluate
BOOL ScriptWhoseTestIsTrue( NSScriptWhoseTest *ref );


#pragma mark - LogicalTest
// Create
NSLogicalTest *LogicalTestAndWithTests( CFArrayRef subTests );
NSLogicalTest *LogicalTestNotWithTest( NSScriptWhoseTest *test );
NSLogicalTest *LogicalTestOrWithTests( CFArrayRef subTests );



#pragma mark - SpecifierTest
// Create
NSSpecifierTest *SpecifierTestWithObjectSpecifier( NSScriptObjectSpecifier *obj1, NSTestComparisonOperation compOp, id obj2 );


#pragma mark - Object (NSComparisonMethods)



#pragma mark - Object (NSScriptingComparisonMethods)

