/*
 View.m
 
 Bernie Wylde
 */

#import "View.h"

#pragma mark - view controller
@implementation CUI_ViewController
@end


#pragma mark - tooltip owner
@implementation CUI_ViewToolTipOwner
#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.view release];
    [super dealloc];
}
#endif

- (NSString *)view:(NSView *)view stringForToolTip:(NSToolTipTag)tag point:(NSPoint)point userData:(void *)data {
    return (__bridge NSString *)(*self.stringForToolTipCallback)([view tag],tag,NSPointToCGPoint(point),data);
}
@end

static NSMutableArray *sCUI_ViewToolTipOwners;

CUI_ViewToolTipOwner *CUI_ViewToolTipOwnerObj( void )
{
    if ( !sCUI_ViewToolTipOwners ) sCUI_ViewToolTipOwners = [[NSMutableArray alloc] initWithCapacity:0];
    CUI_ViewToolTipOwner *owner = [[CUI_ViewToolTipOwner alloc] init];
    [sCUI_ViewToolTipOwners addObject:owner];
    return owner;
}


#pragma mark - view
@implementation ViewSC

//- (void)drawLayer:(CALayer *)theLayer inContext:(CGContextRef)theContext {
//    CallUserDefinedOnDialogFunction( CALayerDraw, 0, 0, NULL );
//}

//- (void)setTrackingAreaRect:(NSRect)rect options:(NSTrackingAreaOptions)options {
//    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:rect options:options owner:self userInfo:nil];
//    [self addTrackingArea:trackingArea];
//    [trackingArea release];
//}

//- (void)viewWillMoveToWindow:(NSWindow *)newWindow {
//    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveAlways;
//    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:options owner:self userInfo:nil];
//    [self addTrackingArea:trackingArea];
//}

- (void)drawRect:(NSRect)dirtyRect {
    if ( ![self suspendDrawRect] ) {
        CUI_ViewSubclassDrawRect( self, dirtyRect );
        if ( !DialogEventBool() ) [super drawRect:dirtyRect];
    }
}

// this is required for key events
//- (BOOL)acceptsFirstResponder {
//    return self.responderFlag;
//}

- (BOOL)acceptsFirstResponder {
    DialogEventSetBool(NO);
    return CUI_ResponderAcceptsFirstResponder( self );
}

- (void)mouseDown:(NSEvent *)event {
    DialogEventSetBool(NO);
    CUI_ResponderMouseDown( self, event );
    if ( !DialogEventBool() ) [super mouseDown:event];
}

- (void)mouseUp:(NSEvent *)event {
    DialogEventSetBool(NO);
    CUI_ResponderMouseUp( self, event );
    if ( !DialogEventBool() ) [super mouseUp:event];
}

- (void)mouseEntered:(NSEvent *)event {
    CUI_ResponderMouseEntered( self, event );
}

- (void)mouseExited:(NSEvent *)event {
    CUI_ResponderMouseExited( self, event );
}

- (void)mouseDragged:(NSEvent *)event {
    [super mouseDragged:event];

    DialogEventSetBool(NO);
    CUI_ResponderMouseDragged( self, event );
    //if ( !DialogEventBool() ) [super mouseDragged:event];

}

- (void)mouseMoved:(NSEvent *)event {
    DialogEventSetBool(NO);
    CUI_ViewSubclassMouseMoved( self, event );
    if ( !DialogEventBool() ) [super mouseMoved:event];
}

- (void)rightMouseDown:(NSEvent *)event {
    CUI_ViewSubclassRightMouseDown( self, event );
    if ( !DialogEventBool() ) [super rightMouseDown:event];
}

- (void)rightMouseUp:(NSEvent *)event {
    CUI_ViewSubclassRightMouseUp( self, event );
}

- (void)rightMouseDragged:(NSEvent *)event {
    CUI_ViewSubclassRightMouseDragged( self, event );
}

- (void)keyDown:(NSEvent *)event {
    CUI_ViewSubclassKeyDown( self, event );
    if ( !DialogEventBool() ) [super keyDown:event];
}

- (void)keyUp:(NSEvent *)event {
    CUI_ViewSubclassKeyUp( self, event );
    //    if ( !DialogEventBool() ) [super keyUp:event];
}

- (void)flagsChanged:(NSEvent *)event {
    CUI_ViewSubclassFlagsChanged( self, event );
    //    if ( !DialogEventBool() ) [super flagsChanged:event];
}

- (void)updateTrackingAreas {
    NSArray *areas = [self trackingAreas];
    if ( [areas count] > 0 ) {
        NSTrackingArea *trackingArea = [areas objectAtIndex:0];
        [self removeTrackingArea:trackingArea];
        
#if !__has_feature(objc_arc)
        [trackingArea release];// ????
#endif
        
        NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow | NSTrackingInVisibleRect;
        trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:options owner:self userInfo:nil];
        [self addTrackingArea:trackingArea];
        //[trackingArea release];// ????
    }
    //[super updateTrackingAreas];
}

- (void)resetCursorRects {
    CUI_ViewSubclassResetCursorRects( self );
}

#pragma mark - dragging
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    return CUI_ViewSubclassDraggingEntered( self, sender );
}

//- (BOOL)wantsPeriodicDraggingUpdates {
//    return NO;
//}

//- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
//
//    return NSDragOperationNone;
//}

- (void)draggingEnded:(id<NSDraggingInfo>)sender {
    
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    CUI_ViewSubclassDraggingExited( self, sender );
}

//- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
//    return NO;
//}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    return CUI_ViewSubclassPerformDragOperation( self, sender );
}

- (void)concludeDragOperation:(id<NSDraggingInfo>)sender {
    
}

- (void)updateDraggingItemsForDrag:(id<NSDraggingInfo>)sender {
    
}

- (void)viewDidChangeEffectiveAppearance {
    CUI_ViewSubclassViewDidChangeEffectiveAppearance( self );
}

#pragma mark - flipped
- (BOOL)isFlipped {
    return self.flipFlag;
}

#pragma mark - menu
- (NSMenu *)menuForEvent:(NSEvent*)theEvent {
    CUI_ViewSubclassMenuForEvent( self, theEvent );
    return DialogEventNSMenu();
}

#pragma mark - layer
- (BOOL)wantsUpdateLayer {
    return CUI_ViewSubclassWantsUpdateLayer( self );
}

- (void)updateLayer {
    CUI_ViewSubclassUpdateLayer( self );
}

//- (void)displayLayer:(CALayer *)layer {
//    CallUserDefinedOnDialogFunction( caLayerDisplay, 0, 0, layer );
//}
//
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
//    DialogEventSetCGContext( ctx );
//    CallUserDefinedOnDialogFunction( caLayerDraw, 0, 0, layer );
//}
//
//- (void)layerWillDraw:(CALayer *)layer {
//    CallUserDefinedOnDialogFunction( caLayerWillDraw, 0, 0, layer );
//}
//
//- (void)layoutSublayersOfLayer:(CALayer *)layer {
//    CallUserDefinedOnDialogFunction( caLayerLayoutSublayers, 0, 0, layer );
//}
//
//- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
//    DialogEventSetNSString( event );
//    DialogEventSetCAAction( nil );
//    CallUserDefinedOnDialogFunction( caLayerAction, 0, 0, layer );
//    return DialogEventCAAction();
//}

- (void)awakeFromNib {
    CUI_ViewSubclassAwakeFromNib( self );
}
@end

/*
 CUI_ViewWindowTag // 20220721

 The returned value can be either a window tag or popover tag
*/
NSInteger CUI_ViewWindowTag( id view )
{
    NSInteger wndTag = 0;
    
    NSWindow *window = [(NSView *)view window];
    wndTag = [window tag];
    if ( wndTag == 0 ) {
        NSPopover *popover = CUI_PopoverForView( view );
        if ( popover ) wndTag = [popover tag];
    }
    return wndTag;
}


void CUI_ViewSubclassDrawRect( id view, NSRect dirtyRect )
{
    DialogEventSetBool( NO );
    DialogEventSetNSRect( dirtyRect );
    CUI_EventSetEvent( [NSApp currentEvent] );// 20220227
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( viewDrawRect, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)view );
}

void CUI_ViewSubclassAcceptsFirstResponder( id view )
{
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( viewAcceptsFirstResponder, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)view );
}

void CUI_ViewSubclassMouseDown( NSView *view, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_ResponderMouseDown( view, event );
}

void CUI_ViewSubclassMouseUp( NSView *view, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_ResponderMouseUp( view, event );
}

void CUI_ViewSubclassMouseEntered( NSView *view, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_ResponderMouseEntered( view, event );
}

void CUI_ViewSubclassMouseExited( NSView *view, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_ResponderMouseExited( view, event );
}

void CUI_ViewSubclassMouseDragged( NSView *view, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_ResponderMouseDragged( view, event );
}

void CUI_ViewSubclassMouseMoved( NSView *view, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_ResponderMouseMoved( view, event );
}

void CUI_ViewSubclassRightMouseDown( NSView *view, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( viewRightMouseDown, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
    //CUI_ResponderRightMouseDown( view, event );
}

void CUI_ViewSubclassRightMouseUp( NSView *view, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( viewRightMouseUp, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
    //CUI_ResponderRightMouseUp( view, event );
}

void CUI_ViewSubclassRightMouseDragged( NSView *view, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( viewRightMouseDragged, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
    //CUI_ResponderRightMouseDragged( view, event );
}

void CUI_ViewSubclassKeyDown( NSView *view, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( viewKeyDown, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
    //CUI_ResponderKeyDown( view, event );
}

void CUI_ViewSubclassKeyUp( NSView *view, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( viewKeyUp, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
    //CUI_ResponderKeyUp( view, event );
}

void CUI_ViewSubclassFlagsChanged( NSView *view, NSEvent *event )
{
    DialogEventSetBool(NO);
    CUI_EventSetEvent( event );
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( viewFlagsChanged, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
    //CUI_ResponderFlagsChanged( view, event );
}

//void CUI_ViewSubclassUpdateTrackingAreas( NSView *view )
//{
//    DialogEventSetBool(NO);
//    NSWindow *window = [view window];
//    CUI_OutputWindowSetTag( [window tag] );
//    CallUserDefinedOnDialogFunction( viewUpdateTrackingAreas, CUI_ViewTag(view), [window tag], nil );
//
//    if ( !DialogEventBool() ) {
//        NSTrackingArea *trackingArea;
//        NSArray *areas = [view trackingAreas];
//        if ( [areas count] > 0 ) {
//            trackingArea = [areas objectAtIndex:0];
//            [view removeTrackingArea:trackingArea];
//            [trackingArea release];
//            NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow | NSTrackingInVisibleRect;
//            trackingArea = [[NSTrackingArea alloc] initWithRect:[view bounds] options:options owner:view userInfo:nil];
//            [view addTrackingArea:trackingArea];
//        }
//    }
//}

void CUI_ViewSubclassResetCursorRects( NSView *view )
{
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( viewResetCursorRects, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)view );
}

NSDragOperation CUI_ViewSubclassDraggingEntered( NSView *view, id<NSDraggingInfo>sender )
{
    NSDragOperation dragOperation = NSDragOperationNone;

    DialogEventSetLong((long)dragOperation);
    NSArray *regTypes = [view registeredDraggedTypes];

    if ( [regTypes containsObject:NSFilenamesPboardType] ) {
        NSInteger wndTag = CUI_ViewWindowTag( view );

        CUI_OutputWindowSetTag( wndTag );

        NSPasteboard *pb = [sender draggingPasteboard];
        NSArray *pbTypes = [pb types];
        if ( [pbTypes containsObject:NSFilenamesPboardType] ) {
            DialogEventSetDraggingInfo(sender);

            NSArray *files = [pb propertyListForType:NSFilenamesPboardType];

            BOOL validFile = NO;

            if ( view.dragFileTypes != nil || view.dragFileExtensions != nil ) {
                for ( NSString *path in files ) {
                    validFile = NO;

                    if ( view.dragFileTypes ) {
                        NSString *utiType = [[NSWorkspace sharedWorkspace] typeOfFile:path error:nil];
                        for ( NSString *type in view.dragFileTypes ) {
                            if ( [[NSWorkspace sharedWorkspace] type:utiType conformsToType:(id)type] ) {
                                validFile = YES;
                                break;
                            }
                        }
                    }

                    if ( !validFile ) {
                        if ( view.dragFileExtensions ) {
                            NSString *extension = [path pathExtension];
                            if ( extension ) {
                                if ( [view.dragFileExtensions containsObject:extension] ) {
                                    validFile = YES;
                                }
                            }
                        }
                    }

                    if ( !validFile ) break;
                }
            } else {
                validFile = YES;
            }

            if ( validFile ) {
                dragOperation = NSDragOperationLink;
                NSMutableArray *urls = [NSMutableArray arrayWithCapacity:[files count]];
                for ( NSString *path in files ) {
                    [urls addObject:[NSURL fileURLWithPath:path]];
                }
                DialogEventSetNSArray( urls );
                DialogEventSetNSURL( [urls objectAtIndex:0] );
                view.dragInsideFlag = YES;
                DialogEventSetLong((long)dragOperation);
                CallUserDefinedOnDialogFunction( viewDraggingEntered, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)urls );
                DialogEventSetDraggingInfo(nil);
                DialogEventSetNSArray( nil );
                DialogEventSetNSURL( nil );
            }
        }
    }
    return DialogEventLong();
}

void CUI_ViewSubclassDraggingExited( NSView *view, id <NSDraggingInfo>sender )
{
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    DialogEventSetDraggingInfo(sender);
    view.dragInsideFlag = NO;
    CallUserDefinedOnDialogFunction( viewDraggingExited, CUI_ViewTag(view), wndTag, nil );
    DialogEventSetDraggingInfo(nil);
    DialogEventSetNSArray( nil );
    DialogEventSetNSURL( nil );
}

BOOL CUI_ViewSubclassPerformDragOperation( NSView *view, id <NSDraggingInfo>sender )
{
    [[NSCursor arrowCursor] set];
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    NSPasteboard *pb = [sender draggingPasteboard];
    NSArray *files = [pb propertyListForType:NSFilenamesPboardType];
    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:[files count]];

    for ( NSString *path in files ) {
        [urls addObject:[NSURL fileURLWithPath:path]];
    }

    DialogEventSetNSArray( urls );
    DialogEventSetNSURL( [urls objectAtIndex:0] );
    DialogEventSetDraggingInfo(sender);
    DialogEventSetBool(NO);
    CallUserDefinedOnDialogFunction( viewPerformDragOperation, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)urls );
    CUI_ViewSubclassDraggingExited( view, sender );
    return YES;
}

void CUI_ViewSubclassViewDidChangeEffectiveAppearance( id view )
{
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CallUserDefinedOnDialogFunction( viewDidChangeEffectiveAppearance, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)view );
}

void CUI_ViewSubclassMenuForEvent( id view, NSEvent *event )
{
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_EventSetEvent( event );// 20231221
    DialogEventSetNSMenu( [(NSView *)view menu] );
    CallUserDefinedOnDialogFunction( viewMenuForEvent, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)event );
}

