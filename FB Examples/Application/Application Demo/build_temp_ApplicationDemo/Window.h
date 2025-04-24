/*
 Window.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// window function selectors// 20221110
enum {
    windowKey,
    windowMain,// 20240225
    windowOutput,
    windowWidth,
    windowHeight,
    windowContentWidth,
    windowContentHeight
};


#pragma mark - PrintToWindow

@interface CUI_PrintToWindowDefaults : NSObject
@property (nonatomic,strong) NSFont *font;
@property (nonatomic,assign) CGFloat textInset;
@property (nonatomic,assign) BOOL showScroller;
@property (nonatomic,assign) BOOL autoHideScroller;
@end

// item types. These match constants in Window.incl header    // 20211126
enum {
    CUI_PrintToWindowItemTypeText, // = _windowPrintViewTypeText
    CUI_PrintToWindowItemTypeLine, // = _windowPrintViewTypeLine
    CUI_PrintToWindowItemTypeRect, // = _windowPrintViewTypeRect
    CUI_PrintToWindowItemTypeOval  // = _windowPrintViewTypeOval
};

@interface CUI_PrintToWindowItem : NSObject
@property (nonatomic,assign) NSUInteger type;

// text
@property (nonatomic,assign) NSPoint pt;
@property (nonatomic,retain) NSString *string;
@property (nonatomic,retain) NSDictionary *attributes;

// shapes   // 20211126
@property (nonatomic,assign) NSPoint linePt1;
@property (nonatomic,assign) NSPoint linePt2;
@property (nonatomic,assign) NSRect rect;// used by both 'rect' and 'oval' types
@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic,assign) NSLineCapStyle lineCapStyle;
//@property (nonatomic,assign) NSLineJoinStyle lineJoinStyle;
//@property (nonatomic,assign) CGFloat miterLimit;
//@property (nonatomic,assign) CGFloat flatness;
@property (nonatomic,retain) NSArray *lineDashPattern;
@property (nonatomic,assign) CGFloat lineDashPhase;
@property (nonatomic,retain) NSColor *strokeColor;
@property (nonatomic,retain) NSColor *fillColor;
@property (nonatomic,retain) NSShadow *shadow;

@property (nonatomic,assign) BOOL strokeFlag;
@property (nonatomic,assign) BOOL fillFlag;

@property (nonatomic,assign) CGFloat cornerRadius;

// init
- (id)initWithString:(NSString *)string point:(NSPoint)pt attributes:(NSDictionary *)attributes;
+ (id)itemWithString:(NSString *)string point:(NSPoint)pt attributes:(NSDictionary *)attributes;

- (id)initWithLinePoint1:(NSPoint)pt1 linePoint2:(NSPoint)pt2;
+ (id)itemWithLinePoint1:(NSPoint)pt1 linePoint2:(NSPoint)pt2;

- (id)initWithType:(NSInteger)type rect:(NSRect)r strokeColor:(NSColor *)strokeCol fillColor:(NSColor *)fillCol cornerRadius:(CGFloat)cornerRad;
+ (id)itemWithType:(NSInteger)type rect:(NSRect)r strokeColor:(NSColor *)strokeCol fillColor:(NSColor *)fillCol cornerRadius:(CGFloat)cornerRad;

@end

@interface CUI_PrintToWindowScrollView : NSScrollView
@end

@interface CUI_PrintToWindowView : NSView

@property (nonatomic,strong) CUI_PrintToWindowScrollView *scrollView;

@property (nonatomic,retain) NSMutableArray *items;
@property (nonatomic,strong) NSMutableString *textString;

@property (nonatomic,assign) CGFloat textInset;// 20220707  this defaults to 3px left and 3px right (top and bottom don't have an inset)

@property (nonatomic,assign) CGFloat viewH;
@property (nonatomic,assign) CGFloat viewW;

@property (nonatomic,assign) NSPoint currentPoint;

@property (nonatomic,retain) NSMutableDictionary *currentAttributes;

@property (nonatomic,assign) NSTextAlignment currentAlignment;
@property (nonatomic,assign) BOOL flipView;

@property (nonatomic,assign) NSPoint currentLinePoint;
@property (nonatomic,assign) CGFloat currentLineWidth;

@property (nonatomic,assign) NSLineCapStyle currentLineCapStyle;
//@property (nonatomic,assign) NSLineJoinStyle currentLineJoinStyle;
//@property (nonatomic,assign) CGFloat currentMiterLimit;
//@property (nonatomic,assign) CGFloat currentFlatness;
@property (nonatomic,retain) NSArray *currentLineDashPattern;
@property (nonatomic,assign) CGFloat currentLineDashPhase;

@property (nonatomic,retain) NSColor *currentStrokeColor;
@property (nonatomic,retain) NSColor *currentFillColor;
@property (nonatomic,retain) NSShadow *currentShadow;

@property (nonatomic,assign) CGFloat currentCornerRadius;

@property (nonatomic,assign) BOOL autoscrolls; // 20240426
@property (nonatomic,assign) BOOL scrollNow;   // 20240426

@property (nonatomic,assign) BOOL antialias;   // 20241011

- (id)initWithFrame:(NSRect)r;
+ (id)viewWithFrame:(NSRect)r;

- (void)copyAction:(id)sender;

- (NSPoint)addString:(NSString *)string;
- (NSPoint)addString:(NSString *)string at:(NSPoint)pt;
//- (void)setFont:(NSFont *)font;
- (void)setFontName:(NSString *)name;
- (void)setFontSize:(CGFloat)size;
- (void)setForegroundColor:(NSColor *)col;
- (void)setBackgroundColor:(NSColor *)col;
- (void)setAttributes:(NSDictionary *)attributes;
- (void)setAlignment:(NSTextAlignment)alignment;
- (void)setTabInterval:(CGFloat)interval;
- (void)resetAttributes;
- (void)clear;

// draw
- (void)addLines:(NSArray *)lines fromCurrentLocation:(BOOL)from;
- (void)addOvalWithRect:(NSRect)r strokeColor:(NSColor *)strokeCol fillColor:(NSColor *)fillCol;
- (void)addRectWithRect:(NSRect)r strokeColor:(NSColor *)strokeCol fillColor:(NSColor *)fillCol cornerRadius:(CGFloat)cornerRadius;

// item array
- (NSArray *)itemArray;
@end

NSWindow *CUI_PrintToWindowWindow( void );
CUI_PrintToWindowView *CUI_PrintToWindowViewObj( NSWindow *w );

CUI_PrintToWindowScrollView *CUI_PrintToWindowScrollViewObj( NSInteger wndTag );

void CUI_PrintToWindowSetXY( NSWindow *w, CGFloat x, CGFloat y );
void CUI_PrintToWindowSetColRow( NSWindow *, CGFloat col, CGFloat row );// 20211207
void CUI_PrintToWindowPrint( NSWindow *w, NSString *string );
void CUI_PrintToWindowClear( NSWindow *w );

// print to window
void CUI_PrintToWindowTextSetFontName( NSWindow *w, NSString *name );
void CUI_PrintToWindowTextSetFontSize( NSWindow *w, CGFloat size );
void CUI_PrintToWindowTextSetForegroundColor( NSWindow *w, NSColor *col );
void CUI_PrintToWindowTextSetBackgroundColor( NSWindow *w, NSColor *col );
void CUI_PrintToWindowTextSetAlignment( NSWindow *w, NSTextAlignment alignment );
void CUI_PrintToWindowTextSetTabInterval( NSWindow *w, CGFloat interval );
void CUI_PrintToWindowTextReset( NSWindow *w );

// draw to window
void CUI_DrawToWindowLines( NSWindow *w, NSArray *lines );
void CUI_DrawToWindowToLines( NSWindow *w, NSArray *lines );

void CUI_DrawToWindowLineWidth( NSWindow *w, CGFloat width );

void CUI_DrawToWindowPen( NSWindow *w, CGFloat width, NSColor *col, long capStyle, NSArray *dashPattern, CGFloat dashPhase, NSShadow *inShadow );
void CUI_DrawToWindowPenReset( NSWindow *w );

void CUI_DrawToWindowOval( NSWindow *wnd, NSRect rect, NSColor *fillCol, BOOL fillFlag );
void CUI_DrawToWindowRect( NSWindow *wnd, NSRect rect, NSColor *fillCol, CGFloat cornerRadius, BOOL fillFlag );

// print %(x,y) statement
void CUI_PrintToWindowSetXYStatement( CGFloat x, CGFloat y );

// print !(col,row) statement
void CUI_PrintToWindowSetColRowStatement( CGFloat col, CGFloat row );// 20211207

// Print to window utilities
CFArrayRef WindowPrintViewItems( NSInteger tag );
CUI_PrintToWindowView *WindowPrintView( NSInteger tag );
CFStringRef WindowPrintViewString( NSInteger tag );

CGFloat WindowPrintViewTextInset( NSInteger tag );
void WindowPrintViewSetTextInset( NSInteger tag, CGFloat inset );
void WindowPrintViewSetPosition( NSInteger tag, NSWindowOrderingMode place, NSInteger otherViewTag );// 20211206
void WindowPrintViewSetFlipped( NSInteger wndTag, BOOL flag );
CGPoint WindowPrintViewCurrentLocation( NSInteger wndTag );// 20221103
void WindowPrintViewSetAttributes( NSInteger wndTag, CFDictionaryRef attributes ); // 20230220
void WindowPrintViewUndo( NSInteger wndTag );// 20221103

void WindowPrintViewSetHasVerticalScroller( NSInteger wndTag, BOOL flag ); // 20221107

void WindowPrintViewSetAutoscrolls( NSInteger wndTag, BOOL flag );         // 20240425

void WindowPrintViewScrollToTop( NSInteger wndTag );                       // 20221108
void WindowPrintViewScrollToBottom( NSInteger wndTag );                    // 20221108
void WindowPrintViewScrollToPoint( NSInteger wndTag, CGPoint pt );         // 20221108
void WindowPrintViewScrollerSetHidden( NSInteger wndTag, BOOL flag );      // 20240210

NSInteger WindowPrintViewItemCount( NSInteger wndTag );                        // 20241011
NSInteger WindowPrintViewItemTypeAtIndex( NSInteger wndTag, NSInteger index ); // 20241011
void WindowPrintViewRemoveItemAtIndex( NSInteger wndTag, NSInteger index );    // 20241010
void WindowPrintViewSetShouldAntialias( NSInteger wndTag, BOOL flag );         // 20241011

void WindowSetPrintViewPosition( NSInteger tag, NSWindowOrderingMode place, NSInteger otherViewTag );// deprecated 20220707
void WindowSetPrintViewFlipped( NSInteger wndTag, BOOL flag );// deprecated 20220707

// print statement
void CUI_PrintToWindowPrintStatement( id obj, ... );
void CUI_PrintToWindowPrintFStatement( id fmt, ... );

// cls statement
void CUI_PrintToWindowClearStatement( void );

// text statement
void CUI_PrintToWindowTextStatement( CFStringRef fontName, CGFloat fontSize, long inForeColor, long inBackColor, NSInteger alignment, NSInteger tabInterval );
void CUI_PrintToWindowTextResetStatement( void );

// draw to window statements
void CUI_DrawToWindowLineStatement( id obj, ... );
void CUI_DrawToWindowLineToStatement( id obj, ... );

//void CUI_DrawToWindowLineWidthStatement( CGFloat width );
void CUI_DrawToWindowPenStatement( CGFloat width, long inCol, long capStyle, NSArray *dashPattern, CGFloat dashPhase, NSShadow *inShadow );
void CUI_DrawToWindowPenResetStatement( void );
void CUI_DrawToWindowOvalStatement( CGRect inRect, long inFillCol, BOOL fillFlag );
void CUI_DrawToWindowRectStatement( CGRect inRect, long inFillCol, CGFloat inCornerRadius, BOOL fillFlag );



#pragma mark - titlebar accessory view
id TitlebarAccessoryViewWithTag( NSInteger tag );


#pragma mark - window controller
@interface CUI_WindowController : NSWindowController
@end

#pragma mark - window
#pragma mark - subclass
@interface WindowSC : NSWindow
@end

void CUI_WindowSubclassCanBecomeKeyWindow( NSWindow *w );
void CUI_WindowSubclassMouseDown( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassMouseUp( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassKeyDown( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassKeyUp( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassFlagsChanged( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassMouseEntered( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassMouseExited( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassRightMouseUp( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassOtherMouseUp( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassRightMouseDown( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassOtherMouseDown( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassMouseMoved( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassMouseDragged( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassRightMouseDragged( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassOtherMouseDragged( NSWindow *w, NSEvent *event );
void CUI_WindowSubclassAwakeFromNib( id w );// 20211014

#pragma mark - content view tag
enum {
    windowContentViewTag = -1437226411
};

enum {
    WindowContentViewTag = -1437226411
};

#pragma mark - private
id CUI_VisibleTargetWindow( NSInteger *inWndTag );
id CUI_TargetWindow( NSInteger *inWndTag );
NSView *CUI_TargetContentView( id w );

#pragma mark - content view subclass
@interface ContentViewSC : NSView
@property (nonatomic,assign) BOOL flip;
@property (nonatomic,assign) BOOL subclassFlag;
@property (nonatomic,assign) BOOL responderFlag;
@property (nonatomic,retain) NSArray *dragFileTypes;
@property (nonatomic,retain) NSArray *dragFileExtensions;
//@property (weak) NSArray *dragFileTypes;
//@property (weak) NSArray *dragFileExtensions;
@property (nonatomic,assign) BOOL dragInside;
@end

#pragma mark - dialog events
enum {
    // sheet
    windowWillPositionSheet = 10000,
    windowWillBeginSheet,
    windowDidEndSheet,
    
    // size
    windowWillResize,           // get/set CGSize
    windowDidResize,
    windowWillStartLiveResize,
    windowDidEndLiveResize,
    
    // minimize
    windowWillMiniaturize,
    windowDidMiniaturize,
    windowDidDeminiaturize,
    
    // zoom
    windowWillUseStandardFrame,
    windowShouldZoom,          // get CGRect, set Bool
    
    // full-screen
    windowWillUseFullScreenContentSize,
    windowWillUseFullScreenPresentationOptions,
    windowWillEnterFullScreen,
    windowDidEnterFullScreen,
    windowWillExitFullScreen,
    windowDidExitFullScreen,
    
    // full-screen animations
    windowCustomWindowsToEnterFullScreen,
    windowCustomWindowsToEnterFullScreenOnScreen,
    windowStartCustomAnimationToEnterFullScreen,
    windowStartCustomAnimationToEnterFullScreenOnScreen,
    windowDidFailToEnterFullScreen,
    windowCustomWindowsToExitFullScreen,
    windowStartCustomAnimationToExitFullScreen,
    windowDidFailToExitFullScreen,
    
    // move
    windowWillMove,
    windowDidMove,
    windowDidChangeScreen,
    windowDidChangeScreenProfile,
    windowDidChangeBackingProperties,

    // close
    windowShouldClose,         // set Bool
    windowWillClose,
    
    // key
    windowDidBecomeKey,
    windowDidResignKey,
    
    // main
    windowDidBecomeMain,
    windowDidResignMain,
    
    // field editor
    windowWillReturnFieldEditorToObject,

    // update
    windowDidUpdate,
    
    // exposing
    
    // occlusion state
    
    // dragging
    
    // undo manager
    
    // title
    windowShouldPopUpDocumentPathMenu,
    
    // restorable state
    
    // version browser
    
#pragma mark - subclass events
    windowCanBecomeKeyWindow,
    
    // drag
    windowDraggingEntered,
    windowWantsPeriodicDraggingUpdates,
    windowDraggingUpdated,
    windowDraggingEnded,
    windowDraggingExited,
    windowPrepareForDragOperation,
    windowPerformDragOperation,
    windowConcludeDragOperation,
    windowUpdateDraggingItemsForDrag,
    
    windowAcceptsFirstResponder,
    windowMouseDown,
    windowMouseDragged,
    windowMouseMoved,
    windowMouseUp,
    windowKeyDown,
    windowKeyUp,
    windowFlagsChanged,
    windowMouseEntered,
    windowMouseExited,
    
    windowRightMouseUp,
    windowOtherMouseUp,
    windowRightMouseDown,
    windowOtherMouseDown,
    windowRightMouseDragged,
    windowOtherMouseDragged,

    windowAwakeFromNib// 20211014
};

#pragma mark - delegate
typedef void (*CUI_WindowCallbackType)(NSInteger,NSInteger,void *);

@interface CUI_WindowDelegate : NSObject <NSWindowDelegate>
@property (nonatomic,assign) BOOL boolVal;
@property (nonatomic,assign) NSSize sizeVal;
@property (nonatomic,assign) NSRect rectVal;
@property (nonatomic,assign) CUI_WindowCallbackType allWindowsCallback;
@property (nonatomic,retain) NSArray *dragFileTypes;
@property (nonatomic,retain) NSArray *dragFileExtensions;
//@property (weak) NSArray *dragFileTypes;
//@property (weak) NSArray *dragFileExtensions;
@property (nonatomic,assign) BOOL dragInside;

- (void)window:(NSWindow *)w forwardEvent:(NSInteger)event tag:(NSInteger)tag obj:(id)obj;

@end

CUI_WindowDelegate *CUI_WindowDelegateObj( void );

#pragma mark - additions
@interface NSWindow (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;
@property (nonatomic,retain) NSValue *callbackValue;
@property (nonatomic,retain) NSValue *userDataValue;

- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
- (CUI_WindowCallbackType)cuiWindowCallback;
- (void *)cuiWindowUserData;
- (void)setCuiWindowCallback:(CUI_WindowCallbackType)cb;
- (void)setCuiWindowUserData:(void *)userData;
@end

#pragma mark - private
NSInteger CUI_OutputWindowTag( void );
void CUI_OutputWindowSetTag( NSInteger tag );
id CUI_VisibleOutputWindow( void );
id CUI_OutputWindow( void );
NSView *CUI_OutputWindowContentView( void );
NSInteger CUI_ParentTagForView( id view );
id CUI_TargetWithTag( NSInteger tag );
id CUI_VisibleTargetWithTag( NSInteger tag );

BOOL CUI_ObjectIsPopover( NSInteger tag );
BOOL CUI_ObjectIsWindow( NSInteger tag );

id CUI_VisibleWindowWithTag( NSInteger tag );

id CUI_WindowWithTag( NSInteger tag );

NSWindow *CUI_VisibleFrontWindow( void );
NSWindow *CUI_FrontWindow( void );

void CUI_WindowMakeFirstTextViewResponder( NSWindow *w );

void CUI_WindowSetTitle( NSInteger tag, CFStringRef title );


#pragma mark - public
Class WindowClass( void );
NSInteger WindowTag( NSWindow *wnd );

// Configure
void WindowToggleFullScreen( NSInteger tag );
BOOL WindowWorksWhenModal( NSInteger tag );
CGFloat WindowAlphaValue( NSInteger tag );
void WindowSetAlphaValue( NSInteger tag, CGFloat value );
NSColor *WindowBackgroundColor( NSInteger tag );
void WindowSetBackgroundColor( NSInteger tag, NSColor *col );
NSColorSpace *WindowColorSpace( NSInteger tag );
void WindowSetColorSpace( NSInteger tag, NSColorSpace *cs );
NSViewController *WindowContentViewController( NSInteger tag );
void WindowSetContentViewController( NSInteger tag, NSViewController *viewController );
NSView *WindowContentView( NSInteger tag );
void WindowSetContentView( NSInteger tag, NSInteger vwTag );
BOOL WindowCanHide( NSInteger tag );
void WindowSetCanHide( NSInteger tag, BOOL flag );
BOOL WindowIsOnActiveSpace( NSInteger tag );
BOOL WindowHidesOnDeactivate( NSInteger tag );
void WindowSetHidesOnDeactivate( NSInteger tag, BOOL flag );
NSWindowCollectionBehavior WindowCollectionBehavior( NSInteger tag );
void WindowSetCollectionBehavior( NSInteger tag, NSWindowCollectionBehavior behavior );
BOOL WindowIsOpaque( NSInteger tag );
void WindowSetOpaque( NSInteger tag, BOOL flag );
BOOL WindowHasShadow( NSInteger tag );
void WindowSetHasShadow( NSInteger tag, BOOL flag );

void WindowInvalidateShadow( NSInteger tag );
BOOL WindowAutorecalculatesContentBorderThickness( NSInteger tag, CGRectEdge edge );
void WindowSetAutorecalculatesContentBorderThickness( NSInteger tag, BOOL flag, CGRectEdge edge );

CGFloat WindowContentBorderThickness( NSInteger tag, CGRectEdge edge );
void WindowSetContentBorderThickness( NSInteger tag, CGFloat thickness, CGRectEdge edge );
BOOL WindowPreventsApplicationTerminationWhenModal( NSInteger tag );
void WindowSetPreventsApplicationTerminationWhenModal( NSInteger tag, BOOL flag );

// Info
NSWindowDepth WindowDefaultDepthLimit( void );
NSInteger WindowNumber( NSInteger tag );
CFArrayRef WindowNumbersWithOptions( NSWindowNumberListOptions options );
CFDictionaryRef WindowDeviceDescription( NSInteger tag );
BOOL WindowCanBecomeVisibleWithoutLogin( NSInteger tag );
void WindowSetCanBecomeVisibleWithoutLogin( NSInteger tag, BOOL flag );
NSWindowSharingType WindowSharingType( NSInteger tag );
void WindowSetSharingType( NSInteger tag, NSWindowSharingType type );
NSBackingStoreType WindowBackingType( NSInteger tag );
void WindowSetBackingType( NSInteger tag, NSBackingStoreType type );
NSWindowDepth WindowDepthLimit( NSInteger tag );
void WindowSetDepthLimit( NSInteger tag, NSWindowDepth depth );
BOOL WindowHasDynamicDepthLimit( NSInteger tag );

NSInteger WindowAttachedSheet( NSInteger tag );
BOOL WindowIsSheet( NSInteger tag );
CGSize WindowAspectRatio( NSInteger tag );
void WindowSetAspectRatio( NSInteger tag, CGSize size );
CFStringRef WindowTitle( NSInteger tag );
void WindowSetTitle( NSInteger tag, CFStringRef title );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
CFStringRef WindowSubtitle( NSInteger tag );
API_AVAILABLE(macos(11.0))
void WindowSetSubtitle( NSInteger tag, CFStringRef subtitle );
#endif// 110000
CFURLRef WindowRepresentedURL( NSInteger tag );
void WindowSetRepresentedURL( NSInteger tag, CFURLRef url );

NSScreen *WindowScreen( NSInteger tag );
NSScreen *WindowDeepestScreen( NSInteger tag );
BOOL WindowDisplaysWhenScreenProfileChanges( NSInteger tag );
void WindowSetDisplaysWhenScreenProfileChanges( NSInteger tag, BOOL flag );

BOOL WindowIsMovableByWindowBackground( NSInteger tag );
void WindowSetMovableByWindowBackground( NSInteger tag, BOOL flag );
BOOL WindowIsMovable( NSInteger tag );
void WindowSetMovable( NSInteger tag, BOOL flag );
void WindowCenter( NSInteger tag );
void WindowPerformClose( NSInteger tag );
void WindowClose( NSInteger tag );

BOOL WindowIsReleasedWhenClosed( NSInteger tag );
void WindowSetReleasedWhenClosed( NSInteger tag, BOOL flag );

BOOL WindowIsMiniaturized( NSInteger tag );
void WindowPerformMiniaturize( NSInteger tag );
void WindowMiniaturize( NSInteger tag );
void WindowDeminiaturize( NSInteger tag );
NSImage *WindowMiniwindowImage( NSInteger tag );
void WindowSetMiniwindowImage( NSInteger tag, CFTypeRef inImage );
void WindowSetMiniwindowImageNamed( NSInteger tag, CFStringRef imageName );
CFStringRef WindowMiniwindowTitle( NSInteger tag );
void WindowSetMiniwindowTitle( NSInteger tag, CFStringRef title );
NSDockTile *WindowDockTile( NSInteger tag );

void WindowPrint( NSInteger tag );
CFDataRef WindowDataWithEPSInsideRect( NSInteger tag, CGRect r );
CFDataRef WindowDataWithPDFInsideRect( NSInteger tag, CGRect r );

// Scripting attributes
BOOL WindowHasCloseBox( NSInteger tag );
BOOL WindowHasTitleBar( NSInteger tag );
void WindowSetIsMiniaturized( NSInteger tag, BOOL flag );
void WindowSetIsVisible( NSInteger tag, BOOL flag );
void WindowSetIsZoomed( NSInteger tag, BOOL flag );

// Ordered indices
NSInteger WindowOrderedIndex( NSInteger tag );
void WindowSetOrderedIndex( NSInteger tag, NSInteger index );


CGRect WindowFrame( NSInteger tag );
CGRect WindowContentRect( NSInteger tag );
void WindowSetFrameTopLeftPoint( NSInteger tag, CGPoint pt );

void WindowConstrainFrameRect( NSInteger tag, CGRect frame, NSScreen *screen );

void WindowSetMinSize( NSInteger tag, CGSize size );
void WindowSetMaxSize( NSInteger tag, CGSize size );
void WindowSetContentAspectRatio( NSInteger tag, CGSize size );
CGSize WindowContentMinSize( NSInteger tag );
void WindowSetContentMinSize( NSInteger tag, CGSize size );
CGSize WindowContentMaxSize( NSInteger tag );
void WindowSetContentMaxSize( NSInteger tag, CGSize size );
void WindowOrderOut( NSInteger tag );
void WindowOrderBack( NSInteger tag );
void WindowOrderFront( NSInteger tag );
void WindowOrderFrontRegardless( NSInteger tag );

NSWindowOcclusionState WindowOcclusionState( NSInteger tag );

BOOL WindowIsKey( NSInteger tag );
BOOL WindowCanBecomeKey( NSInteger tag );
void WindowMakeKey( NSInteger tag );
void WindowMakeKeyAndOrderFront( NSInteger tag );
BOOL WindowIsMain( NSInteger tag );
BOOL WindowCanBecomeMain( NSInteger tag );
void WindowMakeMain( NSInteger tag );
void WindowSetFrameUsingName( NSInteger tag, CFStringRef name );
void WindowSetFrameUsingNameForce( NSInteger tag, CFStringRef name, BOOL force );
void WindowSaveFrameUsingName( NSInteger tag, CFStringRef name );
CFStringRef WindowFrameAutosaveName( NSInteger tag );
CFStringRef WindowStringWithSavedFrame( NSInteger tag );
void WindowSetFrameFromString( NSInteger tag, CFStringRef string );

void WindowBeginSheet( NSInteger tag, NSInteger sheetTag );
void WindowBeginCriticalSheet( NSInteger tag, NSInteger sheetTag );
void WindowEndSheet( NSInteger tag, NSInteger sheetTag );
void WindowEndSheetWithReturnCode( NSInteger tag, NSInteger sheetTag, NSInteger returnCode );

void WindowFlush( NSInteger tag );

// Default buttons
void WindowEnableKeyEquivalentForDefaultButtonCell( NSInteger tag );
void WindowDisableKeyEquivalentForDefaultButtonCell( NSInteger tag );

NSInteger WindowInitialFirstResponder( NSInteger tag );
void WindowSetInitialFirstResponder( NSInteger wndTag, NSInteger responderTag );
NSInteger WindowFirstResponder( NSInteger tag );
void WindowMakeFirstResponder( NSInteger wndTag, NSInteger viewTag );
void WindowSelectKeyViewPrecedingView( NSInteger wndTag, NSInteger viewTag );
void WindowSelectKeyViewFollowingView( NSInteger wndTag, NSInteger viewTag );
void WindowSelectPreviousKeyView( NSInteger tag );
void WindowSelectNextKeyView( NSInteger tag );
NSSelectionDirection WindowKeyViewSelectionDirection( NSInteger tag );
BOOL WindowAutorecalculatesKeyViewLoop( NSInteger tag );
void WindowSetAutorecalculatesKeyViewLoop( NSInteger tag, BOOL flag );
void WindowRecalculateKeyViewLoop( NSInteger tag );

BOOL WindowAcceptsMouseMovedEvents( NSInteger tag );
void WindowSetAcceptsMouseMovedEvents( NSInteger tag, BOOL flag );
BOOL WindowIgnoresMouseEvents( NSInteger tag );
void WindowSetIgnoresMouseEvents( NSInteger tag, BOOL flag );
CGPoint WindowMouseLocationOutsideOfEventStream( NSInteger tag );
NSInteger WindowNumberAtPoint( CGPoint pt, NSInteger belowWindowNumber );

void WindowSetToolbar( NSInteger wndTag, NSInteger toolbarTag );
NSInteger WindowToolbar( NSInteger tag );
void WindowToggleToolbarShown( NSInteger tag );
void WindowRunToolbarCustomizationPalette( NSInteger tag );

void WindowSetDocumentEdited( NSInteger tag, BOOL flag );
BOOL WindowDocumentEdited( NSInteger tag );

// Converting coordinates
CGFloat WindowBackingScaleFactor( NSInteger tag );
CGRect WindowBackingAlignedRect( NSInteger tag, CGRect r, NSAlignmentOptions options );
CGRect WindowConvertRectFromBacking( NSInteger tag, CGRect r );
CGRect WindowConvertRectToBacking( NSInteger tag, CGRect r );
CGRect WindowConvertRectToScreen( NSInteger tag, CGRect r );
CGRect WindowConvertRectFromScreen( NSInteger tag, CGRect r );

BOOL WindowTitlebarAppearsTransparent( NSInteger tag );
void WindowSetTitlebarAppearsTransparent( NSInteger tag, BOOL flag );

void WindowAddTitlebarAccessoryViewController( NSInteger wndTag, NSTitlebarAccessoryViewController *controller );
void WindowInsertTitlebarAccessoryViewController( NSInteger wndTag, NSTitlebarAccessoryViewController *controller, NSInteger index );
void WindowRemoveTitlebarAccessoryViewController( NSInteger wndTag, NSInteger index );
CFArrayRef WindowTitlebarAccessoryViewControllers( NSInteger wndTag );

// - titlebar accessory view convenience functions
void WindowAddTitlebarAccessoryView( NSInteger wndTag, NSInteger viewTag, NSLayoutAttribute layout );
void WindowInsertTitlebarAccessoryView( NSInteger wndTag, NSInteger viewTag, NSInteger index, NSLayoutAttribute layout );
void WindowRemoveTitlebarAccessoryView( NSInteger wndTag, NSInteger index );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSWindowToolbarStyle WindowToolbarStyle( NSInteger tag );
API_AVAILABLE(macos(11.0))
void WindowSetToolbarStyle( NSInteger tag, NSWindowToolbarStyle style );
#endif// 110000

void WindowPerformWindowDragWithEvent( NSInteger wndTag, NSEvent *evnt );

// Tabs
BOOL WindowAllowsAutomaticWindowTabbing( void );
void WindowSetAllowsAutomaticWindowTabbing( BOOL flag );
NSWindowUserTabbingPreference WindowUserTabbingPreference( void );
NSWindowTab *WindowTab( NSInteger tag );
CFStringRef WindowTabbingIdentifier( NSInteger tag );
void WindowSetTabbingIdentifier( NSInteger tag, CFStringRef identifier );
void WindowAddTabbedWindow( NSInteger tag, NSInteger otherTag, NSWindowOrderingMode orderingMode );
NSWindowTabbingMode WindowTabbingMode( NSInteger tag );
CFArrayRef WindowTabbedWindows( NSInteger tag );
void WindowSelectNextTab( NSInteger tag );
void WindowSelectPreviousTab( NSInteger tag );
void WindowMoveTabToNewWindow( NSInteger tag );
void WindowToggleTabBar( NSInteger tag );
void WindowToggleTabOverview( NSInteger tag );
NSWindowTabGroup *WindowTabGroup( NSInteger tag );

void WindowSetAllowsToolTipsWhenApplicationIsInactive( NSInteger tag, BOOL flag);
void WindowSetTitleWithRepresentedFilename( NSInteger tag, CFStringRef filename );
CFArrayRef WindowChildWindows( NSInteger tag );
void WindowAddChildWindow( NSInteger parTag, NSInteger childTag, NSWindowOrderingMode ordered );
void WindowRemoveChildWindow( NSInteger parTag, NSInteger childTag );
NSInteger WindowParentWindow( NSInteger tag );
void WindowSetFrameOrigin( NSInteger tag, CGPoint pt );
void WindowSetFrame( NSInteger tag, CGRect frame, BOOL display, BOOL animate );
CGPoint WindowCascadeTopLeftFromPoint( NSInteger tag, CGPoint pt );
CFTimeInterval WindowAnimationResizeTime( NSInteger tag, CGRect newFrame );
BOOL WindowIsZoomed( NSInteger tag );
void WindowPerformZoom( NSInteger tag );
void WindowZoom( NSInteger tag );
BOOL WindowShowsResizeIndicator( NSInteger tag );
void WindowSetShowsResizeIndicator( NSInteger tag, BOOL flag );

CGSize WindowMaxFullScreenContentSize( NSInteger tag );
void WindowSetMaxFullScreenContentSize( NSInteger tag, CGSize size );
CGSize WindowMinFullScreenContentSize( NSInteger tag );
void WindowSetMinFullScreenContentSize( NSInteger tag, CGSize size );

BOOL WindowIsVisible( NSInteger tag );
void WindowRemoveFrameUsingName( CFStringRef name );
BOOL WindowIsExcludedFromWindowsMenu( NSInteger tag );
void WindowSetExcludedFromWindowsMenu( NSInteger tag, BOOL flag );

// Window restoration
BOOL WindowIsRestorable( NSInteger tag );
void WindowSetRestorable( NSInteger tag, BOOL flag );
Class WindowRestorationClass( NSInteger tag );
void WindowDisableSnapshotRestoration( NSInteger tag );
void WindowEnableShapshotRestoration( NSInteger tag );

// Drawing
void WindowDisplay( NSInteger tag );
void WindowDisplayIfNeeded( NSInteger tag );
BOOL WindowViewsNeedDisplay( NSInteger tag );
void WindowSetViewsNeedDisplay( NSInteger tag, BOOL flag );
CGContextRef WindowGraphicsContext( NSInteger tag );
BOOL WindowAllowsConcurrentViewDrawing( NSInteger tag );
void WindowSetAllowsConcurrentViewDrawing( NSInteger tag, BOOL flag );

BOOL WindowAreCursorRectsEnabled( NSInteger tag );
void WindowEnableCursorRects( NSInteger tag );
void WindowDisableCursorRects( NSInteger tag );
void WindowDiscardCursorRects( NSInteger tag );
void WindowInvalidateCursorRectsForView( NSInteger tag, NSInteger vwTag );
void WindowResetCursorRects( NSInteger tag );

// Animation
NSWindowAnimationBehavior WindowAnimationBehavior( NSInteger tag );
void WindowSetAnimationBehavior( NSInteger tag, NSWindowAnimationBehavior behavior );

// Dragging items
void WindowRegisterForDraggedTypes( NSInteger tag, CFArrayRef types );
void WindowUnregisterDraggedTypes( NSInteger tag );

CGRect WindowContentRectForFrameRectAndStyle( CGRect r, NSInteger styleMask );
CGRect WindowFrameRectForContentRectAndStyle( CGRect r, NSInteger styleMask );
CGFloat WindowMinFrameWidthWithTitle( CFStringRef title, NSInteger styleMask );

CGRect WindowContentRectForFrameRect( NSInteger tag, CGRect r );
CGRect WindowFrameRectForContentRect( NSInteger tag, CGRect r );

NSInteger WindowSheetParent( NSInteger tag );
CFArrayRef WindowSheets( NSInteger tag );

CGSize WindowResizeIncrements( NSInteger tag );
void WindowSetResizeIncrements( NSInteger tag, CGSize size );

BOOL WindowInLiveResize( NSInteger tag );

void WindowSetContentSize( NSInteger tag, CGSize size );
CGSize WindowContentResizeIncrements( NSInteger tag );
void WindowSetContentResizeIncrements( NSInteger tag, CGSize size );
void WindowOrderRelativeTo( NSInteger wndTag, NSWindowOrderingMode order, NSInteger otherWndTag );
NSInteger WindowLevel( NSInteger tag );
void WindowSetLevel( NSInteger tag, NSInteger level );

void *WindowStandardWindowButtonForStyleMask( NSWindowButton btn, NSUInteger styleMask );
void *WindowStandardWindowButton( NSInteger tag, NSWindowButton btn );

NSWindowTitleVisibility WindowTitleVisibility( NSInteger tag );
void WindowSetTitleVisibility( NSInteger tag, NSWindowTitleVisibility visibility );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSTitlebarSeparatorStyle WindowTitlebarSeparatorStyle( NSInteger tag );
API_AVAILABLE(macos(11.0))
void WindowSetTitlebarSeparatorStyle( NSInteger tag, NSTitlebarSeparatorStyle style );
#endif// 110000

NSUInteger WindowResizeFlags( NSInteger tag );

// Instance properties
BOOL WindowIsFloatingPanel( NSInteger tag );
BOOL WindowIsMiniaturizable( NSInteger tag );
BOOL WindowIsModalPanel( NSInteger tag );
BOOL WindowIsResizable( NSInteger tag );
NSUInteger WindowStyleMask( NSInteger tag );
void WindowSetStyleMask( NSInteger tag, NSUInteger mask );
BOOL WindowIsZoomable( NSInteger tag );

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
API_AVAILABLE(macos(10.14))
CGPoint WindowConvertPointFromScreen( NSInteger tag, CGPoint pt );
API_AVAILABLE(macos(10.14))
CGPoint WindowConvertPointToScreen( NSInteger tag, CGPoint pt );
API_AVAILABLE(macos(10.14))
CGPoint WindowConvertPointFromBacking( NSInteger tag, CGPoint pt );
API_AVAILABLE(macos(10.14))
CGPoint WindowConvertPointToBacking( NSInteger tag, CGPoint pt );
#endif// 101400

void WindowMergeAllWindows( NSInteger tag );
void WindowSetFrameAutosaveName( NSInteger tag, CFStringRef name );

// DisplayLink
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
CADisplayLink *WindowDisplayLinkWithTarget( NSInteger tag, id target, CFStringRef selector );
#endif// 140000

/*
 NSAppearanceCustomization
 */
