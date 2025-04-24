/*
 SharingService.m

 Bernie Wylde
 */

#import "SharingService.h"

// delegate
@implementation CUI_SharingServiceDelegate

#pragma mark - sharing delegate
#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.theSharingService dealloc];
    [self.theItems dealloc];
    [self.theError dealloc];
    [self.theItem dealloc];
    [self.theTransitionImage dealloc];
    [self.theSourceWindow dealloc];
    [super dealloc];
}
#endif

- (void)sharingService:(NSSharingService *)sharingService willShareItems:(NSArray *)items {
    self.theSharingService = sharingService;
    self.theItems = items;
    
    //sharingServiceWillShareItems
    
}

- (void)sharingService:(NSSharingService *)sharingService didShareItems:(NSArray *)items {
    self.theSharingService = sharingService;
    self.theItems = items;

    //sharingServiceDidShareItems

}

- (void)sharingService:(NSSharingService *)sharingService didFailToShareItems:(NSArray *)items error:(NSError *)error {
    self.theSharingService = sharingService;
    self.theItems = items;
    self.theError = error;

    //sharingServiceDidFailToShareItems

}

//- (NSRect)sharingService:(NSSharingService *)sharingService sourceFrameOnScreenForShareItem:(id)item {
//    self.theSharingService = sharingService;
//    self.theItem = item;

    //sharingServiceSourceFrameOnScreenForShareItem

//    return NSZeroRect;
//}

//- (NSImage *)sharingService:(NSSharingService *)sharingService transitionImageForShareItem:(id)item contentRect:(NSRect *)contentRect {
//    self.theSharingService = sharingService;
//    self.theItem = item;
//  self.theContentRect = contentRect;

    //sharingServiceTransitionImageForShareItem

//    return self.theTransitionImage;
//}

- (NSWindow *)sharingService:(NSSharingService *)sharingService sourceWindowForShareItems:(NSArray *)items sharingContentScope:(NSSharingContentScope *)sharingContentScope {
    self.theSharingService = sharingService;
    self.theItems = items;

    //sharingServiceSourceWindowForShareItem

    *sharingContentScope = NSSharingContentScopeItem;
    
    return self.theSourceWindow;
}

//- (NSView *)anchoringViewForSharingService:(NSSharingService *)sharingService showRelativeToRect:(NSRect *)positioningRect preferredEdge:(NSRectEdge *)preferredEdge {
//    self.theSharingService = sharingService;
//  self.thePositioningRect = positioningRect;
//  self.thePreferredEdge = preferredEdge;

    //sharingServiceAnchoringView

//    return nil;
//}
@end

CUI_SharingServiceDelegate *CUI_SharingServiceDelegateObj( void )
{
    static CUI_SharingServiceDelegate *sCUI_SharingServiceDelegate = nil;
    if ( !sCUI_SharingServiceDelegate ) sCUI_SharingServiceDelegate = [[CUI_SharingServiceDelegate alloc] init];
    return sCUI_SharingServiceDelegate;
}

// Class
Class SharingServiceClass( void )
{ return [NSSharingService class]; }

NSSharingService *SharingServiceEventSharingService( void )
{ return [CUI_SharingServiceDelegateObj() theSharingService]; }

CFArrayRef SharingServiceEventItems( void )
{ return (__bridge CFArrayRef)[CUI_SharingServiceDelegateObj() theItems]; }

NSError *SharingServiceEventError( void )
{ return [CUI_SharingServiceDelegateObj() theError]; }

CFTypeRef SharingServiceEventItem( void )
{ return (__bridge CFTypeRef)[CUI_SharingServiceDelegateObj() theItem]; }

CGRect SharingServiceEventSourceFrame( void )
{ return NSRectToCGRect([CUI_SharingServiceDelegateObj() theSourceFrame]); }

NSImage *SharingServiceEventTransitionImage( void )
{ return [CUI_SharingServiceDelegateObj() theTransitionImage]; }