BOOL CUI_ViewSubclassWantsUpdateLayer( id view )
{
    NSInteger wndTag = CUI_ViewWindowTag( view );
    DialogEventSetBool(NO);
    CallUserDefinedOnDialogFunction( viewWantsUpdateLayer, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)view );
    return DialogEventBool();
}

void CUI_ViewSubclassUpdateLayer( id view )
{
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CallUserDefinedOnDialogFunction( viewUpdateLayer, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)view );
}

void CUI_ViewSubclassAwakeFromNib( id view )
{
    NSInteger wndTag = CUI_ViewWindowTag( view );
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( viewAwakeFromNib, CUI_ViewTag(view), wndTag, (__bridge CFTypeRef)view );
}

static CUI_SortSubviewsFunctionType sCUI_SortSubviewsFunctionAddress;

NSComparisonResult CUI_SortSubviewsFunction( NSView *view1, NSView *view2, void *context )
{
    NSInteger tag1 = [view1 tag];
    NSInteger tag2 = [view2 tag];
    if ( sCUI_SortSubviewsFunctionAddress ) return (*sCUI_SortSubviewsFunctionAddress)(tag1,tag2,context);
    return NSOrderedSame;
}


@implementation NSView (Additions)

// suspendDrawRect
@dynamic suspendDrawRectNumber;
- (BOOL)suspendDrawRect {
    return [objc_getAssociatedObject(self, @selector(suspendDrawRectNumber)) boolValue];
}
- (void)setSuspendDrawRect:(BOOL)flag {
    objc_setAssociatedObject(self, @selector(suspendDrawRectNumber), [NSNumber numberWithBool:flag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// flipFlag
@dynamic flipFlagNumber;
- (BOOL)flipFlag {
    return [objc_getAssociatedObject(self, @selector(flipFlagNumber)) boolValue];
}
- (void)setFlipFlag:(BOOL)flag {
    objc_setAssociatedObject(self, @selector(flipFlagNumber), [NSNumber numberWithBool:flag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// responderFlag
@dynamic responderFlagNumber;
- (BOOL)responderFlag {
    return [objc_getAssociatedObject(self, @selector(responderFlagNumber)) boolValue];
}
- (void)setResponderFlag:(BOOL)flag {
    objc_setAssociatedObject(self, @selector(responderFlagNumber), [NSNumber numberWithBool:flag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// dragFileTypes
@dynamic dragFileTypesArray;
- (NSArray *)dragFileTypes {
    return objc_getAssociatedObject(self, @selector(dragFileTypesArray));
}
- (void)setDragFileTypes:(NSArray *)types {
    objc_setAssociatedObject(self, @selector(dragFileTypesArray), types, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// dragFileExtensions
@dynamic dragFileExtensionsArray;
- (NSArray *)dragFileExtensions {
    return objc_getAssociatedObject(self, @selector(dragFileExtensionsArray));
}
- (void)setDragFileExtensions:(NSArray *)extensions {
    objc_setAssociatedObject(self, @selector(dragFileExtensionsArray), extensions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// dragInsideFlag
@dynamic dragInsideFlagNumber;
- (BOOL)dragInsideFlag {
    return [objc_getAssociatedObject(self, @selector(dragInsideFlagNumber)) boolValue];
}
- (void)setDragInsideFlag:(BOOL)flag {
    objc_setAssociatedObject(self, @selector(dragInsideFlagNumber), [NSNumber numberWithBool:flag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


#pragma mark - private
id CUI_FindViewInMenu( NSInteger tag, NSMenu *menu )// 20231227
{
    NSArray *items = [menu itemArray];
    for ( NSMenuItem *item in items ) {
        id view = [item view];
        if ( view ) {
            if ( [view respondsToSelector:@selector(tag)] ) {
                if ( [view tag] == tag ) return view;
            }
            if ( [view respondsToSelector:@selector(identifier)] ) {
                if ( [[view identifier] integerValue] == tag ) return view;
            }
            
            // check subviews
            id subview = CUI_ViewSubviewWithTag( view, tag );
            if ( subview ) return subview;
        }
        NSMenu *submenu = [item submenu];
        if ( submenu ) {
            view = CUI_FindViewInMenu( tag, submenu );
            if ( view ) return view;
        }
    }
    return nil;
}

id CUI_FindViewInAnyMenu( NSInteger tag )// 20231227
{
    id view = CUI_FindViewInMenu( tag, [NSApp mainMenu] );
    if ( view ) return view;
    NSArray *otherMenus = CUI_OtherMenus();
    if ( otherMenus ) {
        for ( NSMenu *menu in otherMenus ) {
            view = CUI_FindViewInMenu( tag, menu );
            if ( view ) return view;
        }
    }
    return nil;
}

BOOL CUI_ViewWithKindOfClassExists( NSInteger tag, Class cls )
{
    id w = nil;
    NSView *contentView = CUI_OutputWindowContentView();
    if ( !contentView ) {
        w = CUI_FrontWindow();
        contentView = [(NSWindow *)w contentView];
    }

    if ( contentView ) {
        id view = CUI_ViewWithTag( tag );
        if ( view ) {
            if ( [(NSObject *)view isKindOfClass:cls] ) {
                return YES;
            }
        }
    }
    return NO;
}


//id CUI_ViewWithKindOfClassInAnyWindow( NSInteger tag, Class cls )// 20250217
//{
//    // first look in the current output window
//    NSInteger wndTag = 0;
//    id w = CUI_TargetWindow( &wndTag );
//    if ( w ) {
//        NSView *contentView = CUI_TargetContentView( w );
//        id view = CUI_ViewSubviewWithTag( contentView, tag );
//        if ( view ) {
//            if ( [(NSObject *)view isKindOfClass:cls] ) return view;
//        }
//    }
//    
//    // if not found, search all windows from front to back
//    NSArray *windows = [NSApp orderedWindows];
//    for ( NSWindow *w in windows ) {
//        NSView *contentView = [w contentView];
//        id view = CUI_ViewSubviewWithTag( contentView, tag );
//        if ( view ) {
//            if ( [(NSObject *)view isKindOfClass:cls] ) return view;
//        }
//    }
//    return nil;
//}


#if 1

id CUI_ValidateViewKindOfClass( NSInteger tag, Class cls )
{
    if ( tag > 1000000 ) {
        id view = (__bridge id)(void *)tag;
        if ( [view isKindOfClass:cls] ) {
            return view;
        } else {
            CUI_ShowAlert( NSWarningAlertStyle, @"Class error.", [NSString stringWithFormat:@"View %@ cannot respond to %@ messages.",view,cls] );
        }
    } else {
        id view = CUI_FindViewInAnyMenu( tag );
        if ( view ) return view;
        
        id w = nil;
        NSView *contentView = CUI_OutputWindowContentView();
        if ( !contentView ) {
            w = CUI_FrontWindow();
            contentView = [(NSWindow *)w contentView];
        }
        
        if ( contentView ) {
            w = [contentView window];
            id view = CUI_ViewWithTag( tag );
            if ( view ) {
                
                if ( [(NSObject *)view isKindOfClass:cls] ) {
                    return view;
                } else {
                              
//                    view = CUI_ViewWithKindOfClassInAnyWindow( tag, cls ); // 20250226
//                    if ( view ) return view; // 20250226
                    
                    CUI_ShowAlert( NSWarningAlertStyle, @"Class error.", [NSString stringWithFormat:@"View %ld (%@), in window %ld, cannot respond to %@ messages.",(long)tag,[(NSObject *)view class],(long)[(NSWindow *)w tag],cls] );
                }
            } else {
                CUI_ShowAlert( NSWarningAlertStyle, @"Tag error.", [NSString stringWithFormat:@"Can't find view %ld in window %ld.",(long)tag,(long)[(NSWindow *)w tag]] );
            }
        } else {
            CUI_ShowAlert( NSWarningAlertStyle, @"Error.", @"Can't find any windows." );
        }
    }
    return nil;
}

#else

id CUI_ValidateViewKindOfClass( NSInteger tag, Class cls )
{
    if ( tag > 1000000 ) {
        id view = (__bridge id)(void *)tag;
        if ( [view isKindOfClass:cls] ) {
            return view;
        } else {
            CUI_ShowAlert( NSWarningAlertStyle, @"Class error.", [NSString stringWithFormat:@"View %@ cannot respond to %@ messages.",view,cls] );
        }
    } else {
        id view = CUI_FindViewInAnyMenu( tag );
        if ( view ) return view;
        
        id w = nil;
        NSView *contentView = CUI_OutputWindowContentView();
        if ( !contentView ) {
            w = CUI_FrontWindow();
            contentView = [(NSWindow *)w contentView];
        }
        
        if ( contentView ) {
            w = [contentView window];
            id view = CUI_ViewWithTag( tag );
            if ( view ) {
                
                if ( [(NSObject *)view isKindOfClass:cls] ) {
                    return view;
                } else {
                    CUI_ShowAlert( NSWarningAlertStyle, @"Class error.", [NSString stringWithFormat:@"View %ld (%@), in window %ld, cannot respond to %@ messages.",(long)tag,[(NSObject *)view class],(long)[(NSWindow *)w tag],cls] );
                }
            } else {
                CUI_ShowAlert( NSWarningAlertStyle, @"Tag error.", [NSString stringWithFormat:@"Can't find view %ld in window %ld.",(long)tag,(long)[(NSWindow *)w tag]] );
            }
        } else {
            CUI_ShowAlert( NSWarningAlertStyle, @"Error.", @"Can't find any windows." );
        }
    }
    return nil;
}

#endif

BOOL CUI_ValidateViewClass( NSInteger wndTag, NSInteger viewTag, id obj, Class requiredClass )
{
    if ( ![(NSObject *)obj isKindOfClass:requiredClass] ) {
        if ( wndTag ) {
            CUI_ShowAlert( NSWarningAlertStyle, @"Class error.", [NSString stringWithFormat:@"View %ld (%@), in window %ld, expected %@ class.",(long)viewTag,requiredClass,(long)wndTag,[(NSObject *)obj class]] );
        } else {
            CUI_ShowAlert( NSWarningAlertStyle, @"Class error.", [NSString stringWithFormat:@"View %ld (%@), expected %@ class.",(long)viewTag,requiredClass,[(NSObject *)obj class]] );
        }
        return NO;
    }
    return YES;
}

id ViewSubviewWithIdentifier( id superview, CFStringRef identifier )
{
    NSArray *subviews = [superview subviews];
    NSView *obj2;
    for ( NSView *obj in subviews ) {
        if ( class_respondsToSelector( [obj class], NSSelectorFromString( @"identifier" ) ) ) {
            if ( [obj identifier] != nil ) {
                if ( [[obj identifier] compare:(__bridge NSString *)identifier] == NSOrderedSame ) {
                    return obj;
                }
            }
            obj2 = ViewSubviewWithIdentifier( obj, identifier );
            if ( obj2 != nil ) return obj2;
        }
    }
    return nil;
}

// Class
Class ViewClass( void )
{ return [NSView class]; }

NSInteger CUI_ViewTag( id view )
{
    NSInteger tag = 0;
    if ( [(NSView *)view class] == [NSView class] || [(NSView *)view class] == [ViewSC class] || [(NSView *)view class] == [ContentViewSC class] || [(NSView *)view class] == [CUI_RadioGroup class] ) {
        tag = [[(NSView *)view identifier] integerValue];
    } else {
        tag = [(NSView *)view tag];
    }
    return tag;
}

id CUI_ViewSubviewWithTag( NSView *superview, NSInteger tag )
{
    NSView *obj = nil;
    
    if ( [superview isKindOfClass:[NSTabView class]] ) {
        NSArray *items = [(NSTabView *)superview tabViewItems];
        for ( NSTabViewItem *item in items ) {
            NSView *itemView = [item view];
            obj = CUI_ViewSubviewWithTag( itemView, tag );
            if ( obj ) return obj;
        }
    } else if ( [superview class] == [NSSegmentedControl class] ) { // don't descend into segmented control because segment views are given tag values by macOS < 10.13
        return nil;
    } else {
        NSArray *subviews = [superview subviews];
        for ( obj in subviews ) {
            
            NSInteger viewTag = 0;
            if ( [obj class] == [NSView class] || [obj class] == [ViewSC class] || [obj class] == [CUI_RadioGroup class] ) {
                viewTag = [[obj identifier] integerValue];
            } else {
                if ( [obj class] == [NSVisualEffectView class] ) {
                    viewTag = [[obj identifier] integerValue];
                } else {
                    viewTag = [obj tag];
                }
            }
            
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
            if (@available(macOS 14.0, *)) {
                if ( [obj isKindOfClass:[NSTextInsertionIndicator class]] ) {// 20230924
                    viewTag = [[obj identifier] integerValue];
                }
            }
#endif// 140000
            
            if ( viewTag == tag ) return obj;
            obj = CUI_ViewSubviewWithTag( obj, tag );
            if ( obj ) return obj;
        }
    }
    return nil;
}

NSView *CUI_ViewWithTag( NSInteger tag )
{
    NSView *view = nil;
    
    if ( tag ) {
        if ( tag > 1000000 ) {
            //return (NSView *)tag;
            return (__bridge NSView *)(void *)tag;
        }
        
        // could the view be in a popover? // 20220721
        NSPopover *popover = CUI_PopoverShown();
        if ( popover ) {
            NSView *popoverView = [[popover contentViewController] view];
            if ( popoverView ) {
                view = CUI_ViewSubviewWithTag( popoverView, tag );
                if ( view ) return view;
            }
        }
        
        // check if the view is in a menu item // 20231227
        if ( !view ) {
            view = CUI_FindViewInAnyMenu( tag );
            if ( view ) return view;
        }
        
        NSView *contentView = CUI_OutputWindowContentView();
        if ( !contentView ) {
            NSWindow *w = CUI_FrontWindow();
            contentView = [w contentView];
        }
        if ( contentView ) {
            NSWindow *w = [contentView window];
            
            if ( tag == windowContentViewTag ) return contentView;
            
            view = CUI_ViewSubviewWithTag( contentView, tag );
            
            // check window titlebar accessoryview
            if ( !view ) {
                view = TitlebarAccessoryViewWithTag( tag );
            }
            
            // it may be in the toolbar
            if ( !view ) {
                NSToolbar *toolbar = [w toolbar];
                if ( toolbar ) {
                    NSInteger toolbarTag = CUI_ToolbarTag( toolbar );
                    if ( toolbarTag ) {
                        NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, tag );
                        if ( item ) {
                            view = item.view;
                        }
                    }
                }
            }
            
        } else {
            
            // warn of 0 view tag
            
        }
    }
    return view;
}

NSInteger ViewSuperview( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        NSView *superview = [view superview];
        if ( superview ) return CUI_ViewTag(superview);
    }
    return 0;
}

CFArrayRef ViewSubviews( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view subviews];
    return nil;
}

NSInteger ViewWindow( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        NSWindow *w = [view window];
        if ( w ) return [w tag];
    }
    return 0;
}

void ViewSetFrameOrigin( NSInteger tag, CGPoint origin )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view setFrameOrigin:NSPointFromCGPoint( origin )];
    }
}

void ViewSetFrameSize( NSInteger tag, CGSize size )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view setFrameSize:NSSizeFromCGSize( size )];
    }
}

void ViewSetFrameRotation( NSInteger tag, CGFloat rotation )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view setFrameRotation:rotation];
    }
}

CGRect ViewBounds( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        return NSRectToCGRect( [view bounds] );
    }
    return CGRectZero;
}

void ViewSetBounds( NSInteger tag, CGRect bounds )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view setBounds:NSRectFromCGRect( bounds )];
    }
}

