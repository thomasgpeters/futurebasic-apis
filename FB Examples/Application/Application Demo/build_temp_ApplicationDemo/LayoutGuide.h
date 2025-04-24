/*
 LayoutGuide.h

 Bernie Wylde
 */

#import "CocoaUI.h"


// Class
Class LayoutGuideClass( void );

// Guides
CFStringRef LayoutGuideIdentifier( NSLayoutGuide *ref );
void LayoutGuideSetIdentifier( NSLayoutGuide *ref, CFStringRef identifier );
CGRect LayoutGuideFrame( NSLayoutGuide *ref );
NSView *LayoutGuideOwningView( NSLayoutGuide *ref );
void LayoutGuideSetOwningView( NSLayoutGuide *ref, NSView *owningView );

// Create constraints
NSLayoutYAxisAnchor *LayoutGuideBottomAnchor( NSLayoutGuide *ref );
NSLayoutXAxisAnchor *LayoutGuideCenterXAnchor( NSLayoutGuide *ref );
NSLayoutYAxisAnchor *LayoutGuideCenterYAnchor( NSLayoutGuide *ref );
NSLayoutDimension *LayoutGuideHeightAnchor( NSLayoutGuide *ref );
NSLayoutXAxisAnchor *LayoutGuideLeadingAnchor( NSLayoutGuide *ref );
NSLayoutXAxisAnchor *LayoutGuideLeftAnchor( NSLayoutGuide *ref );
NSLayoutXAxisAnchor *LayoutGuideRightAnchor( NSLayoutGuide *ref );
NSLayoutYAxisAnchor *LayoutGuideTopAnchor( NSLayoutGuide *ref );
NSLayoutXAxisAnchor *LayoutGuideTrailingAnchor( NSLayoutGuide *ref );
NSLayoutDimension *LayoutGuideWidthAnchor( NSLayoutGuide *ref );

// Instance properties
BOOL LayoutGuideHasAmbiguousLayout( NSLayoutGuide *ref );

// Instance methods
CFArrayRef LayoutGuideConstraintsAffectingLayoutForOrientation( NSLayoutGuide *ref, NSLayoutConstraintOrientation orientation );