CGRect SharingServiceEventContentRect( void )
{ return NSRectToCGRect([CUI_SharingServiceDelegateObj() theContentRect]); }

CGRect SharingServiceEventPositioningRect( void )
{ return NSRectToCGRect([CUI_SharingServiceDelegateObj() thePositioningRect]); }

CGRectEdge SharingServiceEventPreferredEdge( void )
{ return (CGRectEdge)[CUI_SharingServiceDelegateObj() thePreferredEdge]; }

NSWindow *SharingServiceEventSourceWindow( void )
{ return [CUI_SharingServiceDelegateObj() theSourceWindow]; }



#pragma mark - SharingService
NSSharingService *SharingServiceNamed( CFStringRef name )
{ return [NSSharingService sharingServiceNamed:(__bridge NSString *)name]; }
          
NSSharingService *SharingServiceWithTitle( CFStringRef title, NSImage *image, NSImage *alternateImage, CUI_SharingServiceWithTitleHandlerType handler, void *userData )
{
#if __has_feature(objc_arc)
    return [[NSSharingService alloc] initWithTitle:(__bridge NSString *)title image:image alternateImage:alternateImage handler:^(void) {
        (*handler)( userData );
    }];
#else
    return [[[NSSharingService alloc] initWithTitle:(__bridge NSString *)title image:image alternateImage:alternateImage handler:^(void) {
        (*handler)( userData );
    }] autorelease];
#endif
}
          
// Configuration
CFStringRef SharingServiceMenuItemTitle( NSSharingService *ref )
{ return (__bridge CFStringRef)[ref menuItemTitle]; }

void SharingServiceSetMenuItemTitle( NSSharingService *ref, CFStringRef title )
{ [ref setMenuItemTitle:(__bridge NSString *)title]; }

CFStringRef SharingServiceTitle( NSSharingService *ref )
{ return (__bridge CFStringRef)[ref title]; }

CFStringRef SharingServiceAccountName( NSSharingService *ref )
{ return (__bridge CFStringRef)[ref accountName]; }

// Available sharing services
CFArrayRef SharingServiceServicesForItems( CFArrayRef items )
{ return (__bridge CFArrayRef)[NSSharingService sharingServicesForItems:(__bridge NSArray *)items]; }

// Items
BOOL SharingServiceCanPerformWithItems( NSSharingService *ref, CFArrayRef items )
{ return [ref canPerformWithItems:(__bridge NSArray *)items]; }

void SharingServicePerformWithItems( NSSharingService *ref, CFArrayRef items )
{ [ref performWithItems:(__bridge NSArray *)items]; }

CFArrayRef SharingServiceRecipients( NSSharingService *ref )
{ return (__bridge CFArrayRef)[ref recipients]; }

void SharingServiceSetRecipients( NSSharingService *ref, CFArrayRef recipients )
{ [ref setRecipients:(__bridge NSArray *)recipients]; }

// Content attributes
NSImage *SharingServiceAlternateImage( NSSharingService *ref )
{ return [ref alternateImage]; }

NSImage *SharingServiceImage( NSSharingService *ref )
{ return [ref image]; }

CFStringRef SharingServiceSubject( NSSharingService *ref )
{ return (__bridge CFStringRef)[ref subject]; }

void SharingServiceSetSubject( NSSharingService *ref, CFStringRef subject )
{ [ref setSubject:(__bridge NSString *)subject]; }

// Info about completed post
CFArrayRef SharingServiceAttachmentFileURLs( NSSharingService *ref )
{ return (__bridge CFArrayRef)[ref attachmentFileURLs]; }

CFStringRef SharingServiceMessageBody( NSSharingService *ref )
{ return (__bridge CFStringRef)[ref messageBody]; }

CFURLRef SharingServicePermanentLink( NSSharingService *ref )
{ return (__bridge CFURLRef)[ref permanentLink]; }


#pragma mark - SharingServicePicker

// delegate
@implementation CUI_SharingServicePickerDelegate

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.theSharingServicePicker release];
    [self.theItems release];
    [self.theProposedServices release];
    [self.theSharingService release];
    [super dealloc];
}
#endif

