/*
 PathControl.m

 Bernie Wylde
 */

#import "PathControl.h"

#pragma mark - subclass
@implementation PathControlSC

- (void)resetCursorRects {
    CUI_ViewSubclassResetCursorRects( self );
}

- (BOOL)wantsUpdateLayer {
    return CUI_ViewSubclassWantsUpdateLayer( self );
}

- (void)updateLayer {
    CUI_ViewSubclassUpdateLayer( self );
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CUI_ViewSubclassAwakeFromNib(self);
}

#pragma mark - menu
- (NSMenu *)menuForEvent:(NSEvent*)theEvent {
    CUI_ViewSubclassMenuForEvent( self, theEvent );
    return DialogEventNSMenu();
}
@end


@implementation CUI_PathControlDelegate
//- (BOOL)pathControl:(NSPathControl *)pathControl shouldDragPathComponentCell:(NSPathComponentCell *)pathComponentCell withPasteboard:(NSPasteboard *)pasteboard {
//    DialogEventSetBool(YES);
//    CUI_ControlCallUserDefinedOnDialogOrCallback( pathControlShouldDragPathComponentCell, pathControl, pathComponentCell );
//    return DialogEventBool();
//}

- (NSDragOperation)pathControl:(NSPathControl *)pathControl validateDrop:(id<NSDraggingInfo>)info {
    DialogEventSetDraggingInfo( info );
    DialogEventSetLong(NSDragOperationEvery);
    
    NSURL *url = nil;
    NSPasteboard *pb = [info draggingPasteboard];
    if ( [[pb types] containsObject:NSURLPboardType] || [[pb types] containsObject:NSFilenamesPboardType] ) {
        url = [NSURL URLFromPasteboard:pb];
    }
    DialogEventSetNSURL( url );

    CUI_ControlCallUserDefinedOnDialogOrCallback( pathControlValidateDrop, pathControl, info );
    return DialogEventLong();
}

- (BOOL)pathControl:(NSPathControl *)pathControl acceptDrop:(id<NSDraggingInfo>)info {
    DialogEventSetDraggingInfo( info );
    DialogEventSetBool(YES);
    
    NSURL *url = nil;
    NSPasteboard *pb = [info draggingPasteboard];
    if ( [[pb types] containsObject:NSURLPboardType] || [[pb types] containsObject:NSFilenamesPboardType] ) {
        url = [NSURL URLFromPasteboard:pb];
    }
    DialogEventSetNSURL( url );

    CUI_ControlCallUserDefinedOnDialogOrCallback( pathControlAcceptDrop, pathControl, info );
    
    return DialogEventBool();
}

- (void)pathControl:(NSPathControl *)pathControl willDisplayOpenPanel:(NSOpenPanel *)openPanel {
    CUI_ControlCallUserDefinedOnDialogOrCallback( pathControlWillDisplayOpenPanel, pathControl, openPanel );
}

- (void)pathControl:(NSPathControl *)pathControl willPopUpMenu:(NSMenu *)menu {
    DialogEventSetMenu( menu );
    CUI_ControlCallUserDefinedOnDialogOrCallback( pathControlWillPopUpMenu, pathControl, menu );
}

- (BOOL)pathControl:(NSPathControl *)pathControl shouldDragItem:(NSPathControlItem *)pathItem withPasteboard:(NSPasteboard *)pasteboard {
    DialogEventSetPasteboard( pasteboard );
    DialogEventSetBool(YES);
    CUI_ControlCallUserDefinedOnDialogOrCallback( pathControlShouldDragItem, pathControl, pathItem );
    return DialogEventBool();
}

- (void)singleAction:(id)sender {
    CUI_ControlCallUserDefinedOnDialogOrCallback( 1, sender, nil );// 1 = _btnClick
}

- (void)doubleAction:(id)sender {
    CUI_ControlCallUserDefinedOnDialogOrCallback( pathControlDoubleAction, sender, nil );
}
@end


CUI_PathControlDelegate *CUI_PathControlDelegateObj( void )
{
    static CUI_PathControlDelegate *sCUI_PathControlDelegate = nil;
    if ( !sCUI_PathControlDelegate ) sCUI_PathControlDelegate = [[CUI_PathControlDelegate alloc] init];
    return sCUI_PathControlDelegate;
}


// Class
Class PathControlClass( void )
{ return [NSPathControl class]; }

NSPathControl *PathControlWithTag( NSInteger tag )
{ return (NSPathControl *)CUI_ValidateViewKindOfClass( tag, [NSPathControl class] ); }

BOOL PathControlExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSPathControl class] ); }


// Style
NSPathStyle PathControlStyle( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) return [ref pathStyle];
    return NSPathStyleStandard;
}

void PathControlSetStyle( NSInteger tag, NSPathStyle style )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) [ref setPathStyle:style];
}

// Background color
NSColor *PathControlBackgroundColor( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) return [ref backgroundColor];
    return nil;
}

void PathControlSetBackgroundColor( NSInteger tag, NSColor *col )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) [ref setBackgroundColor:col];
}

// Components
NSPathComponentCell *PathControlClickedPathComponentCell( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) return [ref clickedPathComponentCell];
    return nil;
}

CFArrayRef PathControlPathComponentCells( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) return (__bridge CFArrayRef)[ref pathComponentCells];
    return nil;
}

void PathControlSetPathComponentCells( NSInteger tag, CFArrayRef comps )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) [ref setPathComponentCells:(__bridge NSArray *)comps];
}

// Path
CFURLRef PathControlURL( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) return (__bridge CFURLRef)[ref URL];
    return nil;
}

