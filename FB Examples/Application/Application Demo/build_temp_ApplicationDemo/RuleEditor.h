/*
 RuleEditor.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class RuleEditorClass( void );

NSRuleEditor *RuleEditorWithTag( NSInteger tag );
BOOL RuleEditorExists( NSInteger tag );

// Configure
BOOL RuleEditorIsEditable( NSInteger tag );
void RuleEditorSetEditable( NSInteger tag, BOOL flag );
NSRuleEditorNestingMode RuleEditorNestingMode( NSInteger tag );
void RuleEditorSetNestingMode( NSInteger tag, NSRuleEditorNestingMode nestingMode );
BOOL RuleEditorCanRemoveAllRows( NSInteger tag );
void RuleEditorSetCanRemoveAllRows( NSInteger tag, BOOL flag );
CGFloat RuleEditorRowHeight( NSInteger tag );
void RuleEditorSetRowHeight( NSInteger tag, CGFloat height );

// Formatting
CFDictionaryRef RuleEditorFormattingDictionary( NSInteger tag );
void RuleEditorSetFormattingDictionary( NSInteger tag, CFDictionaryRef formatting );
CFStringRef RuleEditorFormattingStringsFilename( NSInteger tag );
void RuleEditorSetFormattingStringsFilename( NSInteger tag, CFStringRef filename );

// Data
void RuleEditorReloadCriteria( NSInteger tag );
void RuleEditorSetCriteriaAndDisplayValuesForRow( NSInteger tag, CFArrayRef criteria, CFArrayRef displayValues, NSInteger row );
CFArrayRef RuleEditorCriteriaForRow( NSInteger tag, NSInteger row );
CFArrayRef RuleEditorDisplayValuesForRow( NSInteger tag, NSInteger row );

// Row info
NSInteger RuleEditorNumberOfRows( NSInteger tag );
NSInteger RuleEditorParentRowForRow( NSInteger tag, NSInteger row );
NSInteger RuleEditorRowForDisplayValue( NSInteger tag, CFTypeRef value );
NSRuleEditorRowType RuleEditorRowTypeForRow( NSInteger tag, NSInteger row );
NSIndexSet *RuleEditorSubrowIndexesForRow( NSInteger tag, NSInteger row );

// Selection
NSIndexSet *RuleEditorSelectedRowIndexes( NSInteger tag );
void RuleEditorSelectRowIndexes( NSInteger tag, NSIndexSet *indexes, BOOL byExtendingSelection );

// Manipulate rows
void RuleEditorAddRow( NSInteger tag );
void RuleEditorInsertRow( NSInteger tag, NSInteger rowIndex, NSRuleEditorRowType rowType, NSInteger parentRow, BOOL animate );
void RuleEditorRemoveRow( NSInteger tag, NSInteger rowIndex );
void RuleEditorRemoveRows( NSInteger tag, NSIndexSet *rowIndexes, BOOL includeSubrows );

// Predicates
NSPredicate *RuleEditorPredicate( NSInteger tag );
void RuleEditorReloadPredicate( NSInteger tag );
NSPredicate *RuleEditorPredicateForRow( NSInteger tag, NSInteger rowIndex );

// Bindings
Class RuleEditorRowClass( NSInteger tag );
void RuleEditorSetRowClass( NSInteger tag, Class cls );
CFStringRef RuleEditorRowTypeKeyPath( NSInteger tag );
void RuleEditorSetRowTypeKeyPath( NSInteger tag, CFStringRef path );
CFStringRef RuleEditorSubrowsKeyPath( NSInteger tag );
void RuleEditorSetSubrowsKeyPath( NSInteger tag, CFStringRef path );
CFStringRef RuleEditorCriteriaKeyPath( NSInteger tag );
void RuleEditorSetCriteriaKeyPath( NSInteger tag, CFStringRef path );
CFStringRef RuleEditorDisplayValuesKeyPath( NSInteger tag );
void RuleEditorSetDisplayValuesKeyPath( NSInteger tag, CFStringRef path );
