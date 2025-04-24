/*
 View.h

 Bernie Wylde
 */

#import "CocoaUI.h"
#import "GestureRecognizer.h"

#pragma mark - view controller
@interface CUI_ViewController : NSViewController
@end


#pragma mark - tooltip owner
typedef CFStringRef (*CUI_ViewStringForToolTipCallbackType)(NSInteger,NSToolTipTag,CGPoint,void*);

@interface CUI_ViewToolTipOwner : NSObject// <NSViewToolTipOwner>
@property (nonatomic,retain) NSView *view;
@property (nonatomic,assign) NSToolTipTag toolTipTag;
@property (nonatomic,assign) CUI_ViewStringForToolTipCallbackType stringForToolTipCallback;
@end

CUI_ViewToolTipOwner *CUI_ViewToolTipOwnerObj( void );


#pragma mark - view
@interface ViewSC : NSView
@end

NSInteger CUI_ViewWindowTag( id view );

void CUI_ViewSubclassDrawRect( id view, NSRect dirtyRect );
void CUI_ViewSubclassAcceptsFirstResponder( id view );
void CUI_ViewSubclassMouseDown( NSView *view, NSEvent *event );
void CUI_ViewSubclassMouseUp( NSView *view, NSEvent *event );
void CUI_ViewSubclassMouseEntered( NSView *view, NSEvent *event );
void CUI_ViewSubclassMouseExited( NSView *view, NSEvent *event );
void CUI_ViewSubclassMouseDragged( NSView *view, NSEvent *event );
void CUI_ViewSubclassMouseMoved( NSView *view, NSEvent *event );
void CUI_ViewSubclassRightMouseDown( NSView *view, NSEvent *event );
void CUI_ViewSubclassRightMouseUp( NSView *view, NSEvent *event );
void CUI_ViewSubclassRightMouseDragged( NSView *view, NSEvent *event );
void CUI_ViewSubclassKeyDown( NSView *view, NSEvent *event );
void CUI_ViewSubclassKeyUp( NSView *view, NSEvent *event );
void CUI_ViewSubclassFlagsChanged( NSView *view, NSEvent *event );
//void CUI_ViewSubclassUpdateTrackingAreas( NSView *view );
void CUI_ViewSubclassResetCursorRects( NSView *view );
NSDragOperation CUI_ViewSubclassDraggingEntered( NSView *view, id<NSDraggingInfo>sender );
void CUI_ViewSubclassDraggingExited( NSView *view, id <NSDraggingInfo>sender );
BOOL CUI_ViewSubclassPerformDragOperation( NSView *view, id <NSDraggingInfo>sender );
void CUI_ViewSubclassViewDidChangeEffectiveAppearance( id view );
void CUI_ViewSubclassMenuForEvent( id view, NSEvent *event );
BOOL CUI_ViewSubclassWantsUpdateLayer( id view );
void CUI_ViewSubclassUpdateLayer( id view );
void CUI_ViewSubclassAwakeFromNib( id view );// 20211014


typedef CGPoint (*CUI_ViewShowDefinitionBaselineOriginProviderType)(CFRange,void*);

@interface NSView (Additions)
// suspendDrawRect
@property (nonatomic,retain) NSNumber *suspendDrawRectNumber;
- (BOOL)suspendDrawRect;
- (void)setSuspendDrawRect:(BOOL)flag;

// flipFlag
@property (nonatomic,retain) NSNumber *flipFlagNumber;
- (BOOL)flipFlag;
- (void)setFlipFlag:(BOOL)flag;

// responderFlag
@property (nonatomic,retain) NSNumber *responderFlagNumber;
- (BOOL)responderFlag;
- (void)setResponderFlag:(BOOL)flag;

// dragFileTypes
@property (nonatomic,retain) NSArray *dragFileTypesArray;
- (NSArray *)dragFileTypes;
- (void)setDragFileTypes:(NSArray *)types;

// dragFileExtensions
@property (nonatomic,retain) NSArray *dragFileExtensionsArray;
- (NSArray *)dragFileExtensions;
- (void)setDragFileExtensions:(NSArray *)extensions;

// dragInsideFlag
@property (nonatomic,retain) NSNumber *dragInsideFlagNumber;
- (BOOL)dragInsideFlag;
- (void)setDragInsideFlag:(BOOL)flag;

@end


