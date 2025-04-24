/*
 ItemProvider.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_ItemProviderLoadItemCompletionHandler)(NSItemProvider*,id<NSSecureCoding>,NSError*,void*);
typedef void (*CUI_ItemProviderLoadDataCompletionHandler)(NSItemProvider*,CFDataRef,NSError*,void*);
typedef void (*CUI_ItemProviderLoadFileRepresentationCompletionHandler)(NSItemProvider*,CFURLRef,NSError*,void*);
typedef void (*CUI_ItemProviderLoadInPlaceFileRepresentationCompletionHandler)(NSItemProvider*,CFURLRef,BOOL,NSError*,void*);
typedef void (*CUI_ItemProviderLoadObjectCompletionHandler)(NSItemProvider*,id<NSItemProviderReading>,NSError*,void*);
typedef NSProgress *(*CUI_ItemProviderRegisterDataRepresentationLoadHandler)(NSItemProvider*,CFDataRef,NSError*,void*);
typedef NSProgress *(*CUI_ItemProviderRegisterDataRepresentationWithOptionsLoadHandler)(NSItemProvider*,CFURLRef,BOOL,NSError*,void*);
typedef NSProgress *(*CUI_ItemProviderRegisterObjectOfClassLoadHandler)(NSItemProvider*,id<NSItemProviderWriting>,NSError*,void*);

// Class
Class ItemProviderClass( void );

// Create
NSItemProvider *ItemProviderWithContentsOfURL( CFURLRef url );
NSItemProvider *ItemProviderWithItem( id<NSSecureCoding> item, CFStringRef identifier );
NSItemProvider *ItemProviderWithObject( CFTypeRef obj );

// Get data
BOOL ItemProviderCanLoadObjectOfClass( NSItemProvider *ref, Class class );
BOOL ItemProviderHasItemConformingToTypeIdentifier( NSItemProvider *ref, CFStringRef identifier );
void ItemProviderLoadItemForTypeIdentifier( NSItemProvider *ref, CFStringRef identifier, CFDictionaryRef options, CUI_ItemProviderLoadItemCompletionHandler handler, void *userData );
NSProgress *ItemProviderLoadDataRepresentationForTypeIdentifier( NSItemProvider *ref, CFStringRef identifier, CUI_ItemProviderLoadDataCompletionHandler handler, void *userData );
NSProgress *ItemProviderLoadFileRepresentationForTypeIdentifier( NSItemProvider *ref, CFStringRef identifier, CUI_ItemProviderLoadFileRepresentationCompletionHandler handler, void *userData );
NSProgress *ItemProviderLoadInPlaceFileRepresentationForTypeIdentifier( NSItemProvider *ref, CFStringRef identifier, CUI_ItemProviderLoadInPlaceFileRepresentationCompletionHandler handler, void *userData );
NSProgress *ItemProviderLoadObjectOfClass( NSItemProvider *ref, Class class, CUI_ItemProviderLoadObjectCompletionHandler handler, void *userData );
BOOL ItemProviderHasRepresentationConformingToTypeIdentifier( NSItemProvider *ref, CFStringRef identifier, NSItemProviderFileOptions fileOptions );
CFArrayRef ItemProviderRegisteredTypeIdentifiersWithFileOptions( NSItemProvider *ref, NSItemProviderFileOptions fileOptions );

// Provide data
void ItemProviderRegisterDataRepresentation( NSItemProvider *ref, CFStringRef identifier, NSItemProviderRepresentationVisibility visibility, CUI_ItemProviderRegisterDataRepresentationLoadHandler handler, void *userData );
void ItemProviderRegisterDataRepresentationWithOptions( NSItemProvider *ref, CFStringRef identifier, NSItemProviderFileOptions options, NSItemProviderRepresentationVisibility visibility, CUI_ItemProviderRegisterDataRepresentationWithOptionsLoadHandler handler, void *userData );
void ItemProviderRegisterObject( NSItemProvider *ref, id<NSItemProviderWriting> obj, NSItemProviderRepresentationVisibility visibility );
void ItemProviderRegisterObjectOfClass( NSItemProvider *ref, Class class, NSItemProviderRepresentationVisibility visibility, CUI_ItemProviderRegisterObjectOfClassLoadHandler handler, void *userData );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
CFStringRef ItemProviderSuggestedName( NSItemProvider *ref );
API_AVAILABLE(macos(10.14))
void ItemProviderSetSuggestedName( NSItemProvider *ref, CFStringRef name );
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



