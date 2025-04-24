/*
 PredicateEditor.m

 Bernie Wylde
 */

#import "PredicateEditor.h"

#pragma mark - subclass
@implementation PredicateEditorSC
@end

// Class
Class PredicateEditorClass( void )
{ return [NSPredicateEditor class]; }

NSPredicateEditor *PredicateEditorWithTag( NSInteger tag )
{ return (NSPredicateEditor *)CUI_ValidateViewKindOfClass( tag, [NSPredicateEditor class] ); }

BOOL PredicateEditorExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSPredicateEditor class] ); }


// Row templates
CFArrayRef PredicateEditorRowTemplates( NSInteger tag )
{
    NSPredicateEditor *c = PredicateEditorWithTag( tag );
    if ( c ) return (__bridge CFArrayRef)[c rowTemplates];
    return nil;
}

void PredicateEditorSetRowTemplates( NSInteger tag, CFArrayRef templates )
{
    NSPredicateEditor *c = PredicateEditorWithTag( tag );
    if ( c ) [c setRowTemplates:(__bridge NSArray *)templates];
}


// Init
NSPredicateEditor *PredicateEditorInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 0, 0, 333, 84 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSPredicateEditor *view;
#if __has_feature(objc_arc)
    if ( subclass ) {
        view = [[PredicateEditorSC alloc] initWithFrame:rect];
    } else {
        view = [[NSPredicateEditor alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        view = [[[PredicateEditorSC alloc] initWithFrame:rect] autorelease];
    } else {
        view = [[[NSPredicateEditor alloc] initWithFrame:rect] autorelease];
    }
#endif
    
    // tag
    [view setTag:inTag];
    
    return view;
}


// Statement
void CUI_PredicateEditor( NSInteger inTag, CGRect inRect, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSPredicateEditor *view = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !view ) {
            view = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( view ) {     // already exists
            // clear subclass flag
            CUI_SetSubclassFlag( NO );
            
            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, view, [NSPredicateEditor class] ) ) {
                return;
            }

            // rect
            if ( !NSIsEmptyRect( rect ) ) [view setFrame:rect];
        } else {            // create
            // init
            view = PredicateEditorInit( inTag, inRect );
            
            // default autoresizing
            [view setAutoresizingMask:NSViewMinYMargin];
            
            // wndTag
            [view setWndTag:inWndTag];
            
            // add to window
            [contentView addSubview:view];
        }
        
        [view setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

