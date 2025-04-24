/*
 LocalizedNumberFormatRule.m

 Bernie Wylde
 */

#import "LocalizedNumberFormatRule.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000

// Type methods
NSLocalizedNumberFormatRule *LocalizedNumberFormatRuleAutomatic( void )
{ return [NSLocalizedNumberFormatRule automatic]; }

#endif // 150000
