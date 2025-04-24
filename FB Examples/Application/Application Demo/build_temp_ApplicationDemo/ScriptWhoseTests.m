/*
 ScriptWhoseTests.m

 Bernie Wylde
 */

#import "ScriptWhoseTests.h"


#pragma mark - ScriptWhoseTest
// Create
NSScriptWhoseTest *ScriptWhoseTestInit( void )
{
#if __has_feature(objc_arc)
    return [[NSScriptWhoseTest alloc] init];
#else
    return [[[NSScriptWhoseTest alloc] init] autorelease];
#endif
}

// Evaluate
BOOL ScriptWhoseTestIsTrue( NSScriptWhoseTest *ref )
{ return [ref isTrue]; }


#pragma mark - LogicalTest
// Create
NSLogicalTest *LogicalTestAndWithTests( CFArrayRef subTests )
{
#if __has_feature(objc_arc)
    return [[NSLogicalTest alloc] initAndTestWithTests:(__bridge NSArray *)subTests];
#else
    return [[[NSLogicalTest alloc] initAndTestWithTests:(__bridge NSArray *)subTests] autorelease];
#endif
}

NSLogicalTest *LogicalTestNotWithTest( NSScriptWhoseTest *test )
{
#if __has_feature(objc_arc)
    return [[NSLogicalTest alloc] initNotTestWithTest:test];
#else
    return [[[NSLogicalTest alloc] initNotTestWithTest:test] autorelease];
#endif
}

NSLogicalTest *LogicalTestOrWithTests( CFArrayRef subTests )
{
#if __has_feature(objc_arc)
    return [[NSLogicalTest alloc] initOrTestWithTests:(__bridge NSArray *)subTests];
#else
    return [[[NSLogicalTest alloc] initOrTestWithTests:(__bridge NSArray *)subTests] autorelease];
#endif
}




#pragma mark - SpecifierTest
// Create
NSSpecifierTest *SpecifierTestWithObjectSpecifier( NSScriptObjectSpecifier *obj1, NSTestComparisonOperation compOp, id obj2 )
{
#if __has_feature(objc_arc)
    return [[NSSpecifierTest alloc] initWithObjectSpecifier:obj1 comparisonOperator: compOp testObject:obj2];
#else
    return [[[NSSpecifierTest alloc] initWithObjectSpecifier:obj1 comparisonOperator: compOp testObject:obj2] autorelease];
#endif
}



#pragma mark - Object (NSComparisonMethods)



#pragma mark - Object (NSScriptingComparisonMethods)


