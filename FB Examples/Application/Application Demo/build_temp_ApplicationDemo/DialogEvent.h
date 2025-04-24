/*
 DialogEvent.h

 Bernie Wylde
 */

#import "CocoaUI.h"

@interface CUI_DialogEvent : NSObject
@property (nonatomic,assign) BOOL boolVal;
@property (nonatomic,assign) long longVal;
@property (nonatomic,assign) float floatVal;
@property (nonatomic,assign) double doubleVal;
@property (nonatomic,retain) NSError *errorObj;
@property (nonatomic,assign) NSPoint pointVal;
@property (nonatomic,assign) NSSize sizeVal;
@property (nonatomic,assign) NSRect rectVal;
@property (nonatomic,assign) NSInteger viewTag;
@property (nonatomic,retain) NSArray *arrayObj;
@property (nonatomic,retain) NSURL *urlObj;
@property (nonatomic,retain) NSURL *otherUrlObj;
@property (nonatomic,retain) id<NSDraggingInfo> dragInfo;
@property (nonatomic,retain) NSArray *pbTypes;
@property (nonatomic,retain) NSString *stringObj;
@property (nonatomic,retain) NSFont *fontObj;
@property (nonatomic,retain) NSColor *colorObj;
@property (nonatomic,retain) NSView *viewObj;
@property (nonatomic,retain) id object;
@property (nonatomic,retain) NSMenu *menuObj;
@property (nonatomic,assign) NSRange rangeVal;
@property (nonatomic,retain) NSPasteboard *pasteboardObj;
@property (nonatomic,assign) void *context;
@property (nonatomic,assign) CGContextRef cgContextObj;
@property (nonatomic,retain) id<CAAction> caAction;
@property (nonatomic,retain) NSURLSessionTask *URLSessionTaskObj;
@property (nonatomic,retain) NSURLSessionDataTask *URLSessionDataTaskObj;
@property (nonatomic,retain) NSData *dataObj;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
@property (nonatomic,retain) NSTintConfiguration *tintConfigurationObj API_AVAILABLE(macos(11.0));
#endif// 110000
@property (nonatomic,retain) NSTableColumn *tableColumnObj;
@property (nonatomic,retain) NSCell *cellObj;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
@property (nonatomic,retain) UTType *utTypeObj API_AVAILABLE(macos(11.0));
#endif // 110000
@property (nonatomic,retain) NSWindow *windowObj;
@end

CUI_DialogEvent *CUI_DialogEventObj( void );

BOOL DialogEventBool( void );
void DialogEventSetBool( BOOL value );
long DialogEventLong( void );
void DialogEventSetLong( long value );
float DialogEventFloat( void );
void DialogEventSetFloat( float value );
double DialogEventDouble( void );
void DialogEventSetDouble( double value );

void DialogEventSetError( NSError *error );
NSError *DialogEventError( void );

NSPoint DialogEventNSPoint( void );
void DialogEventSetNSPoint( NSPoint value );

NSSize DialogEventNSSize( void );
void DialogEventSetNSSize( NSSize value );

NSRect DialogEventNSRect( void );
void DialogEventSetNSRect( NSRect value );

NSArray *DialogEventNSArray( void );
void DialogEventSetNSArray( NSArray *array );

NSURL *DialogEventNSURL( void );
void DialogEventSetNSURL( NSURL *url );

void DialogEventSetOtherNSURL( NSURL *url );

NSString *DialogEventNSString( void );
void DialogEventSetNSString( NSString *string );

id DialogEventNSObject( void );
void DialogEventSetNSObject( id obj );

NSMenu *DialogEventNSMenu( void );
void DialogEventSetNSMenu( NSMenu *menu );

void DialogEventSetNSRange( NSRange range );

void DialogEventSetFont( NSFont *font );
void DialogEventSetColor( NSColor *col );

CGSize DialogEventSize( void );
void DialogEventSetSize( CGSize value );

CGPoint DialogEventPoint( void );
void DialogEventSetPoint( CGPoint value );

CGRect DialogEventRect( void );
void DialogEventSetRect( CGRect value );

NSInteger DialogEventViewTag( void );
void DialogEventSetViewTag( NSInteger value );
CFArrayRef DialogEventArray( void );
void DialogEventSetArray( CFArrayRef array );
CFURLRef DialogEventURL( void );
void DialogEventSetURL( CFURLRef url );
CFURLRef DialogEventOtherURL( void );
id<NSDraggingInfo> DialogEventDraggingInfo( void );
void DialogEventSetDraggingInfo( id<NSDraggingInfo> info );
CFStringRef DialogEventString( void );
void DialogEventSetString( CFStringRef string );
NSFont *DialogEventFont( void );
NSColor *DialogEventColor( void );

NSView *DialogEventView( void );
void DialogEventSetView( NSView *aView );

CFTypeRef DialogEventObject( void );
void DialogEventSetObject( CFTypeRef obj );

NSMenu *DialogEventMenu( void );
void DialogEventSetMenu( NSMenu *menu );

CFRange DialogEventRange( void );

NSPasteboard *DialogEventPasteboard( void );
void DialogEventSetPasteboard( NSPasteboard *pb );

void *DialogEventContext( void );
void DialogEventSetContext( void *context );

CGContextRef DialogEventCGContext( void );
void DialogEventSetCGContext( CGContextRef ctx );

id<CAAction>DialogEventCAAction( void );
void DialogEventSetCAAction( CAActionRef ref );

NSURLSessionTask *DialogEventURLSessionTask( void );
void DialogEventSetURLSessionTask( NSURLSessionTask *task );

NSURLSessionDataTask *DialogEventURLSessionDataTask( void );
void DialogEventSetURLSessionDataTask( NSURLSessionDataTask *dataTask );

CFDataRef DialogEventData( void );
void DialogEventSetData( NSData *data );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSTintConfiguration *DialogEventTintConfiguration( void );
API_AVAILABLE(macos(11.0))
void DialogEventSetTintConfiguration( NSTintConfiguration *tint );
#endif// 110000

NSTableColumn *DialogEventTableColumn( void );
void DialogEventSetTableColumn( NSTableColumn *column );

NSCell *DialogEventCell( void );
void DialogEventSetCell( NSCell *cell );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
UTType *DialogEventUTType( void );
API_AVAILABLE(macos(11.0))
void DialogEventSetUTType( UTType *type );
#endif // 110000

NSWindow *DialogEventWindow( void );
void DialogEventSetWindow( NSWindow *wnd );


#pragma mark - FB dialog
// all dialog stuff moved to here from AppThings.c - 20211004
typedef void (*CUI_OnDialogFunctionType)(NSInteger,NSInteger,NSInteger,CFTypeRef);
static CUI_OnDialogFunctionType sCUI_OnDialogFunction;

CUI_OnDialogFunctionType CUI_OnDialogFunction( void );
void CUI_SetOnDialogFunction( CUI_OnDialogFunctionType onDialogFn );

void CallUserDefinedOnDialogFunction( long fbEventKind, long fbEventID, long fbWndNum, CFTypeRef object );
void FBDialogStatement( long id );

