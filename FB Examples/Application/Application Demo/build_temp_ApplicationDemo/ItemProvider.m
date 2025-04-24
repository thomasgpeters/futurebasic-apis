/*
 ItemProvider.m

 Bernie Wylde
 */

#import "ItemProvider.h"


// Class
Class ItemProviderClass( void )
{ return [NSItemProvider class]; }

// Create
NSItemProvider *ItemProviderWithContentsOfURL( CFURLRef url )
{
#if __has_feature(objc_arc)
    return [[NSItemProvider alloc] initWithContentsOfURL:(__bridge NSURL *)url];
#else
    return [[[NSItemProvider alloc] initWithContentsOfURL:(__bridge NSURL *)url] autorelease];
#endif
}

NSItemProvider *ItemProviderWithItem( id<NSSecureCoding> item, CFStringRef identifier )
{
#if __has_feature(objc_arc)
    return [[NSItemProvider alloc] initWithItem:item typeIdentifier:(__bridge NSString *)identifier];
#else
    return [[[NSItemProvider alloc] initWithItem:item typeIdentifier:(__bridge NSString *)identifier] autorelease];
#endif
}

NSItemProvider *ItemProviderWithObject( CFTypeRef obj )
{
#if __has_feature(objc_arc)
    return [[NSItemProvider alloc] initWithObject:(__bridge id<NSItemProviderWriting>)obj];
#else
    return [[[NSItemProvider alloc] initWithObject:(__bridge id<NSItemProviderWriting>)obj] autorelease];
#endif
}

// Get data
BOOL ItemProviderCanLoadObjectOfClass( NSItemProvider *ref, Class class )
{ return [ref canLoadObjectOfClass:class]; }

BOOL ItemProviderHasItemConformingToTypeIdentifier( NSItemProvider *ref, CFStringRef identifier )
{ return [ref hasItemConformingToTypeIdentifier:(__bridge NSString *)identifier]; }

void ItemProviderLoadItemForTypeIdentifier( NSItemProvider *ref, CFStringRef identifier, CFDictionaryRef options, CUI_ItemProviderLoadItemCompletionHandler handler, void *userData )
{
    [ref loadItemForTypeIdentifier:(__bridge NSString *)identifier options:(__bridge NSDictionary *)options completionHandler:^(id<NSSecureCoding> item, NSError *error) {
        (*handler)(ref,item,error,userData);
    }];
}

NSProgress *ItemProviderLoadDataRepresentationForTypeIdentifier( NSItemProvider *ref, CFStringRef identifier, CUI_ItemProviderLoadDataCompletionHandler handler, void *userData )
{
    return [ref loadDataRepresentationForTypeIdentifier:(__bridge NSString *)identifier completionHandler:^(NSData *data, NSError *error) {
        (*handler)(ref,(__bridge CFDataRef)data,error,userData);
    }];
}

NSProgress *ItemProviderLoadFileRepresentationForTypeIdentifier( NSItemProvider *ref, CFStringRef identifier, CUI_ItemProviderLoadFileRepresentationCompletionHandler handler, void *userData )
{
    return [ref loadFileRepresentationForTypeIdentifier:(__bridge NSString *)identifier completionHandler:^(NSURL *url, NSError *error) {
        (*handler)(ref,(__bridge CFURLRef)url,error,userData);
    }];
}

NSProgress *ItemProviderLoadInPlaceFileRepresentationForTypeIdentifier( NSItemProvider *ref, CFStringRef identifier, CUI_ItemProviderLoadInPlaceFileRepresentationCompletionHandler handler, void *userData )
{
    return [ref loadInPlaceFileRepresentationForTypeIdentifier:(__bridge NSString *)identifier completionHandler:^(NSURL *url, BOOL isInPlace, NSError *error) {
        (*handler)(ref,(__bridge CFURLRef)url,isInPlace,error,userData);
    }];
}

