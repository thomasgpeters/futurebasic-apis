/*
 TextLabel.m

 Bernie Wylde
 */

#import "TextLabel.h"

NSTextField *TextLabelWithTag( NSInteger tag )
{ return TextFieldWithTag( tag ); }

BOOL TextLabelExists( NSInteger tag )
{ return TextFieldExists( tag ); }


// Init
NSTextField *TextLabelInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 18, 20, 37, 17 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSTextField *fld;
#if __has_feature(objc_arc)
    if ( subclass ) {
        fld = [[TextFieldSC alloc] initWithFrame:rect];
    } else {
        fld = [[NSTextField alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        fld = [[[TextFieldSC alloc] initWithFrame:rect] autorelease];
    } else {
        fld = [[[NSTextField alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [fld autorelease];
//#endif
    
    [fld setDrawsBackground:NO];
    [fld setEditable:NO];
    [fld setSelectable:NO];
    [fld setBezeled:NO];

    // tag
    [fld setTag: inTag];
    
    // fix font to match I.B.
    CUI_ControlFixFont( fld );
    
    return fld;
}


// Statement
#if 1// attributed string text
void CUI_TextLabel( NSInteger inTag, CFTypeRef inText, CGRect inRect, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSString *text = nil;
    NSAttributedString *attrText = nil;
    
    if ( inText ) {
        if ( CFGetTypeID(inText) == CFStringGetTypeID() ) {
            text = (__bridge NSString *)inText;
        } else if ( CFGetTypeID(inText) == CFAttributedStringGetTypeID() ) {
            attrText = (__bridge NSAttributedString *)inText;
        }
    }

    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );

    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSTextField *fld = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !fld ) {
            fld = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( fld ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, fld, [NSTextField class] ) ) {
                return;
            }

            // text
            if ( text ) [fld setStringValue:text];
            if ( attrText ) [fld setAttributedStringValue:attrText];

            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [fld setFrame:rect];
            
        } else {        // create
            // init
            fld = TextLabelInit( inTag, inRect );
            
            // default autoresizing
            [fld setAutoresizingMask:NSViewMinYMargin];
             
            // text
            if ( text ) [fld setStringValue:text];
            if ( attrText ) [fld setAttributedStringValue:attrText];

            // wndTag
            [fld setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:fld];
            } else {
                [contentView addSubview:fld];
            }
        }
        
        [fld setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

#else// attributed string text

void CUI_TextLabel( NSInteger inTag, CFStringRef inText, CGRect inRect, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSString *text = (__bridge NSString *)inText;
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );

    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSTextField *fld = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !fld ) {
            fld = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( fld ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, fld, [NSTextField class] ) ) {
                return;
            }

            // text
            if ( text ) [fld setStringValue:text];
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [fld setFrame:rect];
            
        } else {        // create
            // init
            fld = TextLabelInit( inTag, inRect );
            
            // default autoresizing
            [fld setAutoresizingMask:NSViewMinYMargin];
             
            // text
            if ( text ) [fld setStringValue:text];
            
            // wndTag
            [fld setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:fld];
            } else {
                [contentView addSubview:fld];
            }
        }
        
        [fld setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}
#endif// attributed string text

