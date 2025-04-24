/*
 Popover.m

 Bernie Wylde
 */

#import "Popover.h"

@implementation PopoverSC
- (void)awakeFromNib {
    [super awakeFromNib];
    CUI_WindowSubclassAwakeFromNib(self);
}
@end

@implementation CUI_PopoverDelegate

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.detachableWindow release];
    [super dealloc];
}
#endif

- (BOOL)windowShouldClose:(NSWindow *)window {
    if ( window == self.detachableWindow ) {
        [window orderOut:nil];
        return NO;
    }
    return YES;
}

- (NSWindow *)detachableWindowForPopover:(NSPopover *)popover {
    NSWindow *window;
    NSInteger detachableWndTag = 0;
    
    DialogEventSetLong(detachableWndTag);
    if ( self.detachableWindow ) DialogEventSetLong([self.detachableWindow tag]);
    
    CallUserDefinedOnDialogFunction( popoverDetachableWindow, [popover tag], [popover tag], (__bridge CFTypeRef)popover );
    
    detachableWndTag = DialogEventLong();
    window = CUI_WindowWithTag(detachableWndTag);
    CUI_OutputWindowSetTag( detachableWndTag );
    
    return window;
}

- (BOOL)popoverShouldClose:(NSPopover *)popover {
    DialogEventSetBool( YES );
    CallUserDefinedOnDialogFunction( popoverShouldClose, [popover tag], [popover tag], (__bridge CFTypeRef)popover );
    return DialogEventBool();
}

- (void)popoverWillShow:(NSNotification *)notification {
    CallUserDefinedOnDialogFunction( popoverWillShow, [notification.object tag], [notification.object tag], (__bridge CFTypeRef)notification.object );
}

- (void)popoverDidShow:(NSNotification *)notification {
    CallUserDefinedOnDialogFunction( popoverDidShow, [notification.object tag], [notification.object tag], (__bridge CFTypeRef)notification.object );
}

- (void)popoverWillClose:(NSNotification *)notification {
    CallUserDefinedOnDialogFunction( popoverWillClose, [notification.object tag], [notification.object tag], (__bridge CFTypeRef)notification.object );
}

- (void)popoverDidClose:(NSNotification *)notification {
    CallUserDefinedOnDialogFunction( popoverDidClose, [notification.object tag], [notification.object tag], (__bridge CFTypeRef)notification.object );
}

- (void)popoverDidDetach:(NSPopover *)popover {
    CallUserDefinedOnDialogFunction( popoverDidDetach, [popover tag], [popover tag], (__bridge CFTypeRef)popover );
}

- (BOOL)popoverShouldDetach:(NSPopover *)popover {
    DialogEventSetBool( YES );
    CallUserDefinedOnDialogFunction( popoverShouldDetach, [popover tag], [popover tag], (__bridge CFTypeRef)popover );
    return DialogEventBool();
}

@end

@implementation NSPopover (Additions)
@dynamic tagNumber;

- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

NSPopover *CUI_PopoverForView( id view )
{
    NSPopover *popover = nil;
    if ( [view class] == [NSView class] ) {
        NSResponder *viewNextResponder = [view nextResponder];
        if ( viewNextResponder ) {
            if ( [viewNextResponder class] == [NSViewController class] ) {
                NSResponder *viewControllerNextResponder = [viewNextResponder nextResponder];
                if ( viewControllerNextResponder ) {
                    if ( [viewControllerNextResponder class] == [NSPopover class] ) {
                        popover = (NSPopover *)viewControllerNextResponder;
                    }
                }
            }
        }
    } else {
        id superview = [view superview];
        if ( superview ) popover = CUI_PopoverForView( superview );
    }
    return popover;
}

void CUI_PopoverAdd( NSPopover *popover, NSInteger tag )
{
    if ( !sCUI_Popovers ) sCUI_Popovers = [[NSMutableArray alloc] initWithCapacity:0];
    NSDictionary *poDict = [NSDictionary dictionaryWithObject:popover forKey:[NSString stringWithFormat:@"%ld",(long)tag]];
    [sCUI_Popovers addObject:poDict];
    CUI_PopoverDelegate *delegate = [[CUI_PopoverDelegate alloc] init];
    [popover setDelegate:delegate];
}

NSPopover *CUI_PopoverWithTag( NSInteger tag )
{
    if ( tag ) {
        if ( tag > 1000000 ) {
            //return (NSPopover *)tag;// it's a NSPopover *
            return (__bridge NSPopover *)(void *)tag;
        }
        
        if ( sCUI_Popovers ) {
            for ( NSDictionary *poDict in sCUI_Popovers ) {
                NSPopover *popover = [poDict objectForKey:[NSString stringWithFormat:@"%ld",(long)tag]];
                if ( popover ) return popover;
            }
        }
    }
    
    return nil;
}


NSPopover *CUI_PopoverShown( void )// 20220721
{
    if ( sCUI_Popovers ) {
        for ( NSDictionary *dict in sCUI_Popovers ) {
            NSArray *values = [dict allValues];
            for ( NSPopover *popover in values ) {
                if ( [popover isShown] ) return popover;
            }
        }
    }
    return nil;
}


void PopoverAddSubview( NSInteger tag, NSInteger subviewTag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) {
        NSViewController *controller = [popover contentViewController];
        if ( controller ) {
            NSView *view = [controller view];
            if ( view ) {
                NSView *subview = CUI_ViewWithTag( subviewTag );
                if ( subview ) {
                    [view addSubview:subview];
                    [(NSButton *)subview setWndTag:tag];
                }
            }
        }
    }
}

// Class
Class PopoverClass( void )
{ return [NSPopover class]; }

NSPopover *PopoverWithTag( NSInteger tag )
{ return CUI_PopoverWithTag( tag ); }

