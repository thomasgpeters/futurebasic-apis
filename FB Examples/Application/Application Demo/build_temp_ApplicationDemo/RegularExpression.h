/*
 RegularExpression.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_RegularExpressionCallbackType)(NSTextCheckingResult *,NSMatchingFlags,BOOL*,void*);

// Class
Class RegularExpressionClass( void );

// Create
NSRegularExpression *RegularExpressionWithPattern( CFStringRef pattern, NSRegularExpressionOptions options, NSError **err );

// Getting the regex and options
CFStringRef RegularExpressionPattern( NSRegularExpression *ref );
NSRegularExpressionOptions RegularExpressionOptions( NSRegularExpression *ref );
NSUInteger RegularExpressionNumberOfCaptureGroups( NSRegularExpression *ref );

// Searching
NSUInteger RegularExpressionNumberOfMatches( NSRegularExpression *ref, CFStringRef string, NSMatchingOptions options, CFRange range );
void RegularExpressionEnumerateMatches( NSRegularExpression *ref, CFStringRef string, NSMatchingOptions options, CFRange range, CUI_RegularExpressionCallbackType callback, void *userData );
CFArrayRef RegularExpressionMatches( NSRegularExpression *ref, CFStringRef string, NSMatchingOptions options, CFRange range );
NSTextCheckingResult *RegularExpressionFirstMatch( NSRegularExpression *ref, CFStringRef string, NSMatchingOptions options, CFRange range );
CFRange RegularExpressionRangeOfFirstMatch( NSRegularExpression *ref, CFStringRef string, NSMatchingOptions options, CFRange range );

// Replacing
NSUInteger RegularExpressionReplaceMatches( NSRegularExpression *ref, CFMutableStringRef string, NSMatchingOptions options, CFRange range, CFStringRef templ );
CFStringRef RegularExpressionStringByReplacingMatches( NSRegularExpression *ref, CFStringRef string, NSMatchingOptions options, CFRange range, CFStringRef templ );

// Escaping
CFStringRef RegularExpressionEscapedTemplate( CFStringRef string );
CFStringRef RegularExpressionEscapedPattern( CFStringRef string );

// Custom replace
CFStringRef RegularExpressionReplacementStringForResult( NSRegularExpression *ref, NSTextCheckingResult *result, CFStringRef string, NSInteger offset, CFStringRef templ );



/*
 DataDetector.h
 */

// Create
NSDataDetector *DataDetectorWithTypes( NSTextCheckingTypes types, NSError **err );

// Checking types
NSTextCheckingTypes DataDetectorCheckingTypes( NSDataDetector *ref );
