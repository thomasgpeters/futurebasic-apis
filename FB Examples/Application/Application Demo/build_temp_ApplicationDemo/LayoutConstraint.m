/*
 LayoutConstraint.m

 Bernie Wylde
 */

#import "LayoutConstraint.h"

// Class
Class LayoutConstraintClass( void )
{ return [NSLayoutConstraint class]; }

// Create
CFArrayRef LayoutConstraintConstraintsWithVisualFormat( CFStringRef format, NSLayoutFormatOptions options, CFDictionaryRef metrics, CFDictionaryRef views )
{ return (__bridge CFArrayRef)[NSLayoutConstraint constraintsWithVisualFormat:(__bridge NSString *)format options:options metrics:(__bridge NSDictionary *)metrics views:(__bridge NSDictionary *)views]; }

NSLayoutConstraint *LayoutConstraintWithItem( CFTypeRef view1, NSLayoutAttribute attr1, NSLayoutRelation relation, CFTypeRef view2, NSLayoutAttribute attr2, CGFloat multiplier, CGFloat constant )
{ return [NSLayoutConstraint constraintWithItem:(__bridge id)view1 attribute:attr1 relatedBy:relation toItem:(__bridge id)view2 attribute:attr2 multiplier:multiplier constant:constant]; }

// Activate/deactivate
BOOL LayoutConstraintIsActive( NSLayoutConstraint *ref )
{ return [ref isActive]; }

void LayoutConstraintSetActive( NSLayoutConstraint *ref, BOOL flag )
{ [ref setActive:flag]; }

void LayoutConstraintActivateConstraints( CFArrayRef constraints )
{ [NSLayoutConstraint activateConstraints:(__bridge NSArray *)constraints]; }

void LayoutConstraintDeactivateConstraints( CFArrayRef constraints )
{ [NSLayoutConstraint deactivateConstraints:(__bridge NSArray *)constraints]; }

// Data
CFTypeRef LayoutConstraintFirstItem( NSLayoutConstraint *ref )
{ return (__bridge CFTypeRef)[ref firstItem]; }

NSLayoutAttribute LayoutConstraintFirstAttribute( NSLayoutConstraint *ref )
{ return [ref firstAttribute]; }

NSLayoutRelation LayoutConstraintRelation( NSLayoutConstraint *ref )
{ return [ref relation]; }

CFTypeRef LayoutConstraintSecondItem( NSLayoutConstraint *ref )
{ return (__bridge CFTypeRef)[ref secondItem]; }

NSLayoutAttribute LayoutConstraintSecondAttribute( NSLayoutConstraint *ref )
{ return [ref secondAttribute]; }

CGFloat LayoutConstraintMultiplier( NSLayoutConstraint *ref )
{ return [ref multiplier]; }

CGFloat LayoutConstraintConstant( NSLayoutConstraint *ref )
{ return [ref constant]; }

void LayoutConstraintSetConstant( NSLayoutConstraint *ref, CGFloat value )
{ [ref setConstant:value]; }

NSLayoutAnchor *LayoutConstraintFirstAnchor( NSLayoutConstraint *ref )
{ return [ref firstAnchor]; }

NSLayoutAnchor *LayoutConstraintSecondAnchor( NSLayoutConstraint *ref )
{ return [ref secondAnchor]; }

// Priority
NSLayoutPriority LayoutConstraintPriority( NSLayoutConstraint *ref )
{ return [ref priority]; }

void LayoutConstraintSetPriority( NSLayoutConstraint *ref, NSLayoutPriority priority )
{ [ref setPriority:priority]; }

// Identify
CFStringRef LayoutConstraintIdentifier( NSLayoutConstraint *ref )
{ return (__bridge CFStringRef)[ref identifier]; }

void LayoutConstraintSetIdentifier( NSLayoutConstraint *ref, CFStringRef identifier )
{ [ref setIdentifier:(__bridge NSString *)identifier]; }

// Archiving
BOOL LayoutConstraintShouldBeArchived( NSLayoutConstraint *ref )
{ return [ref shouldBeArchived]; }

void LayoutConstraintSetShouldBeArchived( NSLayoutConstraint *ref, BOOL flag )
{ [ref setShouldBeArchived:flag]; }