NSProgress *ItemProviderLoadObjectOfClass( NSItemProvider *ref, Class class, CUI_ItemProviderLoadObjectCompletionHandler handler, void *userData )
{
    return [ref loadObjectOfClass:class completionHandler:^(id<NSItemProviderReading> object, NSError *error) {
        (*handler)(ref,object,error,userData);
    }];
}

BOOL ItemProviderHasRepresentationConformingToTypeIdentifier( NSItemProvider *ref, CFStringRef identifier, NSItemProviderFileOptions fileOptions )
{ return [ref hasRepresentationConformingToTypeIdentifier:(__bridge NSString *)identifier fileOptions:fileOptions]; }

CFArrayRef ItemProviderRegisteredTypeIdentifiersWithFileOptions( NSItemProvider *ref, NSItemProviderFileOptions fileOptions )
{ return (__bridge CFArrayRef)[ref registeredTypeIdentifiersWithFileOptions:fileOptions]; }

// Provide data
void ItemProviderRegisterDataRepresentation( NSItemProvider *ref, CFStringRef identifier, NSItemProviderRepresentationVisibility visibility, CUI_ItemProviderRegisterDataRepresentationLoadHandler handler, void *userData );
void ItemProviderRegisterDataRepresentationWithOptions( NSItemProvider *ref, CFStringRef identifier, NSItemProviderFileOptions options, NSItemProviderRepresentationVisibility visibility, CUI_ItemProviderRegisterDataRepresentationWithOptionsLoadHandler handler, void *userData );
void ItemProviderRegisterObject( NSItemProvider *ref, id<NSItemProviderWriting> obj, NSItemProviderRepresentationVisibility visibility );
void ItemProviderRegisterObjectOfClass( NSItemProvider *ref, Class class, NSItemProviderRepresentationVisibility visibility, CUI_ItemProviderRegisterObjectOfClassLoadHandler handler, void *userData );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
CFStringRef ItemProviderSuggestedName( NSItemProvider *ref )
{ return (__bridge CFStringRef)[ref suggestedName]; }

void ItemProviderSetSuggestedName( NSItemProvider *ref, CFStringRef name )
{ [ref setSuggestedName:(__bridge NSString *)name]; }
#endif// 101400

// Register custom coercion handlers
void ItemProviderRegisterItemForTypeIdentifier( NSItemProvider *ref, CFStringRef identifier, void *handler, void *userData );
CFArrayRef ItemProviderRegisteredTypeIdentifiers( NSItemProvider *ref );

// Preview image
void ItemProviderLoadPreviewImageWithOptions( NSItemProvider *ref, CFDictionaryRef options, void *handler, void *userData );

// Visual attributes
CGRect ItemProviderSourceFrame( NSItemProvider *ref );
CGRect ItemProviderContainerFrame( NSItemProvider *ref );
CGSize ItemProviderPreferredPresentationSize( NSItemProvider *ref );




#pragma mark - ItemProviderReading

// Create
id<NSItemProviderReading> ItemProviderReadingObjectWithData( CFDataRef dta, CFStringRef identifier, NSError **err );

// Type identifiers
CFArrayRef ItemProviderReadingReadableTypeIdentifiers( void );

// Load data
NSProgress *ItemProviderWritingLoadData( id<NSItemProviderWriting> ref, CFStringRef identifier, void *completionHandler, void *userData );



#pragma mark - ItemProviderWriting

// Type identifiers
CFArrayRef ItemProviderWritingWritableTypeIdentifiers( void );
CFArrayRef ItemProviderWritingWritableTypeIdentifiersForItemProvider( id<NSItemProviderWriting> ref );

// Visibility
NSItemProviderRepresentationVisibility ItemProviderWritingVisibilityForRepresentation( CFStringRef identifier );
NSItemProviderRepresentationVisibility ItemProviderWritingVisibilityForRepresentationWithTypeIdentifier( id<NSItemProviderWriting> ref, CFStringRef identifier );