#pragma mark - private
id CUI_FindViewInMenu( NSInteger tag, NSMenu *menu );// 20231227
id CUI_FindViewInAnyMenu( NSInteger tag );// 20231227
//id CUI_FindViewInAnyOpenPanelAccessoryView( NSInteger tag, Class cls );
//id CUI_FindViewInAnySavePanelAccessoryView( NSInteger tag, Class cls );
//id CUI_FindViewInWindow( NSInteger tag, Class cls, NSWindow *w );
//id CUI_FindViewInAnyWindow( NSInteger tag, Class cls );
//id CUI_FindView( NSInteger tag, Class cls );
BOOL CUI_ViewWithKindOfClassExists( NSInteger tag, Class cls );
//id CUI_ViewWithKindOfClassInAnyWindow( NSInteger tag, Class cls );// 20250217
id CUI_ValidateViewKindOfClass( NSInteger tag, Class cls );
BOOL CUI_ValidateViewClass( NSInteger wndTag, NSInteger viewTag, id obj, Class requiredClass );


// dialog events
enum {
    viewDrawRect = 2000,
    
    // first responder
    viewAcceptsFirstResponder,
    
    // mouse
    viewMouseDown,
    viewMouseDragged,
    viewMouseUp,
    viewMouseMoved,
    viewMouseEntered,
    viewMouseExited,
    viewRightMouseDown,
    viewRightMouseDragged,
    viewRightMouseUp,
    
    // key
    viewKeyDown,
    viewKeyUp,
    viewFlagsChanged,
    
    // tracking
    viewUpdateTrackingAreas,
    
    // cursor
    viewResetCursorRects,
    
    // drag
    viewDraggingEntered,
    viewWantsPeriodicDraggingUpdates,
    viewDraggingUpdated,
    viewDraggingEnded,
    viewDraggingExited,
    viewPrepareForDragOperation,
    viewPerformDragOperation,
    viewConcludeDragOperation,
    viewUpdateDraggingItemsForDrag,
    
    // appearance
    viewDidChangeEffectiveAppearance,
    
    // menu
    viewMenuForEvent,
    
    // layer
    viewWantsUpdateLayer,
    viewUpdateLayer,
    
    // awakeFromNib
    viewAwakeFromNib
};


typedef NSComparisonResult (*CUI_SortSubviewsFunctionType)(NSInteger,NSInteger,void*);
NSComparisonResult CUI_SortSubviewsFunction( NSView *view1, NSView *view2, void *context );

//void CUI_ViewConfigureSubviews( NSView *superview );

id ViewSubviewWithIdentifier( id superview, CFStringRef identifier );

// Class
Class ViewClass( void );

NSInteger CUI_ViewTag( id view );
id CUI_ViewSubviewWithTag( NSView *superview, NSInteger tag );
NSView *CUI_ViewWithTag( NSInteger tag );

NSInteger ViewSuperview( NSInteger tag );
CFArrayRef ViewSubviews( NSInteger tag );
NSInteger ViewWindow( NSInteger tag );
void ViewSetFrameOrigin( NSInteger tag, CGPoint origin );
void ViewSetFrameSize( NSInteger tag, CGSize size );
void ViewSetFrameRotation( NSInteger tag, CGFloat rotation );
CGRect ViewBounds( NSInteger tag );
void ViewSetBounds( NSInteger tag, CGRect bounds );
void ViewSetBoundsOrigin( NSInteger tag, CGPoint origin );
void ViewSetBoundsSize( NSInteger tag, CGSize size );
void ViewSetBoundsRotation( NSInteger tag, CGFloat rotation );
CGFloat ViewFrameRotation( NSInteger tag );
CGFloat ViewBoundsRotation( NSInteger tag );

// Layer
void ViewSetWantsLayer( NSInteger tag, BOOL flag );
BOOL ViewWantsUpdateLayer( NSInteger tag );
CALayer *ViewLayer( NSInteger tag );
void ViewSetLayer( NSInteger tag, CALayer *layer );
CALayer *ViewMakeBackingLayer( NSInteger tag );
NSViewLayerContentsPlacement ViewLayerContentsPlacement( NSInteger tag );
void ViewSetLayerContentsPlacement( NSInteger tag, NSViewLayerContentsPlacement placement );
NSViewLayerContentsRedrawPolicy ViewLayerContentsRedrawPolicy( NSInteger tag );
void ViewSetLayerContentsRedrawPolicy( NSInteger tag, NSViewLayerContentsRedrawPolicy policy );
BOOL ViewCanDrawSubviewsIntoLayer( NSInteger tag );
void ViewSetCanDrawSubviewsIntoLayer( NSInteger tag, BOOL flag );
BOOL ViewLayerUsesCoreImageFilters( NSInteger tag );
void ViewSetLayerUsesCoreImageFilters( NSInteger tag, BOOL flag );

