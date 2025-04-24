/*
 DialogEvent.m

 Bernie Wylde
 */

#import "DialogEvent.h"

@implementation CUI_DialogEvent

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.errorObj release];
    [self.arrayObj release];
    [self.otherUrlObj release];
    [self.dragInfo release];
    [self.pbTypes release];
    [self.stringObj release];
    [self.fontObj release];
    [self.colorObj release];
    [self.viewObj release];
    [self.object release];
    [self.menuObj release];
    [self.pasteboardObj release];
    [self.URLSessionTaskObj release];
    [self.URLSessionDataTaskObj release];
    [self.dataObj release];
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
    if (@available(macOS 11.0, *)) {
        [self.tintConfigurationObj release];
    }
#endif// 110000
    [self.tableColumnObj release];
    [self.windowObj release];
    [super dealloc];
}
#endif
@end

CUI_DialogEvent *CUI_DialogEventObj( void )
{
    static CUI_DialogEvent *sCUI_DialogEvent = nil;
    if ( !sCUI_DialogEvent ) sCUI_DialogEvent = [[CUI_DialogEvent alloc] init];
    return sCUI_DialogEvent;
}

// NS
void DialogEventSetError( NSError *error )
{ [CUI_DialogEventObj() setErrorObj:error]; }

NSPoint DialogEventNSPoint( void )
{ return [CUI_DialogEventObj() pointVal]; }

void DialogEventSetNSPoint( NSPoint value )
{ [CUI_DialogEventObj() setPointVal:value]; }

NSSize DialogEventNSSize( void )
{ return [CUI_DialogEventObj() sizeVal]; }

void DialogEventSetNSSize( NSSize value )
{ [CUI_DialogEventObj() setSizeVal:value]; }

NSRect DialogEventNSRect( void )
{ return [CUI_DialogEventObj() rectVal]; }

void DialogEventSetNSRect( NSRect value )
{ [CUI_DialogEventObj() setRectVal:value]; }

NSArray *DialogEventNSArray( void )
{ return [CUI_DialogEventObj() arrayObj]; }

void DialogEventSetNSArray( NSArray *array )
{ [CUI_DialogEventObj() setArrayObj:array]; }

NSURL *DialogEventNSURL( void )
{ return [CUI_DialogEventObj() urlObj]; }

void DialogEventSetNSURL( NSURL *url )
{ [CUI_DialogEventObj() setUrlObj:url]; }

void DialogEventSetOtherNSURL( NSURL *url )
{ [CUI_DialogEventObj() setOtherUrlObj:url]; }

NSString *DialogEventNSString( void )
{ return [CUI_DialogEventObj() stringObj];}

void DialogEventSetNSString( NSString *string )
{ [CUI_DialogEventObj() setStringObj:string]; }

void DialogEventSetFont( NSFont *font )
{ [CUI_DialogEventObj() setFontObj:font]; }

void DialogEventSetColor( NSColor *col )
{ [CUI_DialogEventObj() setColorObj:col]; }

id DialogEventNSObject( void )
{ return [CUI_DialogEventObj() object]; }

void DialogEventSetNSObject( id obj )
{ [CUI_DialogEventObj() setObject:obj]; }

NSMenu *DialogEventNSMenu( void )
{ return [CUI_DialogEventObj() menuObj]; }

void DialogEventSetNSMenu( NSMenu *menu )
{ [CUI_DialogEventObj() setMenuObj:menu]; }

void DialogEventSetNSRange( NSRange range )
{ [CUI_DialogEventObj() setRangeVal:range]; }


// non-NS
BOOL DialogEventBool( void )
{ return [CUI_DialogEventObj() boolVal]; }

void DialogEventSetBool( BOOL value )
{ [CUI_DialogEventObj() setBoolVal:value]; }

long DialogEventLong( void )
{ return [CUI_DialogEventObj() longVal]; }

void DialogEventSetLong( long value )
{ [CUI_DialogEventObj() setLongVal:value]; }

