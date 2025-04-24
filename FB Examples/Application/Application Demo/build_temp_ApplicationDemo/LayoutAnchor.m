/*
 LayoutAnchor.m

 Bernie Wylde
 */

#import "LayoutAnchor.h"


// Class
Class LayoutAnchorClass( void )
{ return [NSLayoutAnchor class]; }

// Build constraints
NSLayoutConstraint *LayoutAnchorConstraintEqualToAnchor( NSLayoutAnchor *ref, NSLayoutAnchor *anchor )
{ return [ref constraintEqualToAnchor:anchor]; }

NSLayoutConstraint *LayoutAnchorConstraintEqualToAnchorConstant( NSLayoutAnchor *ref, NSLayoutAnchor *anchor, CGFloat constant )
{ return [ref constraintEqualToAnchor:anchor constant:constant]; }

NSLayoutConstraint *LayoutAnchorConstraintGreaterThanOrEqualToAnchor( NSLayoutAnchor *ref, NSLayoutAnchor *anchor )
{ return [ref constraintGreaterThanOrEqualToAnchor:anchor]; }

NSLayoutConstraint *LayoutAnchorConstraintGreaterThanOrEqualToAnchorConstant( NSLayoutAnchor *ref, NSLayoutAnchor *anchor, CGFloat constant )
{ return [ref constraintGreaterThanOrEqualToAnchor:anchor constant:constant]; }

NSLayoutConstraint *LayoutAnchorConstraintLessThanOrEqualToAnchor( NSLayoutAnchor *ref, NSLayoutAnchor *anchor )
{ return [ref constraintLessThanOrEqualToAnchor:anchor]; }

NSLayoutConstraint *LayoutAnchorConstraintLessThanOrEqualToAnchorConstant( NSLayoutAnchor *ref, NSLayoutAnchor *anchor, CGFloat constant )
{ return [ref constraintLessThanOrEqualToAnchor:anchor constant:constant]; }

// Debugging
CFArrayRef LayoutAnchorConstraintsAffectingLayout( NSLayoutAnchor *ref )
{ return (__bridge CFArrayRef)[ref constraintsAffectingLayout]; }

BOOL LayoutAnchorHasAmbiguousLayout( NSLayoutAnchor *ref )
{ return [ref hasAmbiguousLayout]; }

CFStringRef LayoutAnchorName( NSLayoutAnchor *ref )
{ return (__bridge CFStringRef)[ref name]; }

CFTypeRef LayoutAnchorItem( NSLayoutAnchor *ref )
{ return (__bridge CFTypeRef)[ref item]; }


/*
 LayoutYAxisAnchor
 */
// Class
Class LayoutYAxisAnchorClass( void )
{ return [NSLayoutYAxisAnchor class]; }

// Create layout dimension
NSLayoutDimension *LayoutYAxisAnchorWithOffsetToAnchor( NSLayoutYAxisAnchor *ref, NSLayoutYAxisAnchor *otherAnchor )
{ return [ref anchorWithOffsetToAnchor:otherAnchor]; }


/*
 LayoutXAxisAnchor
 */
// Class
Class LayoutXAxisAnchorClass( void )
{ return [NSLayoutXAxisAnchor class]; }

// Create layout dimension
NSLayoutDimension *LayoutXAxisAnchorWithOffsetToAnchor( NSLayoutXAxisAnchor *ref, NSLayoutXAxisAnchor *otherAnchor )
{ return [ref anchorWithOffsetToAnchor:otherAnchor]; }


/*
 LayoutDimension
 */
// Class
Class LayoutDimensionClass( void )
{ return [NSLayoutDimension class]; }

// Build constraints
NSLayoutConstraint *LayoutDimensionConstraintEqualToAnchor( NSLayoutDimension *ref, NSLayoutDimension *anchor, CGFloat multiplier )
{ return [ref constraintEqualToAnchor:anchor multiplier:multiplier]; }

NSLayoutConstraint *LayoutDimensionConstraintEqualToAnchorConstant( NSLayoutDimension *ref, NSLayoutDimension *anchor, CGFloat multiplier, CGFloat constant )
{ return [ref constraintEqualToAnchor:anchor multiplier:multiplier constant:constant]; }

NSLayoutConstraint *LayoutDimensionConstraintEqualToConstant( NSLayoutDimension *ref, CGFloat constant )
{ return [ref constraintEqualToConstant:constant]; }

NSLayoutConstraint *LayoutDimensionConstraintGreaterThanOrEqualToAnchor( NSLayoutDimension *ref, NSLayoutDimension *anchor, CGFloat multiplier )
{ return [ref constraintGreaterThanOrEqualToAnchor:anchor multiplier:multiplier]; }

NSLayoutConstraint *LayoutDimensionConstraintGreaterThanOrEqualToAnchorConstant( NSLayoutDimension *ref, NSLayoutDimension *anchor, CGFloat multiplier, CGFloat constant )
{ return [ref constraintGreaterThanOrEqualToAnchor:anchor multiplier:multiplier constant:constant]; }

NSLayoutConstraint *LayoutDimensionConstraintGreaterThanOrEqualToConstant( NSLayoutDimension *ref, CGFloat constant )
{ return [ref constraintGreaterThanOrEqualToConstant:constant]; }

NSLayoutConstraint *LayoutDimensionConstraintLessThanOrEqualToAnchor( NSLayoutDimension *ref, NSLayoutDimension *anchor, CGFloat multiplier )
{ return [ref constraintLessThanOrEqualToAnchor:anchor multiplier:multiplier]; }

NSLayoutConstraint *LayoutDimensionConstraintLessThanOrEqualToAnchorConstant( NSLayoutDimension *ref, NSLayoutDimension *anchor, CGFloat multiplier, CGFloat constant )
{ return [ref constraintLessThanOrEqualToAnchor:anchor multiplier:multiplier constant:constant]; }

NSLayoutConstraint *LayoutDimensionConstraintLessThanOrEqualToConstant( NSLayoutDimension *ref, CGFloat constant )
{ return [ref constraintLessThanOrEqualToConstant:constant]; }



