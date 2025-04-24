/*
 TabView.m

 Bernie Wylde
 */

#import "TabView.h"

@implementation TabViewSC
- (void)drawRect:(NSRect)dirtyRect {
    CUI_ViewSubclassDrawRect( self, dirtyRect );
    if ( !DialogEventBool() ) [super drawRect:dirtyRect];
}

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

@implementation NSTabView (Additions)
@dynamic tagNumber;

- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

@implementation CUI_TabViewDelegate

- (void)tabView:(NSTabView *)tabView callUserDefinedOnDialogFunctionWithEvent:(NSInteger)event object:(id)obj {
    NSInteger wndTag = [tabView wndTag];
    CUI_OutputWindowSetTag( wndTag );
    CallUserDefinedOnDialogFunction( event, [tabView tag], wndTag, (__bridge CFTypeRef)obj );
}

- (void)tabViewDidChangeNumberOfTabViewItems:(NSTabView *)tabView {
    [self tabView:tabView callUserDefinedOnDialogFunctionWithEvent:tabViewDidChangeNumberOfTabViewItems object:tabView];
}

- (BOOL)tabView:(NSTabView *)tabView shouldSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    DialogEventSetBool( YES );
    [self tabView:tabView callUserDefinedOnDialogFunctionWithEvent:tabViewShouldSelectTabViewItem object:tabView];
    return DialogEventBool();
}

- (void)tabView:(NSTabView *)tabView willSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    DialogEventSetLong( [tabView indexOfTabViewItem:tabViewItem] );
    [self tabView:tabView callUserDefinedOnDialogFunctionWithEvent:tabViewWillSelectTabViewItem object:tabView];
}

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(NSTabViewItem *)tabViewItem {
    DialogEventSetLong( [tabView indexOfTabViewItem:tabViewItem] );
    [self tabView:tabView callUserDefinedOnDialogFunctionWithEvent:tabViewDidSelectTabViewItem object:tabView];
}
@end

CUI_TabViewDelegate *CUI_TabViewDelegateObj( void )
{
    static CUI_TabViewDelegate *sCUI_TabViewDelegate = nil;
    if ( !sCUI_TabViewDelegate ) sCUI_TabViewDelegate = [[CUI_TabViewDelegate alloc] init];
    return sCUI_TabViewDelegate;
}

void CUI_TabViewItemFixFrame( NSTabViewItem *item )
{
    NSTabView *tabView = [item tabView];
    if ( tabView ) {
        [[item view] setFrame:[tabView contentRect]];
    }
}



#pragma mark - public

// Class
Class TabViewClass( void )
{ return [NSTabView class]; }

NSTabView *TabViewWithTag( NSInteger tag )
{ return (NSTabView *)CUI_ValidateViewKindOfClass( tag, [NSTabView class] ); }

BOOL TabViewExists( NSInteger tag )
{ return CUI_ViewWithKindOfClassExists( tag, [NSTabView class] ); }

// Adding and removing tabs
void TabViewAddItem( NSInteger tag, NSTabViewItem *item )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) {
        [c addTabViewItem:item];
        CUI_TabViewItemFixFrame( item );
    }
}

void TabViewInsertItem( NSInteger tag, NSTabViewItem *item, NSInteger index )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) {
        [c insertTabViewItem:item atIndex:index];
        CUI_TabViewItemFixFrame( item );
    }
}

void TabViewRemoveItem( NSInteger tag, NSTabViewItem *item )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) {
        [c removeTabViewItem:item];
    }
}

// Accessing tabs
NSInteger TabViewIndexOfItem( NSInteger tag, NSTabViewItem *item )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) {
        return [c indexOfTabViewItem:item];
    }
    return NSNotFound;
}

NSInteger TabViewIndexOfItemWithIdentifier( NSInteger tag, CFTypeRef identifier )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) {
        return [c indexOfTabViewItemWithIdentifier:(__bridge id)identifier];
    }
    return NSNotFound;
}

NSInteger TabViewIndex( NSInteger tag )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) {
        NSTabViewItem *item = [c selectedTabViewItem];
        if ( item ) return [c indexOfTabViewItem:item];
    }
    return 0;
}