CGFloat ViewAlphaValue( NSInteger tag );
void ViewSetAlphaValue( NSInteger tag, CGFloat value );
CGFloat ViewFrameCenterRotation( NSInteger tag );
void ViewSetFrameCenterRotation( NSInteger tag, CGFloat rotation );
CFArrayRef ViewBackgroundFilters( NSInteger tag );
void ViewSetBackgroundFilters( NSInteger tag, CFArrayRef filters );
CIFilter *ViewCompositingFilter( NSInteger tag );
void ViewSetCompositingFilter( NSInteger tag, CIFilter *filter );
CFArrayRef ViewContentFilters( NSInteger tag );
void ViewSetContentFilters( NSInteger tag, CFArrayRef filters );
NSShadow *ViewShadow( NSInteger tag );
void ViewSetShadow( NSInteger tag, NSShadow *shadow );

// Drawing
void ViewUpdateLayer( NSInteger tag );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
BOOL ViewClipsToBounds( NSInteger tag );
API_AVAILABLE(macos(14.0))
void ViewSetClipsToBounds( NSInteger tag, BOOL flag );
#endif// 140000
BOOL ViewCanDrawConcurrently( NSInteger tag );
void ViewSetCanDrawConcurrently( NSInteger tag, BOOL flag );
CGRect ViewVisibleRect( NSInteger tag );
BOOL ViewNeedsToDrawRect( NSInteger tag, CGRect r );
BOOL ViewWantsDefaultClipping( NSInteger tag );
NSBitmapImageRep *ViewBitmapImageRepForCachingDisplayInRect( NSInteger tag, CGRect r );
void ViewCacheDisplayInRectToBitmapImageRep( NSInteger tag, CGRect r, NSBitmapImageRep *repRef );

// Print
void ViewPrint( NSInteger tag );
void ViewBeginPageInRect( NSInteger tag, CGRect r, CGPoint location );
CFDataRef ViewDataWithEPSInsideRect( NSInteger tag, CGRect r );
CFDataRef ViewDataWithPDFInsideRect( NSInteger tag, CGRect r );
CFStringRef ViewPrintJobTitle( NSInteger tag );
CFAttributedStringRef ViewPageHeader( NSInteger tag );
CFAttributedStringRef ViewPageFooter( NSInteger tag );
void ViewWriteEPSInsideRectToPasteboard( NSInteger tag, CGRect r, NSPasteboard *pb );
void ViewWritePDFInsideRectToPasteboard( NSInteger tag, CGRect r, NSPasteboard *pb );
void ViewDrawPageBorderWithSize( NSInteger tag, CGSize size );

// Pagination
CGFloat ViewHeightAdustLimit( NSInteger tag );
CGFloat ViewWidthAdustLimit( NSInteger tag );
void ViewAdjustPageWidth( NSInteger tag, CGFloat *newRight, CGFloat oldLeft, CGFloat oldRight, CGFloat rightLimit );
void ViewAdjustPageHeight( NSInteger tag, CGFloat *newBottom, CGFloat oldTop, CGFloat oldBottom, CGFloat bottomLimit );
BOOL ViewKnowsPageRange( NSInteger tag, CFRange *range );
CGRect ViewRectForPage( NSInteger tag, NSInteger pageNum );
CGPoint ViewLocationOfPrintRect( NSInteger tag, CGRect r );

// Invalidate view content
void ViewSetNeedsDisplayInRect( NSInteger tag, CGRect r );
BOOL ViewNeedsDisplay( NSInteger tag );
void ViewSetNeedsDisplay( NSInteger tag );
void ViewDisplayRect( NSInteger tag, CGRect r );
void ViewDisplayRectIgnoringOpacity( NSInteger tag, CGRect r );
void ViewDisplayRectIgnoringOpacityInContext( NSInteger tag, CGRect r, NSGraphicsContext *ctx );
void ViewDisplay( NSInteger tag );
void ViewDisplayIfNeeded( NSInteger tag );
void ViewDisplayIfNeededInRect( NSInteger tag, CGRect r );
void ViewDisplayIfNeededIgnoringOpacity( NSInteger tag );
void ViewDisplayIfNeededInRectIgnoringOpacity( NSInteger tag, CGRect r );
void ViewTranslateRectsNeedingDisplayInRect( NSInteger tag, CGRect clipRect, CGSize delta );
BOOL ViewIsOpaque( NSInteger tag );

