/*
 AppleEventDescriptor.h
 
 Bernie Wylde
 */

#import "CocoaUI.h"

// Class
Class AppleEventDescriptorClass( void );

// Init
NSAppleEventDescriptor *AppleEventDescriptorWithEventClass( FourCharCode eventClass, FourCharCode eventID, NSAppleEventDescriptor *targetDescriptor, SInt16 returnID, SInt32 transactionID );
NSAppleEventDescriptor *AppleEventDescriptorWithBoolean( BOOL flag );
NSAppleEventDescriptor *AppleEventDescriptorWithBytes( DescType type, void *bytes, NSUInteger length );
NSAppleEventDescriptor *AppleEventDescriptorWithData( DescType type, CFDataRef dta );
NSAppleEventDescriptor *AppleEventDescriptorWithEnumCode( OSType enumerator );
NSAppleEventDescriptor *AppleEventDescriptorWithInt32( SInt32 value );
NSAppleEventDescriptor *AppleEventDescriptorWithString( CFStringRef string );
NSAppleEventDescriptor *AppleEventDescriptorWithTypeCode( OSType type );
NSAppleEventDescriptor *AppleEventDescriptorListDescriptor( void );
NSAppleEventDescriptor *AppleEventDescriptorNullDescriptor( void );
NSAppleEventDescriptor *AppleEventDescriptorRecordDescriptor( void );
NSAppleEventDescriptor *AppleEventDescriptorWithAEDescNoCopy( const AEDesc *desc );

// Info
const AEDesc *AppleEventDescriptorAEDesc( NSAppleEventDescriptor *ref );
BOOL AppleEventDescriptorBooleanValue( NSAppleEventDescriptor *ref );
NSAppleEventDescriptor *AppleEventDescriptorCoerceToType( NSAppleEventDescriptor *ref, DescType type );
CFDataRef AppleEventDescriptorData( NSAppleEventDescriptor *ref );
DescType AppleEventDescriptorType( NSAppleEventDescriptor *ref );
OSType AppleEventDescriptorEnumCodeValue( NSAppleEventDescriptor *ref );
SInt32 AppleEventDescriptorInt32Value( NSAppleEventDescriptor *ref );
NSInteger AppleEventDescriptorNumberOfItems( NSAppleEventDescriptor *ref );
CFStringRef AppleEventDescriptorStringValue( NSAppleEventDescriptor *ref );
OSType AppleEventDescriptorTypeCodeValue( NSAppleEventDescriptor *ref );

// List descriptors
NSAppleEventDescriptor *AppleEventDescriptorDescriptorAtIndex( NSAppleEventDescriptor *ref, NSInteger index );
void AppleEventDescriptorInsertDescriptorAtIndex( NSAppleEventDescriptor *ref, NSAppleEventDescriptor *ref2, NSInteger index );
void AppleEventDescriptorRemoveDescriptorAtIndex( NSAppleEventDescriptor *ref, NSInteger index );

// Record descriptors
NSAppleEventDescriptor *AppleEventDescriptorDescriptorForKeyword( NSAppleEventDescriptor *ref, FourCharCode keyword );
FourCharCode AppleEventDescriptorKeywordForDescriptorAtIndex( NSAppleEventDescriptor *ref, NSInteger index );
void AppleEventDescriptorRemoveDescriptorWithKeyword( NSAppleEventDescriptor *ref, FourCharCode keyword );
void AppleEventDescriptorSetDescriptorForKeyword( NSAppleEventDescriptor *ref, NSAppleEventDescriptor *ref2, FourCharCode keyword );

// Apple event descriptors
NSAppleEventDescriptor *AppleEventDescriptorAttributeDescriptorForKeyword( NSAppleEventDescriptor *ref, FourCharCode keyword );
FourCharCode AppleEventDescriptorEventClass( NSAppleEventDescriptor *ref );
FourCharCode AppleEventDescriptorEventID( NSAppleEventDescriptor *ref );
NSAppleEventDescriptor *AppleEventDescriptorParamDescriptorForKeyword( NSAppleEventDescriptor *ref, FourCharCode keyword );
void AppleEventDescriptorRemoveParamDescriptorWithKeyword( NSAppleEventDescriptor *ref, FourCharCode keyword );
SInt16 AppleEventDescriptorReturnID( NSAppleEventDescriptor *ref );
void AppleEventDescriptorSetAttributeDescriptorForKeyword( NSAppleEventDescriptor *ref, NSAppleEventDescriptor *attrDescRef, FourCharCode keyword );
void AppleEventDescriptorSetParamDescriptorForKeyword( NSAppleEventDescriptor *ref, NSAppleEventDescriptor *paramDescRef, FourCharCode keyword );
SInt32 AppleEventDescriptorTransactionID( NSAppleEventDescriptor *ref );

// Initializers
NSAppleEventDescriptor *AppleEventDescriptorWithApplicationURL( CFURLRef url );
NSAppleEventDescriptor *AppleEventDescriptorWithBundleIdentifier( CFStringRef identifier );
NSAppleEventDescriptor *AppleEventDescriptorWithDate( CFDateRef dt );
NSAppleEventDescriptor *AppleEventDescriptorWithDouble( double dbl );
NSAppleEventDescriptor *AppleEventDescriptorWithFileURL( CFURLRef url );
NSAppleEventDescriptor *AppleEventDescriptorWithProcessIdentifier( pid_t pid );

// Instance properties
CFDateRef AppleEventDescriptorDateValue( NSAppleEventDescriptor *ref );
double AppleEventDescriptorDoubleValue( NSAppleEventDescriptor *ref );
CFURLRef AppleEventDescriptorFileURLValue( NSAppleEventDescriptor *ref );
BOOL AppleEventDescriptorIsRecordDescriptor( NSAppleEventDescriptor *ref );

// Instance methods
NSAppleEventDescriptor *AppleEventDescriptorSendEvent( NSAppleEventDescriptor *ref, NSAppleEventSendOptions options, CFTimeInterval timeout, NSError **err );

// Type methods
NSAppleEventDescriptor *AppleEventDescriptorCurrentProcessDescriptor( void );