NSInteger TabViewNumberOfItems( NSInteger tag )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) return [c numberOfTabViewItems];
    return 0;
}

NSTabViewItem *TabViewItemAtIndex( NSInteger tag, NSInteger index )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) {
        return [c tabViewItemAtIndex:index];
    }
    return nil;
}

CFArrayRef TabViewItems( NSInteger tag )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) {
        return (__bridge CFArrayRef)[c tabViewItems];
    }
    return nil;
}

// Configure
NSTabViewType TabViewType( NSInteger tag )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) return [c tabViewType];
    return 0;
}

void TabViewSetType( NSInteger tag, NSTabViewType type )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) [c setTabViewType:type];
}

NSTabPosition TabViewPosition( NSInteger tag )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) return [c tabPosition];
    return 0;
}

void TabViewSetPosition( NSInteger tag, NSTabPosition position )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) [c setTabPosition:position];
}

NSTabViewBorderType TabViewBorderType( NSInteger tag )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) return [c tabViewBorderType];
    return 0;
}

void TabViewSetBorderType( NSInteger tag, NSTabViewBorderType type )
{
    NSTabView *c = TabViewWithTag( tag );
    if ( c ) [c setTabViewBorderType:type];
}

// Select
void TabViewSelectFirstItem( NSInteger tag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) [tab selectFirstTabViewItem:nil];
}

void TabViewSelectLastItem( NSInteger tag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) [tab selectLastTabViewItem:nil];
}

void TabViewSelectNextItem( NSInteger tag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) [tab selectNextTabViewItem:nil];
}

void TabViewSelectPreviousItem( NSInteger tag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) [tab selectPreviousTabViewItem:nil];
}

void TabViewSelectItemAtIndex( NSInteger tag, NSInteger index )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) [tab selectTabViewItemAtIndex:index];
}

void TabViewSelectItemWithIdentifier( NSInteger tag, CFTypeRef identifier )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) [tab selectTabViewItemWithIdentifier:(__bridge id)identifier];
}

NSTabViewItem *TabViewSelectedItem( NSInteger tag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) return [tab selectedTabViewItem];
    return nil;
}

void TabViewTakeSelectedItemFromSender( NSInteger tag, CFTypeRef sender )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) [tab takeSelectedTabViewItemFromSender:(__bridge id)sender];
}

// Font
NSFont *TabViewFont( NSInteger tag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) return [tab font];
    return nil;
}

void TabViewSetFont( NSInteger tag, CFTypeRef inFont )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) {
        NSFont *font = CUI_FixFont( (const void *)inFont );
        [tab setFont:font];
    }
}

// Tint
void TabViewSetControlTint( NSInteger tag, NSControlTint tint )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) [tab setControlTint:tint];
}

// Background
BOOL TabViewDrawsBackground( NSInteger tag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) return [tab drawsBackground];
    return NO;
}

void TabViewSetDrawsBackground( NSInteger tag, BOOL flag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) [tab setDrawsBackground:flag];
}

// Size
CGSize TabViewMinimumSize( NSInteger tag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) return NSSizeToCGSize([tab minimumSize]);
    return CGSizeZero;
}

CGRect TabViewContentRect( NSInteger tag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) return NSRectToCGRect([tab contentRect]);
    return CGRectZero;
}

NSControlSize TabViewControlSize( NSInteger tag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) return [tab controlSize];
    return 0;
}

void TabViewSetControlSize( NSInteger tag, NSControlSize size )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) {
        [tab setControlSize:size];
        [tab setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:size]]];
    }
}

// Truncate
BOOL TabViewAllowsTruncatedLabels( NSInteger tag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) return [tab allowsTruncatedLabels];
    return NO;
}

void TabViewSetAllowsTruncatedLabels( NSInteger tag, BOOL flag )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) [tab setAllowsTruncatedLabels:flag];
}

// Event handling
NSTabViewItem *TabViewItemAtPoint( NSInteger tag, CGPoint pt )
{
    NSTabView *tab = TabViewWithTag( tag );
    if ( tab ) return [tab tabViewItemAtPoint:NSPointFromCGPoint(pt)];
    return nil;
}




