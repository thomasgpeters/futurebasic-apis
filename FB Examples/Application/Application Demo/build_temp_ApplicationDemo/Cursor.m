/*
 Cursor.m

 Bernie Wylde
 */

#import "Cursor.h"

static CUI_CursorAnimator *sCUI_CursorAnimator;

@implementation CUI_CursorAnimator
#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.timer release];
    [self.name release];
    [self.extension release];
    [super dealloc];
}
#endif

- (void)timerFireMethod:(NSTimer *)t {
    self.counter++;
    if ( self.counter > self.numImages ) self.counter = 1;
    NSString *string = [NSString stringWithFormat:@"%@%ld.%@",self.name,self.counter,self.extension];
    //NSImage *image = ImageNamed((__bridge CFStringRef)string);
    NSImage *image = CUI_ImageResource( string );
    if ( !NSEqualSizes(self.size,NSZeroSize) ) [image setSize:self.size];
#if __has_feature(objc_arc)
    NSCursor *cursor = [[NSCursor alloc] initWithImage:image hotSpot:_hotSpot];
#else
    NSCursor *cursor = [[[NSCursor alloc] initWithImage:image hotSpot:self.hotSpot] autorelease];
#endif
    if ( cursor ) [cursor set];
}
@end

// Class
Class CursorClass( void )
{ return [NSCursor class]; }

NSCursor *CursorWithImage( CFTypeRef inImage, CGPoint hotSpot )
{
    NSImage *image = CUI_FixImageValue( inImage );
    if ( image ) {
#if __has_feature(objc_arc)
        return [[NSCursor alloc] initWithImage:image hotSpot:NSPointFromCGPoint(hotSpot)];
#else
        return [[[NSCursor alloc] initWithImage:image hotSpot:NSPointFromCGPoint(hotSpot)] autorelease];
#endif
    }
    return nil;
}

NSImage *CursorImage( NSCursor *ref )
{ return [ref image]; }

CGPoint CursorHotSpot( NSCursor *ref )
{ return NSPointToCGPoint([ref hotSpot]); }

void CursorHide( void )
{ [NSCursor hide]; }

void CursorUnhide( void )
{ [NSCursor unhide]; }

void CursorSetHiddenUntilMouseMoves( BOOL flag )
{ [NSCursor setHiddenUntilMouseMoves:flag]; }


void CursorPop( void )
{ [NSCursor pop]; }

void CursorPush( NSCursor *ref )
{ [ref push]; }

void CursorSet( NSCursor *ref )
{ [ref set]; }


NSCursor *CursorCurrent( void )
{ return [NSCursor currentCursor]; }

NSCursor *CursorCurrentSystem( void )
{ return [NSCursor currentSystemCursor]; }

NSCursor *CursorArrow( void )
{ return [NSCursor arrowCursor]; }

NSCursor *CursorContextualMenu( void )
{ return [NSCursor contextualMenuCursor]; }

NSCursor *CursorClosedHand( void )
{ return [NSCursor closedHandCursor]; }

NSCursor *CursorCrosshair( void )
{ return [NSCursor crosshairCursor]; }

NSCursor *CursorDisappearingItem( void )
{ return [NSCursor disappearingItemCursor]; }

NSCursor *CursorDragCopy( void )
{ return [NSCursor dragCopyCursor]; }

NSCursor *CursorDragLink( void )
{ return [NSCursor dragLinkCursor]; }

NSCursor *CursorIBeam( void )
{ return [NSCursor IBeamCursor]; }

NSCursor *CursorOpenHand( void )
{ return [NSCursor openHandCursor]; }

NSCursor *CursorOperationNotAllowed( void )
{ return [NSCursor operationNotAllowedCursor]; }

NSCursor *CursorPointingHand( void )
{ return [NSCursor pointingHandCursor]; }

NSCursor *CursorResizeDown( void )
{ return [NSCursor resizeDownCursor]; }

NSCursor *CursorResizeLeft( void )
{ return [NSCursor resizeLeftCursor]; }

NSCursor *CursorResizeLeftRight( void )
{ return [NSCursor resizeLeftRightCursor]; }

NSCursor *CursorResizeRight( void )
{ return [NSCursor resizeRightCursor]; }

NSCursor *CursorResizeUp( void )
{ return [NSCursor resizeUpCursor]; }

NSCursor *CursorResizeUpDown( void )
{ return [NSCursor resizeUpDownCursor]; }

NSCursor *CursorIBeamForVerticalLayout( void )
{ return [NSCursor IBeamCursorForVerticalLayout]; }

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
NSCursor *CursorZoomIn( void )
{ return [NSCursor zoomInCursor]; }

NSCursor *CursorZoomOut( void )
{ return [NSCursor zoomOutCursor]; }

NSCursor *CursorColumnResize( void )
{ return [NSCursor columnResizeCursor]; }

NSCursor *CursorColumnResizeInDirections( NSHorizontalDirections directions )
{ return [NSCursor columnResizeCursorInDirections:directions]; }