void ViewSetBoundsOrigin( NSInteger tag, CGPoint origin )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view setBoundsOrigin:NSPointFromCGPoint( origin )];
    }
}

void ViewSetBoundsSize( NSInteger tag, CGSize size )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view setBoundsSize:NSSizeFromCGSize( size )];
    }
}

void ViewSetBoundsRotation( NSInteger tag, CGFloat rotation )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view setBoundsRotation:rotation];
    }
}

CGFloat ViewFrameRotation( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view frameRotation];
    return 0.0;
}

CGFloat ViewBoundsRotation( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view boundsRotation];
    return 0.0;
}


// Layer
void ViewSetWantsLayer( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setWantsLayer:flag];
}

BOOL ViewWantsUpdateLayer( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view wantsUpdateLayer];
    return NO;
}

CALayer *ViewLayer( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view layer];
    return nil;
}

void ViewSetLayer( NSInteger tag, CALayer *layer )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setLayer:layer];
}

CALayer *ViewMakeBackingLayer( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view makeBackingLayer];
    return nil;
}

NSViewLayerContentsPlacement ViewLayerContentsPlacement( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view layerContentsPlacement];
    return 0;
}

void ViewSetLayerContentsPlacement( NSInteger tag, NSViewLayerContentsPlacement placement )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setLayerContentsPlacement:placement];
}

NSViewLayerContentsRedrawPolicy ViewLayerContentsRedrawPolicy( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view layerContentsRedrawPolicy];
    return 0;
}

void ViewSetLayerContentsRedrawPolicy( NSInteger tag, NSViewLayerContentsRedrawPolicy policy )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setLayerContentsRedrawPolicy:policy];
}

BOOL ViewCanDrawSubviewsIntoLayer( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view canDrawSubviewsIntoLayer];
    return 0;
}

void ViewSetCanDrawSubviewsIntoLayer( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setCanDrawSubviewsIntoLayer:flag];
}

BOOL ViewLayerUsesCoreImageFilters( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view layerUsesCoreImageFilters];
    return 0;
}

void ViewSetLayerUsesCoreImageFilters( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setLayerUsesCoreImageFilters:flag];
}

CGFloat ViewAlphaValue( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        return [view alphaValue];
    }
    return 0;
}

void ViewSetAlphaValue( NSInteger tag, CGFloat value )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view setAlphaValue:value];
    }
}

CGFloat ViewFrameCenterRotation( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        return [view frameCenterRotation];
    }
    return 0;
}

void ViewSetFrameCenterRotation( NSInteger tag, CGFloat rotation )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view setFrameCenterRotation:rotation];
    }
}

CFArrayRef ViewBackgroundFilters( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view backgroundFilters];
    return nil;
}

void ViewSetBackgroundFilters( NSInteger tag, CFArrayRef filters )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setBackgroundFilters:(__bridge NSArray *)filters];
}

CIFilter *ViewCompositingFilter( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view compositingFilter];
    return nil;
}

void ViewSetCompositingFilter( NSInteger tag, CIFilter *filter )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setCompositingFilter:filter];
}

CFArrayRef ViewContentFilters( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view contentFilters];
    return nil;
}

void ViewSetContentFilters( NSInteger tag, CFArrayRef filters )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setContentFilters:(__bridge NSArray *)filters];
}

NSShadow *ViewShadow( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view shadow];
    return nil;
}

void ViewSetShadow( NSInteger tag, NSShadow *shadow )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view setWantsLayer:YES];
        [view setShadow:shadow];
    }
}


// Drawing
void ViewUpdateLayer( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view updateLayer];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
BOOL ViewClipsToBounds( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view clipsToBounds];
    return NO;
}
void ViewSetClipsToBounds( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setClipsToBounds:flag];
}
#endif// 140000

BOOL ViewCanDrawConcurrently( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view canDrawConcurrently];
    return NO;
}

void ViewSetCanDrawConcurrently( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setCanDrawConcurrently:flag];
}

CGRect ViewVisibleRect( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return NSRectToCGRect([view visibleRect]);
    return CGRectZero;
}

BOOL ViewNeedsToDrawRect( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view needsToDrawRect:NSRectFromCGRect(r)];
    return NO;
}

BOOL ViewWantsDefaultClipping( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view wantsDefaultClipping];
    return NO;
}

NSBitmapImageRep *ViewBitmapImageRepForCachingDisplayInRect( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view bitmapImageRepForCachingDisplayInRect:NSRectFromCGRect(r)];
    return nil;
}

void ViewCacheDisplayInRectToBitmapImageRep( NSInteger tag, CGRect r, NSBitmapImageRep *repRef )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view cacheDisplayInRect:NSRectFromCGRect(r) toBitmapImageRep:repRef];
}

void ViewPrint( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view print:nil];
    }
}

void ViewBeginPageInRect( NSInteger tag, CGRect r, CGPoint location )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view beginPageInRect:NSRectFromCGRect(r) atPlacement:NSPointFromCGPoint(location)];
}

CFDataRef ViewDataWithEPSInsideRect( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFDataRef)[view dataWithEPSInsideRect:NSRectFromCGRect(r)];
    return nil;
}

CFDataRef ViewDataWithPDFInsideRect( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFDataRef)[view dataWithPDFInsideRect:NSRectFromCGRect(r)];
    return nil;
}

CFStringRef ViewPrintJobTitle( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFStringRef)[view printJobTitle];
    return nil;
}

CFAttributedStringRef ViewPageHeader( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFAttributedStringRef)[view pageHeader];
    return nil;
}

CFAttributedStringRef ViewPageFooter( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFAttributedStringRef)[view pageFooter];
    return nil;
}

void ViewWriteEPSInsideRectToPasteboard( NSInteger tag, CGRect r, NSPasteboard *pb )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view writeEPSInsideRect:NSRectFromCGRect(r) toPasteboard:pb];
}

void ViewWritePDFInsideRectToPasteboard( NSInteger tag, CGRect r, NSPasteboard *pb )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view writePDFInsideRect:NSRectFromCGRect(r) toPasteboard:pb];
}

void ViewDrawPageBorderWithSize( NSInteger tag, CGSize size )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view drawPageBorderWithSize:NSSizeFromCGSize(size)];
}

// Pagination
CGFloat ViewHeightAdustLimit( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view heightAdjustLimit];
    return 0.0;
}

CGFloat ViewWidthAdustLimit( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view widthAdjustLimit];
    return 0.0;
}

