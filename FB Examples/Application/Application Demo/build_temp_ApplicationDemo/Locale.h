/*
 Locale.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class LocaleClass( void );

// Init
CFLocaleRef LocaleWithIdentifier( CFStringRef identifier );

// User's locale
CFLocaleRef LocaleAutoupdatingCurrent( void );
CFLocaleRef LocaleCurrent( void );
CFLocaleRef LocaleSystem( void );

// Known identifiers and codes
CFArrayRef LocaleAvailableIdentifiers( void );
CFArrayRef LocaleISOCountryCodes( void );
CFArrayRef LocaleISOLanguageCodes( void );
CFArrayRef LocaleISOCurrencyCodes( void );
CFArrayRef LocaleCommonISOCurrencyCodes( void );

// Converting between identifiers
CFStringRef LocaleCanonicalIdentifierFromString( CFStringRef string );
CFDictionaryRef LocaleComponentsFromIdentifier( CFStringRef identifier );
CFStringRef LocaleIdentifierFromComponents( CFDictionaryRef components );
CFStringRef LocaleCanonicalLanguageIdentifierFromString( CFStringRef string );
CFStringRef LocaleIdentifierFromWindowsLocaleCode( UInt32 lcid );
UInt32 LocaleWindowsLocaleCodeFromIdentifier( CFStringRef identifier );

// Locale info
CFStringRef LocaleIdentifier( CFLocaleRef ref );
CFStringRef LocaleCountryCode( CFLocaleRef ref );
CFStringRef LocaleLanguageCode( CFLocaleRef ref );
CFStringRef LocaleScriptCode( CFLocaleRef ref );
CFStringRef LocaleVariantCode( CFLocaleRef ref );
CFCharacterSetRef LocaleExemplarCharacterSet( CFLocaleRef ref );
CFStringRef LocaleCollationIdentifier( CFLocaleRef ref );
CFStringRef LocaleCollatorIdentifier( CFLocaleRef ref );
BOOL LocaleUsesMetricSystem( CFLocaleRef ref );
CFStringRef LocaleDecimalSeparator( CFLocaleRef ref );
CFStringRef LocaleGroupingSeparator( CFLocaleRef ref );
CFStringRef LocaleCurrencyCode( CFLocaleRef ref );
CFStringRef LocaleCurrencySymbol( CFLocaleRef ref );
CFStringRef LocaleCalendarIdentifier( CFLocaleRef ref );
CFStringRef LocaleQuotationBeginDelimiter( CFLocaleRef ref );
CFStringRef LocaleQuotationEndDelimiter( CFLocaleRef ref );
CFStringRef LocaleAlternateQuotationBeginDelimiter( CFLocaleRef ref );
CFStringRef LocaleAlternateQuotationEndDelimiter( CFLocaleRef ref );

// Display info
CFStringRef LocaleLocalizedStringForIdentifier( CFLocaleRef ref, CFStringRef identifier );
CFStringRef LocaleLocalizedStringForCountryCode( CFLocaleRef ref, CFStringRef code );
CFStringRef LocaleLocalizedStringForLanguageCode( CFLocaleRef ref, CFStringRef code );
CFStringRef LocaleLocalizedStringForScriptCode( CFLocaleRef ref, CFStringRef code );
CFStringRef LocaleLocalizedStringForVariantCode( CFLocaleRef ref, CFStringRef code );
CFStringRef LocaleLocalizedStringForCollationIdentifier( CFLocaleRef ref, CFStringRef identifier );
CFStringRef LocaleLocalizedStringForCollatorIdentifier( CFLocaleRef ref, CFStringRef identifier );
CFStringRef LocaleLocalizedStringForCurrencyCode( CFLocaleRef ref, CFStringRef code );
CFStringRef LocaleLocalizedStringForCalendarIdentifier( CFLocaleRef ref, CFStringRef identifier );

// Info by key
CFTypeRef LocaleObjectForKey( CFLocaleRef ref, CFStringRef key );
CFStringRef LocaleDisplayNameForKey( CFLocaleRef ref, CFStringRef key, CFTypeRef value );

// Preferred languages
CFArrayRef LocalePreferredLanguages( void );

// Line and character direction
NSLocaleLanguageDirection LocaleCharacterDirectionForLanguage( CFStringRef isoLangCode );
NSLocaleLanguageDirection LocaleLineDirectionForLanguage( CFStringRef isoLangCode );