- (NSArray *)sharingServicePicker:(NSSharingServicePicker *)sharingServicePicker sharingServicesForItems:(NSArray *)items proposedSharingServices:(NSArray *)proposedServices {
    self.theSharingServicePicker = sharingServicePicker;
    self.theItems = items;
    self.theProposedServices = proposedServices;
    CallUserDefinedOnDialogFunction( sharingServicePickerSharingServicesForItems, 0, 0, (__bridge CFTypeRef)sharingServicePicker );
    return self.theProposedServices;
}

- (id)sharingServicePicker:(NSSharingServicePicker *)sharingServicePicker delegateForSharingService:(NSSharingService *)sharingService {
    return self;
}

- (void)sharingServicePicker:(NSSharingServicePicker *)sharingServicePicker didChooseSharingService:(NSSharingService *)service {
    self.theSharingServicePicker = sharingServicePicker;
    self.theSharingService = service;
    CallUserDefinedOnDialogFunction( sharingServicePickerDidChooseSharingService, 0, 0, (__bridge CFTypeRef)sharingServicePicker );
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
- (NSArray *)sharingServicePickerCollaborationModeRestrictions:(NSSharingServicePicker *)sharingServicePicker {
    self.theSharingServicePicker = sharingServicePicker;
    DialogEventSetNSArray( nil );
    CallUserDefinedOnDialogFunction( sharingServicePickerCollaborationModeRestrictions, 0, 0, (__bridge CFTypeRef)sharingServicePicker );
    return DialogEventNSArray();
}
#endif // 150000

@end

CUI_SharingServicePickerDelegate *CUI_SharingServicePickerDelegateObj( void )
{
    static CUI_SharingServicePickerDelegate *sCUI_SharingServicePickerDelegate = nil;
    if ( !sCUI_SharingServicePickerDelegate ) sCUI_SharingServicePickerDelegate = [[CUI_SharingServicePickerDelegate alloc] init];
    return sCUI_SharingServicePickerDelegate;
}

NSSharingServicePicker *SharingServicePickerEventSharingServicePicker( void )
{ return [CUI_SharingServicePickerDelegateObj() theSharingServicePicker]; }

CFArrayRef SharingServicePickerEventItems( void )
{ return (__bridge CFArrayRef)[CUI_SharingServicePickerDelegateObj() theItems]; }

CFArrayRef SharingServicePickerEventProposedServices( void )
{ return (__bridge CFArrayRef)[CUI_SharingServicePickerDelegateObj() theProposedServices]; }

void SharingServicePickerEventSetProposedServices( CFArrayRef services )
{ [CUI_SharingServicePickerDelegateObj() setTheProposedServices:(__bridge NSArray *)services]; }

NSSharingService *SharingServicePickerEventSharingService( void )
{ return [CUI_SharingServicePickerDelegateObj() theSharingService]; }


// Create
NSSharingServicePicker *SharingServicePickerWithItems( CFArrayRef items )
{
#if __has_feature(objc_arc)
    NSSharingServicePicker *picker = [[NSSharingServicePicker alloc] initWithItems:(__bridge NSArray *)items];
#else
    NSSharingServicePicker *picker = [[[NSSharingServicePicker alloc] initWithItems:(__bridge NSArray *)items] autorelease];
#endif
    [picker setDelegate:CUI_SharingServicePickerDelegateObj()];
    return picker;
}

// Display
void SharingServicePickerShowRelativeToRect( NSSharingServicePicker *ref, CGRect r, NSInteger vwTag, CGRectEdge preferredEdge )
{
    NSView *view = CUI_ViewWithTag( vwTag );
    if ( view ) {
        [ref showRelativeToRect:NSRectFromCGRect(r) ofView:view preferredEdge:(NSRectEdge)preferredEdge];
    }
}

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
NSMenuItem *SharingServicePickerStandardShareMenuItem( NSSharingServicePicker *ref )
{ return [ref standardShareMenuItem]; }
#endif// 130000