// Converting coordinate values
CGRect ViewBackingAlignedRect( NSInteger tag, CGRect r, NSAlignmentOptions options );
CGPoint ViewConvertPointFromBacking( NSInteger tag, CGPoint pt );
CGPoint ViewConvertPointToBacking( NSInteger tag, CGPoint pt );
CGPoint ViewConvertPointFromLayer( NSInteger tag, CGPoint pt );
CGPoint ViewConvertPointToLayer( NSInteger tag, CGPoint pt );
CGRect ViewConvertRectFromBacking( NSInteger tag, CGRect r );
CGRect ViewConvertRectToBacking( NSInteger tag, CGRect r );
CGRect ViewConvertRectFromLayer( NSInteger tag, CGRect r );
CGRect ViewConvertRectToLayer( NSInteger tag, CGRect r );
CGSize ViewConvertSizeFromBacking( NSInteger tag, CGSize size );
CGSize ViewConvertSizeToBacking( NSInteger tag, CGSize size );
CGSize ViewConvertSizeFromLayer( NSInteger tag, CGSize size );
CGSize ViewConvertSizeToLayer( NSInteger tag, CGSize size );
CGPoint ViewConvertPointFromView( NSInteger tag1, CGPoint pt, NSInteger tag2 );
CGPoint ViewConvertPointToView( NSInteger tag1, CGPoint pt, NSInteger tag2 );
CGSize ViewConvertSizeFromView( NSInteger tag1, CGSize size, NSInteger tag2 );
CGSize ViewConvertSizeToView( NSInteger tag1, CGSize size, NSInteger tag2 );
CGRect ViewConvertRectFromView( NSInteger tag1, CGRect r, NSInteger tag2 );
CGRect ViewConvertRectToView( NSInteger tag1, CGRect r, NSInteger tag2 );
CGRect ViewCenterScanRect( NSInteger tag, CGRect r );

// Modify coordinate system
void ViewTranslateOriginToPoint( NSInteger tag, CGPoint pt );
void ViewScaleUnitSquareToSize( NSInteger tag, CGSize size );
void ViewRotateByAngle( NSInteger tag, CGFloat angle );

// Examine coordinate system
BOOL ViewIsFlipped( NSInteger tag );
void ViewSetFlipped( NSInteger tag, BOOL flag );
BOOL ViewIsRotatedFromBase( NSInteger tag );
BOOL ViewIsRotatedOrScaledFromBase( NSInteger tag );


void ViewAddSubview( NSInteger viewTag, NSInteger subviewTag );
void ViewAddSubviewPositioned( NSInteger superviewTag, NSInteger subviewTag, NSWindowOrderingMode position, NSInteger otherViewTag );
void ViewRemoveFromSuperview( NSInteger tag );
void ViewRemoveFromSuperviewWithoutNeedingDisplay( NSInteger tag );
void ViewReplaceSubview( NSInteger tag, NSInteger subview1, NSInteger subview2 );
BOOL ViewIsDescendantOf( NSInteger tag, NSInteger superTag );
NSInteger ViewOpaqueAncestor( NSInteger tag );
NSInteger ViewAncestorSharedWithView( NSInteger tag, NSInteger otherTag );
void ViewSortSubviewsUsingFunction( NSInteger tag, CUI_SortSubviewsFunctionType fnAddress, void *context );

BOOL ViewAutoresizesSubviews( NSInteger tag );
void ViewSetAutoresizesSubviews( NSInteger tag, BOOL flag );
NSUInteger ViewAutoresizingMask( NSInteger tag );
void ViewSetAutoresizingMask( NSInteger tag, NSUInteger mask );


// Layout anchors
NSLayoutYAxisAnchor *ViewBottomAnchor( NSInteger tag );
NSLayoutXAxisAnchor *ViewCenterXAnchor( NSInteger tag );
NSLayoutYAxisAnchor *ViewCenterYAnchor( NSInteger tag );
NSLayoutYAxisAnchor *ViewFirstBaselineAnchor( NSInteger tag );
NSLayoutDimension *ViewHeightAnchor( NSInteger tag );
NSLayoutYAxisAnchor *ViewLastBaselineAnchor( NSInteger tag );
NSLayoutXAxisAnchor *ViewLeadingAnchor( NSInteger tag );
NSLayoutXAxisAnchor *ViewLeftAnchor( NSInteger tag );
NSLayoutXAxisAnchor *ViewRightAnchor( NSInteger tag );
NSLayoutYAxisAnchor *ViewTopAnchor( NSInteger tag );
NSLayoutXAxisAnchor *ViewTrailingAnchor( NSInteger tag );
NSLayoutDimension *ViewWidthAnchor( NSInteger tag );

// Constraints
CFArrayRef ViewConstraints( NSInteger tag );
void ViewAddConstraint( NSInteger tag, NSLayoutConstraint *constraint );
void ViewAddConstraints( NSInteger tag, CFArrayRef constraints );
void ViewRemoveConstraint( NSInteger tag, NSLayoutConstraint *constraint );
void ViewRemoveConstraints( NSInteger tag, CFArrayRef constraints );

