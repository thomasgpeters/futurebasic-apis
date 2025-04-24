/*
 InflectionRule.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000

#pragma mark - InflectionRule

// Automatic inflection
API_AVAILABLE(macos(12.0))
NSInflectionRule *InflectionRuleAutomaticRule( void );

// Availability
API_AVAILABLE(macos(12.0))
BOOL InflectionRuleCanInflectLanguage( CFStringRef language );
API_AVAILABLE(macos(12.0))
BOOL InflectionRuleCanInflectPreferredLocalization( void );


#pragma mark - InflectionRuleExplicit

// Create
API_AVAILABLE(macos(12.0))
NSInflectionRuleExplicit *InflectionRuleExplicitWithMorphology( NSMorphology *morphology );

// Properties
API_AVAILABLE(macos(12.0))
NSMorphology *InflectionRuleExplicitMorphology( NSInflectionRuleExplicit *ref );

#endif// 120000

