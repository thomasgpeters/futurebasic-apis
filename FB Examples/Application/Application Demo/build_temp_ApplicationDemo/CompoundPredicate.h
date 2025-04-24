/*
 CompoundPredicate.h
 
 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class CompoundPredicateClass( void );

// Constructors
NSCompoundPredicate *CompoundPredicateAndPredicateWithSubpredicates( CFArrayRef subpredicates );
NSCompoundPredicate *CompoundPredicateNotPredicateWithSubpredicate( NSPredicate *predicate );
NSCompoundPredicate *CompoundPredicateOrPredicateWithSubpredicates( CFArrayRef subpredicates );
NSCompoundPredicate *CompoundPredicateWithType( NSCompoundPredicateType type, CFArrayRef subpredicates );

// Info
NSCompoundPredicateType CompoundPredicateType( NSCompoundPredicate *ref );
CFArrayRef CompoundPredicateSubpredicates( NSCompoundPredicate *ref );
