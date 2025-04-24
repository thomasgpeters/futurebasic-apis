/*
 PredicateEditorRowTemplate.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// Class
Class PredicateEditorRowTemplateClass( void );

// Init
NSPredicateEditorRowTemplate *PredicteEditorRowTemplateWithExpressions( CFArrayRef leftExpressions, CFArrayRef rightExpressions, NSComparisonPredicateModifier modifier, CFArrayRef operators, NSUInteger options );
NSPredicateEditorRowTemplate *PredicteEditorRowTemplateWithCompoundTypes( CFArrayRef compoundTypes );

// Primitive methods
double PredicteEditorRowTemplateMatchForPredicate( NSPredicateEditorRowTemplate *ref, NSPredicate *predicate );
CFArrayRef PredicteEditorRowTemplateViews( NSPredicateEditorRowTemplate *ref );
void PredicteEditorRowTemplateSetPredicate( NSPredicateEditorRowTemplate *ref, NSPredicate *predicate );
CFArrayRef PredicteEditorRowTemplateDisplayableSubpredicatesOfPredicate( NSPredicateEditorRowTemplate *ref, NSPredicate *predicate );
NSPredicate *PredicteEditorRowTemplatePredicateWithSubpredicates( NSPredicateEditorRowTemplate *ref, CFArrayRef subpredicates );

// Info
CFArrayRef PredicteEditorRowTemplateLeftExpressions( NSPredicateEditorRowTemplate *ref );
CFArrayRef PredicteEditorRowTemplateRightExpressions( NSPredicateEditorRowTemplate *ref );
CFArrayRef PredicteEditorRowTemplateCompoundTypes( NSPredicateEditorRowTemplate *ref );
NSComparisonPredicateModifier PredicteEditorRowTemplateModifier( NSPredicateEditorRowTemplate *ref );
CFArrayRef PredicteEditorRowTemplateOperators( NSPredicateEditorRowTemplate *ref );
NSUInteger PredicteEditorRowTemplateOptions( NSPredicateEditorRowTemplate *ref );

#pragma mark - Functions requiring CoreData
NSPredicateEditorRowTemplate *PredicteEditorRowTemplateWithRightExpressionAttributeType( CFArrayRef leftExpressions, NSAttributeType type, NSComparisonPredicateModifier modifier, CFArrayRef operators, NSUInteger options );
CFArrayRef PredicteEditorRowTemplateTemplatesWithAttributeKeyPaths( CFArrayRef keyPaths, NSEntityDescription *entityDescription );
NSAttributeType PredicteEditorRowTemplateRightExpressionAttributeType( NSPredicateEditorRowTemplate *ref );