void ViewAdjustPageWidth( NSInteger tag, CGFloat *newRight, CGFloat oldLeft, CGFloat oldRight, CGFloat rightLimit )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view adjustPageWidthNew:newRight left:oldLeft right:oldRight limit:rightLimit];
}

void ViewAdjustPageHeight( NSInteger tag, CGFloat *newBottom, CGFloat oldTop, CGFloat oldBottom, CGFloat bottomLimit )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view adjustPageHeightNew:newBottom top:oldTop bottom:oldBottom limit:bottomLimit];
}

BOOL ViewKnowsPageRange( NSInteger tag, CFRange *range )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view knowsPageRange:(NSRangePointer)range];
    return NO;
}

CGRect ViewRectForPage( NSInteger tag, NSInteger pageNum )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return NSRectToCGRect( [view rectForPage:pageNum] );
    return CGRectZero;
}

CGPoint ViewLocationOfPrintRect( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return NSPointToCGPoint( [view locationOfPrintRect:NSRectFromCGRect(r)]);
    return CGPointZero;
}

// Invalidate view content
void ViewSetNeedsDisplayInRect( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setNeedsDisplayInRect:NSRectFromCGRect(r)];
}

BOOL ViewNeedsDisplay( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view needsDisplay];
    return NO;
}

void ViewSetNeedsDisplay( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view setNeedsDisplay:YES];
    }
}

void ViewDisplayRect( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view displayRect:NSRectFromCGRect(r)];
}

void ViewDisplayRectIgnoringOpacity( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view displayRectIgnoringOpacity:NSRectFromCGRect(r)];
}

void ViewDisplayRectIgnoringOpacityInContext( NSInteger tag, CGRect r, NSGraphicsContext *ctx )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view displayRectIgnoringOpacity:NSRectFromCGRect(r) inContext:ctx];
}

void ViewDisplay( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view display];
}

void ViewDisplayIfNeeded( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view displayIfNeeded];
}

void ViewDisplayIfNeededInRect( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view displayIfNeededInRect:NSRectFromCGRect(r)];
}

void ViewDisplayIfNeededIgnoringOpacity( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view displayIfNeededIgnoringOpacity];
}

void ViewDisplayIfNeededInRectIgnoringOpacity( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view displayIfNeededInRectIgnoringOpacity:NSRectFromCGRect(r)];
}

void ViewTranslateRectsNeedingDisplayInRect( NSInteger tag, CGRect clipRect, CGSize delta )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view translateRectsNeedingDisplayInRect:NSRectFromCGRect(clipRect) by:NSSizeFromCGSize(delta)];
}

BOOL ViewIsOpaque( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view isOpaque];
    return NO;
}

// Converting coordinate values
CGRect ViewBackingAlignedRect( NSInteger tag, CGRect r, NSAlignmentOptions options )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view backingAlignedRect:NSRectFromCGRect(r) options:options];
    return CGRectZero;
}

CGPoint ViewConvertPointFromBacking( NSInteger tag, CGPoint pt )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view convertPointFromBacking:NSPointFromCGPoint(pt)];
    return CGPointZero;
}

CGPoint ViewConvertPointToBacking( NSInteger tag, CGPoint pt )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view convertPointToBacking:NSPointFromCGPoint(pt)];
    return CGPointZero;
}

CGPoint ViewConvertPointFromLayer( NSInteger tag, CGPoint pt )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view convertPointFromLayer:NSPointFromCGPoint(pt)];
    return CGPointZero;
}

CGPoint ViewConvertPointToLayer( NSInteger tag, CGPoint pt )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view convertPointToLayer:NSPointFromCGPoint(pt)];
    return CGPointZero;
}

CGRect ViewConvertRectFromBacking( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view convertRectFromBacking:NSRectFromCGRect(r)];
    return CGRectZero;
}

CGRect ViewConvertRectToBacking( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view convertRectToBacking:NSRectFromCGRect(r)];
    return CGRectZero;
}

CGRect ViewConvertRectFromLayer( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view convertRectFromLayer:NSRectFromCGRect(r)];
    return CGRectZero;
}

CGRect ViewConvertRectToLayer( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view convertRectToLayer:NSRectFromCGRect(r)];
    return CGRectZero;
}

CGSize ViewConvertSizeFromBacking( NSInteger tag, CGSize size )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view convertSizeFromBacking:NSSizeFromCGSize(size)];
    return CGSizeZero;
}

CGSize ViewConvertSizeToBacking( NSInteger tag, CGSize size )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view convertSizeToBacking:NSSizeFromCGSize(size)];
    return CGSizeZero;
}

CGSize ViewConvertSizeFromLayer( NSInteger tag, CGSize size )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view convertSizeFromLayer:NSSizeFromCGSize(size)];
    return CGSizeZero;
}

CGSize ViewConvertSizeToLayer( NSInteger tag, CGSize size )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view convertSizeToLayer:NSSizeFromCGSize(size)];
    return CGSizeZero;
}

CGPoint ViewConvertPointFromView( NSInteger tag1, CGPoint pt, NSInteger tag2 )
{
    NSView *view1 = CUI_ViewWithTag( tag1 );
    if ( view1 ) {
        NSView *view2 = nil;
        if ( tag2 ) view2 = CUI_ViewWithTag( tag2 );
        return NSPointToCGPoint([view1 convertPoint:NSPointFromCGPoint(pt) fromView:view2]);
    }
    return CGPointZero;
}

CGPoint ViewConvertPointToView( NSInteger tag1, CGPoint pt, NSInteger tag2 )
{
    NSView *view1 = CUI_ViewWithTag( tag1 );
    if ( view1 ) {
        NSView *view2 = nil;
        if ( tag2 ) view2 = CUI_ViewWithTag( tag2 );
        return NSPointToCGPoint([view1 convertPoint:NSPointFromCGPoint(pt) toView:view2]);
    }
    return CGPointZero;
}

CGSize ViewConvertSizeFromView( NSInteger tag1, CGSize size, NSInteger tag2 )
{
    NSView *view1 = CUI_ViewWithTag( tag1 );
    if ( view1 ) {
        NSView *view2 = nil;
        if ( tag2 ) view2 = CUI_ViewWithTag( tag2 );
        return NSSizeToCGSize([view1 convertSize:NSSizeFromCGSize(size) fromView:view2]);
    }
    return CGSizeZero;
}

CGSize ViewConvertSizeToView( NSInteger tag1, CGSize size, NSInteger tag2 )
{
    NSView *view1 = CUI_ViewWithTag( tag1 );
    if ( view1 ) {
        NSView *view2 = nil;
        if ( tag2 ) view2 = CUI_ViewWithTag( tag2 );
        return NSSizeToCGSize([view1 convertSize:NSSizeFromCGSize(size) toView:view2]);
    }
    return CGSizeZero;
}

CGRect ViewConvertRectFromView( NSInteger tag1, CGRect r, NSInteger tag2 )
{
    NSView *view1 = CUI_ViewWithTag( tag1 );
    if ( view1 ) {
        NSView *view2 = nil;
        if ( tag2 ) view2 = CUI_ViewWithTag( tag2 );
        return NSRectToCGRect([view1 convertRect:NSRectFromCGRect(r) fromView:view2]);
    }
    return CGRectZero;
}

CGRect ViewConvertRectToView( NSInteger tag1, CGRect r, NSInteger tag2 )
{
    NSView *view1 = CUI_ViewWithTag( tag1 );
    if ( view1 ) {
        NSView *view2 = nil;
        if ( tag2 ) view2 = CUI_ViewWithTag( tag2 );
        return NSRectToCGRect([view1 convertRect:NSRectFromCGRect(r) toView:view2]);
    }
    return CGRectZero;
}

CGRect ViewCenterScanRect( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return NSRectToCGRect( [view centerScanRect:NSRectFromCGRect(r)]);
    return CGRectZero;
}

// Modify coordinate system
void ViewTranslateOriginToPoint( NSInteger tag, CGPoint pt )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view translateOriginToPoint:NSPointFromCGPoint(pt)];
}

void ViewScaleUnitSquareToSize( NSInteger tag, CGSize size )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view scaleUnitSquareToSize:NSSizeFromCGSize(size)];
}

void ViewRotateByAngle( NSInteger tag, CGFloat angle )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view rotateByAngle:angle];
    }
}

// Examine coordinate system
BOOL ViewIsFlipped( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    //if ( view ) return [view isFlipped];
    if ( view ) {
        if ( [view class] == [ViewSC class] ) {
            return [view flipFlag];
        } else if ( [view class] == [ContentViewSC class] ) {
            return [(ContentViewSC *)view flip];
        }
        //return [view flipFlag];
    }
    return NO;
}

void ViewSetFlipped( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        if ( [view class] == [ViewSC class] ) {
            [view setFlipFlag:flag];
        } else if ( [view class] == [ContentViewSC class] ) {
            [(ContentViewSC *)view setFlip:flag];
        }
    }
}

BOOL ViewIsRotatedFromBase( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view isRotatedFromBase];
    return NO;
}

BOOL ViewIsRotatedOrScaledFromBase( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view isRotatedOrScaledFromBase];
    return NO;
}



void ViewAddSubview( NSInteger viewTag, NSInteger subviewTag )
{
    if ( viewTag == subviewTag ) return;
    NSView *view = CUI_ViewWithTag( viewTag );
    if ( view ) {
        NSView *subview = CUI_ViewWithTag( subviewTag );
        if ( subview ) {
            [view addSubview:subview];
            [subview setWndTag:[[view window] tag]];// 20190603
        }
    }
}

void ViewAddSubviewPositioned( NSInteger superviewTag, NSInteger subviewTag, NSWindowOrderingMode position, NSInteger otherViewTag )
{
    if ( superviewTag == subviewTag ) return;
    NSView *superview = CUI_ViewWithTag( superviewTag );
    if ( superview ) {
        NSView *subview = CUI_ViewWithTag( subviewTag );
        if ( subview ) {
            NSView *otherView = nil;
            if ( otherViewTag ) otherView = CUI_ViewWithTag( otherViewTag );
            [superview addSubview:subview positioned:position relativeTo:otherView];
        }
    }
}

void ViewRemoveFromSuperview( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view removeFromSuperview];
}

void ViewRemoveFromSuperviewWithoutNeedingDisplay( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view removeFromSuperviewWithoutNeedingDisplay];
}

void ViewReplaceSubview( NSInteger tag, NSInteger subview1, NSInteger subview2 )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        NSView *view1 = CUI_ViewWithTag( subview1 );
        if ( view1 ) {
            NSView *view2 = CUI_ViewWithTag( subview2 );
            if ( view2 ) [view replaceSubview:view1 with:view2];
        }
    }
}

BOOL ViewIsDescendantOf( NSInteger tag, NSInteger superTag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        NSView *superview = CUI_ViewWithTag( superTag );
        if ( superview ) {
            return [view isDescendantOf:superview];
        }
    }
    return NO;
}

NSInteger ViewOpaqueAncestor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        NSView *ancestor = [view opaqueAncestor];
        if ( ancestor ) {
            return [ancestor tag];
        }
    }
    return 0;
}

NSInteger ViewAncestorSharedWithView( NSInteger tag, NSInteger otherTag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        NSView *otherView = CUI_ViewWithTag( otherTag );
        if ( otherView ) {
            NSView *ancestor = [view ancestorSharedWithView:otherView];
            if ( ancestor ) {
                return [ancestor tag];
            }
        }
    }
    return 0;
}

void ViewSortSubviewsUsingFunction( NSInteger tag, CUI_SortSubviewsFunctionType fnAddress, void *context )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        sCUI_SortSubviewsFunctionAddress = fnAddress;
        [view sortSubviewsUsingFunction:CUI_SortSubviewsFunction context:context];
    }
}

BOOL ViewAutoresizesSubviews( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [(NSView *)view autoresizesSubviews];
    return NO;
}

void ViewSetAutoresizesSubviews( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [(NSView *)view setAutoresizesSubviews:flag];
}

NSUInteger ViewAutoresizingMask( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view autoresizingMask];
    return 0;
}

void ViewSetAutoresizingMask( NSInteger tag, NSUInteger mask )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [(NSView *)view setAutoresizingMask:mask];
}


// Layout anchors
NSLayoutYAxisAnchor *ViewBottomAnchor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view bottomAnchor];
    return nil;
}

NSLayoutXAxisAnchor *ViewCenterXAnchor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view centerXAnchor];
    return nil;
}