NSAppearance *WindowAppearance( NSInteger tag );
void WindowSetAppearance( NSInteger tag, NSAppearance *appearance );
void WindowSetAppearanceNamed( NSInteger tag, CFStringRef name );
NSAppearance *WindowEffectiveAppearance( NSInteger tag );


#pragma mark - convenience
// Animation
CFTypeRef WindowAnimator( NSInteger tag );
CFDictionaryRef WindowAnimations( NSInteger tag );
void WindowSetAnimations( NSInteger tag, CFDictionaryRef animations );

// Identifier (same as UserInterfaceItemIdentificationIdentifier)
CFStringRef WindowIdentifier( NSInteger tag );
void WindowSetIdentifier( NSInteger tag, CFStringRef identifier );


#pragma mark - custom
void WindowSetOutput( NSInteger tag );

void WindowAddSubview( NSInteger tag, NSView *vwRef );

void WindowSetTitleWithRepresentedURL( NSInteger tag, CFURLRef url );

// Class
//Class WindowClass( void );

BOOL WindowExists( NSInteger tag );
id WindowWithTag( NSInteger tag );
id WindowViewWithTag( NSInteger wndTag, NSInteger viewTag );
void WindowSetDelegateCallback( NSInteger tag, CUI_WindowCallbackType callback, void *userData );
void WindowSubclassContentView( NSInteger tag );
void WindowRecalculateKeyViewLoopByTagOrder( NSInteger wndTag );
void WindowSetKeyViewLoop( NSInteger wndTag, CFTypeRef views );