// Layout guides
void ViewAddLayoutGuide( NSInteger tag, NSLayoutGuide *guide );
CFArrayRef ViewLayoutGuides( NSInteger tag );
void ViewRemoveLayoutGuide( NSInteger tag, NSLayoutGuide *guide );

// Measuring in auto layout
CGSize ViewFittingSize( NSInteger tag );
CGSize ViewIntrinsicContentSize( NSInteger tag );
void ViewInvalidateIntrinsicContentSize( NSInteger tag );
NSLayoutPriority ViewContentCompressionResistancePriorityForOrientation( NSInteger tag, NSLayoutConstraintOrientation orientation );
void ViewSetContentCompressionResistancePriorityForOrientation( NSInteger tag, NSLayoutPriority priority, NSLayoutConstraintOrientation orientation );
NSLayoutPriority ViewContentHuggingPriorityForOrientation( NSInteger tag, NSLayoutConstraintOrientation orientation );
void ViewSetContentHuggingPriorityForOrientation( NSInteger tag, NSLayoutPriority priority, NSLayoutConstraintOrientation orientation );

// Aligning views
CGRect ViewAlignmentRectForFrame( NSInteger tag, CGRect frame );
CGRect ViewFrameForAlignmentRect( NSInteger tag, CGRect r );
NSEdgeInsets ViewAlignmentRectInsets( NSInteger tag );
CGFloat ViewBaselineOffsetFromBottom( NSInteger tag );
CGFloat ViewFirstBaselineOffsetFromTop( NSInteger tag );
CGFloat ViewLastBaselineOffsetFromBottom( NSInteger tag );

// Triggering auto layout
BOOL ViewNeedsLayout( NSInteger tag );
void ViewSetNeedsLayout( NSInteger tag, BOOL flag );
void ViewLayout( NSInteger tag );
void ViewLayoutSubtreeIfNeeded( NSInteger tag );
BOOL ViewNeedsUpdateConstraints( NSInteger tag );
void ViewSetNeedsUpdateConstraints( NSInteger tag, BOOL flag );
void ViewUpdateConstraints( NSInteger tag );
void ViewUpdateConstraintsForSubtreeIfNeeded( NSInteger tag );

// Opting in to auto layout
BOOL ViewTranslatesAutoresizingMaskIntoConstraints( NSInteger tag );
void ViewSetTranslatesAutoresizingMaskIntoConstraints( NSInteger tag, BOOL flag );

// Enable and disable constraints
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
BOOL ViewIsHorizontalContentSizeConstraintActive( NSInteger tag );
void ViewSetHorizontalContentSizeConstraintActive( NSInteger tag, BOOL flag );
BOOL ViewIsVerticalContentSizeConstraintActive( NSInteger tag );
void ViewSetVerticalContentSizeConstraintActive( NSInteger tag, BOOL flag );
#endif// 101500

// Debugging auto layout
CFArrayRef ViewConstraintsAffectingLayoutForOrientation( NSInteger tag, NSLayoutConstraintOrientation orientation );
BOOL ViewHasAmbiguousLayout( NSInteger tag );
void ViewExerciseAmbiguityInLayout( NSInteger tag );

// Focusing
void ViewLockFocus( NSInteger tag );
void ViewUnlockFocus( NSInteger tag );
NSInteger ViewFocusView( void );

// Focus ring drawing
NSFocusRingType ViewFocusRingType( NSInteger tag );
void ViewSetFocusRingType( NSInteger tag, NSFocusRingType type );
CGRect ViewFocusRingMaskBounds( NSInteger tag );
void ViewDrawFocusRingMask( NSInteger tag );
void ViewNoteFocusRingMaskChanged( NSInteger tag );
void ViewSetKeyboardFocusRingNeedsDisplayInRect( NSInteger tag, CGRect r );
NSFocusRingType ViewDefaultFocusRingType( void );

// Vibrancy
BOOL ViewAllowsVibrancy( NSInteger tag );

// Full screen mode
BOOL ViewEnterFullScreenMode( NSInteger tag, NSScreen *screen, CFDictionaryRef options );
void ViewExitFullScreenMode( NSInteger tag, CFDictionaryRef options );
BOOL ViewIsInFullScreenMode( NSInteger tag );


CGRect ViewFrame( NSInteger tag );
void ViewSetFrame( NSInteger tag, CGRect r );

// Tags
NSInteger ViewTag( NSView *view );

// Tracking rect
NSTrackingRectTag ViewAddTrackingRect( NSInteger tag, CGRect r, id owner, void *userData, BOOL assumeInside );
void ViewRemoveTrackingRect( NSInteger tag, NSTrackingRectTag rectTag );

