/*
 AppleEventDescriptor.M
 
 Bernie Wylde
 */

#import "AppleEventDescriptor.h"

// Class
Class AppleEventDescriptorClass( void )
{ return [NSAppleEventDescriptor class]; }

// Init
NSAppleEventDescriptor *AppleEventDescriptorWithEventClass( FourCharCode eventClass, FourCharCode eventID, NSAppleEventDescriptor *targetDescriptor, SInt16 returnID, SInt32 transactionID )
{ return [NSAppleEventDescriptor appleEventWithEventClass:eventClass eventID:eventID targetDescriptor:targetDescriptor returnID:returnID transactionID:transactionID]; }

NSAppleEventDescriptor *AppleEventDescriptorWithBoolean( BOOL flag )
{ return [NSAppleEventDescriptor descriptorWithBoolean:flag]; }

NSAppleEventDescriptor *AppleEventDescriptorWithBytes( DescType type, void *bytes, NSUInteger length )
{ return [NSAppleEventDescriptor descriptorWithDescriptorType:type bytes:bytes length:length]; }

NSAppleEventDescriptor *AppleEventDescriptorWithData( DescType type, CFDataRef dta )
{ return [NSAppleEventDescriptor descriptorWithDescriptorType:type data:(__bridge NSData *)dta]; }

NSAppleEventDescriptor *AppleEventDescriptorWithEnumCode( OSType enumerator )
{ return [NSAppleEventDescriptor descriptorWithEnumCode:enumerator]; }

NSAppleEventDescriptor *AppleEventDescriptorWithInt32( SInt32 value )
{ return [NSAppleEventDescriptor descriptorWithInt32:value]; }

NSAppleEventDescriptor *AppleEventDescriptorWithString( CFStringRef string )
{ return [NSAppleEventDescriptor descriptorWithString:(__bridge NSString *)string]; }

NSAppleEventDescriptor *AppleEventDescriptorWithTypeCode( OSType type )
{ return [NSAppleEventDescriptor descriptorWithTypeCode:type]; }

NSAppleEventDescriptor *AppleEventDescriptorListDescriptor( void )
{ return [NSAppleEventDescriptor listDescriptor]; }

NSAppleEventDescriptor *AppleEventDescriptorNullDescriptor( void )
{ return [NSAppleEventDescriptor nullDescriptor]; }

NSAppleEventDescriptor *AppleEventDescriptorRecordDescriptor( void )
{ return [NSAppleEventDescriptor recordDescriptor]; }

NSAppleEventDescriptor *AppleEventDescriptorWithAEDescNoCopy( const AEDesc *desc )
{
#if __has_feature(objc_arc)
    return [[NSAppleEventDescriptor alloc] initWithAEDescNoCopy:desc];
#else
    return [[[NSAppleEventDescriptor alloc] initWithAEDescNoCopy:desc] autorelease];
#endif
}

// Info
const AEDesc *AppleEventDescriptorAEDesc( NSAppleEventDescriptor *ref )
{ return [ref aeDesc]; }

BOOL AppleEventDescriptorBooleanValue( NSAppleEventDescriptor *ref )
{ return [ref booleanValue]; }

NSAppleEventDescriptor *AppleEventDescriptorCoerceToType( NSAppleEventDescriptor *ref, DescType type )
{ return [ref coerceToDescriptorType:type]; }

CFDataRef AppleEventDescriptorData( NSAppleEventDescriptor *ref )
{ return (__bridge CFDataRef)[ref data]; }

DescType AppleEventDescriptorType( NSAppleEventDescriptor *ref )
{ return [ref descriptorType]; }

OSType AppleEventDescriptorEnumCodeValue( NSAppleEventDescriptor *ref )
{ return [ref enumCodeValue]; }

SInt32 AppleEventDescriptorInt32Value( NSAppleEventDescriptor *ref )
{ return [ref int32Value]; }

NSInteger AppleEventDescriptorNumberOfItems( NSAppleEventDescriptor *ref )
{ return [ref numberOfItems]; }

CFStringRef AppleEventDescriptorStringValue( NSAppleEventDescriptor *ref )
{ return (__bridge CFStringRef)[ref stringValue]; }

OSType AppleEventDescriptorTypeCodeValue( NSAppleEventDescriptor *ref )
{ return [ref typeCodeValue]; }

// List descriptors
NSAppleEventDescriptor *AppleEventDescriptorDescriptorAtIndex( NSAppleEventDescriptor *ref, NSInteger index )
{ return [ref descriptorAtIndex:index]; }

void AppleEventDescriptorInsertDescriptorAtIndex( NSAppleEventDescriptor *ref, NSAppleEventDescriptor *ref2, NSInteger index )
{ [ref insertDescriptor:ref2 atIndex:index]; }

void AppleEventDescriptorRemoveDescriptorAtIndex( NSAppleEventDescriptor *ref, NSInteger index )
{ [ref removeDescriptorAtIndex:index]; }

