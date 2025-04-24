/*
 LayoutConstraint.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class LayoutConstraintClass( void );

// Create
CFArrayRef LayoutConstraintConstraintsWithVisualFormat( CFStringRef format, NSLayoutFormatOptions options, CFDictionaryRef metrics, CFDictionaryRef views );
NSLayoutConstraint *LayoutConstraintWithItem( CFTypeRef view1, NSLayoutAttribute attr1, NSLayoutRelation relation, CFTypeRef view2, NSLayoutAttribute attr2, CGFloat multiplier, CGFloat constant );

// Activate/deactivate
BOOL LayoutConstraintIsActive( NSLayoutConstraint *ref );
void LayoutConstraintSetActive( NSLayoutConstraint *ref, BOOL flag );
void LayoutConstraintActivateConstraints( CFArrayRef constraints );
void LayoutConstraintDeactivateConstraints( CFArrayRef constraints );

// Data
CFTypeRef LayoutConstraintFirstItem( NSLayoutConstraint *ref );
NSLayoutAttribute LayoutConstraintFirstAttribute( NSLayoutConstraint *ref );
NSLayoutRelation LayoutConstraintRelation( NSLayoutConstraint *ref );
CFTypeRef LayoutConstraintSecondItem( NSLayoutConstraint *ref );
NSLayoutAttribute LayoutConstraintSecondAttribute( NSLayoutConstraint *ref );
CGFloat LayoutConstraintMultiplier( NSLayoutConstraint *ref );
CGFloat LayoutConstraintConstant( NSLayoutConstraint *ref );
void LayoutConstraintSetConstant( NSLayoutConstraint *ref, CGFloat value );

NSLayoutAnchor *LayoutConstraintFirstAnchor( NSLayoutConstraint *ref );
NSLayoutAnchor *LayoutConstraintSecondAnchor( NSLayoutConstraint *ref );

// Priority
NSLayoutPriority LayoutConstraintPriority( NSLayoutConstraint *ref );
void LayoutConstraintSetPriority( NSLayoutConstraint *ref, NSLayoutPriority priority );

// Identify
CFStringRef LayoutConstraintIdentifier( NSLayoutConstraint *ref );
void LayoutConstraintSetIdentifier( NSLayoutConstraint *ref, CFStringRef identifier );

// Archiving
BOOL LayoutConstraintShouldBeArchived( NSLayoutConstraint *ref );
void LayoutConstraintSetShouldBeArchived( NSLayoutConstraint *ref, BOOL flag );