CFTypeRef WindowProperty( NSInteger tag, CFStringRef key );
void WindowSetProperty( NSInteger tag, CFStringRef key, CFTypeRef value );
void WindowPropertySet( NSInteger tag, CFStringRef key, CFTypeRef value );

BOOL WindowPropertyBool( NSInteger tag, CFStringRef key );
void WindowPropertySetBool( NSInteger tag, CFStringRef key, BOOL value );
long WindowPropertyLong( NSInteger tag, CFStringRef key );
void WindowPropertySetLong( NSInteger tag, CFStringRef key, long value );
double WindowPropertyDouble( NSInteger tag, CFStringRef key );
void WindowPropertySetDouble( NSInteger tag, CFStringRef key, double value );
CGRect WindowPropertyRect( NSInteger tag, CFStringRef key );
void WindowPropertySetRect( NSInteger tag, CFStringRef key, CGRect r );
CGPoint WindowPropertyPoint( NSInteger tag, CFStringRef key );
void WindowPropertySetPoint( NSInteger tag, CFStringRef key, CGPoint pt );
CGSize WindowPropertySize( NSInteger tag, CFStringRef key );
void WindowPropertySetSize( NSInteger tag, CFStringRef key, CGSize sz );
CFRange WindowPropertyRange( NSInteger tag, CFStringRef key );
void WindowPropertySetRange( NSInteger tag, CFStringRef key, CFRange range );
CFURLRef WindowPropertyBookmarkURL( NSInteger tag, CFStringRef key );
void WindowPropertySetBookmarkURL( NSInteger tag, CFStringRef key, CFURLRef url );
BOOL WindowPropertyGetBytes( NSInteger tag, CFStringRef key, void *bytes );
void WindowPropertySetBytes( NSInteger tag, CFStringRef key, void *bytes, long length );