// Tracking area
void ViewAddTrackingArea( NSInteger tag, NSTrackingArea *ta );
void ViewRemoveTrackingArea( NSInteger tag, NSTrackingArea *ta );
CFArrayRef ViewTrackingAreas( NSInteger tag );
//void ViewUpdateTrackingAreas( NSInteger tag );

// Cursor tracking
void ViewAddCursorRect( NSInteger tag, CGRect r, NSCursor *curs );
void ViewRemoveCursorRect( NSInteger tag, CGRect r, NSCursor *curs );
void ViewDiscardCursorRects( NSInteger tag );

// Definition windows
void ViewShowDefinition( NSInteger tag, CFAttributedStringRef aString, CGPoint pt );
void ViewShowDefinitionBaselineOriginProvider( NSInteger tag, CFAttributedStringRef aString, CFRange targetRange, CFDictionaryRef options, CUI_ViewShowDefinitionBaselineOriginProviderType originProvider, void *userData );

// Find indicator
BOOL ViewIsDrawingFindIndicator( NSInteger tag );

// Content layout direction
NSUserInterfaceLayoutDirection ViewUserInterfaceLayoutDirection( NSInteger tag );
void ViewSetUserInterfaceLayoutDirection( NSInteger tag, NSUserInterfaceLayoutDirection direction );

// Configuring pressure
NSPressureConfiguration *ViewPressureConfiguration( NSInteger tag );
void ViewSetPressureConfiguration( NSInteger tag, NSPressureConfiguration *pressureConfig );

// Type properties
NSTouchTypeMask ViewAllowedTouchTypes( NSInteger tag );
void ViewSetAllowedTouchTypes( NSInteger tag, NSTouchTypeMask mask );

// Safe areas
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
API_AVAILABLE(macos(11.0))
NSEdgeInsets ViewSafeAreaInsets( NSInteger tag );
API_AVAILABLE(macos(11.0))
NSEdgeInsets ViewAdditionalSafeAreaInsets( NSInteger tag );
API_AVAILABLE(macos(11.0))
void ViewSetAdditionalSafeAreaInsets( NSInteger tag, NSEdgeInsets insets );
API_AVAILABLE(macos(11.0))
NSLayoutGuide *ViewSafeAreaLayoutGuide( NSInteger tag );
API_AVAILABLE(macos(11.0))
CGRect ViewSafeAreaRect( NSInteger tag );
API_AVAILABLE(macos(11.0))
NSLayoutGuide *ViewLayoutMarginsGuide( NSInteger tag );
#endif// 110000

BOOL ViewIsHidden( NSInteger tag );
void ViewSetHidden( NSInteger tag, BOOL flag );
BOOL ViewIsHiddenOrHasHiddenAncestor( NSInteger tag );

// Live resize
BOOL ViewInLiveResize( NSInteger tag );
BOOL ViewPreservesContentDuringLiveResize( NSInteger tag );
void ViewGetRectsExposedDuringLiveResize( NSInteger tag, CGRect *rects, NSInteger *count );
CGRect ViewRectPreservedDuringLiveResize( NSInteger tag );

// Gesture recognizer
CFArrayRef ViewGestureRecognizers( NSInteger tag );
void ViewAddGestureRecognizer( NSInteger tag, NSGestureRecognizer *ref );
void ViewRemoveGestureRecognizer( NSInteger tag, NSGestureRecognizer *ref );

// Event handling
NSInteger ViewHitTest( NSInteger tag, CGPoint pt );
BOOL ViewMouseInRect( NSInteger tag, CGPoint pt, CGRect r );
BOOL ViewMouseDownCanMoveWindow( NSInteger tag );

// Touch event handling
BOOL ViewWantsRestingTouches( NSInteger tag );
void ViewSetWantsRestingTouches( NSInteger tag, BOOL flag );

// Key-view loop management
BOOL ViewCanBecomeKeyView( NSInteger tag );
BOOL ViewNeedsPanelToBecomeKey( NSInteger tag );
NSInteger ViewNextKeyView( NSInteger tag );
void ViewSetNextKeyView( NSInteger tag, NSInteger nextViewTag );
NSInteger ViewNextValidKeyView( NSInteger tag );
NSInteger ViewPreviousKeyView( NSInteger tag );
NSInteger ViewPreviousValidKeyView( NSInteger tag );