// Record descriptors
NSAppleEventDescriptor *AppleEventDescriptorDescriptorForKeyword( NSAppleEventDescriptor *ref, FourCharCode keyword )
{ return [ref descriptorForKeyword:keyword]; }

FourCharCode AppleEventDescriptorKeywordForDescriptorAtIndex( NSAppleEventDescriptor *ref, NSInteger index )
{ return [ref keywordForDescriptorAtIndex:index]; }

void AppleEventDescriptorRemoveDescriptorWithKeyword( NSAppleEventDescriptor *ref, FourCharCode keyword )
{ [ref removeDescriptorWithKeyword:keyword]; }

void AppleEventDescriptorSetDescriptorForKeyword( NSAppleEventDescriptor *ref, NSAppleEventDescriptor *ref2, FourCharCode keyword )
{ [ref setDescriptor:ref2 forKeyword:keyword]; }

// Apple event descriptors
NSAppleEventDescriptor *AppleEventDescriptorAttributeDescriptorForKeyword( NSAppleEventDescriptor *ref, FourCharCode keyword )
{ return [ref attributeDescriptorForKeyword:keyword]; }

FourCharCode AppleEventDescriptorEventClass( NSAppleEventDescriptor *ref )
{ return [ref eventClass]; }

FourCharCode AppleEventDescriptorEventID( NSAppleEventDescriptor *ref )
{ return [ref eventID]; }

NSAppleEventDescriptor *AppleEventDescriptorParamDescriptorForKeyword( NSAppleEventDescriptor *ref, FourCharCode keyword )
{ return [ref paramDescriptorForKeyword:keyword]; }

void AppleEventDescriptorRemoveParamDescriptorWithKeyword( NSAppleEventDescriptor *ref, FourCharCode keyword )
{ [ref removeParamDescriptorWithKeyword:keyword]; }

SInt16 AppleEventDescriptorReturnID( NSAppleEventDescriptor *ref )
{ return [ref returnID]; }

void AppleEventDescriptorSetAttributeDescriptorForKeyword( NSAppleEventDescriptor *ref, NSAppleEventDescriptor *attrDescRef, FourCharCode keyword )
{ [ref setAttributeDescriptor:attrDescRef forKeyword:keyword]; }

void AppleEventDescriptorSetParamDescriptorForKeyword( NSAppleEventDescriptor *ref, NSAppleEventDescriptor *paramDescRef, FourCharCode keyword )
{ [ref setParamDescriptor:paramDescRef forKeyword:keyword]; }

SInt32 AppleEventDescriptorTransactionID( NSAppleEventDescriptor *ref )
{ return [ref transactionID]; }

// Initializers
NSAppleEventDescriptor *AppleEventDescriptorWithApplicationURL( CFURLRef url )
{ return [NSAppleEventDescriptor descriptorWithApplicationURL:(__bridge NSURL *)url]; }

NSAppleEventDescriptor *AppleEventDescriptorWithBundleIdentifier( CFStringRef identifier )
{ return [NSAppleEventDescriptor descriptorWithBundleIdentifier:(__bridge NSString *)identifier]; }

NSAppleEventDescriptor *AppleEventDescriptorWithDate( CFDateRef dt )
{ return [NSAppleEventDescriptor descriptorWithDate:(__bridge NSDate *)dt]; }

NSAppleEventDescriptor *AppleEventDescriptorWithDouble( double dbl )
{ return [NSAppleEventDescriptor descriptorWithDouble:dbl]; }

NSAppleEventDescriptor *AppleEventDescriptorWithFileURL( CFURLRef url )
{ return [NSAppleEventDescriptor descriptorWithFileURL:(__bridge NSURL *)url]; }

NSAppleEventDescriptor *AppleEventDescriptorWithProcessIdentifier( pid_t pid )
{ return [NSAppleEventDescriptor descriptorWithProcessIdentifier:pid]; }

// Instance properties
CFDateRef AppleEventDescriptorDateValue( NSAppleEventDescriptor *ref )
{ return (__bridge CFDateRef)[ref dateValue]; }

double AppleEventDescriptorDoubleValue( NSAppleEventDescriptor *ref )
{ return [ref doubleValue]; }

CFURLRef AppleEventDescriptorFileURLValue( NSAppleEventDescriptor *ref )
{ return (__bridge CFURLRef)[ref fileURLValue]; }

BOOL AppleEventDescriptorIsRecordDescriptor( NSAppleEventDescriptor *ref )
{ return [ref isRecordDescriptor]; }

// Instance methods
NSAppleEventDescriptor *AppleEventDescriptorSendEvent( NSAppleEventDescriptor *ref, NSAppleEventSendOptions options, CFTimeInterval timeout, NSError **err )
{ return [ref sendEventWithOptions:options timeout:timeout error:err]; }

// Type methods
NSAppleEventDescriptor *AppleEventDescriptorCurrentProcessDescriptor( void )
{ return [NSAppleEventDescriptor currentProcessDescriptor]; }
