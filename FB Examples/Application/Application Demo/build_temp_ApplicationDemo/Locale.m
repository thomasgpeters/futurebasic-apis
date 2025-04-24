/*
 Locale.m

 Bernie Wylde
 */

#import "Locale.h"

// Class
Class LocaleClass( void )
{ return [NSLocale class]; }

// Init
CFLocaleRef LocaleWithIdentifier( CFStringRef identifier )
{
#if __has_feature(objc_arc)
    return (__bridge CFLocaleRef)[[NSLocale alloc] initWithLocaleIdentifier:(__bridge NSString *)identifier];
#else
    return (__bridge CFLocaleRef)[[[NSLocale alloc] initWithLocaleIdentifier:(__bridge NSString *)identifier] autorelease];
#endif
}

// User's locale
CFLocaleRef LocaleAutoupdatingCurrent( void )
{ return (__bridge CFLocaleRef)[NSLocale autoupdatingCurrentLocale]; }

CFLocaleRef LocaleCurrent( void )
{ return (__bridge CFLocaleRef)[NSLocale currentLocale]; }

CFLocaleRef LocaleSystem( void )
{ return (__bridge CFLocaleRef)[NSLocale systemLocale]; }

// Known identifiers and codes
CFArrayRef LocaleAvailableIdentifiers( void )
{ return (__bridge CFArrayRef)[NSLocale availableLocaleIdentifiers]; }

CFArrayRef LocaleISOCountryCodes( void )
{ return (__bridge CFArrayRef)[NSLocale ISOCountryCodes]; }

CFArrayRef LocaleISOLanguageCodes( void )
{ return (__bridge CFArrayRef)[NSLocale ISOLanguageCodes]; }

CFArrayRef LocaleISOCurrencyCodes( void )
{ return (__bridge CFArrayRef)[NSLocale ISOCurrencyCodes]; }

CFArrayRef LocaleCommonISOCurrencyCodes( void )
{ return (__bridge CFArrayRef)[NSLocale commonISOCurrencyCodes]; }

// Converting between identifiers
CFStringRef LocaleCanonicalIdentifierFromString( CFStringRef string )
{ return (__bridge CFStringRef)[NSLocale canonicalLocaleIdentifierFromString:(__bridge NSString *)string]; }

CFDictionaryRef LocaleComponentsFromIdentifier( CFStringRef identifier )
{ return (__bridge CFDictionaryRef)[NSLocale componentsFromLocaleIdentifier:(__bridge NSString *)identifier]; }

CFStringRef LocaleIdentifierFromComponents( CFDictionaryRef components )
{ return (__bridge CFStringRef)[NSLocale localeIdentifierFromComponents:(__bridge NSDictionary *)components]; }

CFStringRef LocaleCanonicalLanguageIdentifierFromString( CFStringRef string )
{ return (__bridge CFStringRef)[NSLocale canonicalLanguageIdentifierFromString:(__bridge NSString *)string]; }

CFStringRef LocaleIdentifierFromWindowsLocaleCode( UInt32 lcid )
{ return (__bridge CFStringRef)[NSLocale localeIdentifierFromWindowsLocaleCode:lcid]; }

UInt32 LocaleWindowsLocaleCodeFromIdentifier( CFStringRef identifier )
{ return [NSLocale windowsLocaleCodeFromLocaleIdentifier:(__bridge NSString *)identifier]; }

// Locale info
CFStringRef LocaleIdentifier( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref localeIdentifier]; }

CFStringRef LocaleCountryCode( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref countryCode]; }

CFStringRef LocaleLanguageCode( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref languageCode]; }

CFStringRef LocaleScriptCode( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref scriptCode]; }

CFStringRef LocaleVariantCode( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref variantCode]; }

CFCharacterSetRef LocaleExemplarCharacterSet( CFLocaleRef ref )
{ return (__bridge CFCharacterSetRef)[(__bridge NSLocale *)ref exemplarCharacterSet]; }

CFStringRef LocaleCollationIdentifier( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref collationIdentifier]; }