// Scrolling
void ViewPrepareContentInRect( NSInteger tag, CGRect r );
CGRect ViewPreparedContentRect( NSInteger tag );
void ViewScrollPoint( NSInteger tag, CGPoint pt );
BOOL ViewScrollRectToVisible( NSInteger tag, CGRect r );
BOOL ViewAutoscroll( NSInteger tag, NSEvent *evnt );
CGRect ViewAdjustScroll( NSInteger tag, CGRect newVisible );
void ViewScrollRect( NSInteger tag, CGRect r, CGSize size );
NSInteger ViewEnclosingScrollView( NSInteger tag );

// Dragging
void ViewRegisterForDraggedTypes( NSInteger tag, CFArrayRef types );
void ViewUnregisterDraggedTypes( NSInteger tag );
CFArrayRef ViewRegisteredDraggedTypes( NSInteger tag );
NSDraggingSession *ViewBeginDraggingSession( NSInteger tag, CFArrayRef items, NSEvent *evnt, id<NSDraggingSource> source );

// First responder
void ViewSetAcceptsFirstResponder( NSInteger tag, BOOL flag );

// Notifications
BOOL ViewPostsFrameChangedNotifications( NSInteger tag );
void ViewSetPostsFrameChangedNotifications( NSInteger tag, BOOL flag );
BOOL ViewPostsBoundsChangedNotifications( NSInteger tag );
void ViewSetPostsBoundsChangedNotifications( NSInteger tag, BOOL flag );

// Tooltips
NSToolTipTag ViewAddToolTipRect( NSInteger tag, CGRect r, CUI_ViewStringForToolTipCallbackType callback, void *userData );
void ViewRemoveAllToolTips( NSInteger tag );
void ViewRemoveToolTip( NSInteger tag, NSToolTipTag tooltipTag );
CFStringRef ViewToolTip( NSInteger tag );
void ViewSetToolTip( NSInteger tag, CFStringRef string );

// custom
void ViewRegisterForDraggedFileTypes( NSInteger tag, CFTypeRef inFileTypes );
void ViewRegisterForDraggedFileExtensions( NSInteger tag, CFTypeRef inFileExtensions );
BOOL ViewDragInside( NSInteger tag );
void ViewSetDragInside( NSInteger tag, BOOL flag );

// generic functions
//CFStringRef ViewText( NSInteger tag );

// animator
void *ViewAnimator( NSInteger tag );
void ViewAnimatorSetFrame( NSInteger tag, CGRect r );
void ViewAnimatorSetFrameOrigin( NSInteger tag, CGPoint origin );
void ViewAnimatorSetFrameSize( NSInteger tag, CGSize size );
void ViewAnimatorSetFrameRotation( NSInteger tag, CGFloat rot );
void ViewAnimatorSetBounds( NSInteger tag, CGRect r );
void ViewAnimatorSetBoundsOrigin( NSInteger tag, CGPoint origin );
void ViewAnimatorSetBoundsSize( NSInteger tag, CGSize size );
void ViewAnimatorSetBoundsRotation( NSInteger tag, CGFloat rot );
void ViewAnimatorSetFrameCenterRotation( NSInteger tag, CGFloat rot );
void ViewAnimatorSetAlphaValue( NSInteger tag, CGFloat value );

//void ViewSetTrackingArea( NSInteger tag, CGRect r, NSTrackingAreaOptions options );

// custom
id ViewWithTag( NSInteger tag );

void ViewsEmbedInView( int tag, ... );

// gesture recognizer

// - user dialog -
void ViewSetClickGestureRecognizer( NSInteger tag );
void ViewSetMagnificationGestureRecognizer( NSInteger tag );
void ViewSetPanGestureRecognizer( NSInteger tag );
void ViewSetPressGestureRecognizer( NSInteger tag );
void ViewSetRotationGestureRecognizer( NSInteger tag );

// - callback function -
//typedef void (*CUI_GestureRecognizerCallbackType)(id,NSInteger,void *);

void ViewSetClickGestureRecognizerCallback( NSInteger tag, CUI_GestureRecognizerCallbackType callback, void *userData );
void ViewSetMagnificationGestureRecognizerCallback( NSInteger tag, CUI_GestureRecognizerCallbackType callback, void *userData );
void ViewSetPanGestureRecognizerCallback( NSInteger tag, CUI_GestureRecognizerCallbackType callback, void *userData );
void ViewSetPressGestureRecognizerCallback( NSInteger tag, CUI_GestureRecognizerCallbackType callback, void *userData );
void ViewSetRotationGestureRecognizerCallback( NSInteger tag, CUI_GestureRecognizerCallbackType callback, void *userData );

// Identifier (same as UserInterfaceItemIdentificationIdentifier)
CFStringRef ViewIdentifier( NSInteger tag );
void ViewSetIdentifier( NSInteger tag, CFStringRef identifier );

// Appearance
void ViewSetAppearance( NSInteger tag, NSAppearance *appearance );
void ViewSetAppearanceNamed( NSInteger tag, CFStringRef name );