NSLayoutYAxisAnchor *ViewCenterYAnchor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view centerYAnchor];
    return nil;
}

NSLayoutYAxisAnchor *ViewFirstBaselineAnchor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view firstBaselineAnchor];
    return nil;
}

NSLayoutDimension *ViewHeightAnchor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view heightAnchor];
    return nil;
}

NSLayoutYAxisAnchor *ViewLastBaselineAnchor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view lastBaselineAnchor];
    return nil;
}

NSLayoutXAxisAnchor *ViewLeadingAnchor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view leadingAnchor];
    return nil;
}

NSLayoutXAxisAnchor *ViewLeftAnchor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view leftAnchor];
    return nil;
}

NSLayoutXAxisAnchor *ViewRightAnchor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view rightAnchor];
    return nil;
}

NSLayoutYAxisAnchor *ViewTopAnchor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view topAnchor];
    return nil;
}

NSLayoutXAxisAnchor *ViewTrailingAnchor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view trailingAnchor];
    return nil;
}

NSLayoutDimension *ViewWidthAnchor( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view widthAnchor];
    return nil;
}

// Constraints
CFArrayRef ViewConstraints( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view constraints];
    return nil;
}

void ViewAddConstraint( NSInteger tag, NSLayoutConstraint *constraint )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view addConstraint:constraint];
}

void ViewAddConstraints( NSInteger tag, CFArrayRef constraints )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view addConstraints:(__bridge NSArray *)constraints];
}

void ViewRemoveConstraint( NSInteger tag, NSLayoutConstraint *constraint )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view removeConstraint:constraint];
}

void ViewRemoveConstraints( NSInteger tag, CFArrayRef constraints )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view removeConstraints:(__bridge NSArray *)constraints];
}

// Layout guides
void ViewAddLayoutGuide( NSInteger tag, NSLayoutGuide *guide )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view addLayoutGuide:guide];
}

CFArrayRef ViewLayoutGuides( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view layoutGuides];
    return nil;
}

void ViewRemoveLayoutGuide( NSInteger tag, NSLayoutGuide *guide )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view removeLayoutGuide:guide];
}

// Measuring in auto layout
CGSize ViewFittingSize( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return NSSizeToCGSize([view fittingSize]);
    return CGSizeZero;
}

CGSize ViewIntrinsicContentSize( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return NSSizeToCGSize([view intrinsicContentSize]);
    return CGSizeZero;
}

void ViewInvalidateIntrinsicContentSize( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view invalidateIntrinsicContentSize];
}

NSLayoutPriority ViewContentCompressionResistancePriorityForOrientation( NSInteger tag, NSLayoutConstraintOrientation orientation )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view contentCompressionResistancePriorityForOrientation:orientation];
    return 0;
}

void ViewSetContentCompressionResistancePriorityForOrientation( NSInteger tag, NSLayoutPriority priority, NSLayoutConstraintOrientation orientation )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setContentCompressionResistancePriority:priority forOrientation:orientation];
}

NSLayoutPriority ViewContentHuggingPriorityForOrientation( NSInteger tag, NSLayoutConstraintOrientation orientation )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view contentHuggingPriorityForOrientation:orientation];
    return 0;
}

void ViewSetContentHuggingPriorityForOrientation( NSInteger tag, NSLayoutPriority priority, NSLayoutConstraintOrientation orientation )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setContentHuggingPriority:priority forOrientation:orientation];
}

// Aligning views
CGRect ViewAlignmentRectForFrame( NSInteger tag, CGRect frame )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view alignmentRectForFrame:NSRectFromCGRect(frame)];
    return CGRectZero;
}

CGRect ViewFrameForAlignmentRect( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view frameForAlignmentRect:NSRectFromCGRect(r)];
    return CGRectZero;
}

NSEdgeInsets ViewAlignmentRectInsets( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view alignmentRectInsets];
    NSEdgeInsets insets = {0,0,0,0};
    return insets;
}

CGFloat ViewBaselineOffsetFromBottom( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view baselineOffsetFromBottom];
    return 0.0;
}

CGFloat ViewFirstBaselineOffsetFromTop( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view firstBaselineOffsetFromTop];
    return 0.0;
}

CGFloat ViewLastBaselineOffsetFromBottom( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view lastBaselineOffsetFromBottom];
    return 0.0;
}

// Triggering auto layout
BOOL ViewNeedsLayout( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view needsLayout];
    return NO;
}

void ViewSetNeedsLayout( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setNeedsLayout:flag];
}

void ViewLayout( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view layout];
}

void ViewLayoutSubtreeIfNeeded( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view layoutSubtreeIfNeeded];
}

BOOL ViewNeedsUpdateConstraints( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view needsUpdateConstraints];
    return NO;
}

void ViewSetNeedsUpdateConstraints( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setNeedsUpdateConstraints:flag];
}

void ViewUpdateConstraints( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view updateConstraints];
}

void ViewUpdateConstraintsForSubtreeIfNeeded( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view updateConstraintsForSubtreeIfNeeded];
}

// Opting in to auto layout
BOOL ViewTranslatesAutoresizingMaskIntoConstraints( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view translatesAutoresizingMaskIntoConstraints];
    return NO;
}

void ViewSetTranslatesAutoresizingMaskIntoConstraints( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setTranslatesAutoresizingMaskIntoConstraints:flag];
}

// Enable and disable constraints
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
BOOL ViewIsHorizontalContentSizeConstraintActive( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view isHorizontalContentSizeConstraintActive];
    return NO;
}

void ViewSetHorizontalContentSizeConstraintActive( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setHorizontalContentSizeConstraintActive:flag];
}

BOOL ViewIsVerticalContentSizeConstraintActive( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view isVerticalContentSizeConstraintActive];
    return NO;
}

void ViewSetVerticalContentSizeConstraintActive( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setVerticalContentSizeConstraintActive:flag];
}
#endif// 101500

// Debugging auto layout
CFArrayRef ViewConstraintsAffectingLayoutForOrientation( NSInteger tag, NSLayoutConstraintOrientation orientation )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view constraintsAffectingLayoutForOrientation:orientation];
    return nil;
}

BOOL ViewHasAmbiguousLayout( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view hasAmbiguousLayout];
    return NO;
}

void ViewExerciseAmbiguityInLayout( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view exerciseAmbiguityInLayout];
}

// Focusing
void ViewLockFocus( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view lockFocus];
}

void ViewUnlockFocus( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view unlockFocus];
}

NSInteger ViewFocusView( void )
{
    NSView *focusView = [NSView focusView];
    if ( [focusView respondsToSelector:@selector(tag)] ) {
        return [focusView tag];
    }
    return 0;
}

// Focus ring drawing
NSFocusRingType ViewFocusRingType( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( tag ) return [view focusRingType];
    return 0;
}

void ViewSetFocusRingType( NSInteger tag, NSFocusRingType type )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( tag ) [view setFocusRingType:type];
}

CGRect ViewFocusRingMaskBounds( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( tag ) return NSRectToCGRect([view focusRingMaskBounds]);
    return CGRectZero;
}

void ViewDrawFocusRingMask( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( tag ) [view drawFocusRingMask];
}

void ViewNoteFocusRingMaskChanged( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( tag ) [view noteFocusRingMaskChanged];
}

void ViewSetKeyboardFocusRingNeedsDisplayInRect( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( tag ) [view setKeyboardFocusRingNeedsDisplayInRect:NSRectFromCGRect(r)];
}

NSFocusRingType ViewDefaultFocusRingType( void )
{ return [NSView defaultFocusRingType]; }

// Vibrancy
BOOL ViewAllowsVibrancy( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view allowsVibrancy];
    return NO;
}

// Full screen mode
BOOL ViewEnterFullScreenMode( NSInteger tag, NSScreen *screen, CFDictionaryRef options )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view enterFullScreenMode:screen withOptions:(__bridge NSDictionary *)options];
    return NO;
}

void ViewExitFullScreenMode( NSInteger tag, CFDictionaryRef options )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view exitFullScreenModeWithOptions:(__bridge NSDictionary *)options];
}

BOOL ViewIsInFullScreenMode( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view isInFullScreenMode];
    return NO;
}



CGRect ViewFrame( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return NSRectToCGRect([view frame]);
    return NSRectToCGRect( NSZeroRect );
}

void ViewSetFrame( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setFrame:NSRectFromCGRect(r)];
}

// Tags
NSInteger ViewTag( NSView *view )
{ return CUI_ViewTag( view ); }

// Tooltips
NSToolTipTag ViewAddToolTipRect( NSInteger tag, CGRect r, CUI_ViewStringForToolTipCallbackType callback, void *userData )
{
    NSToolTipTag toolTipTag = 0;
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        CUI_ViewToolTipOwner *owner = CUI_ViewToolTipOwnerObj();
        [owner setView:view];
        [owner setStringForToolTipCallback:callback];
        toolTipTag = [view addToolTipRect:NSRectFromCGRect(r) owner:owner userData:userData];
        [owner setToolTipTag:toolTipTag];
    }
    return toolTipTag;
}

void ViewRemoveAllToolTips( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        if ( sCUI_ViewToolTipOwners ) {
            NSInteger count = [sCUI_ViewToolTipOwners count];
            for ( NSInteger index = 0; index < count; index++ ) {
                CUI_ViewToolTipOwner *owner = [sCUI_ViewToolTipOwners objectAtIndex:index];
                if ( [owner view] == view ) {
                    [sCUI_ViewToolTipOwners removeObject:owner];
                    break;
                }
            }
        }
        [view removeAllToolTips];
    }
}

void ViewRemoveToolTip( NSInteger tag, NSToolTipTag tooltipTag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        if ( sCUI_ViewToolTipOwners ) {
            NSInteger count = [sCUI_ViewToolTipOwners count];
            for ( NSInteger index = 0; index < count; index++ ) {
                CUI_ViewToolTipOwner *owner = [sCUI_ViewToolTipOwners objectAtIndex:index];
                if ( [owner toolTipTag] == tooltipTag ) {
                    [sCUI_ViewToolTipOwners removeObject:owner];
                    break;
                }
            }
        }
        [view removeToolTip:tooltipTag];
    }
}

CFStringRef ViewToolTip( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFStringRef)[view toolTip];
    return nil;
}

void ViewSetToolTip( NSInteger tag, CFStringRef string )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [(NSView *)view setToolTip:(__bridge NSString *)string];
}


// Tracking rect
NSTrackingRectTag ViewAddTrackingRect( NSInteger tag, CGRect r, id owner, void *userData, BOOL assumeInside )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        return [view addTrackingRect:NSRectFromCGRect(r) owner:owner userData:userData assumeInside:assumeInside];
    }
    return 0;
}

void ViewRemoveTrackingRect( NSInteger tag, NSTrackingRectTag rectTag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view removeTrackingRect:rectTag];
    }
}

// Tracking area
void ViewAddTrackingArea( NSInteger tag, NSTrackingArea *ta )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view addTrackingArea:ta];
}

void ViewRemoveTrackingArea( NSInteger tag, NSTrackingArea *ta )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view removeTrackingArea:ta];
}

CFArrayRef ViewTrackingAreas( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view trackingAreas];
    return nil;
}

//void ViewUpdateTrackingAreas( NSInteger tag )
//{
//    NSView *view = CUI_ViewWithTag( tag );
//    if ( view ) [view updateTrackingAreas]
//}

// Cursor tracking
void ViewAddCursorRect( NSInteger tag, CGRect r, NSCursor *curs )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view addCursorRect:NSRectFromCGRect(r) cursor:curs];
}

void ViewRemoveCursorRect( NSInteger tag, CGRect r, NSCursor *curs )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view removeCursorRect:NSRectFromCGRect(r) cursor:curs];
}

void ViewDiscardCursorRects( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view discardCursorRects];
}


// Definition windows
void ViewShowDefinition( NSInteger tag, CFAttributedStringRef aString, CGPoint pt )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [(NSView *)view showDefinitionForAttributedString:(__bridge NSAttributedString *)aString atPoint:NSPointFromCGPoint(pt)];
}

void ViewShowDefinitionBaselineOriginProvider( NSInteger tag, CFAttributedStringRef aString, CFRange targetRange, CFDictionaryRef options, CUI_ViewShowDefinitionBaselineOriginProviderType originProvider, void *userData )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [(NSView *)view showDefinitionForAttributedString:(__bridge NSAttributedString *)aString range:NSRangeFromCFRange(targetRange) options:(__bridge NSDictionary *)options baselineOriginProvider:^(NSRange adjustedRange) {
            CGPoint pt = CGPointZero;
            if ( originProvider ) pt = (*originProvider)(NSRangeToCFRange(adjustedRange),userData);
            return NSPointFromCGPoint(pt);
        }];
    }
}

