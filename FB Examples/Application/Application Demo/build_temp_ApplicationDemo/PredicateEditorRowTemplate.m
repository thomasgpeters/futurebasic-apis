/*
 PredicateEditorRowTemplate.m

 Bernie Wylde
 */

#import "PredicateEditorRowTemplate.h"

// Class
Class PredicateEditorRowTemplateClass( void )
{ return [NSPredicateEditorRowTemplate class]; }

// Init
NSPredicateEditorRowTemplate *PredicteEditorRowTemplateWithExpressions( CFArrayRef leftExpressions, CFArrayRef rightExpressions, NSComparisonPredicateModifier modifier, CFArrayRef operators, NSUInteger options )
{
#if __has_feature(objc_arc)
    return [[NSPredicateEditorRowTemplate alloc] initWithLeftExpressions:(__bridge NSArray *)leftExpressions rightExpressions:(__bridge NSArray *)rightExpressions modifier:modifier operators:(__bridge NSArray *)operators options:options];
#else
    return [[[NSPredicateEditorRowTemplate alloc] initWithLeftExpressions:(__bridge NSArray *)leftExpressions rightExpressions:(__bridge NSArray *)rightExpressions modifier:modifier operators:(__bridge NSArray *)operators options:options] autorelease];
#endif
}

NSPredicateEditorRowTemplate *PredicteEditorRowTemplateWithCompoundTypes( CFArrayRef compoundTypes )
{
#if __has_feature(objc_arc)
    return [[NSPredicateEditorRowTemplate alloc] initWithCompoundTypes:(__bridge NSArray *)compoundTypes];
#else
    return [[[NSPredicateEditorRowTemplate alloc] initWithCompoundTypes:(__bridge NSArray *)compoundTypes] autorelease];
#endif
}

// Primitive methods
double PredicteEditorRowTemplateMatchForPredicate( NSPredicateEditorRowTemplate *ref, NSPredicate *predicate )
{ return [ref matchForPredicate:predicate]; }

CFArrayRef PredicteEditorRowTemplateViews( NSPredicateEditorRowTemplate *ref )
{ return (__bridge CFArrayRef)[ref templateViews]; }

void PredicteEditorRowTemplateSetPredicate( NSPredicateEditorRowTemplate *ref, NSPredicate *predicate )
{ [ref setPredicate:predicate]; }

CFArrayRef PredicteEditorRowTemplateDisplayableSubpredicatesOfPredicate( NSPredicateEditorRowTemplate *ref, NSPredicate *predicate )
{ return (__bridge CFArrayRef)[ref displayableSubpredicatesOfPredicate:predicate]; }

NSPredicate *PredicteEditorRowTemplatePredicateWithSubpredicates( NSPredicateEditorRowTemplate *ref, CFArrayRef subpredicates )
{ return [ref predicateWithSubpredicates:(__bridge NSArray *)subpredicates]; }

// Info
CFArrayRef PredicteEditorRowTemplateLeftExpressions( NSPredicateEditorRowTemplate *ref )
{ return (__bridge CFArrayRef)[ref leftExpressions]; }

CFArrayRef PredicteEditorRowTemplateRightExpressions( NSPredicateEditorRowTemplate *ref )
{ return (__bridge CFArrayRef)[ref rightExpressions]; }

CFArrayRef PredicteEditorRowTemplateCompoundTypes( NSPredicateEditorRowTemplate *ref )
{ return (__bridge CFArrayRef)[ref compoundTypes]; }

NSComparisonPredicateModifier PredicteEditorRowTemplateModifier( NSPredicateEditorRowTemplate *ref )
{ return [ref modifier]; }

CFArrayRef PredicteEditorRowTemplateOperators( NSPredicateEditorRowTemplate *ref )
{ return (__bridge CFArrayRef)[ref operators]; }

NSUInteger PredicteEditorRowTemplateOptions( NSPredicateEditorRowTemplate *ref )
{ return [ref options]; }


#pragma mark - Functions requiring CoreData
NSPredicateEditorRowTemplate *PredicteEditorRowTemplateWithRightExpressionAttributeType( CFArrayRef leftExpressions, NSAttributeType type, NSComparisonPredicateModifier modifier, CFArrayRef operators, NSUInteger options )
{
#if __has_feature(objc_arc)
    return [[NSPredicateEditorRowTemplate alloc] initWithLeftExpressions:(__bridge NSArray *)leftExpressions rightExpressionAttributeType:type modifier:modifier operators:(__bridge NSArray *)operators options:options];
#else
    return [[[NSPredicateEditorRowTemplate alloc] initWithLeftExpressions:(__bridge NSArray *)leftExpressions rightExpressionAttributeType:type modifier:modifier operators:(__bridge NSArray *)operators options:options] autorelease];
#endif
}

CFArrayRef PredicteEditorRowTemplateTemplatesWithAttributeKeyPaths( CFArrayRef keyPaths, NSEntityDescription *entityDescription )
{ return (__bridge CFArrayRef)[NSPredicateEditorRowTemplate templatesWithAttributeKeyPaths:(__bridge NSArray *)keyPaths inEntityDescription:entityDescription]; }

NSAttributeType PredicteEditorRowTemplateRightExpressionAttributeType( NSPredicateEditorRowTemplate *ref )
{ return [ref rightExpressionAttributeType]; }