NSCursor *CursorRowResize( void )
{ return [NSCursor rowResizeCursor]; }

NSCursor *CursorRowResizeInDirections( NSVerticalDirections directions )
{ return [NSCursor rowResizeCursorInDirections:directions]; }

NSCursor *CursorFrameResizeFromPosition( NSCursorFrameResizePosition position, NSCursorFrameResizeDirections directions )
{ return [NSCursor frameResizeCursorFromPosition:position inDirections:directions]; }
#endif // 150000

// -- convenience --
void CursorSetImage( CFTypeRef inImage, CGPoint hotSpot )
{
    NSImage *image = CUI_FixImageValue( inImage );
    if ( image ) {
#if __has_feature(objc_arc)
        NSCursor *cursor = [[NSCursor alloc] initWithImage:image hotSpot:NSPointFromCGPoint(hotSpot)];
#else
        NSCursor *cursor = [[[NSCursor alloc] initWithImage:image hotSpot:NSPointFromCGPoint(hotSpot)] autorelease];
#endif
        if ( cursor ) [cursor set];
    }
}

void CursorSetImageNamed( CFStringRef imageName, CGPoint hotSpot )
{
    NSImage *image = CUI_ImageResource( (__bridge NSString *)imageName );
    if ( image ) {
#if __has_feature(objc_arc)
        NSCursor *cursor = [[NSCursor alloc] initWithImage:image hotSpot:NSPointFromCGPoint(hotSpot)];
#else
        NSCursor *cursor = [[[NSCursor alloc] initWithImage:image hotSpot:NSPointFromCGPoint(hotSpot)] autorelease];
#endif
        if ( cursor ) {
            [cursor set];
        }
    }
}

void CursorSetArrow( void )
{ [[NSCursor arrowCursor] set]; }

void CursorSetContextualMenu( void )
{ [[NSCursor contextualMenuCursor] set]; }

void CursorSetClosedHand( void )
{ [[NSCursor closedHandCursor] set]; }

void CursorSetCrosshair( void )
{ [[NSCursor crosshairCursor] set]; }

void CursorSetDisappearingItem( void )
{ [[NSCursor disappearingItemCursor] set]; }

void CursorSetDragCopy( void )
{ [[NSCursor dragCopyCursor] set]; }

void CursorSetDragLink( void )
{ [[NSCursor dragLinkCursor] set]; }

void CursorSetIBeam( void )
{ [[NSCursor IBeamCursor] set]; }

void CursorSetOpenHand( void )
{ [[NSCursor openHandCursor] set]; }

void CursorSetOperationNotAllowed( void )
{ [[NSCursor operationNotAllowedCursor] set]; }

void CursorSetPointingHand( void )
{ [[NSCursor pointingHandCursor] set]; }

void CursorSetResizeDown( void )
{ [[NSCursor resizeDownCursor] set]; }

void CursorSetResizeLeft( void )
{ [[NSCursor resizeLeftCursor] set]; }

void CursorSetResizeRight( void )
{ [[NSCursor resizeRightCursor] set]; }

void CursorSetResizeUp( void )
{ [[NSCursor resizeUpCursor] set]; }

void CursorSetResizeUpDown( void )
{ [[NSCursor resizeUpDownCursor] set]; }

void CursorSetIBeamForVerticalLayout( void )
{ [[NSCursor IBeamCursorForVerticalLayout] set]; }


// Custom
void CursorAnimatorStart( CFTimeInterval ti, CFStringRef inFirstImageName, CGSize size, CGPoint hotSpot, long numImages )
{
    if ( !sCUI_CursorAnimator ) {
        sCUI_CursorAnimator = [[CUI_CursorAnimator alloc] init];
        sCUI_CursorAnimator.counter = 1;
        NSString *firstImageName = (__bridge NSString *)inFirstImageName;
        NSString *extension = [firstImageName pathExtension];
        NSString *name = [firstImageName stringByDeletingPathExtension];
        name = [name substringToIndex:[name length] - 1];
#if __has_feature(objc_arc)
        sCUI_CursorAnimator.name = name;
        sCUI_CursorAnimator.extension = extension;
#else
        sCUI_CursorAnimator.name = [name retain];
        sCUI_CursorAnimator.extension = [extension retain];
#endif
        sCUI_CursorAnimator.size = NSSizeFromCGSize(size);
        sCUI_CursorAnimator.hotSpot = NSPointFromCGPoint(hotSpot);
        sCUI_CursorAnimator.numImages = numImages;
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:ti target:sCUI_CursorAnimator selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
        sCUI_CursorAnimator.timer = timer;
    }
}

void CursorAnimatorStop( void )
{
    if ( sCUI_CursorAnimator ) {
        [sCUI_CursorAnimator.timer invalidate];
#if !__has_feature(objc_arc)
        [sCUI_CursorAnimator release];
#endif
        sCUI_CursorAnimator = nil;
    }
    [[NSCursor arrowCursor] set];
}