BOOL PopoverExists( NSInteger tag )
{
    if ( sCUI_Popovers ) {
        for ( NSDictionary *poDict in sCUI_Popovers ) {
            NSPopover *popover = [poDict objectForKey:[NSString stringWithFormat:@"%ld",(long)tag]];
            if ( popover ) return YES;
        }
    }
    return NO;
}

// Content view controller
NSViewController *PopoverContentViewController( NSInteger tag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) return [popover contentViewController];
    return nil;
}


NSPopoverBehavior PopoverBehavior( NSInteger tag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) return [popover behavior];
    return 0;
}

void PopoverSetBehavior( NSInteger tag, NSPopoverBehavior behavior )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) [popover setBehavior:behavior];
}

void PopoverShow( NSInteger tag, CGRect inRect, NSInteger viewTag, CGRectEdge preferredEdge )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) {
        NSView *view = CUI_ViewWithTag( viewTag );
        if ( view ) {
            NSRect rect = NSRectFromCGRect( inRect );
            [popover showRelativeToRect:rect ofView:view preferredEdge:(NSRectEdge)preferredEdge];
        }
    }
}

CGRect PopoverPositioningRect( NSInteger tag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) return NSRectToCGRect([popover positioningRect]);
    return CGRectZero;
}

void PopoverSetPositioningRect( NSInteger tag, CGRect rect )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) [popover setPositioningRect:NSRectFromCGRect(rect)];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
BOOL PopoverHasFullSizeContent( NSInteger tag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) return [popover hasFullSizeContent];
    return NO;
}

void PopoverSetHasFullSizeContent( NSInteger tag, BOOL flag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) [popover setHasFullSizeContent:flag];
}

void PopoverShowRelativeToToolbarItem( NSInteger tag, NSInteger tbTag, NSInteger itemTag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) {
        NSToolbarItem *item = ToolbarItemWithTag( tbTag, itemTag );
        if ( item ) [popover showRelativeToToolbarItem:item];
    }
}
#endif// 140000


NSAppearance *PopoverAppearance( NSInteger tag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) return [popover appearance];
    return nil;
}

void PopoverSetAppearance( NSInteger tag, NSAppearance *app )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) [popover setAppearance:app];
}

void PopoverSetAppearanceNamed( NSInteger tag, CFStringRef name )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) [popover setAppearance:[NSAppearance appearanceNamed:(__bridge NSString *)name]];
}

NSAppearance *PopoverEffectiveAppearance( NSInteger tag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) return [popover effectiveAppearance];
    return nil;
}


BOOL PopoverAnimates( NSInteger tag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) return [popover animates];
    return NO;
}

void PopoverSetAnimates( NSInteger tag, BOOL flag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) [popover setAnimates:flag];
}

CGSize PopoverContentSize( NSInteger tag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) return NSSizeToCGSize([popover contentSize]);
    return CGSizeZero;
}

void PopoverSetContentSize( NSInteger tag, CGSize size )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) [popover setContentSize:NSSizeFromCGSize(size)];
}

BOOL PopoverIsShown( NSInteger tag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) return [popover isShown];
    return false;
}

void PopoverPerformClose( NSInteger tag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) [popover performClose:nil];
}

void PopoverClose( NSInteger tag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) [popover close];
}

BOOL PopoverIsDetached( NSInteger tag )
{
    NSPopover *popover = CUI_PopoverWithTag( tag );
    if ( popover ) {
        return [popover isDetached];
    }
    return NO;
}

void PopoverSetDetachableWindow( NSInteger popoverTag, NSInteger wndTag )
{
    NSPopover *popover = CUI_PopoverWithTag( popoverTag );
    if ( popover ) {
        NSWindow *w = CUI_WindowWithTag( wndTag );
        if ( w ) {
            CUI_PopoverDelegate *delegate = (CUI_PopoverDelegate *)[popover delegate];
            delegate.detachableWindow = w;
            [w setDelegate:delegate];
        }
    }
}



// Init
NSPopover *PopoverInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) {
        rect = NSMakeRect( 0, 0, 163, 96 );
    }
    
    // create popover view
    id view = [[NSView alloc] initWithFrame:rect];
    
    // create popover view controller
    NSViewController *controller = [[NSViewController alloc] init];
    [controller setView:view];
    
#if !__has_feature(objc_arc)
    [view release];
#endif
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // create popover
    NSPopover *popover;
#if __has_feature(objc_arc)
    if ( subclass ) {
        popover = [[PopoverSC alloc] init];
    } else {
        popover = [[NSPopover alloc] init];
    }
#else
    if ( subclass ) {
        popover = [[[PopoverSC alloc] init] autorelease];
    } else {
        popover = [[[NSPopover alloc] init] autorelease];
    }
#endif
    
    // set controller
    [popover setContentViewController:controller];
#if !__has_feature(objc_arc)
    [controller release];
#endif
    
    // add to list of popovers
    CUI_PopoverAdd( popover, inTag );
    
    // tag
    [popover setTag:inTag];

    return popover;
}

// Statement
void CUI_Popover( NSInteger inTag, CGRect inRect, NSInteger inBehavior, NSInteger inAnimates )
{
    if ( CUI_ObjectIsWindow( inTag ) ) return;
        
    NSPopover *popover = CUI_PopoverWithTag( inTag );
    if ( !popover ) {        
        popover = PopoverInit( inTag, inRect );
        
        // behavior
        if ( inBehavior != kFBParamMissing ) [popover setBehavior:inBehavior];
        
        // animates
        if ( inAnimates != kFBParamMissing ) [popover setAnimates:(BOOL)inAnimates];
    }
    CUI_OutputWindowSetTag( inTag );
}
