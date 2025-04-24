/*
 LayoutGuide.m

 Bernie Wylde
 */

#import "LayoutGuide.h"


// Class
Class LayoutGuideClass( void )
{ return [NSLayoutGuide class]; }

// Guides
CFStringRef LayoutGuideIdentifier( NSLayoutGuide *ref )
{ return (__bridge CFStringRef)[ref identifier]; }

void LayoutGuideSetIdentifier( NSLayoutGuide *ref, CFStringRef identifier )
{ [ref setIdentifier:(__bridge NSString *)identifier]; }

CGRect LayoutGuideFrame( NSLayoutGuide *ref )
{ return NSRectToCGRect([ref frame]); }

NSView *LayoutGuideOwningView( NSLayoutGuide *ref )
{ return [ref owningView]; }

void LayoutGuideSetOwningView( NSLayoutGuide *ref, NSView *owningView )
{ [ref setOwningView:owningView]; }

// Create constraints
NSLayoutYAxisAnchor *LayoutGuideBottomAnchor( NSLayoutGuide *ref )
{ return [ref bottomAnchor]; }

NSLayoutXAxisAnchor *LayoutGuideCenterXAnchor( NSLayoutGuide *ref )
{ return [ref centerXAnchor]; }

NSLayoutYAxisAnchor *LayoutGuideCenterYAnchor( NSLayoutGuide *ref )
{ return [ref centerYAnchor]; }

NSLayoutDimension *LayoutGuideHeightAnchor( NSLayoutGuide *ref )
{ return [ref heightAnchor]; }

NSLayoutXAxisAnchor *LayoutGuideLeadingAnchor( NSLayoutGuide *ref )
{ return [ref leadingAnchor]; }

NSLayoutXAxisAnchor *LayoutGuideLeftAnchor( NSLayoutGuide *ref )
{ return [ref leftAnchor]; }

NSLayoutXAxisAnchor *LayoutGuideRightAnchor( NSLayoutGuide *ref )
{ return [ref rightAnchor]; }

NSLayoutYAxisAnchor *LayoutGuideTopAnchor( NSLayoutGuide *ref )
{ return [ref topAnchor]; }

NSLayoutXAxisAnchor *LayoutGuideTrailingAnchor( NSLayoutGuide *ref )
{ return [ref trailingAnchor]; }

NSLayoutDimension *LayoutGuideWidthAnchor( NSLayoutGuide *ref )
{ return [ref widthAnchor]; }

// Instance properties
BOOL LayoutGuideHasAmbiguousLayout( NSLayoutGuide *ref )
{ return [ref hasAmbiguousLayout]; }

// Instance methods
CFArrayRef LayoutGuideConstraintsAffectingLayoutForOrientation( NSLayoutGuide *ref, NSLayoutConstraintOrientation orientation )
{ return (__bridge CFArrayRef)[ref constraintsAffectingLayoutForOrientation:orientation]; }


