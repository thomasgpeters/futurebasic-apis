/*
 SharingService.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#pragma mark - SharingService

// dialog events
enum {
    sharingServiceWillShareItems = 5600,
    sharingServiceDidShareItems,
    sharingServiceDidFailToShareItems,
    sharingServiceSourceFrameOnScreenForShareItem,
    sharingServiceTransitionImageForShareItem,
    sharingServiceSourceWindowForShareItem,
    sharingServiceAnchoringView
};

// delegate
@interface CUI_SharingServiceDelegate : NSObject <NSSharingServiceDelegate>

@property (nonatomic,retain) NSSharingService *theSharingService;
@property (nonatomic,retain) NSArray *theItems;
@property (nonatomic,retain) NSError *theError;
@property (nonatomic,retain) id theItem;
@property (nonatomic,assign) NSRect theSourceFrame;
@property (nonatomic,retain) NSImage *theTransitionImage;
@property (nonatomic,assign) NSRect theContentRect;
@property (nonatomic,assign) NSSharingContentScope *theSharingContentScope;
@property (nonatomic,assign) NSRect thePositioningRect;
@property (nonatomic,assign) NSRectEdge thePreferredEdge;
@property (nonatomic,retain) NSWindow *theSourceWindow;

@end

CUI_SharingServiceDelegate *CUI_SharingServiceDelegateObj( void );

NSSharingService *SharingServiceEventSharingService( void );
CFArrayRef SharingServiceEventItems( void );
NSError *SharingServiceEventError( void );
CFTypeRef SharingServiceEventItem( void );
CGRect SharingServiceEventSourceFrame( void );
NSImage *SharingServiceEventTransitionImage( void );
CGRect SharingServiceEventContentRect( void );
CGRect SharingServiceEventPositioningRect( void );
CGRectEdge SharingServiceEventPreferredEdge( void );
NSWindow *SharingServiceEventSourceWindow( void );


typedef void (*CUI_SharingServiceWithTitleHandlerType)(void*);

// Class
Class SharingServiceClass( void );

// Create
NSSharingService *SharingServiceNamed( CFStringRef name );
NSSharingService *SharingServiceWithTitle( CFStringRef title, NSImage *image, NSImage *alternateImage, CUI_SharingServiceWithTitleHandlerType handler, void *userData );

// Configuration
CFStringRef SharingServiceMenuItemTitle( NSSharingService *ref );
void SharingServiceSetMenuItemTitle( NSSharingService *ref, CFStringRef title );
CFStringRef SharingServiceTitle( NSSharingService *ref );
CFStringRef SharingServiceAccountName( NSSharingService *ref );

// Available sharing services
CFArrayRef SharingServiceServicesForItems( CFArrayRef items );

// Items
BOOL SharingServiceCanPerformWithItems( NSSharingService *ref, CFArrayRef items );
void SharingServicePerformWithItems( NSSharingService *ref, CFArrayRef items );
CFArrayRef SharingServiceRecipients( NSSharingService *ref );
void SharingServiceSetRecipients( NSSharingService *ref, CFArrayRef recipients );

// Content attributes
NSImage *SharingServiceAlternateImage( NSSharingService *ref );
NSImage *SharingServiceImage( NSSharingService *ref );
CFStringRef SharingServiceSubject( NSSharingService *ref );
void SharingServiceSetSubject( NSSharingService *ref, CFStringRef subject );

// Info about completed post
CFArrayRef SharingServiceAttachmentFileURLs( NSSharingService *ref );
CFStringRef SharingServiceMessageBody( NSSharingService *ref );
CFURLRef SharingServicePermanentLink( NSSharingService *ref );


#pragma mark - SharingServicePicker
enum {
    sharingServicePickerSharingServicesForItems = 5700,
    sharingServicePickerDidChooseSharingService,
    sharingServicePickerCollaborationModeRestrictions
};

// delegate
@interface CUI_SharingServicePickerDelegate : NSObject <NSSharingServicePickerDelegate>
@property (nonatomic,retain) NSSharingServicePicker *theSharingServicePicker;
@property (nonatomic,retain) NSArray *theItems;
@property (nonatomic,retain) NSArray *theProposedServices;
@property (nonatomic,retain) NSSharingService *theSharingService;
@end

CUI_SharingServicePickerDelegate *CUI_SharingServicePickerDelegateObj( void );

NSSharingServicePicker *SharingServicePickerEventSharingServicePicker( void );
CFArrayRef SharingServicePickerEventItems( void );
CFArrayRef SharingServicePickerEventProposedServices( void );
void SharingServicePickerEventSetProposedServices( CFArrayRef services );
NSSharingService *SharingServicePickerEventSharingService( void );


// Create
NSSharingServicePicker *SharingServicePickerWithItems( CFArrayRef items );

// Display
void SharingServicePickerShowRelativeToRect( NSSharingServicePicker *ref, CGRect r, NSInteger vwTag, CGRectEdge preferredEdge );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
API_AVAILABLE(macos(13.0))
NSMenuItem *SharingServicePickerStandardShareMenuItem( NSSharingServicePicker *ref );
#endif// 130000