void PathControlSetURL( NSInteger tag, CFURLRef url )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) [ref setURL:(__bridge NSURL *)url];
}

// Delegate
//void PathControlSetDelegate( NSInteger tag, BOOL flag )
//{
//    NSPathControl *ref = PathControlWithTag( tag );
//    if ( ref ) {
//        if ( flag ) {
//            [ref setDelegate:CUI_PathControlDelegateObj()];
//            [ref setDoubleAction:@selector(doubleAction:)];
//        } else {
//            [ref setDelegate:nil];
//        }
//    }
//}

// Menu
NSMenu *PathControlMenu( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) return [ref menu];
    return nil;
}

void PathControlSetMenu( NSInteger tag, NSInteger menuIndex )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) {
        NSMenu *menu = MenuAtIndex( menuIndex );
        if ( menu ) [ref setMenu:menu];
    }
}

NSInteger PathControlMenuIndex( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) {
        NSMenu *menu = [ref menu];
        if ( menu ) {
            return CUI_MenuIndex( menu );
        }
    }
    return 0;
}

// Instance properties
CFArrayRef PathControlAllowedTypes( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) {
        return (__bridge CFArrayRef)[ref allowedTypes];
    }
    return nil;
}

void PathControlSetAllowedTypes( NSInteger tag, CFArrayRef types )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) {
        [ref setAllowedTypes:(__bridge NSArray *)types];
    }
}

NSPathControlItem *PathControlClickedPathItem( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) return [ref clickedPathItem];
    return nil;
}

BOOL PathControlIsEditable( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) {
        return [ref isEditable];
    }
    return NO;
}

void PathControlSetEditable( NSInteger tag, BOOL flag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) {
        [ref setEditable:flag];
    }
}

CFArrayRef PathControlPathItems( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) return (__bridge CFArrayRef)[ref pathItems];
    return nil;
}

void PathControlSetPathItems( NSInteger tag, CFArrayRef items )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) [ref setPathItems:(__bridge NSArray *)items];
}

CFAttributedStringRef PathControlPlaceholderAttributedString( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) {
        return (__bridge CFAttributedStringRef)[ref placeholderAttributedString];
    }
    return nil;
}

void PathControlSetPlaceholderAttributedString( NSInteger tag, CFAttributedStringRef aString )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) {
        [ref setPlaceholderAttributedString:(__bridge NSAttributedString *)aString];
    }
}

CFStringRef PathControlPlaceholderString( NSInteger tag )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) {
        return (__bridge CFStringRef)[ref placeholderString];
    }
    return nil;
}

void PathControlSetPlaceholderString( NSInteger tag, CFStringRef string )
{
    NSPathControl *ref = PathControlWithTag( tag );
    if ( ref ) {
        [ref setPlaceholderString:(__bridge NSString *)string];
    }
}


// Init
NSPathControl *PathControlInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) {
        rect = NSMakeRect( 20, 20, 204, 20 );
    }
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();
    
    // init
    NSPathControl *c;
#if __has_feature(objc_arc)
    if ( subclass ) {
        c = [[PathControlSC alloc] initWithFrame:rect];
    } else {
        c = [[NSPathControl alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        c = [[[PathControlSC alloc] initWithFrame:rect] autorelease];
    } else {
        c = [[[NSPathControl alloc] initWithFrame:rect] autorelease];
    }
#endif
    
//#if !__has_feature(objc_arc)
//    [c autorelease];
//#endif
    
    // tag
    [c setTag:inTag];
    
    // url
    //[c setURL:[NSURL fileURLWithPath:@"/Applications/"]];
    
    // style
    [c setPathStyle:NSPathStyleStandard];
    
    // size
    [[c cell] setControlSize:NSSmallControlSize];
    
    // font
    CUI_ControlFixFont( c );
    
    // target/action
    CUI_PathControlDelegate *delegate = CUI_PathControlDelegateObj();
    [c setDelegate:delegate];
    [c setTarget:delegate];
    [c setAction:@selector(singleAction:)];
    [c setDoubleAction:@selector(doubleAction:)];

    return c;
}


#pragma mark - pathcontrol statement
void CUI_PathControl( NSInteger inTag, NSInteger inEnabled, CFURLRef inURL, CGRect inRect, NSInteger inStyle, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSURL *url = (__bridge NSURL *)inURL;
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        
        NSPathControl *c = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !c ) {
            c = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( c ) {    // already exists
            
            // clear subclass flag
            CUI_SetSubclassFlag(NO);
            
            if ( !CUI_ValidateViewClass( inWndTag, inTag, c, [NSPathControl class] ) ) {
                return;
            }
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [c setEnabled:(BOOL)inEnabled];
            
            // url
            if ( url ) [c setURL:url];
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [c setFrame:rect];
            
            // style
            if ( inStyle != kFBParamMissing ) [c setPathStyle:inStyle];
            
        } else {        // create
            c = PathControlInit( inTag, inRect );
            
            // default autoresizing
            [c setAutoresizingMask:NSViewMinYMargin];
            
            // enabled
            if ( inEnabled != kFBParamMissing ) [c setEnabled:(BOOL)inEnabled];
            
            // url
            if ( url ) [c setURL:url];
            
            // style
            if ( inStyle == kFBParamMissing ) inStyle = NSPathStyleStandard;
            [c setPathStyle:inStyle];
            
            // rect
            if ( NSIsEmptyRect( rect ) ) {
                if ( inStyle == NSPathStylePopUp ) {
                    rect = NSMakeRect( 17, 16, 204, 22 );
                    [c setFrame:rect];
                }
             }

            // wndTag
            [c setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:c];
            } else {
                [contentView addSubview:c];
            }

        }
        
        [c setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