CFStringRef LocaleCollatorIdentifier( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref collatorIdentifier]; }

BOOL LocaleUsesMetricSystem( CFLocaleRef ref )
{ return [(__bridge NSLocale *)ref usesMetricSystem]; }

CFStringRef LocaleDecimalSeparator( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref decimalSeparator]; }

CFStringRef LocaleGroupingSeparator( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref groupingSeparator]; }

CFStringRef LocaleCurrencyCode( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref currencyCode]; }

CFStringRef LocaleCurrencySymbol( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref currencySymbol]; }

CFStringRef LocaleCalendarIdentifier( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref calendarIdentifier]; }

CFStringRef LocaleQuotationBeginDelimiter( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref quotationBeginDelimiter]; }

CFStringRef LocaleQuotationEndDelimiter( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref quotationEndDelimiter]; }

CFStringRef LocaleAlternateQuotationBeginDelimiter( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref alternateQuotationBeginDelimiter]; }

CFStringRef LocaleAlternateQuotationEndDelimiter( CFLocaleRef ref )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref alternateQuotationEndDelimiter]; }

// Display info
CFStringRef LocaleLocalizedStringForIdentifier( CFLocaleRef ref, CFStringRef identifier )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref localizedStringForLocaleIdentifier:(__bridge NSString *)identifier]; }

CFStringRef LocaleLocalizedStringForCountryCode( CFLocaleRef ref, CFStringRef code )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref localizedStringForCountryCode:(__bridge NSString *)code]; }

CFStringRef LocaleLocalizedStringForLanguageCode( CFLocaleRef ref, CFStringRef code )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref localizedStringForLanguageCode:(__bridge NSString *)code]; }

CFStringRef LocaleLocalizedStringForScriptCode( CFLocaleRef ref, CFStringRef code )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref localizedStringForScriptCode:(__bridge NSString *)code]; }

CFStringRef LocaleLocalizedStringForVariantCode( CFLocaleRef ref, CFStringRef code )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref localizedStringForVariantCode:(__bridge NSString *)code]; }

CFStringRef LocaleLocalizedStringForCollationIdentifier( CFLocaleRef ref, CFStringRef identifier )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref localizedStringForCollationIdentifier:(__bridge NSString *)identifier]; }

CFStringRef LocaleLocalizedStringForCollatorIdentifier( CFLocaleRef ref, CFStringRef identifier )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref localizedStringForCollatorIdentifier:(__bridge NSString *)identifier]; }

CFStringRef LocaleLocalizedStringForCurrencyCode( CFLocaleRef ref, CFStringRef code )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref localizedStringForCurrencyCode:(__bridge NSString *)code]; }

CFStringRef LocaleLocalizedStringForCalendarIdentifier( CFLocaleRef ref, CFStringRef identifier )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref localizedStringForCalendarIdentifier:(__bridge NSString *)identifier]; }

// Info by key
CFTypeRef LocaleObjectForKey( CFLocaleRef ref, CFStringRef key )
{ return (__bridge CFTypeRef)[(__bridge NSLocale *)ref objectForKey:(__bridge NSString *)key]; }

CFStringRef LocaleDisplayNameForKey( CFLocaleRef ref, CFStringRef key, CFTypeRef value )
{ return (__bridge CFStringRef)[(__bridge NSLocale *)ref displayNameForKey:(__bridge NSString *)key value:(__bridge id)value]; }

// Preferred languages
CFArrayRef LocalePreferredLanguages( void )
{ return (__bridge CFArrayRef)[NSLocale preferredLanguages]; }

// Line and character direction
NSLocaleLanguageDirection LocaleCharacterDirectionForLanguage( CFStringRef isoLangCode )
{ return [NSLocale characterDirectionForLanguage:(__bridge NSString *)isoLangCode]; }

NSLocaleLanguageDirection LocaleLineDirectionForLanguage( CFStringRef isoLangCode )
{ return [NSLocale lineDirectionForLanguage:(__bridge NSString *)isoLangCode]; }

