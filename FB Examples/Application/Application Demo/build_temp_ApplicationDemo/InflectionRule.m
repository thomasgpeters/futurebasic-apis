/*
 InflectionRule.m

 Bernie Wylde
 */

#import "InflectionRule.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000

#pragma mark - InflectionRule

// Automatic inflection
NSInflectionRule *InflectionRuleAutomaticRule( void )
{ return [NSInflectionRule automaticRule]; }

// Availability
BOOL InflectionRuleCanInflectLanguage( CFStringRef language )
{ return [NSInflectionRule canInflectLanguage:(__bridge NSString *)language]; }

BOOL InflectionRuleCanInflectPreferredLocalization( void )
{ return [NSInflectionRule canInflectPreferredLocalization]; }


#pragma mark - InflectionRuleExplicit

// Create
NSInflectionRuleExplicit *InflectionRuleExplicitWithMorphology( NSMorphology *morphology )
{
#if __has_feature(objc_arc)
    return [[NSInflectionRuleExplicit alloc] initWithMorphology:morphology];
#else
    return [[[NSInflectionRuleExplicit alloc] initWithMorphology:morphology] autorelease];
#endif
}

// Properties
NSMorphology *InflectionRuleExplicitMorphology( NSInflectionRuleExplicit *ref )
{ return [ref morphology]; }

#endif// 120000
