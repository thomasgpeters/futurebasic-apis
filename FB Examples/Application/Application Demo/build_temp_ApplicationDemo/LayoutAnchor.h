/*
 LayoutAnchor.h

 Bernie Wylde
 */


#import "CocoaUI.h"


// Class
Class LayoutAnchorClass( void );

// Build constraints
NSLayoutConstraint *LayoutAnchorConstraintEqualToAnchor( NSLayoutAnchor *ref, NSLayoutAnchor *anchor );
NSLayoutConstraint *LayoutAnchorConstraintEqualToAnchorConstant( NSLayoutAnchor *ref, NSLayoutAnchor *anchor, CGFloat constant );
NSLayoutConstraint *LayoutAnchorConstraintGreaterThanOrEqualToAnchor( NSLayoutAnchor *ref, NSLayoutAnchor *anchor );
NSLayoutConstraint *LayoutAnchorConstraintGreaterThanOrEqualToAnchorConstant( NSLayoutAnchor *ref, NSLayoutAnchor *anchor, CGFloat constant );
NSLayoutConstraint *LayoutAnchorConstraintLessThanOrEqualToAnchor( NSLayoutAnchor *ref, NSLayoutAnchor *anchor );
NSLayoutConstraint *LayoutAnchorConstraintLessThanOrEqualToAnchorConstant( NSLayoutAnchor *ref, NSLayoutAnchor *anchor, CGFloat constant );

// Debugging
CFArrayRef LayoutAnchorConstraintsAffectingLayout( NSLayoutAnchor *ref );
BOOL LayoutAnchorHasAmbiguousLayout( NSLayoutAnchor *ref );
CFStringRef LayoutAnchorName( NSLayoutAnchor *ref );
CFTypeRef LayoutAnchorItem( NSLayoutAnchor *ref );



/*
 LayoutYAxisAnchor
 */
// Class
Class LayoutYAxisAnchorClass( void );

// Create layout dimension
NSLayoutDimension *LayoutYAxisAnchorWithOffsetToAnchor( NSLayoutYAxisAnchor *ref, NSLayoutYAxisAnchor *otherAnchor );



/*
 LayoutXAxisAnchor
 */
// Class
Class LayoutXAxisAnchorClass( void );

// Create layout dimension
NSLayoutDimension *LayoutXAxisAnchorWithOffsetToAnchor( NSLayoutXAxisAnchor *ref, NSLayoutXAxisAnchor *otherAnchor );


/*
 LayoutDimension
 */
// Class
Class LayoutDimensionClass( void );

// Build constraints
NSLayoutConstraint *LayoutDimensionConstraintEqualToAnchor( NSLayoutDimension *ref, NSLayoutDimension *anchor, CGFloat multiplier );
NSLayoutConstraint *LayoutDimensionConstraintEqualToAnchorConstant( NSLayoutDimension *ref, NSLayoutDimension *anchor, CGFloat multiplier, CGFloat constant );
NSLayoutConstraint *LayoutDimensionConstraintEqualToConstant( NSLayoutDimension *ref, CGFloat constant );
NSLayoutConstraint *LayoutDimensionConstraintGreaterThanOrEqualToAnchor( NSLayoutDimension *ref, NSLayoutDimension *anchor, CGFloat multiplier );
NSLayoutConstraint *LayoutDimensionConstraintGreaterThanOrEqualToAnchorConstant( NSLayoutDimension *ref, NSLayoutDimension *anchor, CGFloat multiplier, CGFloat constant );
NSLayoutConstraint *LayoutDimensionConstraintGreaterThanOrEqualToConstant( NSLayoutDimension *ref, CGFloat constant );
NSLayoutConstraint *LayoutDimensionConstraintLessThanOrEqualToAnchor( NSLayoutDimension *ref, NSLayoutDimension *anchor, CGFloat multiplier );
NSLayoutConstraint *LayoutDimensionConstraintLessThanOrEqualToAnchorConstant( NSLayoutDimension *ref, NSLayoutDimension *anchor, CGFloat multiplier, CGFloat constant );
NSLayoutConstraint *LayoutDimensionConstraintLessThanOrEqualToConstant( NSLayoutDimension *ref, CGFloat constant );



