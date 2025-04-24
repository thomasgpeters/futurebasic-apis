/*
 SplitView.h

 Bernie Wylde
 */

@interface SplitViewSC : NSSplitView
@end

// dialog events
enum {
    splitViewResizeSubviewsWithOldSize = 1500,
    splitViewWillResizeSubviews,
    splitViewDidResizeSubviews,
    splitViewCanCollapseSubview,
    splitViewShouldAdjustSizeOfSubview,
    splitViewEffectiveRect,
    splitViewShouldHideDividerAtIndex,
    splitViewAdditionalEffectiveRectOfDividerAtIndex,
    splitViewConstrainMaxCoordinate,
    splitViewConstrainMinCoordinate,
    splitViewConstrainSplitPosition,
    
    // subclass events
    splitViewDividerColor,
    splitViewDividerThickness,
    splitViewDrawDividerInRect
};

@interface NSSplitView (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;

- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
@end

@interface CUI_SplitViewDelegate : NSObject <NSSplitViewDelegate>
@end

CUI_SplitViewDelegate *CUI_SplitViewDelegateObj( void );

// Class
Class SplitViewClass( void );

NSSplitView *SplitViewWithTag( NSInteger tag );
BOOL SplitViewExists( NSInteger tag );


// Arranging subviews
CFArrayRef SplitViewArrangedSubviews( NSInteger tag );
BOOL SplitViewArrangesAllSubviews( NSInteger tag );
void SplitViewAddArrangedSubview( NSInteger tag, NSInteger vwTag );
void SplitViewInsertArrangedSubview( NSInteger tag, NSInteger vwTag, NSInteger index );
void SplitViewRemoveArrangedSubview( NSInteger tag, NSInteger vwTag );

// Managing subviews
void SplitViewAdjustSubviews( NSInteger tag );
BOOL SplitViewIsPaneCollapsed( NSInteger tag, NSInteger index );
float SplitViewHoldingPriority( NSInteger tag, NSInteger paneIndex );
void SplitViewSetHoldingPriority( NSInteger tag, NSInteger index, float priority );

// Divider orientation
BOOL SplitViewIsVertical( NSInteger tag );
void SplitViewSetVertical( NSInteger tag, BOOL flag );

// Configure and draw dividers
NSSplitViewDividerStyle SplitViewDividerStyle( NSInteger tag );
void SplitViewSetDividerStyle( NSInteger tag, NSSplitViewDividerStyle style );
CGFloat SplitViewDividerThickness( NSInteger tag );

// Saving subview positions
CFStringRef SplitViewAutosaveName( NSInteger tag );
void SplitViewSetAutosaveName( NSInteger tag, CFStringRef name );

// Constraining split position
CGFloat SplitViewMinPossiblePositionOfDivider( NSInteger tag, NSInteger index );
CGFloat SplitViewMaxPossiblePositionOfDivider( NSInteger tag, NSInteger index );
void SplitViewSetPositionOfDivider( NSInteger tag, NSInteger index, CGFloat position );

// Convenience
void SplitViewAddSubview( NSInteger splitViewTag, NSInteger index, NSInteger subviewTag );
void SplitViewAddSubviewSizeToFit( NSInteger splitViewTag, NSInteger index, NSInteger subviewTag );

NSView *SplitViewPaneView( NSInteger tag, NSInteger paneIndex );
CGSize SplitViewPaneSize( NSInteger tag, NSInteger paneIndex );

void SplitViewMakeSidebar( NSInteger tag );


// Init
NSSplitView *SplitViewInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_SplitView( NSInteger inTag, CGRect inRect, NSInteger inVertical, NSInteger inDividerStyle, NSInteger inWndTag );
