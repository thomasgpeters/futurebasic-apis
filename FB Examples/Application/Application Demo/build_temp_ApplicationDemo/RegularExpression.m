/*
 RegularExpression.m

 Bernie Wylde
 */

#import "RegularExpression.h"

// Class
Class RegularExpressionClass( void )
{ return [NSRegularExpression class]; }

// Create
NSRegularExpression *RegularExpressionWithPattern( CFStringRef pattern, NSRegularExpressionOptions options, NSError **err )
{ return [NSRegularExpression regularExpressionWithPattern:(__bridge NSString *)pattern options:options error:err]; }

// Getting the regex and options
CFStringRef RegularExpressionPattern( NSRegularExpression *ref )
{ return (__bridge CFStringRef)[ref pattern]; }

NSRegularExpressionOptions RegularExpressionOptions( NSRegularExpression *ref )
{ return [ref options]; }

NSUInteger RegularExpressionNumberOfCaptureGroups( NSRegularExpression *ref )
{ return [ref numberOfCaptureGroups]; }

// Searching
NSUInteger RegularExpressionNumberOfMatches( NSRegularExpression *ref, CFStringRef string, NSMatchingOptions options, CFRange range )
{ return [ref numberOfMatchesInString:(__bridge NSString *)string options:options range:NSRangeFromCFRange(range)]; }

void RegularExpressionEnumerateMatches( NSRegularExpression *ref, CFStringRef string, NSMatchingOptions options, CFRange range, CUI_RegularExpressionCallbackType callback, void *userData )
{
    [ref enumerateMatchesInString:(__bridge NSString *)string options:options range:NSRangeFromCFRange(range) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        (*callback)(result,flags,stop,userData);
    }];
}

CFArrayRef RegularExpressionMatches( NSRegularExpression *ref, CFStringRef string, NSMatchingOptions options, CFRange range )
{ return (__bridge CFArrayRef)[ref matchesInString:(__bridge NSString *)string options:options range:NSRangeFromCFRange(range)]; }

NSTextCheckingResult *RegularExpressionFirstMatch( NSRegularExpression *ref, CFStringRef string, NSMatchingOptions options, CFRange range )
{ return [ref firstMatchInString:(__bridge NSString *)string options:options range:NSRangeFromCFRange(range)]; }

CFRange RegularExpressionRangeOfFirstMatch( NSRegularExpression *ref, CFStringRef string, NSMatchingOptions options, CFRange range )
{ return NSRangeToCFRange([ref rangeOfFirstMatchInString:(__bridge NSString *)string options:options range:NSRangeFromCFRange(range)]); }

// Replacing
NSUInteger RegularExpressionReplaceMatches( NSRegularExpression *ref, CFMutableStringRef string, NSMatchingOptions options, CFRange range, CFStringRef templ )
{ return [ref replaceMatchesInString:(__bridge NSMutableString *)string options:options range:NSRangeFromCFRange(range) withTemplate:(__bridge NSString *)templ]; }

CFStringRef RegularExpressionStringByReplacingMatches( NSRegularExpression *ref, CFStringRef string, NSMatchingOptions options, CFRange range, CFStringRef templ )
{ return (__bridge CFStringRef)[ref stringByReplacingMatchesInString:(__bridge NSString *)string options:options range:NSRangeFromCFRange(range) withTemplate:(__bridge NSString *)templ]; }

// Escaping
CFStringRef RegularExpressionEscapedTemplate( CFStringRef string )
{ return (__bridge CFStringRef)[NSRegularExpression escapedTemplateForString:(__bridge NSString *)string]; }

CFStringRef RegularExpressionEscapedPattern( CFStringRef string )
{ return (__bridge CFStringRef)[NSRegularExpression escapedPatternForString:(__bridge NSString *)string]; }

// Custom replace
CFStringRef RegularExpressionReplacementStringForResult( NSRegularExpression *ref, NSTextCheckingResult *result, CFStringRef string, NSInteger offset, CFStringRef templ )
{ return (__bridge CFStringRef)[ref replacementStringForResult:result inString:(__bridge NSString *)string offset:offset template:(__bridge NSString *)templ]; }



/*
 DataDetector.m
 */

// Create
NSDataDetector *DataDetectorWithTypes( NSTextCheckingTypes types, NSError **err )
{ return [NSDataDetector dataDetectorWithTypes:types error:err]; }

// Checking types
NSTextCheckingTypes DataDetectorCheckingTypes( NSDataDetector *ref )
{ return [ref checkingTypes]; }
