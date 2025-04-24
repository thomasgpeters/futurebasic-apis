/*
 PredicateEditor.h

 Bernie Wylde
 */

#import "CocoaUI.h"

@interface PredicateEditorSC : NSPredicateEditor
@end

// Class
Class PredicateEditorClass( void );

NSPredicateEditor *PredicateEditorWithTag( NSInteger tag );
BOOL PredicateEditorExists( NSInteger tag );

// Row templates
CFArrayRef PredicateEditorRowTemplates( NSInteger tag );
void PredicateEditorSetRowTemplates( NSInteger tag, CFArrayRef templates );

// Init
NSPredicateEditor *PredicateEditorInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_PredicateEditor( NSInteger inTag, CGRect inRect, NSInteger inWndTag );