// DisplayLink
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
CADisplayLink *ViewDisplayLinkWithTarget( NSInteger tag, id target, CFStringRef selector );
#endif// 140000

/*
 NSAppearanceCustomization
 */
NSAppearance *ViewAppearance( NSInteger tag );
NSAppearance *ViewEffectiveAppearance( NSInteger tag );

// - custom -
BOOL ViewExists( NSInteger tag );

CFTypeRef ViewProperty( NSInteger tag, CFStringRef key );
void ViewSetProperty( NSInteger tag, CFStringRef key, CFTypeRef value );
void ViewPropertySet( NSInteger tag, CFStringRef key, CFTypeRef value );

BOOL ViewPropertyBool( NSInteger tag, CFStringRef key );
void ViewPropertySetBool( NSInteger tag, CFStringRef key, BOOL value );
long ViewPropertyLong( NSInteger tag, CFStringRef key );
void ViewPropertySetLong( NSInteger tag, CFStringRef key, long value );
double ViewPropertyDouble( NSInteger tag, CFStringRef key );
void ViewPropertySetDouble( NSInteger tag, CFStringRef key, double value );
CGRect ViewPropertyRect( NSInteger tag, CFStringRef key );
void ViewPropertySetRect( NSInteger tag, CFStringRef key, CGRect r );
CGPoint ViewPropertyPoint( NSInteger tag, CFStringRef key );
void ViewPropertySetPoint( NSInteger tag, CFStringRef key, CGPoint pt );
CGSize ViewPropertySize( NSInteger tag, CFStringRef key );
void ViewPropertySetSize( NSInteger tag, CFStringRef key, CGSize sz );
CFRange ViewPropertyRange( NSInteger tag, CFStringRef key );
void ViewPropertySetRange( NSInteger tag, CFStringRef key, CFRange range );
CFURLRef ViewPropertyBookmarkURL( NSInteger tag, CFStringRef key );
void ViewPropertySetBookmarkURL( NSInteger tag, CFStringRef key, CFURLRef url );
BOOL ViewPropertyGetBytes( NSInteger tag, CFStringRef key, void *bytes );
void ViewPropertySetBytes( NSInteger tag, CFStringRef key, void *bytes, long length );

void ViewRemoveProperty( NSInteger tag, CFStringRef key );
void ViewPropertyRemove( NSInteger tag, CFStringRef key );
void ViewRemoveAllProperties( NSInteger tag );
void ViewPropertyRemoveAll( NSInteger tag );

// Suspend drawRect: method
void ViewSuspendDrawRect( NSInteger tag, BOOL flag );
BOOL ViewDrawRectIsSuspended( NSInteger tag );

/*
  ViewInitTrackingArea

  Initialises the view's tracking area so that it will respond to tracking events (mouseEntered, mouseExited, etc.)
*/
void ViewInitTrackingArea( NSInteger tag );

void ViewAddSubviews( NSInteger vwTag, ... );
void ViewAddSubviewsInRange( NSInteger tag, CFRange range );
void ViewAddSubviewsWithIndexes( NSInteger tag, NSIndexSet *set );

void ViewClose( NSInteger tag );

/*
  ViewSelectedButton

  Returns the button ref of the selected subview (usually radio button)
*/
NSButton *ViewSelectedButton( NSInteger tag );

/*
  ViewSelectedButtonTag

  Returns the tag of the selected subview (usually radio button)
*/
NSInteger ViewSelectedButtonTag( NSInteger tag );

/*
  ViewSelectedButtonTitle

  Returns the title of the selected subview (usually radio button)
*/
CFStringRef ViewSelectedButtonTitle( NSInteger tag );

/*
  ViewColorAtPoint

  Returns the color of the pixel at the specified point in the view
*/
NSColor *ViewColorAtPoint( NSInteger tag, CGPoint pt );

/*
  ViewColorAtXY

  Returns the color of the pixel at the specified coordinates
*/
NSColor *ViewColorAtXY( NSInteger tag, CGFloat x, CGFloat y );

// Hide/show tooltips
void ViewSetToolTipsHidden( NSInteger tag, BOOL flag );// 20240622

// menu
NSInteger ViewMenuID( NSInteger tag );
NSMenu *ViewMenuRef( NSInteger tag );
void ViewSetMenu( NSInteger tag, NSInteger menuID );
void ViewSetMenuRef( NSInteger tag, NSMenu *m );

// Create
NSView *ViewInit( NSInteger inTag, CGRect inRect );

// FB Statement
void CUI_View( NSInteger inTag, CGRect inRect, NSInteger inWndTag );