// custom
void TabViewAddSubview( NSInteger tabTag, NSInteger index, NSInteger subviewTag )
{
    NSTabView *tabView = TabViewWithTag( tabTag );
    if ( tabView ) {
        NSTabViewItem *item = [tabView tabViewItemAtIndex:index];
        if ( item ) {
            id subview = CUI_ViewWithTag( subviewTag );
            if ( subview ) {
                [[item view] addSubview:subview];
            }
        }
    }
}

// Init
NSTabView *TabViewInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    if ( NSIsEmptyRect( rect ) ) rect = NSMakeRect( 13, 2, 177, 124 );

    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSTabView *tab;
#if __has_feature(objc_arc)
    if ( subclass ) {
        tab = [[TabViewSC alloc] initWithFrame:rect];
    } else {
        tab = [[NSTabView alloc] initWithFrame:rect];
    }
#else
    if ( subclass ) {
        tab = [[[TabViewSC alloc] initWithFrame:rect] autorelease];
    } else {
        tab = [[[NSTabView alloc] initWithFrame:rect] autorelease];
    }
#endif
    
    // tag
    [tab setTag:inTag];

    // target
    [tab setDelegate:CUI_TabViewDelegateObj()];

    return tab;
}


// Statement
void CUI_TabView( NSInteger inTag, NSInteger inIndex, CFTypeRef inItems, CGRect inRect, NSInteger inWndTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    NSRect rect = NSRectFromCGRect( inRect );
    
    // target window
    id w = CUI_TargetWindow( &inWndTag );
    
    if ( w ) {
        NSView *contentView = CUI_TargetContentView( w );
        NSTabView *tab = CUI_ViewSubviewWithTag( contentView, inTag );
        
        if ( !tab ) {
            tab = TitlebarAccessoryViewWithTag( inTag );
        }
        
        if ( tab ) {    // already exists
            // clear subclass flag
            CUI_SetSubclassFlag(NO);

            // make sure it's correct class
            if ( !CUI_ValidateViewClass( inWndTag, inTag, tab, [NSTabView class] ) ) {
                return;
            }

            // index
            if ( inIndex != kFBParamMissing ) {
                if ( inIndex < [tab numberOfTabViewItems] ) [tab selectTabViewItemAtIndex:inIndex];
            }
            
            // rect
            if ( !NSIsEmptyRect( rect ) ) [tab setFrame:rect];
            
        } else {        // create
            // init
            tab = TabViewInit( inTag, inRect );
            
            // default autoresizing
            [tab setAutoresizingMask:NSViewMinYMargin];
            
            // items
            NSArray *items = nil;
            
            if ( inItems ) {
                if ( CFGetTypeID(inItems) == CFStringGetTypeID() ) {
                    items = [(__bridge NSString *)inItems componentsSeparatedByString:@";"];
                    
                } else if ( CFGetTypeID(inItems) == CFArrayGetTypeID() ) {
                    items = (__bridge NSArray *)inItems;
                }
            } else {
                items = [NSArray arrayWithObjects:@"Tab 1",@"Tab 2",nil];
            }
            
            NSInteger count = [items count];
            for ( NSInteger index = 0; index < count; index++ ) {
                NSTabViewItem *item = [[NSTabViewItem alloc] initWithIdentifier:[NSString stringWithFormat:@"%ld",(long)index+1]];
                [item setLabel:[items objectAtIndex:index]];
                //[[item view] setFrame:[tab contentRect]];
                [tab addTabViewItem:item];
                CUI_TabViewItemFixFrame( item );
            }
            
            // index
            if ( inIndex != kFBParamMissing ) {
                if ( inIndex < [tab numberOfTabViewItems] ) [tab selectTabViewItemAtIndex:inIndex];
            }
            
            // wndTag
            [tab setWndTag:inWndTag];
            
            // add to window/popover/superview
            id superview = CUI_CurrentSuperview();
            if ( superview ) {
                [superview addSubview:tab];
            } else {
                [contentView addSubview:tab];
            }
        }
        
        [tab setHidden:!show];
    } else {
        CUI_ShowWindowDoesNotExistAlert( inWndTag );
    }
}

