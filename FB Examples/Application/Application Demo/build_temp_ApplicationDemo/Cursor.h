/*
 Cursor.h

 Bernie Wylde
 */


#import "CocoaUI.h"

@interface CUI_CursorAnimator : NSObject

@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic,assign) long counter;
@property (nonatomic,retain) NSString *name;
@property (nonatomic,retain) NSString *extension;
@property (nonatomic,assign) NSSize size;
@property (nonatomic,assign) NSPoint hotSpot;
@property (nonatomic,assign) long numImages;

- (void)timerFireMethod:(NSTimer *)t;
@end

// Class
Class CursorClass( void );

NSCursor *CursorWithImage( CFTypeRef inImage, CGPoint hotSpot );

NSImage *CursorImage( NSCursor *ref );
CGPoint CursorHotSpot( NSCursor *ref );
void CursorHide( void );
void CursorUnhide( void );
void CursorSetHiddenUntilMouseMoves( BOOL flag );

void CursorPop( void );
void CursorPush( NSCursor *ref );
void CursorSet( NSCursor *ref );

NSCursor *CursorCurrent( void );
NSCursor *CursorCurrentSystem( void );
NSCursor *CursorArrow( void );
NSCursor *CursorContextualMenu( void );
NSCursor *CursorClosedHand( void );
NSCursor *CursorCrosshair( void );
NSCursor *CursorDisappearingItem( void );
NSCursor *CursorDragCopy( void );
NSCursor *CursorDragLink( void );
NSCursor *CursorIBeam( void );
NSCursor *CursorOpenHand( void );
NSCursor *CursorOperationNotAllowed( void );
NSCursor *CursorPointingHand( void );
NSCursor *CursorResizeDown( void );
NSCursor *CursorResizeLeft( void );
NSCursor *CursorResizeLeftRight( void );
NSCursor *CursorResizeRight( void );
NSCursor *CursorResizeUp( void );
NSCursor *CursorResizeUpDown( void );
NSCursor *CursorIBeamForVerticalLayout( void );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
NSCursor *CursorZoomIn( void );
API_AVAILABLE(macos(15.0))
NSCursor *CursorZoomOut( void );
API_AVAILABLE(macos(15.0))
NSCursor *CursorColumnResize( void );
API_AVAILABLE(macos(15.0))
NSCursor *CursorColumnResizeInDirections( NSHorizontalDirections directions );
API_AVAILABLE(macos(15.0))
NSCursor *CursorRowResize( void );
API_AVAILABLE(macos(15.0))
NSCursor *CursorRowResizeInDirections( NSVerticalDirections directions );
API_AVAILABLE(macos(15.0))
NSCursor *CursorFrameResizeFromPosition( NSCursorFrameResizePosition position, NSCursorFrameResizeDirections directions );
#endif // 150000

// -- convenience --
void CursorSetImage( CFTypeRef inImage, CGPoint hotSpot );
void CursorSetImageNamed( CFStringRef imageName, CGPoint hotSpot );
void CursorSetArrow( void );
void CursorSetContextualMenu( void );
void CursorSetClosedHand( void );
void CursorSetCrosshair( void );
void CursorSetDisappearingItem( void );
void CursorSetDragCopy( void );
void CursorSetDragLink( void );
void CursorSetIBeam( void );
void CursorSetOpenHand( void );
void CursorSetOperationNotAllowed( void );
void CursorSetPointingHand( void );
void CursorSetResizeDown( void );
void CursorSetResizeLeft( void );
void CursorSetResizeRight( void );
void CursorSetResizeUp( void );
void CursorSetResizeUpDown( void );
void CursorSetIBeamForVerticalLayout( void );

// Custom
void CursorAnimatorStart( CFTimeInterval ti, CFStringRef inFirstImageName, CGSize size, CGPoint hotSpot, long numImages );
void CursorAnimatorStop( void );