// Find indicator
BOOL ViewIsDrawingFindIndicator( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view isDrawingFindIndicator];
    return NO;
}

// Content layout direction
NSUserInterfaceLayoutDirection ViewUserInterfaceLayoutDirection( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view userInterfaceLayoutDirection];
    return 0;
}

void ViewSetUserInterfaceLayoutDirection( NSInteger tag, NSUserInterfaceLayoutDirection direction )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setUserInterfaceLayoutDirection:direction];
}

// Configuring pressure
NSPressureConfiguration *ViewPressureConfiguration( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view pressureConfiguration];
    return nil;
}

void ViewSetPressureConfiguration( NSInteger tag, NSPressureConfiguration *pressureConfig )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setPressureConfiguration:pressureConfig];
}

// Type properties
NSTouchTypeMask ViewAllowedTouchTypes( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view allowedTouchTypes];
    return 0;
}

void ViewSetAllowedTouchTypes( NSInteger tag, NSTouchTypeMask mask )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setAllowedTouchTypes:mask];
}

// Safe areas
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSEdgeInsets ViewSafeAreaInsets( NSInteger tag )
{
    NSEdgeInsets insets = {0,0,0,0};
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view safeAreaInsets];
    return insets;
}

NSEdgeInsets ViewAdditionalSafeAreaInsets( NSInteger tag )
{
    NSEdgeInsets insets = {0,0,0,0};
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view additionalSafeAreaInsets];
    return insets;
}

void ViewSetAdditionalSafeAreaInsets( NSInteger tag, NSEdgeInsets insets )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setAdditionalSafeAreaInsets:insets];
}

NSLayoutGuide *ViewSafeAreaLayoutGuide( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view safeAreaLayoutGuide];
    return nil;
}

CGRect ViewSafeAreaRect( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view safeAreaRect];
    return CGRectZero;
}

NSLayoutGuide *ViewLayoutMarginsGuide( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view layoutMarginsGuide];
    return nil;
}
#endif// 110000

BOOL ViewIsHidden( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view isHidden];
    return NO;
}

void ViewSetHidden( NSInteger tag, BOOL flag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view setHidden:flag];
}

BOOL ViewIsHiddenOrHasHiddenAncestor( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view isHiddenOrHasHiddenAncestor];
    return NO;
}

// Live resize
BOOL ViewInLiveResize( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view inLiveResize];
    return NO;
}

BOOL ViewPreservesContentDuringLiveResize( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view preservesContentDuringLiveResize];
    return NO;
}

void ViewGetRectsExposedDuringLiveResize( NSInteger tag, CGRect *rects, NSInteger *count )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view getRectsExposedDuringLiveResize:rects count:count];
}

CGRect ViewRectPreservedDuringLiveResize( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return NSRectToCGRect([view rectPreservedDuringLiveResize]);
    return CGRectZero;
}

// Gesture recognizer
CFArrayRef ViewGestureRecognizers( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view gestureRecognizers];
    return nil;
}

void ViewAddGestureRecognizer( NSInteger tag, NSGestureRecognizer *ref )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view addGestureRecognizer:ref];
}

void ViewRemoveGestureRecognizer( NSInteger tag, NSGestureRecognizer *ref )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view removeGestureRecognizer:ref];
}

// Identifier (same as UserInterfaceItemIdentificationIdentifier)
CFStringRef ViewIdentifier( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFStringRef)[view identifier];
    return nil;
}

void ViewSetIdentifier( NSInteger tag, CFStringRef identifier )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view setIdentifier:(__bridge NSString *)identifier];
}


// Event handling
NSInteger ViewHitTest( NSInteger tag, CGPoint pt )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        NSView *otherview = [view hitTest:NSPointFromCGPoint(pt)];
        if ( otherview ) {
            return CUI_ViewTag( otherview );
        }
    }
    return 0;
}

BOOL ViewMouseInRect( NSInteger tag, CGPoint pt, CGRect r )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view mouse:NSPointFromCGPoint(pt) inRect:NSRectFromCGRect(r)];
    return NO;
}

BOOL ViewMouseDownCanMoveWindow( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view mouseDownCanMoveWindow];
    return NO;
}

// Touch event handling
BOOL ViewWantsRestingTouches( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view wantsRestingTouches];
    return NO;
}

void ViewSetWantsRestingTouches( NSInteger tag, BOOL flag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view setWantsRestingTouches:flag];
}

// Key-view loop management
BOOL ViewCanBecomeKeyView( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view canBecomeKeyView];
    return NO;
}

BOOL ViewNeedsPanelToBecomeKey( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view needsPanelToBecomeKey];
    return NO;
}

NSInteger ViewNextKeyView( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        NSView *nextView = [view nextKeyView];
        if ( nextView ) {
            return CUI_ViewTag( nextView );
        }
    }
    return 0;
}

void ViewSetNextKeyView( NSInteger tag, NSInteger nextViewTag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        NSView *nextView = (NSView *)CUI_ViewWithTag( nextViewTag );
        if ( nextView ) [view setNextKeyView:nextView];
    }
}

NSInteger ViewNextValidKeyView( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        NSView *nextView = [view nextValidKeyView];
        if ( nextView ) {
            return CUI_ViewTag( nextView );
        }
    }
    return 0;
}

NSInteger ViewPreviousKeyView( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        NSView *prevView = [view previousKeyView];
        if ( prevView ) {
            return CUI_ViewTag( prevView );
        }
    }
    return 0;
}

NSInteger ViewPreviousValidKeyView( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        NSView *prevView = [view previousValidKeyView];
        if ( prevView ) {
            return CUI_ViewTag( prevView );
        }
    }
    return 0;
}

// Scrolling
void ViewPrepareContentInRect( NSInteger tag, CGRect r )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view prepareContentInRect:NSRectFromCGRect(r)];
}

CGRect ViewPreparedContentRect( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view preparedContentRect];
    return CGRectZero;
}

void ViewScrollPoint( NSInteger tag, CGPoint pt )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view scrollPoint:NSPointFromCGPoint(pt)];
}

BOOL ViewScrollRectToVisible( NSInteger tag, CGRect r )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view scrollRectToVisible:NSRectFromCGRect(r)];
    return NO;
}

BOOL ViewAutoscroll( NSInteger tag, NSEvent *evnt )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view autoscroll:evnt];
    return NO;
}

CGRect ViewAdjustScroll( NSInteger tag, CGRect newVisible )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return NSRectToCGRect([view adjustScroll:NSRectFromCGRect(newVisible)]);
    return CGRectZero;
}

void ViewScrollRect( NSInteger tag, CGRect r, CGSize size )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        [view scrollRect:NSRectFromCGRect(r) by:NSSizeFromCGSize(size)];
    }
}

NSInteger ViewEnclosingScrollView( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        NSScrollView *scrollView = [view enclosingScrollView];
        if ( scrollView ) return [scrollView tag];
    }
    return 0;
}

// Dragging
void ViewRegisterForDraggedTypes( NSInteger tag, CFArrayRef types )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        [view registerForDraggedTypes:(__bridge NSArray *)types];

//        if ( [view class] == [ViewSC class] || [view class] == [TextViewSubclass class] || [view class] == [ContentViewSC class] ) {
//            [view registerForDraggedTypes:(__bridge NSArray *)types];
//        } else {
//            CUI_ShowAlert( NSWarningAlertStyle, @"Error.", @"View must be subclassed in order to receive dragging events." );
//        }
    }
}

void ViewUnregisterDraggedTypes( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view unregisterDraggedTypes];
}

CFArrayRef ViewRegisteredDraggedTypes( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return (__bridge CFArrayRef)[view registeredDraggedTypes];
    return nil;
}

NSDraggingSession *ViewBeginDraggingSession( NSInteger tag, CFArrayRef items, NSEvent *evnt, id<NSDraggingSource> source )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view beginDraggingSessionWithItems:(__bridge NSArray *)items event:evnt source:source];
    return nil;
}



// custom
void ViewSetAcceptsFirstResponder( NSInteger tag, BOOL flag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        if ( [view class] == [ViewSC class] ) {
            //[(ViewSC *)view setResponderFlag:flag];
            [view setResponderFlag:flag];
        } else if ( [view class] == [ContentViewSC class] ) {
            if ( flag ) [(ContentViewSC *)view setSubclassFlag:flag];
            [(ContentViewSC *)view setResponderFlag:flag];
        }
    }
}

void ViewRegisterForDraggedFileTypes( NSInteger tag, CFTypeRef inFileTypes )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        
        NSArray *fileTypes = nil;
        if ( inFileTypes ) {
            if ( CFGetTypeID( inFileTypes ) == CFStringGetTypeID() ) {
                fileTypes = [(__bridge NSString *)inFileTypes componentsSeparatedByString:@";"];
            } else if ( CFGetTypeID( inFileTypes ) == CFArrayGetTypeID() ) {
                fileTypes = (__bridge NSArray *)inFileTypes;
            }
        }
        
        if ( [view class] == [ViewSC class] ) {
#if __has_feature(objc_arc)
            [(ViewSC *)view setDragFileTypes:fileTypes];
#else
            [(ViewSC *)view setDragFileTypes:[fileTypes retain]];
#endif
        } else if ( [view class] == [ContentViewSC class] ) {
#if __has_feature(objc_arc)
            [(ContentViewSC *)view setDragFileTypes:fileTypes];
#else
            [(ContentViewSC *)view setDragFileTypes:[fileTypes retain]];
#endif
        } else if ( [view class] == [TextViewSC class] ) {

        } else { 
#if __has_feature(objc_arc)
            [view setDragFileTypes:fileTypes];
#else
            [view setDragFileTypes:[fileTypes retain]];
#endif
        }
        
        [view registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
    }
}

void ViewRegisterForDraggedFileExtensions( NSInteger tag, CFTypeRef inFileExtensions )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        
        NSArray *fileExtensions = nil;
        if ( inFileExtensions ) {
            if ( CFGetTypeID( inFileExtensions ) == CFStringGetTypeID() ) {
                fileExtensions = [(__bridge NSString *)inFileExtensions componentsSeparatedByString:@";"];
            } else if ( CFGetTypeID( inFileExtensions ) == CFArrayGetTypeID() ) {
                fileExtensions = (__bridge NSArray *)inFileExtensions;
            }
        }
        
        if ( [view class] == [ViewSC class] ) {
#if __has_feature(objc_arc)
            [(ViewSC *)view setDragFileExtensions:fileExtensions];
#else
            [(ViewSC *)view setDragFileExtensions:[fileExtensions retain]];
#endif
            //[view registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
        }  else if ( [view class] == [ContentViewSC class] ) {
#if __has_feature(objc_arc)
            [(ContentViewSC *)view setDragFileExtensions:fileExtensions];
#else
            [(ContentViewSC *)view setDragFileExtensions:[fileExtensions retain]];
#endif
            //[view registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
        } else {
            //CUI_ShowAlert( NSWarningAlertStyle, @"Error.", @"View must be subclassed in order to receive dragging events." );
        }
        
        [view registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
    }
}

BOOL ViewDragInside( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        if ( [view class] == [ViewSC class] ) {
            //return [(ViewSC *)view dragInside];
            return [view dragInsideFlag];
        } else if ( [view class] == [ContentViewSC class] ) {
            return [(ContentViewSC *)view dragInside];
        }
    }
    return NO;
}

void ViewSetDragInside( NSInteger tag, BOOL flag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) {
        if ( [view class] == [ViewSC class] ) {
            //[(ViewSC *)view setDragInside:flag];
            [view setDragInsideFlag:flag];
        } else if ( [view class] == [ContentViewSC class] ) {
            [(ContentViewSC *)view setDragInside:flag];
        }
    }
}


// Notifications
BOOL ViewPostsFrameChangedNotifications( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view postsFrameChangedNotifications];
    return NO;
}

void ViewSetPostsFrameChangedNotifications( NSInteger tag, BOOL flag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view setPostsFrameChangedNotifications:flag];
}

BOOL ViewPostsBoundsChangedNotifications( NSInteger tag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) return [view postsBoundsChangedNotifications];
    return NO;
}