float DialogEventFloat( void )
{ return [CUI_DialogEventObj() floatVal]; }

void DialogEventSetFloat( float value )
{ [CUI_DialogEventObj() setFloatVal:value]; }

double DialogEventDouble( void )
{ return [CUI_DialogEventObj() doubleVal]; }

void DialogEventSetDouble( double value )
{ [CUI_DialogEventObj() setDoubleVal:value]; }

CGPoint DialogEventPoint( void )
{ return NSPointToCGPoint([CUI_DialogEventObj() pointVal]); }

void DialogEventSetPoint( CGPoint value )
{ [CUI_DialogEventObj() setPointVal:NSPointFromCGPoint(value)]; }

CGSize DialogEventSize( void )
{ return NSSizeToCGSize([CUI_DialogEventObj() sizeVal]); }

void DialogEventSetSize( CGSize value )
{ [CUI_DialogEventObj() setSizeVal:NSSizeFromCGSize(value)]; }

CGRect DialogEventRect( void )
{ return NSRectToCGRect([CUI_DialogEventObj() rectVal]); }

void DialogEventSetRect( CGRect value )
{ [CUI_DialogEventObj() setRectVal:NSRectFromCGRect(value)]; }

NSInteger DialogEventViewTag( void )
{ return [CUI_DialogEventObj() viewTag]; }

void DialogEventSetViewTag( NSInteger value )
{ [CUI_DialogEventObj() setViewTag:value];}

id<NSDraggingInfo> DialogEventDraggingInfo( void )
{ return [CUI_DialogEventObj() dragInfo]; }

void DialogEventSetDraggingInfo( id<NSDraggingInfo> info )
{ [CUI_DialogEventObj() setDragInfo:info]; }

CFArrayRef DialogEventArray( void )
{ return (__bridge CFArrayRef)[CUI_DialogEventObj() arrayObj]; }

void DialogEventSetArray( CFArrayRef array )
{ [CUI_DialogEventObj() setArrayObj:(__bridge NSArray *)array]; }

NSError *DialogEventError( void )
{ return (NSError *)[CUI_DialogEventObj() errorObj]; }

CFURLRef DialogEventURL( void )
{ return (__bridge CFURLRef)[CUI_DialogEventObj() urlObj]; }

void DialogEventSetURL( CFURLRef url )
{ DialogEventSetNSURL( (__bridge NSURL *)url ); }

CFURLRef DialogEventOtherURL( void )
{ return (__bridge CFURLRef)[CUI_DialogEventObj() otherUrlObj]; }

CFStringRef DialogEventString( void )
{ return (__bridge CFStringRef)[CUI_DialogEventObj() stringObj]; }

void DialogEventSetString( CFStringRef string )
{ DialogEventSetNSString( (__bridge NSString *)string ); }

NSFont *DialogEventFont( void )
{ return [CUI_DialogEventObj() fontObj]; }

NSColor *DialogEventColor( void )
{ return [CUI_DialogEventObj() colorObj]; }

NSView *DialogEventView( void )
{ return [CUI_DialogEventObj() viewObj]; }

void DialogEventSetView( NSView *aView )
{ [CUI_DialogEventObj() setViewObj:aView]; }

CFTypeRef DialogEventObject( void )
{ return (__bridge CFTypeRef)[CUI_DialogEventObj() object]; }

void DialogEventSetObject( CFTypeRef obj )
{ [CUI_DialogEventObj() setObject:(__bridge id)obj]; }

NSMenu *DialogEventMenu( void )
{ return DialogEventNSMenu(); }

void DialogEventSetMenu( NSMenu *menu )
{ DialogEventSetNSMenu( menu ); }

CFRange DialogEventRange( void )
{ return NSRangeToCFRange( [CUI_DialogEventObj() rangeVal] ); }

NSPasteboard *DialogEventPasteboard( void )
{ return [CUI_DialogEventObj() pasteboardObj]; }