void WindowRemoveProperty( NSInteger tag, CFStringRef key );
void WindowPropertyRemove( NSInteger tag, CFStringRef key );
void WindowRemoveAllProperties( NSInteger tag );
void WindowPropertyRemoveAll( NSInteger tag );

// Cascade
void WindowCascadeTopLeftFromWindow( NSInteger tag, NSInteger otherTag );
void WindowCascadeTopLeftFromNextWindow( NSInteger tag );

// SheetAlert
void WindowEndSheetAlert( NSInteger tag, NSInteger alertTag );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
CGRect WindowCascadingReferenceFrame( NSInteger tag );
#endif// 150000

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
NSDraggingSession *WindowBeginDraggingSessionWithItems( NSInteger tag, CFArrayRef items, NSEvent *event, id<NSDraggingSource> source );

typedef void (*CUI_WindowRequestSharingOfWindowType)(NSInteger,NSError*,void *);

void WindowRequestSharingOfWindow( NSInteger tag, NSWindow *wnd, CUI_WindowRequestSharingOfWindowType completionHandler, void *userData );
void WindowRequestSharingOfWindowUsingPreview( NSInteger tag, NSImage *image, CFStringRef title, CUI_WindowRequestSharingOfWindowType completionHandler, void *userData );
#endif// 150000

void WindowRegisterForDraggedFileTypes( NSInteger tag, CFTypeRef inFileTypes );
void WindowRegisterForDraggedFileExtensions( NSInteger tag, CFTypeRef inFileExtensions );

// Hide/show tooltips
void WindowSetToolTipsHidden( NSInteger tag, BOOL flag );// 20240622

#pragma mark - window function
NSInteger CUI_WindowFunction( NSInteger inSelector );

#pragma mark - FB statement
// Init
NSWindow *WindowInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_Window( NSInteger inTag, CFStringRef inTitle, CGRect inRect, NSInteger inStyle );

#pragma mark - sidebar splitview controller
//void CUI_ProcessSidebarSplitViewController( NSWindow *window, NSString *nibName );

#pragma mark - nibwindow
void CUI_NibWindow( NSInteger inTag, CFStringRef inNibName, CFStringRef inWndIdentifier );

