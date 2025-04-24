/*
 StackView.h

 Bernie Wylde
 */



//#import "DialogEvent.h"
//#import "View.h"
//#import "Window.h"

@interface StackViewSC : NSStackView
@end

// dialog events
enum {
    stackViewDidReattachViews = 4500,
    stackViewWillDetachViews
};

@interface NSStackView (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;

- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
@end

@interface CUI_StackViewDelegate : NSObject <NSStackViewDelegate>
@end

CUI_StackViewDelegate *CUI_StackViewDelegateObj( void );

// Class
Class StackViewClass( void );

NSStackView *StackViewWithTag( NSInteger tag );
BOOL StackViewExists( NSInteger tag );

// Instance properties
BOOL StackViewDetachesHiddenViews( NSInteger tag );
void StackViewSetDetachesHiddenViews( NSInteger tag, BOOL flag );

// Adding and removing views
void StackViewAddView( NSInteger tag, NSInteger vwTag, NSStackViewGravity gravity );
void StackViewInsertView( NSInteger tag, NSInteger vwTag, NSUInteger index, NSStackViewGravity gravity );
void StackViewSetViewsInGravity( NSInteger tag, CFArrayRef views, NSStackViewGravity gravity );
void StackViewRemoveView( NSInteger tag, NSInteger vwTag );
void StackViewAddArrangedSubview( NSInteger tag, NSInteger vwTag );
void StackViewInsertArrangedSubview( NSInteger tag, NSInteger vwTag, NSUInteger index );
void StackViewRemoveArrangedSubview( NSInteger tag, NSInteger vwTag );
CFArrayRef StackViewArrangedSubviews( NSInteger tag );

// Inspecting
CFArrayRef StackViewViews( NSInteger tag );
CFArrayRef StackViewViewsInGravity( NSInteger tag, NSStackViewGravity gravity );
CFArrayRef StackViewDetachedViews( NSInteger tag );
NSLayoutPriority StackViewClippingResistancePriorityForOrientation( NSInteger tag, NSLayoutConstraintOrientation orientation );
void StackViewSetClippingResistancePriorityForOrientation( NSInteger tag, NSLayoutPriority priority, NSLayoutConstraintOrientation orientation );
NSLayoutPriority StackViewHuggingPriorityForOrientation( NSInteger tag, NSLayoutConstraintOrientation orientation );
void StackViewSetHuggingPriorityForOrientation( NSInteger tag, NSLayoutPriority priority, NSLayoutConstraintOrientation orientation );

// Configure layout
NSUserInterfaceLayoutOrientation StackViewOrientation( NSInteger tag );
void StackViewSetOrientation( NSInteger tag, NSUserInterfaceLayoutOrientation orientation );
NSLayoutAttribute StackViewAlignment( NSInteger tag );
void StackViewSetAlignment( NSInteger tag, NSLayoutAttribute alignment );
CGFloat StackViewSpacing( NSInteger tag );
void StackViewSetSpacing( NSInteger tag, CGFloat spacing );
NSEdgeInsets StackViewEdgeInsets( NSInteger tag );
void StackViewSetEdgeInsets( NSInteger tag, NSEdgeInsets insets );
NSStackViewDistribution StackViewDistribution( NSInteger tag );
void StackViewSetDistribution( NSInteger tag, NSStackViewDistribution distribution );

// Configure views
CGFloat StackViewCustomSpacingAfterView( NSInteger tag, NSInteger vwTag );
void StackViewSetCustomSpacingAfterView( NSInteger tag, CGFloat spacing, NSInteger vwTag );
NSStackViewVisibilityPriority StackViewVisibilityPriorityForView( NSInteger tag, NSInteger vwTag );
void StackViewSetVisibilityPriorityForView( NSInteger tag, NSStackViewVisibilityPriority priority, NSInteger vwTag );


// Init
NSStackView *StackViewInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_StackView( NSInteger inTag, CGRect inRect, NSInteger inHorizontal, NSInteger inWndTag );