void ViewSetPostsBoundsChangedNotifications( NSInteger tag, BOOL flag )
{
    NSView *view = (NSView *)CUI_ViewWithTag( tag );
    if ( view ) [view setPostsBoundsChangedNotifications:flag];
}


// generic functions
void *ViewAnimator( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return (__bridge void *)[view animator];
    return NULL;
}

void ViewAnimatorSetFrame( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [[view animator] setFrame:NSRectFromCGRect(r)];
}

void ViewAnimatorSetFrameOrigin( NSInteger tag, CGPoint origin )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [[view animator] setFrameOrigin:NSPointFromCGPoint(origin)];
}

void ViewAnimatorSetFrameSize( NSInteger tag, CGSize size )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [[view animator] setFrameSize:NSSizeFromCGSize(size)];
}

void ViewAnimatorSetFrameRotation( NSInteger tag, CGFloat rot )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [[view animator] setFrameRotation:rot];
}

void ViewAnimatorSetBounds( NSInteger tag, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [[view animator] setBounds:NSRectFromCGRect(r)];
}

void ViewAnimatorSetBoundsOrigin( NSInteger tag, CGPoint origin )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [[view animator] setBoundsOrigin:NSPointFromCGPoint(origin)];
}

void ViewAnimatorSetBoundsSize( NSInteger tag, CGSize size )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [[view animator] setBoundsSize:NSSizeFromCGSize(size)];
}

void ViewAnimatorSetBoundsRotation( NSInteger tag, CGFloat rot )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [[view animator] setBoundsRotation:rot];
}

void ViewAnimatorSetFrameCenterRotation( NSInteger tag, CGFloat rot )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [[view animator] setFrameCenterRotation:rot];
}

void ViewAnimatorSetAlphaValue( NSInteger tag, CGFloat value )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [[view animator] setAlphaValue:value];
}

// custom
id ViewWithTag( NSInteger tag )
{ return CUI_ViewWithTag( tag ); }

void ViewsEmbedInView( int tag, ... )
{
    NSInteger inWndTag = kFBParamMissing;
    NSWindow *w = CUI_TargetWindow( &inWndTag );
    if ( w ) {
        va_list ap;
        va_start(ap,tag);
        
        CGFloat minX = 10000;
        CGFloat minY = 10000;
        CGFloat maxX = 0;
        CGFloat maxY = 0;
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        while ( tag ) {
            NSView *view = CUI_ViewWithTag( tag );
            if ( view ) {
                [array addObject:view];
                NSRect r = [view frame];
                CGFloat x1 = r.origin.x;
                CGFloat y1 = r.origin.y;
                CGFloat x2 = x1 + r.size.width;
                CGFloat y2 = y1 + r.size.height;
                if ( x1 < minX ) minX = x1;
                if ( y1 < minY ) minY = y1;
                if ( x2 > maxX ) maxX = x2;
                if ( y2 > maxY ) maxY = y2;
            }
            tag = va_arg( ap, int );
        }
        NSView *superview = [[NSView alloc] initWithFrame:NSMakeRect(minX,minY,minX+(maxX-minX),minY+(maxY-minY))];
        for ( NSView *view in array ) {
            NSRect r = [view frame];
            r.origin.x -= minX;
            r.origin.y -= minY;
            [view setFrame:r];
            [superview addSubview:view];
        }
        [[w contentView] addSubview:superview];
        va_end(ap);
    }
}

// gesture recognizer

// - user dialog -
void ViewSetClickGestureRecognizer( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] init];
#if __has_feature(objc_arc)
        NSClickGestureRecognizer *gr = [[NSClickGestureRecognizer alloc] initWithTarget:target action:@selector(clickAction:)];
#else
        NSClickGestureRecognizer *gr = [[[NSClickGestureRecognizer alloc] initWithTarget:target action:@selector(clickAction:)] autorelease];
#endif
        [view addGestureRecognizer:gr];
    }
}

void ViewSetMagnificationGestureRecognizer( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] init];
#if __has_feature(objc_arc)
        NSMagnificationGestureRecognizer *gr = [[NSMagnificationGestureRecognizer alloc] initWithTarget:target action:@selector(magnificationAction:)];
#else
        NSMagnificationGestureRecognizer *gr = [[[NSMagnificationGestureRecognizer alloc] initWithTarget:target action:@selector(magnificationAction:)] autorelease];
#endif
        [view addGestureRecognizer:gr];
    }
}

void ViewSetPanGestureRecognizer( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] init];
#if __has_feature(objc_arc)
        NSPanGestureRecognizer *gr = [[NSPanGestureRecognizer alloc] initWithTarget:target action:@selector(panAction:)];
#else
        NSPanGestureRecognizer *gr = [[[NSPanGestureRecognizer alloc] initWithTarget:target action:@selector(panAction:)] autorelease];
#endif
        [view addGestureRecognizer:gr];
    }
}

void ViewSetPressGestureRecognizer( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] init];
#if __has_feature(objc_arc)
        NSPressGestureRecognizer *gr = [[NSPressGestureRecognizer alloc] initWithTarget:target action:@selector(pressAction:)];
#else
        NSPressGestureRecognizer *gr = [[[NSPressGestureRecognizer alloc] initWithTarget:target action:@selector(pressAction:)] autorelease];
#endif
        [view addGestureRecognizer:gr];
    }
}

void ViewSetRotationGestureRecognizer( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] init];
#if __has_feature(objc_arc)
        NSRotationGestureRecognizer *gr = [[NSRotationGestureRecognizer alloc] initWithTarget:target action:@selector(rotationAction:)];
#else
        NSRotationGestureRecognizer *gr = [[[NSRotationGestureRecognizer alloc] initWithTarget:target action:@selector(rotationAction:)] autorelease];
#endif
        [view addGestureRecognizer:gr];
    }
}

// - callback function -
void ViewSetClickGestureRecognizerCallback( NSInteger tag, CUI_GestureRecognizerCallbackType callback, void *userData )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData];
#if __has_feature(objc_arc)
        NSClickGestureRecognizer *gr = [[NSClickGestureRecognizer alloc] initWithTarget:target action:@selector(clickAction:)];
#else
        NSClickGestureRecognizer *gr = [[[NSClickGestureRecognizer alloc] initWithTarget:target action:@selector(clickAction:)] autorelease];
#endif
        [view addGestureRecognizer:gr];
    }
}

void ViewSetMagnificationGestureRecognizerCallback( NSInteger tag, CUI_GestureRecognizerCallbackType callback, void *userData )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData];
#if __has_feature(objc_arc)
        NSMagnificationGestureRecognizer *gr = [[NSMagnificationGestureRecognizer alloc] initWithTarget:target action:@selector(magnificationAction:)];
#else
        NSMagnificationGestureRecognizer *gr = [[[NSMagnificationGestureRecognizer alloc] initWithTarget:target action:@selector(magnificationAction:)] autorelease];
#endif
        [view addGestureRecognizer:gr];
    }
}

void ViewSetPanGestureRecognizerCallback( NSInteger tag, CUI_GestureRecognizerCallbackType callback, void *userData )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData];
#if __has_feature(objc_arc)
        NSPanGestureRecognizer *gr = [[NSPanGestureRecognizer alloc] initWithTarget:target action:@selector(panAction:)];
#else
        NSPanGestureRecognizer *gr = [[[NSPanGestureRecognizer alloc] initWithTarget:target action:@selector(panAction:)] autorelease];
#endif
        [view addGestureRecognizer:gr];
    }
}

void ViewSetPressGestureRecognizerCallback( NSInteger tag, CUI_GestureRecognizerCallbackType callback, void *userData )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData];
#if __has_feature(objc_arc)
        NSPressGestureRecognizer *gr = [[NSPressGestureRecognizer alloc] initWithTarget:target action:@selector(pressAction:)];
#else
        NSPressGestureRecognizer *gr = [[[NSPressGestureRecognizer alloc] initWithTarget:target action:@selector(pressAction:)] autorelease];
#endif
        [view addGestureRecognizer:gr];
    }
}

void ViewSetRotationGestureRecognizerCallback( NSInteger tag, CUI_GestureRecognizerCallbackType callback, void *userData )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        CUI_GestureRecognizerTarget *target = [[CUI_GestureRecognizerTarget alloc] initWithCallback:callback userData:userData];
#if __has_feature(objc_arc)
        NSRotationGestureRecognizer *gr = [[NSRotationGestureRecognizer alloc] initWithTarget:target action:@selector(rotationAction:)];
#else
        NSRotationGestureRecognizer *gr = [[[NSRotationGestureRecognizer alloc] initWithTarget:target action:@selector(rotationAction:)] autorelease];
#endif
        [view addGestureRecognizer:gr];
    }
}

// DisplayLink
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
CADisplayLink *ViewDisplayLinkWithTarget( NSInteger tag, id target, CFStringRef selector )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        return [view displayLinkWithTarget:target selector:NSSelectorFromString((__bridge NSString *)selector)];
    }
    return nil;
}
#endif// 140000


/*
 NSAppearanceCustomization
 */
NSAppearance *ViewAppearance( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view appearance];
    return nil;
}

void ViewSetAppearance( NSInteger tag, NSAppearance *appearance )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setAppearance:appearance];
}

void ViewSetAppearanceNamed( NSInteger tag, CFStringRef name )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setAppearance:[NSAppearance appearanceNamed:(__bridge NSString *)name]];
}

NSAppearance *ViewEffectiveAppearance( NSInteger tag )
{
    NSView *view;
    if ( tag ) {
        view = CUI_ViewWithTag( tag );
    } else {
#if __has_feature(objc_arc)
        view = [[NSView alloc] init];
#else
        view = [[[NSView alloc] init] autorelease];
#endif
    }
    if ( view ) return [view effectiveAppearance];
    return nil;
}


// - custom -
BOOL ViewExists( NSInteger tag )
{ return ( ViewWithTag(tag) != nil ); }


CFTypeRef ViewProperty( NSInteger tag, CFStringRef key )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return ObjectProperty( (__bridge CFTypeRef)view, key );
    return nil;
}

void ViewSetProperty( NSInteger tag, CFStringRef key, CFTypeRef value )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectSetProperty( (__bridge CFTypeRef)view, key, value );
}

void ViewPropertySet( NSInteger tag, CFStringRef key, CFTypeRef value )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectPropertySet( (__bridge CFTypeRef)view, key, value );
}


BOOL ViewPropertyBool( NSInteger tag, CFStringRef key )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return ObjectPropertyBool( (__bridge CFTypeRef)view, key );
    return NO;
}

void ViewPropertySetBool( NSInteger tag, CFStringRef key, BOOL value )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectPropertySetBool( (__bridge CFTypeRef)view, key, value );
}

long ViewPropertyLong( NSInteger tag, CFStringRef key )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return ObjectPropertyLong( (__bridge CFTypeRef)view, key );
    return 0;
}

void ViewPropertySetLong( NSInteger tag, CFStringRef key, long value )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectPropertySetLong( (__bridge CFTypeRef)view, key, value );
}

double ViewPropertyDouble( NSInteger tag, CFStringRef key )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return ObjectPropertyDouble( (__bridge CFTypeRef)view, key );
    return 0.0;
}

void ViewPropertySetDouble( NSInteger tag, CFStringRef key, double value )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectPropertySetDouble( (__bridge CFTypeRef)view, key, value );
}

CGRect ViewPropertyRect( NSInteger tag, CFStringRef key )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return ObjectPropertyRect( (__bridge CFTypeRef)view, key );
    return CGRectZero;
}

void ViewPropertySetRect( NSInteger tag, CFStringRef key, CGRect r )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectPropertySetRect( (__bridge CFTypeRef)view, key, r );
}

CGPoint ViewPropertyPoint( NSInteger tag, CFStringRef key )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return ObjectPropertyPoint( (__bridge CFTypeRef)view, key );
    return CGPointZero;
}

void ViewPropertySetPoint( NSInteger tag, CFStringRef key, CGPoint pt )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectPropertySetPoint( (__bridge CFTypeRef)view, key, pt );
}

CGSize ViewPropertySize( NSInteger tag, CFStringRef key )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return ObjectPropertySize( (__bridge CFTypeRef)view, key );
    return CGSizeZero;
}

void ViewPropertySetSize( NSInteger tag, CFStringRef key, CGSize sz )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectPropertySetSize( (__bridge CFTypeRef)view, key, sz );
}

