/*
 RuleEditor.m

 Bernie Wylde
 */

#import "RuleEditor.h"

// Class
Class RuleEditorClass( void )
{ return [NSRuleEditor class]; }

NSRuleEditor *RuleEditorWithTag( NSInteger tag )
{ return (NSRuleEditor *)CUI_ValidateViewKindOfClass( tag, [NSRuleEditor class] ); }

BOOL RuleEditorExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSRuleEditor class] ); }

// Configure
BOOL RuleEditorIsEditable( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c isEditable];
    return NO;
}

void RuleEditorSetEditable( NSInteger tag, BOOL flag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c setEditable:flag];
}

NSRuleEditorNestingMode RuleEditorNestingMode( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c nestingMode];
    return 0;
}

void RuleEditorSetNestingMode( NSInteger tag, NSRuleEditorNestingMode nestingMode )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c setNestingMode:nestingMode];
}

BOOL RuleEditorCanRemoveAllRows( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c canRemoveAllRows];
    return NO;
}

void RuleEditorSetCanRemoveAllRows( NSInteger tag, BOOL flag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c setCanRemoveAllRows:flag];
}

CGFloat RuleEditorRowHeight( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c rowHeight];
    return 0.0;
}

void RuleEditorSetRowHeight( NSInteger tag, CGFloat height )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c setRowHeight:height];
}

// Formatting
CFDictionaryRef RuleEditorFormattingDictionary( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return (__bridge CFDictionaryRef)[c formattingDictionary];
    return nil;
}

void RuleEditorSetFormattingDictionary( NSInteger tag, CFDictionaryRef formatting )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c setFormattingDictionary:(__bridge NSDictionary *)formatting];
}

CFStringRef RuleEditorFormattingStringsFilename( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return (__bridge CFStringRef)[c formattingStringsFilename];
    return nil;
}

void RuleEditorSetFormattingStringsFilename( NSInteger tag, CFStringRef filename )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c setFormattingStringsFilename:(__bridge NSString *)filename];
}

// Data
void RuleEditorReloadCriteria( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c reloadCriteria];
}

void RuleEditorSetCriteriaAndDisplayValuesForRow( NSInteger tag, CFArrayRef criteria, CFArrayRef displayValues, NSInteger row )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c setCriteria:(__bridge NSArray *)criteria andDisplayValues:(__bridge NSArray *)displayValues forRowAtIndex:row];
}

CFArrayRef RuleEditorCriteriaForRow( NSInteger tag, NSInteger row )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return (__bridge CFArrayRef)[c criteriaForRow:row];
    return nil;
}

CFArrayRef RuleEditorDisplayValuesForRow( NSInteger tag, NSInteger row )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return (__bridge CFArrayRef)[c displayValuesForRow:row];
    return nil;
}

// Row info
NSInteger RuleEditorNumberOfRows( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c numberOfRows];
    return 0;
}

NSInteger RuleEditorParentRowForRow( NSInteger tag, NSInteger row )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c parentRowForRow:row];
    return 0;
}

NSInteger RuleEditorRowForDisplayValue( NSInteger tag, CFTypeRef value )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c rowForDisplayValue:(__bridge id)value];
    return 0;
}

NSRuleEditorRowType RuleEditorRowTypeForRow( NSInteger tag, NSInteger row )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c rowTypeForRow:row];
    return 0;
}

NSIndexSet *RuleEditorSubrowIndexesForRow( NSInteger tag, NSInteger row )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c subrowIndexesForRow:row];
    return nil;
}

// Selection
NSIndexSet *RuleEditorSelectedRowIndexes( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c selectedRowIndexes];
    return nil;
}

void RuleEditorSelectRowIndexes( NSInteger tag, NSIndexSet *indexes, BOOL byExtendingSelection )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c selectRowIndexes:indexes byExtendingSelection:byExtendingSelection];
}

// Manipulate rows
void RuleEditorAddRow( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c addRow:nil];
}

void RuleEditorInsertRow( NSInteger tag, NSInteger rowIndex, NSRuleEditorRowType rowType, NSInteger parentRow, BOOL animate )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c insertRowAtIndex:rowIndex withType:rowType asSubrowOfRow:parentRow animate:animate];
}

void RuleEditorRemoveRow( NSInteger tag, NSInteger rowIndex )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c removeRowAtIndex:rowIndex];
}

void RuleEditorRemoveRows( NSInteger tag, NSIndexSet *rowIndexes, BOOL includeSubrows )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c removeRowsAtIndexes:rowIndexes includeSubrows:includeSubrows];
}

// Predicates
NSPredicate *RuleEditorPredicate( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c predicate];
    return nil;
}

void RuleEditorReloadPredicate( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c reloadPredicate];
}

NSPredicate *RuleEditorPredicateForRow( NSInteger tag, NSInteger rowIndex )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c predicateForRow:rowIndex];
    return nil;
}

// Bindings
Class RuleEditorRowClass( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return [c rowClass];
    return nil;
}

void RuleEditorSetRowClass( NSInteger tag, Class cls )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c setRowClass:cls];
}

CFStringRef RuleEditorRowTypeKeyPath( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return (__bridge CFStringRef)[c rowTypeKeyPath];
    return nil;
}

void RuleEditorSetRowTypeKeyPath( NSInteger tag, CFStringRef path )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c setRowTypeKeyPath:(__bridge NSString *)path];
}

CFStringRef RuleEditorSubrowsKeyPath( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return (__bridge CFStringRef)[c subrowsKeyPath];
    return nil;
}

void RuleEditorSetSubrowsKeyPath( NSInteger tag, CFStringRef path )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c setSubrowsKeyPath:(__bridge NSString *)path];
}

CFStringRef RuleEditorCriteriaKeyPath( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return (__bridge CFStringRef)[c criteriaKeyPath];
    return nil;
}

void RuleEditorSetCriteriaKeyPath( NSInteger tag, CFStringRef path )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c setCriteriaKeyPath:(__bridge NSString *)path];
}

CFStringRef RuleEditorDisplayValuesKeyPath( NSInteger tag )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) return (__bridge CFStringRef)[c displayValuesKeyPath];
    return nil;
}

void RuleEditorSetDisplayValuesKeyPath( NSInteger tag, CFStringRef path )
{
    NSRuleEditor *c = RuleEditorWithTag( tag );
    if ( c ) [c setDisplayValuesKeyPath:(__bridge NSString *)path];
}