void DialogEventSetPasteboard( NSPasteboard *pb )
{ [CUI_DialogEventObj() setPasteboardObj:pb]; }

void *DialogEventContext( void )
{ return [CUI_DialogEventObj() context]; }

void DialogEventSetContext( void *context )
{ [CUI_DialogEventObj() setContext:context]; }

CGContextRef DialogEventCGContext( void )
{ return [CUI_DialogEventObj() cgContextObj]; }

void DialogEventSetCGContext( CGContextRef ctx )
{ [CUI_DialogEventObj() setCgContextObj:ctx]; }

id<CAAction>DialogEventCAAction( void )
{ return [CUI_DialogEventObj() caAction]; }

void DialogEventSetCAAction( CAActionRef ref )
{ [CUI_DialogEventObj() setCaAction:ref]; }

NSURLSessionTask *DialogEventURLSessionTask( void )
{ return [CUI_DialogEventObj() URLSessionTaskObj]; }

void DialogEventSetURLSessionTask( NSURLSessionTask *task )
{ [CUI_DialogEventObj() setURLSessionTaskObj:task]; }

NSURLSessionDataTask *DialogEventURLSessionDataTask( void )
{ return [CUI_DialogEventObj() URLSessionDataTaskObj]; }

void DialogEventSetURLSessionDataTask( NSURLSessionDataTask *dataTask )
{ [CUI_DialogEventObj() setURLSessionDataTaskObj:dataTask]; }

CFDataRef DialogEventData( void )
{ return (__bridge CFDataRef)[CUI_DialogEventObj() dataObj]; }

void DialogEventSetData( NSData *data )
{ [CUI_DialogEventObj() setDataObj:data]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSTintConfiguration *DialogEventTintConfiguration( void )
{ return [CUI_DialogEventObj() tintConfigurationObj]; }

void DialogEventSetTintConfiguration( NSTintConfiguration *tint )
{ [CUI_DialogEventObj() setTintConfigurationObj:tint]; }
#endif// 110000

NSTableColumn *DialogEventTableColumn( void )
{ return [CUI_DialogEventObj() tableColumnObj]; }

void DialogEventSetTableColumn( NSTableColumn *column )
{ [CUI_DialogEventObj() setTableColumnObj:column]; }

NSCell *DialogEventCell( void )
{ return [CUI_DialogEventObj() cellObj]; }

void DialogEventSetCell( NSCell *cell )
{ [CUI_DialogEventObj() setCellObj:cell]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
UTType *DialogEventUTType( void )
{ return [CUI_DialogEventObj() utTypeObj]; }

void DialogEventSetUTType( UTType *type )
{ [CUI_DialogEventObj() setUtTypeObj:type]; }
#endif // 110000

NSWindow *DialogEventWindow( void )
{ return [CUI_DialogEventObj() windowObj]; }

void DialogEventSetWindow( NSWindow *wnd )
{ [CUI_DialogEventObj() setWindowObj:wnd]; }


#pragma mark - FB keywords
// all dialog stuff moved to here from AppThings.c and CocoaUI.m - 20211004
enum {
    kFBUserDialog = 23
};

void FBDialogStatement( long id )
{ CallUserDefinedOnDialogFunction( kFBUserDialog, id, 0, NULL ); }

CUI_OnDialogFunctionType CUI_OnDialogFunction( void )
{ return sCUI_OnDialogFunction; }

void CUI_SetOnDialogFunction( CUI_OnDialogFunctionType onDialogFn )
{ sCUI_OnDialogFunction = onDialogFn; }

void CallUserDefinedOnDialogFunction( long fbEventKind, long fbEventID, long fbWndNum, CFTypeRef object )
{
    CUI_OnDialogFunctionType onDialogFn = CUI_OnDialogFunction();
    if ( onDialogFn ) {
        (*onDialogFn)( fbEventKind, fbEventID, fbWndNum, object );
    }
}