CFRange ViewPropertyRange( NSInteger tag, CFStringRef key )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return ObjectPropertyRange( (__bridge CFTypeRef)view, key );
    return CFRangeMake(NSNotFound,0);
}

void ViewPropertySetRange( NSInteger tag, CFStringRef key, CFRange range )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectPropertySetRange( (__bridge CFTypeRef)view, key, range );
}

CFURLRef ViewPropertyBookmarkURL( NSInteger tag, CFStringRef key )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return ObjectPropertyBookmarkURL( (__bridge CFTypeRef)view, key );
    return nil;
}

void ViewPropertySetBookmarkURL( NSInteger tag, CFStringRef key, CFURLRef url )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectPropertySetBookmarkURL( (__bridge CFTypeRef)view, key, url );
}

BOOL ViewPropertyGetBytes( NSInteger tag, CFStringRef key, void *bytes )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return ObjectPropertyGetBytes( (__bridge CFTypeRef)view, key, bytes );
    return NO;
}

void ViewPropertySetBytes( NSInteger tag, CFStringRef key, void *bytes, long length )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectPropertySetBytes( (__bridge CFTypeRef)view, key, bytes, length );
}


void ViewRemoveProperty( NSInteger tag, CFStringRef key )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectRemoveProperty( (__bridge CFTypeRef)view, key );
}

void ViewPropertyRemove( NSInteger tag, CFStringRef key )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectPropertyRemove( (__bridge CFTypeRef)view, key );
}

void ViewRemoveAllProperties( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectRemoveAllProperties( (__bridge CFTypeRef)view );
}

void ViewPropertyRemoveAll( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) ObjectPropertyRemoveAll( (__bridge CFTypeRef)view );
}


// Suspend drawRect: method
void ViewSuspendDrawRect( NSInteger tag, BOOL flag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [view setSuspendDrawRect:flag];
    }
}

BOOL ViewDrawRectIsSuspended( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        return [view suspendDrawRect];
    }
    return NO;
}

/*
  ViewInitTrackingArea

  Initialises the view's tracking area so that it will respond to tracking events (mouseEntered, mouseExited, etc.)
*/
void ViewInitTrackingArea( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        NSTrackingArea *trackingArea;
        NSArray *areas = [view trackingAreas];
        if ( [areas count] > 0 ) {
            trackingArea = [areas objectAtIndex:0];
            [view removeTrackingArea:trackingArea];
#if !__has_feature(objc_arc)
            [trackingArea release];
#endif
        }
        NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveInKeyWindow | NSTrackingInVisibleRect;
        trackingArea = [[NSTrackingArea alloc] initWithRect:[view bounds] options:options owner:view userInfo:nil];
        [view addTrackingArea:trackingArea];
    }
}


void ViewAddSubviews( NSInteger vwTag, ... )
{
    va_list ap;
    va_start(ap,vwTag);
    NSView *view = CUI_ViewWithTag( vwTag );
    if ( view ) {
        int tag = va_arg(ap,int);
        while ( tag ) {
            NSView *subview = CUI_ViewWithTag( tag );
            if ( subview ) {
                [view addSubview:subview];
            }
            tag = va_arg(ap,int);
        }
    }
    va_end(ap);
}

void ViewAddSubviewsInRange( NSInteger tag, CFRange range )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        for ( NSInteger index = range.location; index < (range.location + range.length); index++ ) {
            NSView *subview = CUI_ViewWithTag( index );
            if ( subview ) {
                [view addSubview:subview];
            }
        }
    }
}

void ViewAddSubviewsWithIndexes( NSInteger tag, NSIndexSet *set )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop __attribute__ ((__unused__))) {
            NSView *subview = CUI_ViewWithTag( idx );
            if ( subview ) {
                [view addSubview:subview];
            }
        }];
    }
}

void ViewClose( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view removeFromSuperview];
}


/*
  ViewSelectedButton

  Returns the button ref of the selected subview (usually radio button)
*/
NSButton *ViewSelectedButton( NSInteger tag )
{
    NSButton *btn = nil;
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        for ( NSView *subview in [view subviews] ) {
            if ( [subview isKindOfClass:[NSButton class]] ) {
                if ( [(NSButton *)subview state] == NSOnState ) {
                    btn = (NSButton *)subview;
                    break;
                }
            }
        }
    }
    return btn;
}

/*
  ViewSelectedButtonTag

  Returns the tag of the selected subview (usually radio button)
*/
NSInteger ViewSelectedButtonTag( NSInteger tag )
{
    NSButton *btn = ViewSelectedButton( tag );
    if ( btn ) return [btn tag];
    return 0;
}

/*
  ViewSelectedButtonTitle

  Returns the title of the selected subview (usually radio button)
*/
CFStringRef ViewSelectedButtonTitle( NSInteger tag )
{
    NSButton *btn = ViewSelectedButton( tag );
    if ( btn ) return (__bridge CFStringRef)[btn title];
    return nil;
}


/*
  ViewColorAtPoint

  Returns the color of the pixel at the specified point in the view
*/
NSColor *ViewColorAtPoint( NSInteger tag, CGPoint pt )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        NSRect r = NSMakeRect( pt.x, pt.y, 1, 1 );
        NSBitmapImageRep *bm = [view bitmapImageRepForCachingDisplayInRect:r];
        [view cacheDisplayInRect:r toBitmapImageRep:bm];
        return [bm colorAtX:0 y:0];
    }
    return nil;
}

/*
  ViewColorAtXY

  Returns the color of the pixel at the specified coordinates
*/
NSColor *ViewColorAtXY( NSInteger tag, CGFloat x, CGFloat y )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        NSRect r = NSMakeRect( x, y, 1, 1 );
        NSBitmapImageRep *bm = [view bitmapImageRepForCachingDisplayInRect:r];
        [view cacheDisplayInRect:r toBitmapImageRep:bm];
        return [bm colorAtX:0 y:0];
    }
    return nil;
}

// Hide/show tooltips
void ViewSetToolTipsHidden( NSInteger tag, BOOL flag )// 20240622
{
    NSView *theView = CUI_ViewWithTag( tag );
    if ( theView ) {
        
        if ( [theView respondsToSelector:@selector(menu)] ) {
            MenuSetToolTipsHidden( (NSInteger)[theView menu], flag );
        }
        
        NSString *toolTip = [theView toolTip];
        if ( toolTip ) {
            if ( flag ) {
                ObjectPropertySet( (__bridge CFTypeRef)theView, (__bridge CFStringRef)@"CUI_ToolTip", (__bridge CFTypeRef)toolTip );
                [theView removeAllToolTips];
            } else {
                toolTip = (__bridge NSString *)ObjectProperty( (__bridge CFTypeRef)theView, (__bridge CFStringRef)@"CUI_ToolTip" );
                if ( toolTip ) [theView setToolTip:toolTip];
            }
        } else {
            if ( !flag ) {
                toolTip = (__bridge NSString *)ObjectProperty( (__bridge CFTypeRef)theView, (__bridge CFStringRef)@"CUI_ToolTip" );
                if ( toolTip ) [theView setToolTip:toolTip];
            }
        }
        if ( [theView isKindOfClass:[NSTabView class]] ) { // tabview
            NSTabView *tabView = (NSTabView *)theView;
            NSArray *tabItems = [tabView tabViewItems];
            for ( NSTabViewItem *tabItem in tabItems ) {
                ViewSetToolTipsHidden( (NSInteger)[tabItem view], flag );
            }
        } else if ( [theView isKindOfClass:[NSTableView class]] ) { // tableview
            NSTableView *tableView = (NSTableView *)theView;

            // headers
            NSArray *tableColumns = [tableView tableColumns];
            for ( NSTableColumn *column in tableColumns ) {
                toolTip = [column headerToolTip];
                if ( toolTip ) {
                    if ( flag ) {
                        ObjectPropertySet( (__bridge CFTypeRef)column, (__bridge CFStringRef)@"CUI_ToolTip", (__bridge CFTypeRef)toolTip );
                        [column setHeaderToolTip:nil];
                    } else {
                        toolTip = (__bridge NSString *)ObjectProperty( (__bridge CFTypeRef)column, (__bridge CFStringRef)@"CUI_ToolTip" );
                        if ( toolTip ) [column setHeaderToolTip:toolTip];
                    }
                } else {
                    if ( !flag ) {
                        toolTip = (__bridge NSString *)ObjectProperty( (__bridge CFTypeRef)column, (__bridge CFStringRef)@"CUI_ToolTip" );
                        if ( toolTip ) [column setHeaderToolTip:toolTip];
                    }
                }
            }
            
            // rows
            [tableView enumerateAvailableRowViewsUsingBlock:^(__kindof NSTableRowView * _Nonnull rowView, NSInteger row __attribute__ ((__unused__))) {
                ViewSetToolTipsHidden( (NSInteger)rowView, flag );
            }];

        } else if ( [theView isKindOfClass:[NSSegmentedControl class]] ) { // segmented control
            NSSegmentedControl *segCtrl = (NSSegmentedControl *)theView;
            NSInteger segCount = [segCtrl segmentCount];
            for ( NSInteger segIndex = 0; segIndex < segCount; segIndex++ ) {
                NSString *segToolTip = [segCtrl toolTipForSegment:segIndex];
                if ( segToolTip ) {
                    if ( flag ) {
                        ObjectPropertySet( (__bridge CFTypeRef)segCtrl, (__bridge CFStringRef)[NSString stringWithFormat:@"CUI_ToolTipSegment%ld",segIndex], (__bridge CFTypeRef)segToolTip );
                        [segCtrl setToolTip:nil forSegment:segIndex];
                    }
                } else {
                    if ( !flag ) {
                        segToolTip = (__bridge NSString *)ObjectProperty( (__bridge CFTypeRef)segCtrl, (__bridge CFStringRef)[NSString stringWithFormat:@"CUI_ToolTipSegment%ld",segIndex] );
                        if ( segToolTip ) {
                            [segCtrl setToolTip:segToolTip forSegment:segIndex];
                        }
                    }
                }
            }
        } else {
            NSArray *subviews = [theView subviews];
            for ( NSView *subview in subviews ) {
                ViewSetToolTipsHidden( (NSInteger)subview, flag );
            }
        }
    }
}


// menu
NSInteger ViewMenuID( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        NSMenu *m = [view menu];
        if ( m ) return CUI_MenuIndex( m );
    }
    return -1;
}

NSMenu *ViewMenuRef( NSInteger tag )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) return [view menu];
    return nil;
}

void ViewSetMenu( NSInteger tag, NSInteger menuID )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) {
        if ( menuID >= 0 ) {
            NSMenu *m = MenuAtIndex( menuID );
            if ( m ) [view setMenu:m];
        } else {
            [view setMenu:nil];
        }
    }
}

void ViewSetMenuRef( NSInteger tag, NSMenu *m )
{
    NSView *view = CUI_ViewWithTag( tag );
    if ( view ) [view setMenu:m];
}



// Create
NSView *ViewInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 20, 20, 163, 96 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSView *view;
#if __has_feature(objc_arc)
    if ( subclass ) {
        view = [[ViewSC alloc] initWithFrame:rect];
    } else {
        view = [[NSView alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        view = [[[ViewSC alloc] initWithFrame:rect] autorelease];
    } else {
        view = [[[NSView alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [view autorelease];
//#endif
    
    // tag
    [view setIdentifier:[NSString stringWithFormat:@"%ld",(long)inTag]];
    
    return view;
}

// FB statement
void CUI_View( NSInteger inTag, CGRect inRect, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    NSWindow *w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSView *view = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !view ) {
            view = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( view ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's same view type
            if ( !CUI_ValidateViewClass( inWndTag, inTag, view, [NSView class] ) ) return;// 20230721

            // rect
            if ( !NSIsEmptyRect( rect ) ) [view setFrame:rect];
            
        } else {
            // init
            view = ViewInit( inTag, inRect );
            
            // default autoresizing
            [(NSView *)view setAutoresizingMask:NSViewMinYMargin];
            
            // wndTag
            [view setWndTag:inWndTag];
            
            // if superview flag set, add view to superview stack
            if ( CUI_IsSuperview() ) CUI_AddSuperview( view );

            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview == view ) {
                superview = CUI_PenultimateSuperview();
            }

            if ( superview ) {
                [superview addSubview:view];
            } else {
                [contentView addSubview:view];
            }

        }
        
        [view setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}


