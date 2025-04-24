/*
 Menu.m
 
 Bernie Wylde
 */

#import "Menu.h"

@implementation CUI_MenuItemTarget

- (void)menuItemAction:(id)sender {
    NSMenu *menu = [(NSMenuItem *)sender menu];
    NSInteger menuIndex = [menu tag];
    if ( menuIndex <= 0 ) {
        NSMenu *supermenu = [menu supermenu];
        menuIndex = [supermenu indexOfItemWithSubmenu:menu];
    }
    NSInteger itemIndex = [menu indexOfItem:sender];
    
    CUI_MenuItemCallbackType callback = [sender cuiMenuItemCallback];
    if ( callback ) {
        void *userData = [sender cuiMenuItemUserData];
        (*callback)(menuIndex,itemIndex,userData);
    } else {
#if 1
        CallUserDefinedOnMenuFunction( menuIndex, itemIndex, menu );// 20240225
#else
        CallUserDefinedOnMenuFunction( menuIndex, itemIndex );
#endif
    }
}

/*
 The following menuItemAction0 ... menuItemAction31 methods
 are to make selections work correctly in section header menus
 introduced in macOS 14.0+
 */
- (void)menuItemAction0:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction1:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction2:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction3:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction4:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction5:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction6:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction7:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction8:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction9:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction10:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction11:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction12:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction13:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction14:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction15:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction16:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction17:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction18:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction19:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction20:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction21:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction22:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction23:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction24:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction25:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction26:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction27:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction28:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction29:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction30:(id)sender {
    [self menuItemAction:sender];
}

- (void)menuItemAction31:(id)sender {
    [self menuItemAction:sender];
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    BOOL flag = [menuItem isEnabled];
    if ( self.validateCallback ) {
        NSMenu *menu = [menuItem menu];
        NSInteger menuIndex = [menu tag];
        if ( menuIndex <= 0 ) {
            NSMenu *supermenu = [menu supermenu];
            menuIndex = [supermenu indexOfItemWithSubmenu:menu];
        }
        NSInteger itemIndex = [menu indexOfItem:menuItem];
        return (*self.validateCallback)(menuIndex,itemIndex);
    }
    return flag;
}

@end

@implementation NSMenuItem (Additions)
@dynamic callbackValue;
@dynamic userDataValue;

//- (CUI_MenuItemCallbackType)cuiMenuItemCallback {
//    return [(NSValue *)objc_getAssociatedObject(self, @selector(callbackValue)) pointerValue];
//}
//
//- (void *)cuiMenuItemUserData {
//    return [(NSValue *)objc_getAssociatedObject(self, @selector(userDataValue)) pointerValue];
//}
//
//- (void)setCuiMenuItemCallback:(CUI_MenuItemCallbackType)callback {
//    objc_setAssociatedObject(self, @selector(callbackValue), [NSValue valueWithPointer:callback], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (void)setCuiMenuItemUserData:(void *)userData {
//    objc_setAssociatedObject(self, @selector(userDataValue), [NSValue valueWithPointer:userData], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

- (CUI_MenuItemCallbackType)cuiMenuItemCallback {
    return (CUI_MenuItemCallbackType)[(NSValue *)objc_getAssociatedObject(self, @selector(callbackValue)) pointerValue];
}

- (void *)cuiMenuItemUserData {
    return [(NSValue *)objc_getAssociatedObject(self, @selector(userDataValue)) pointerValue];
}

- (void)setCuiMenuItemCallback:(CUI_MenuItemCallbackType)callback {
    objc_setAssociatedObject(self, @selector(callbackValue), [NSValue valueWithPointer:(void *)callback], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCuiMenuItemUserData:(void *)userData {
    objc_setAssociatedObject(self, @selector(userDataValue), [NSValue valueWithPointer:userData], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end


@implementation CUI_MenuDelegate// 20220311

- (void)menu:(NSMenu *)menu itemIndex:(NSInteger)itemIndex issueDelegateEvent:(NSInteger)event {
    NSInteger menuIndex = [menu tag];
    if ( menuIndex <= 0 ) {
        NSMenu *supermenu = [menu supermenu];
        menuIndex = [supermenu indexOfItemWithSubmenu:menu];
    }
    if (self.callback)(*self.callback)(event,menuIndex,itemIndex,self.userData);
}

//- (BOOL)menuHasKeyEquivalent:(NSMenu *)menu forEvent:(NSEvent *)event target:(id  _Nullable *)target action:(SEL  _Nullable *)action {
//
//    return NO;
//}

//- (BOOL)menu:(NSMenu *)menu updateItem:(NSMenuItem *)item atIndex:(NSInteger)index shouldCancel:(BOOL)shouldCancel {
//
//    [self menu:menu itemIndex:index issueDelegateEvent:menuUpdateItem];
//    return YES;
//}

//- (NSRect)confinementRectForMenu:(NSMenu *)menu onScreen:(NSScreen *)screen {
//
//    return NSZeroRect;
//}
//

- (void)menu:(NSMenu *)menu willHighlightItem:(NSMenuItem *)item {
    [self menu:menu itemIndex:[menu indexOfItem:item] issueDelegateEvent:menuWillHighlightItem];
}

- (void)menuWillOpen:(NSMenu *)menu {
    [self menu:menu itemIndex:0 issueDelegateEvent:menuWillOpen];
}

- (void)menuDidClose:(NSMenu *)menu {
    [self menu:menu itemIndex:0 issueDelegateEvent:menuDidClose];
}

//- (NSInteger)numberOfItemsInMenu:(NSMenu *)menu {
//
//    return [menu numberOfItems];
//}

- (void)menuNeedsUpdate:(NSMenu *)menu {
    [self menu:menu itemIndex:0 issueDelegateEvent:menuNeedsUpdate];
}
@end

//CUI_MenuDelegate *CUI_MenuDelegateObj( void )
//{
//    static CUI_MenuDelegate *sCUI_MenuDelegate = nil;
//    if ( !sCUI_MenuDelegate ) sCUI_MenuDelegate = [[CUI_MenuDelegate alloc] init];
//    return sCUI_MenuDelegate;
//}

//CUI_MenuDelegate *CUI_MenuDelegateObj( void )
//{ return [[CUI_MenuDelegate alloc] init]; }

// private
static NSMutableDictionary *sCUI_MenuItemTargets;

CUI_MenuItemTarget *CUI_MenuItemTargetForMenuAndGroup( NSInteger menuID, NSInteger groupID )
{
    NSString *key = [NSString stringWithFormat:@"%ld_%ld",menuID,groupID];
    CUI_MenuItemTarget *target = sCUI_MenuItemTargets[key];
    if ( !target ) {
        target = [[CUI_MenuItemTarget alloc] init];
        [sCUI_MenuItemTargets setValue:target forKey:key];
    }
    return target;
}



CUI_MenuItemTarget *CUI_MenuItemTargetObj( void )
{
    static CUI_MenuItemTarget *sCUI_MenuItemTarget = nil;
    if ( !sCUI_MenuItemTarget ) sCUI_MenuItemTarget = [[CUI_MenuItemTarget alloc] init];
    return sCUI_MenuItemTarget;
}

void MenuEventSetBool( BOOL flag )
{ [CUI_MenuItemTargetObj() setBoolVal:flag]; }

static NSMutableArray *sCUI_OtherMenus;

NSArray *CUI_OtherMenus( void )// 20231227
{ return (NSArray *)sCUI_OtherMenus; }

void CUI_OtherMenuAdd( NSMenu *menu )
{
    if ( sCUI_OtherMenus == nil ) sCUI_OtherMenus = [[NSMutableArray alloc] initWithCapacity:0];
    [sCUI_OtherMenus addObject:menu];
}

NSMenu *CUI_OtherMenuAtIndex( NSInteger index )
{
    if ( sCUI_OtherMenus ) {
        for ( NSMenu *menu in sCUI_OtherMenus ) {
            if ( [menu tag] == index ) return menu;
        }
    }
    return nil;
}


NSInteger CUI_MenuIndex( NSMenu *menu )
{
    NSMenu *mainMenu = [NSApp mainMenu];
    NSArray *items = [mainMenu itemArray];
    NSInteger mainMenuItemCount = (NSInteger)[items count];
    if ( mainMenuItemCount ) {
        for ( NSInteger index = 0; index < mainMenuItemCount; index++ ) {
            NSMenuItem *item = [mainMenu itemAtIndex:index];
            NSMenu *submenu = [item submenu];
            if ( submenu ) {
                if ( submenu == menu ) return index;
            }
        }
    }
    return [menu tag];
}



@implementation NSMenu (Additions)
@dynamic tagNumber;

- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

// - private -
void CUI_MenuPadItemsToIndex( NSMenu *menu, NSInteger index )
{
    NSInteger itemCount = [menu numberOfItems];
    if ( index > 1 ) {
        while ( itemCount < index ) {
            NSMenuItem *newItem = [menu addItemWithTitle:@"" action:nil keyEquivalent:@""];
            NSMenu *newMenu = [[NSMenu alloc] initWithTitle:@""];
            [menu setSubmenu:newMenu forItem:newItem];
            itemCount++;
        }
    }
}


// - public -
// Class
Class MenuClass( void )
{ return [NSMenu class]; }

NSMenu *MenuAtIndex( NSInteger index )
{
    if ( index > 1000000 ) {
        //return (NSMenu *)index;
        return (__bridge NSMenu *)(void *)index;
    }
    
    if ( index > 100 ) {
        return CUI_OtherMenuAtIndex( index );
    } else {
        NSMenu *mainMenu = [NSApp mainMenu];
        if ( mainMenu ) {
            NSInteger count = [mainMenu numberOfItems];
            if ( index < count ) {
                NSMenuItem *item = [mainMenu itemAtIndex:index];
                return [item submenu];
            }
        }
    }
    return nil;
}

BOOL MenuExists( NSInteger index )
{
    if ( index > 100 ) {
        return ( CUI_OtherMenuAtIndex( index ) != nil );
    } else {
        NSMenu *mainMenu = [NSApp mainMenu];
        if ( mainMenu ) {
            NSInteger count = [mainMenu numberOfItems];
            if ( index < count ) {
                return ( [mainMenu itemAtIndex:index] != nil );
            }
        }
    }
    return NO;
}

NSInteger MenuIndex( NSMenu *m )
{ return CUI_MenuIndex( m ); }


// MenuBar
BOOL MenuBarVisible( void )
{ return [NSMenu menuBarVisible]; }

void MenuBarSetVisible( BOOL flag )
{ [NSMenu setMenuBarVisible:flag]; }

CGFloat MenuBarHeight( void )
{ return [[NSApp mainMenu] menuBarHeight]; }

// Init
NSMenu *MenuWithTitle( CFStringRef title )
{
#if __has_feature(objc_arc)
    return [[NSMenu alloc] initWithTitle:(__bridge NSString *)title];
#else
    return [[[NSMenu alloc] initWithTitle:(__bridge NSString *)title] autorelease];
#endif
}

// Add/remove items
void MenuInsertItem( NSInteger menuIndex, NSMenuItem *item, NSInteger itemIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [menu insertItem:item atIndex:itemIndex];
}

NSMenuItem *MenuInsertItemWithTitle( NSInteger menuIndex, NSInteger itemIndex, CFStringRef title, CFStringRef keyEquivalent, NSUInteger keyEquivalentModifierMask )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSInteger count = [menu numberOfItems];
        if ( itemIndex < count ) {
            if ( !keyEquivalent ) keyEquivalent = (__bridge CFStringRef)@"";
            NSMenuItem *item = [menu insertItemWithTitle:(__bridge NSString *)title action:@selector(menuItemAction:) keyEquivalent:(__bridge NSString *)keyEquivalent atIndex:(NSInteger)itemIndex];
            if ( keyEquivalentModifierMask > 0 ) [item setKeyEquivalentModifierMask:keyEquivalentModifierMask];
            [item setTarget:CUI_MenuItemTargetObj()];
            return item;
        }
    }
    return nil;
}

void MenuAddItem( NSInteger menuIndex, NSMenuItem *item )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [menu addItem:item];
}

NSMenuItem *MenuAddItemWithTitle( NSInteger menuIndex, CFStringRef title, CFStringRef keyEquivalent, NSUInteger keyEquivalentModifierMask )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        if ( !keyEquivalent ) keyEquivalent = (__bridge CFStringRef)@"";
        NSMenuItem *item = [menu addItemWithTitle:(__bridge NSString *)title action:@selector(menuItemAction:) keyEquivalent:(__bridge NSString *)keyEquivalent];
        if ( keyEquivalentModifierMask > 0 ) [item setKeyEquivalentModifierMask:keyEquivalentModifierMask];
        [item setTarget:CUI_MenuItemTargetObj()];
        return item;
    }
    return nil;
}

void MenuRemoveItem( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSMenuItem *item = CUI_MenuItemAtIndex( menu, itemIndex );
        if ( item ) [menu removeItem:item];
    }
}

void MenuRemoveAllItems( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        [menu removeAllItems];
    }
}

// Find menu items
NSMenuItem *MenuItemWithTag( NSInteger menuIndex, NSInteger itemTag )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        return [menu itemWithTag:itemTag];
    }
    return nil;
}

NSInteger MenuItemWithTitle( NSInteger menuIndex, CFStringRef title )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        return [menu indexOfItemWithTitle:(__bridge NSString *)title];
    }
    return 0;
}

NSMenuItem *MenuItemAtIndex( NSInteger menuIndex, NSInteger itemIndex )
{
    if ( itemIndex > 1000000 ) {
        //return (NSMenuItem *)itemIndex;
        return (__bridge NSMenuItem *)(void *)itemIndex;
    }
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSInteger count = [menu numberOfItems];
        if ( itemIndex < count ) return [menu itemAtIndex:itemIndex];
    }
    return nil;
}

NSInteger MenuNumberOfItems( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu numberOfItems];
    return 0;
}

CFArrayRef MenuItemArray( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return (__bridge CFArrayRef)[menu itemArray];
    return nil;
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
void MenuSetItemArray( NSInteger menuIndex, CFArrayRef items )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [menu setItemArray:(__bridge NSArray *)items];
}
#endif// 101400

// Find indices of items
NSInteger MenuIndexOfItem( NSInteger menuIndex, NSMenuItem *item )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu indexOfItem:item];
    return -1;
}

NSInteger MenuIndexOfItemWithTitle( NSInteger menuIndex, CFStringRef title )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu indexOfItemWithTitle:(__bridge NSString *)title];
    return -1;
}

NSInteger MenuIndexOfItemWithTag( NSInteger menuIndex, NSInteger tag )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu indexOfItemWithTag:tag];
    return -1;
}

NSInteger MenuIndexOfItemWithRepresentedObject( NSInteger menuIndex, CFTypeRef obj )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu indexOfItemWithRepresentedObject:(__bridge id)obj];
    return -1;
}

NSInteger MenuIndexOfItemWithSubmenu( NSInteger menuIndex, NSInteger submenuID )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSMenu *submenu = MenuAtIndex( submenuID );
        if ( submenu ) return [menu indexOfItemWithSubmenu:submenu];
    }
    return -1;
}

// Submenus
void MenuSetSubmenu( NSInteger parMenuIndex, NSInteger parItemIndex, NSInteger submenuIndex )
{
    NSMenu *parMenu = MenuAtIndex( parMenuIndex );
    if ( parMenu ) {
        NSMenuItem *parItem = [parMenu itemAtIndex:parItemIndex];
        if ( parItem ) {
            NSMenu *submenu = MenuAtIndex( submenuIndex );
            if ( submenu ) [parMenu setSubmenu:submenu forItem:parItem];
        }
    }
}

NSMenu *MenuSupermenu( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu supermenu];
    return nil;
}

NSInteger MenuSupermenuIndex( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSMenu *supermenu = [menu supermenu];
        if ( supermenu ) return CUI_MenuIndex( supermenu );
    }
    return -1;
}

// Enable/disable menu items
BOOL MenuAutoenablesItems( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu autoenablesItems];
    return NO;
}

void MenuSetAutoenablesItems( NSInteger menuIndex, BOOL flag )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        [menu setAutoenablesItems:flag];
    }
}

void MenuUpdate( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [menu update];
}


// Font
NSFont *MenuFont( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        return [menu font];
    }
    return nil;
}


void MenuSetFont( NSInteger menuIndex, CFTypeRef inFont )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSFont *font = CUI_FixFont( (const void *)inFont );
        [menu setFont:(NSFont *)font];
    }
}

void MenuSetFontWithName( NSInteger menuIndex, CFStringRef inName, CGFloat size )// convenience
{
    BOOL usePrevFont = NO;
    NSString *name = (__bridge NSString *)inName;
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        if ( name ) {
            usePrevFont = ( [name length] == 0 );
        } else {
            usePrevFont = YES;
        }
        if ( usePrevFont ) {
            name = [[menu font] fontName];
        }
        if ( (int)size == 0 ) size = [[menu font] pointSize];
        //        [menu setFont:[NSFont fontWithName:(__bridge NSString *)name size:size]];
        CTFontRef font = CTFontCreateWithName( (__bridge CFStringRef)name, size, nil );
        [menu setFont:(__bridge NSFont *)font];
        if ( font ) CFRelease(font);// check for NULL 20221227
    }
}

// Keyboard equivalents
BOOL MenuPerformKeyEquivalent( NSInteger menuIndex, NSEvent *event )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu performKeyEquivalent:event];
    return NO;
}

// Simulate mouse clicks
void MenuPerformActionForItemAtIndex( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [menu performActionForItemAtIndex:itemIndex];
}

// Title
CFStringRef MenuTitle( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSString *title = [menu title];
        if ( title != nil ) {
            if ( [title length] == 0 ) {
                NSMenu *supermenu = [menu supermenu];
                if ( supermenu ) {
                    for ( NSMenuItem *item in [supermenu itemArray] ) {
                        if ( [item submenu] == menu ) {
                            title = [item title];
                            break;
                        }
                    }
                }
            }
        }
        return (__bridge CFStringRef)title;
    }
    return nil;
}

void MenuSetTitle( NSInteger menuIndex, CFStringRef title )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [menu setTitle:(__bridge NSString *)title];
}

// Size
CGFloat MenuMinimumWidth( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu minimumWidth];
    return 0.0;
}

void MenuSetMinimumWidth( NSInteger menuIndex, CGFloat width )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [menu setMinimumWidth:width];
}

CGSize MenuSize( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return NSSizeToCGSize([menu size]);
    return CGSizeZero;
}

// Properties
NSMenuProperties MenuPropertiesToUpdate( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu propertiesToUpdate];
    return 0;
}

// Contextual menus
BOOL MenuAllowsContextMenuPlugIns( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu allowsContextMenuPlugIns];
    return NO;
}

void MenuSetAllowsContextMenuPlugIns( NSInteger menuIndex, BOOL flag )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [menu setAllowsContextMenuPlugIns:flag];
}

// Context-sensitive help
void MenuPopUpContextMenuForView( NSInteger menuIndex, NSEvent *event, NSInteger aViewTag )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSView *view = ViewWithTag( aViewTag );
        if ( view ) {
            [NSMenu popUpContextMenu:menu withEvent:event forView:view];
        }
    }
}

void MenuPopUpContextMenuForViewWithFont( NSInteger menuIndex, NSEvent *event, NSInteger aViewTag, NSFont *font )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSView *view = ViewWithTag( aViewTag );
        if ( view ) {
            [NSMenu popUpContextMenu:menu withEvent:event forView:view withFont:font];
        }
    }
}

BOOL MenuPopUp( NSInteger menuIndex, NSInteger itemIndex, CGPoint location, NSInteger viewTag )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSMenuItem *item = [menu itemAtIndex:itemIndex];
        if ( item ) {
            NSView *view = ViewWithTag( viewTag );
            if ( view ) {
                return [menu popUpMenuPositioningItem:item atLocation:NSPointFromCGPoint(location) inView:view];
            }
        }
    }
    return NO;
}

// State column
BOOL MenuShowsStateColumn( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu showsStateColumn];
    return NO;
}

void MenuSetShowsStateColumn( NSInteger menuIndex, BOOL flag )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        [menu setShowsStateColumn:flag];
    }
}

// Highlighting
NSInteger MenuHighlightedItem( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSMenuItem *item = [menu highlightedItem];
        if ( item ) {
            return [menu indexOfItem:item];
        }
    }
    return -1;
}

// Delegate
void MenuSetDelegateCallback( NSInteger menuIndex, CUI_MenuDelegateCallbackType callback, void *userData )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        CUI_MenuDelegate *delegate = [[CUI_MenuDelegate alloc] init];//CUI_MenuDelegateObj();
        [delegate setCallback:callback];
        [delegate setUserData:userData];
        [menu setDelegate:delegate];
    }
}

// User interface
NSUserInterfaceLayoutDirection MenuUserInterfaceLayoutDirection( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu userInterfaceLayoutDirection];
    return 0;
}

void MenuSetUserInterfaceLayoutDirection( NSInteger menuIndex, NSUserInterfaceLayoutDirection direction )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [menu setUserInterfaceLayoutDirection:direction];
}

// Tracking
void MenuCancelTracking( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [menu cancelTracking];
}

void MenuCancelTrackingWithoutAnimation( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [menu cancelTrackingWithoutAnimation];
}

// Presentation style
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
NSMenuPresentationStyle MenuPresentationStyle( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu presentationStyle];
    return 0;
}

void MenuSetPresentationStyle( NSInteger menuIndex, NSMenuPresentationStyle style )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) [menu setPresentationStyle:style];
}

NSMenuSelectionMode MenuSelectionMode( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return [menu selectionMode];
    return 0;
}

void MenuSetSelectionMode( NSInteger menuIndex, NSMenuSelectionMode mode )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        [menu setSelectionMode:mode];
        if ( mode == NSMenuSelectionModeSelectOne ) {
            // create separate target objects for each section
            NSArray *items = [menu itemArray];
            NSInteger groupID = 0;
            CUI_MenuItemTarget *target = CUI_MenuItemTargetForMenuAndGroup( menuIndex, groupID );
            for ( NSMenuItem *item in items ) {
                if ( [item isSeparatorItem] || [item isSectionHeader] ) {
                    groupID++;
                    target = CUI_MenuItemTargetForMenuAndGroup( menuIndex, groupID );
                }
                [item setTarget:target];
                SEL selector = NSSelectorFromString([NSString stringWithFormat:@"menuItemAction%ld:",groupID]);
                [item setAction:selector];
            }
        }
    }
}

//CFArrayRef MenuSelectedItems( NSInteger menuIndex )
//{
//    NSMenu *menu = MenuAtIndex( menuIndex );
//    if ( menu ) return (__bridge CFArrayRef)[menu selectedItems];
//    return nil;
//}

void MenuSetSelectedItems( NSInteger menuIndex, CFArrayRef items )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menuIndex ) [menu setSelectedItems:(__bridge NSArray *)items];
}
#endif// 140000


CFArrayRef MenuSelectedItems( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
        if (@available(macOS 14.0, *)) {
            return (__bridge CFArrayRef)[menu selectedItems];
        } else {
            NSMutableArray *selItems = [NSMutableArray arrayWithCapacity:0];
            NSArray *items = [menu itemArray];
            for ( NSMenuItem *item in items ) {
                if ( [item state] == NSOnState ) {
                    [selItems addObject:item];
                }
            }
            if ( [selItems count] > 0 ) return (__bridge CFArrayRef)selItems;
        }
#else// 140000
        NSMutableArray *selItems = [NSMutableArray arrayWithCapacity:0];
        NSArray *items = [menu itemArray];
        for ( NSMenuItem *item in items ) {
            if ( [item state] == NSOnState ) {
                [selItems addObject:item];
            }
        }
        if ( [selItems count] > 0 ) return (__bridge CFArrayRef)selItems;
#endif// 140000
    }
    return nil;
}


// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150200
BOOL MenuAutomaticallyInsertsWritingToolsItems( NSInteger menuID )
{
    NSMenu *menu = MenuAtIndex( menuID );
    if ( menu ) {
        return [menu automaticallyInsertsWritingToolsItems];
    }
    return NO;
}

void MenuSetAutomaticallyInsertsWritingToolsItems( NSInteger menuID, BOOL flag )
{
    NSMenu *menu = MenuAtIndex( menuID );
    if ( menu ) {
        [menu setAutomaticallyInsertsWritingToolsItems:flag];
    }
}
#endif// 150200


#pragma mark - Custom
void MenuSetTag( NSInteger menuIndex, NSInteger tag )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSMenuItem *item = [[menu supermenu] itemAtIndex:menuIndex];
        if ( item ) [item setTag:tag];
    }
}

void MenuSetOneItemOnState( NSInteger menuIndex, NSInteger itemIndex )
{ MenuSelectItem( menuIndex, itemIndex ); }

void MenuSelectItem( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSInteger count = [menu numberOfItems];
        for ( NSInteger index = 0; index < count; index++ ) {
            NSMenuItem *item = [menu itemAtIndex:index];
            [item setState:(index == itemIndex )];
        }
    }
}

void MenuSelectGroupItem( NSInteger menuIndex, NSInteger itemIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSInteger count = [menu numberOfItems];
        NSInteger firstGroupIndex = 0;
        NSInteger lastGroupIndex = count - 1;
        
        // count back to separator or 0
        if ( itemIndex > 0 ) {
            for ( NSInteger index = itemIndex - 1; index >= 0; index-- ) {
                NSMenuItem *item = [menu itemAtIndex:index];
                if ( [item isSeparatorItem] ) {
                    firstGroupIndex = index + 1;
                    break;
                }
                
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
                if ( [item isSectionHeader] ) {
                    firstGroupIndex = index + 1;
                    break;
                }
#endif // 140000
                
            }
        }
        
        // count forward to separator or last item
        if ( itemIndex < lastGroupIndex ) {
            for ( NSInteger index = itemIndex + 1; index < count; index++ ) {
                NSMenuItem *item = [menu itemAtIndex:index];
                if ( [item isSeparatorItem] ) {
                    lastGroupIndex = index - 1;
                    break;
                }
                
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
                if ( [item isSectionHeader] ) {
                    lastGroupIndex = index - 1;
                    break;
                }
#endif // 140000

            }
        }
                
        for ( NSInteger index = firstGroupIndex; index <= lastGroupIndex; index++ ) {
            NSMenuItem *item = [menu itemAtIndex:index];
            [item setState:(index == itemIndex ) ? NSOnState : NSOffState];
        }
    }
}

NSInteger MenuSelectedItem( NSInteger menuID )
{
    NSMenu *menu = MenuAtIndex( menuID );
    if ( menu ) {
        NSArray *items = [menu itemArray];
        for ( NSUInteger index = 0; index < [items count]; index++ ) {
            NSMenuItem *item = items[index];
            if ( [item state] == NSOnState ) return (NSInteger)index;
        }
    }
    return -1;// no selected items
}

void MenuSetValidateItemsCallback( CUI_ValidateMenuItemCallbackType callback )
{
    CUI_MenuItemTarget *target = CUI_MenuItemTargetObj();
    if ( target ) {
        target.validateCallback = callback;
    }
}

BOOL MenuIsHidden( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSMenuItem *item = [[menu supermenu] itemAtIndex:menuIndex];
        if ( item ) return [item isHidden];
    }
    return NO;
}

void MenuSetHidden( NSInteger menuIndex, BOOL flag )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSMenuItem *item = [[menu supermenu] itemAtIndex:menuIndex];
        if ( item ) [item setHidden:flag];
    }
}

BOOL MenuIsHiddenOrHasHiddenAncestor( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) {
        NSMenuItem *item = [[menu supermenu] itemAtIndex:menuIndex];
        if ( item ) return [item isHiddenOrHasHiddenAncestor];
    }
    return NO;
}



CFTypeRef MenuProperty( NSInteger menuIndex, CFStringRef key )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return (CFTypeRef)ObjectProperty( (__bridge CFTypeRef)menu, key );
    return nil;
}

void MenuSetProperty( NSInteger menuIndex, CFStringRef key, CFTypeRef value )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectSetProperty( (__bridge CFTypeRef)menu, key, value );
}

void MenuPropertySet( NSInteger menuIndex, CFStringRef key, CFTypeRef value )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectPropertySet( (__bridge CFTypeRef)menu, key, value );
}


BOOL MenuPropertyBool( NSInteger menuIndex, CFStringRef key )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return ObjectPropertyBool( (__bridge CFTypeRef)menu, key );
    return NO;
}

void MenuPropertySetBool( NSInteger menuIndex, CFStringRef key, BOOL value )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectPropertySetBool( (__bridge CFTypeRef)menu, key, value );
}

long MenuPropertyLong( NSInteger menuIndex, CFStringRef key )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return ObjectPropertyLong( (__bridge CFTypeRef)menu, key );
    return 0;
}

void MenuPropertySetLong( NSInteger menuIndex, CFStringRef key, long value )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectPropertySetLong( (__bridge CFTypeRef)menu, key, value );
}

double MenuPropertyDouble( NSInteger menuIndex, CFStringRef key )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return ObjectPropertyDouble( (__bridge CFTypeRef)menu, key );
    return 0.0;
}

void MenuPropertySetDouble( NSInteger menuIndex, CFStringRef key, double value )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectPropertySetDouble( (__bridge CFTypeRef)menu, key, value );
}

CGRect MenuPropertyRect( NSInteger menuIndex, CFStringRef key )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return ObjectPropertyRect( (__bridge CFTypeRef)menu, key );
    return CGRectZero;
}

void MenuPropertySetRect( NSInteger menuIndex, CFStringRef key, CGRect r )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectPropertySetRect( (__bridge CFTypeRef)menu, key, r );
}

CGPoint MenuPropertyPoint( NSInteger menuIndex, CFStringRef key )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return ObjectPropertyPoint( (__bridge CFTypeRef)menu, key );
    return CGPointZero;
}

void MenuPropertySetPoint( NSInteger menuIndex, CFStringRef key, CGPoint pt )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectPropertySetPoint( (__bridge CFTypeRef)menu, key, pt );
}

CGSize MenuPropertySize( NSInteger menuIndex, CFStringRef key )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return ObjectPropertySize( (__bridge CFTypeRef)menu, key );
    return CGSizeZero;
}

void MenuPropertySetSize( NSInteger menuIndex, CFStringRef key, CGSize sz )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectPropertySetSize( (__bridge CFTypeRef)menu, key, sz );
}

CFRange MenuPropertyRange( NSInteger menuIndex, CFStringRef key )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return ObjectPropertyRange( (__bridge CFTypeRef)menu, key );
    return CFRangeMake(NSNotFound,0);
}

void MenuPropertySetRange( NSInteger menuIndex, CFStringRef key, CFRange range )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectPropertySetRange( (__bridge CFTypeRef)menu, key, range );
}

CFURLRef MenuPropertyBookmarkURL( NSInteger menuIndex, CFStringRef key )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return ObjectPropertyBookmarkURL( (__bridge CFTypeRef)menu, key );
    return nil;
}

void MenuPropertySetBookmarkURL( NSInteger menuIndex, CFStringRef key, CFURLRef url )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectPropertySetBookmarkURL( (__bridge CFTypeRef)menu, key, url );
}

BOOL MenuPropertyGetBytes( NSInteger menuIndex, CFStringRef key, void *bytes )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) return ObjectPropertyGetBytes( (__bridge CFTypeRef)menu, key, bytes );
    return NO;
}

void MenuPropertySetBytes( NSInteger menuIndex, CFStringRef key, void *bytes, long length )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectPropertySetBytes( (__bridge CFTypeRef)menu, key, bytes, length );
}


void MenuRemoveProperty( NSInteger menuIndex, CFStringRef key )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectRemoveProperty( (__bridge CFTypeRef)menu, key );
}

void MenuPropertyRemove( NSInteger menuIndex, CFStringRef key )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectPropertyRemove( (__bridge CFTypeRef)menu, key );
}

void MenuRemoveAllProperties( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectRemoveAllProperties( (__bridge CFTypeRef)menu );
}

void MenuPropertyRemoveAll( NSInteger menuIndex )
{
    NSMenu *menu = MenuAtIndex( menuIndex );
    if ( menu ) ObjectPropertyRemoveAll( (__bridge CFTypeRef)menu );
}

// Hide/show tooltips
void MenuSetToolTipsHidden( NSInteger menuID, BOOL flag )
{
    NSString *toolTip;
    NSMenu *menu = MenuAtIndex( menuID );
    NSArray *items = [menu itemArray];
    for ( NSMenuItem *item in items ) {
        if ( [item hasSubmenu] ) {
            MenuSetToolTipsHidden( (NSInteger)[item submenu], flag );
        }
        toolTip = [item toolTip];
        if ( toolTip ) {
            if ( flag ) {
                ObjectPropertySet( (__bridge CFTypeRef)item, (__bridge CFStringRef)@"CUI_ToolTip", (__bridge CFTypeRef)toolTip );
                [item setToolTip:nil];
            } else {
                toolTip = (__bridge NSString *)ObjectProperty( (__bridge CFTypeRef)item, (__bridge CFStringRef)@"CUI_ToolTip" );
                if ( toolTip ) [item setToolTip:toolTip];
            }
        } else {
            if ( !flag ) {
                toolTip = (__bridge NSString *)ObjectProperty( (__bridge CFTypeRef)item, (__bridge CFStringRef)@"CUI_ToolTip" );
                if ( toolTip ) [item setToolTip:toolTip];
            }
        }
    }
}


// FB keywords
#if 1// attributed title (menu item only)
void CUI_Menu( NSInteger inMenuIndex, NSInteger inItemIndex, NSInteger inEnabled, CFTypeRef inTitle, CFStringRef inKeyEquivalent, NSInteger inKeyEquivalentModifier, NSInteger inSectionHeader )
{
    // title
    NSString *title = nil;
    NSAttributedString *attrTitle = nil;
    
    if ( inTitle ) {
        if ( CFGetTypeID(inTitle) == CFStringGetTypeID() ) {
            title = (__bridge NSString *)inTitle;
        } else if ( CFGetTypeID(inTitle) == CFAttributedStringGetTypeID() ) {
            attrTitle = (__bridge NSAttributedString *)inTitle;
            title = [attrTitle string];
        }
    }
    
    // keyEquivalent
    NSString *keyEquivalent = (__bridge NSString *)inKeyEquivalent;// 20180726
    if ( !keyEquivalent ) keyEquivalent = @"";// 20180726
    
    // make sure we have at least a minimal menu
    if ( ![NSApp mainMenu] ) {
        CUI_BuildMinimalMenu();
    }
    
    // get the main menu
    NSMenu *mainMenu = [NSApp mainMenu];
    if ( mainMenu ) {
        
        if ( inMenuIndex == 0 ) { // application menu
            NSMenu *appMenu = [[mainMenu itemAtIndex:0] submenu];
            
            NSMenuItem *item = [appMenu itemAtIndex:inItemIndex];
            
            BOOL userItemExists = NO;
            if ( item ) {
                if ( [item tag] ) {
                    userItemExists = YES;
                }
            }
            
            if ( userItemExists ) {   // item exists
                
                // enabled
                if ( inEnabled != kFBParamMissing ) [item setEnabled:(BOOL)inEnabled];
                
                // title
                if ( title ) [item setTitle:title];
                if ( attrTitle ) [item setAttributedTitle:attrTitle];
                    
                // keyEquivalent
                if ( [keyEquivalent length] ) [item setKeyEquivalent:keyEquivalent];// 20180726
                
                // keyEquivalentModifierMask
                if ( inKeyEquivalentModifier != kFBParamMissing ) [item setKeyEquivalentModifierMask:(NSUInteger)inKeyEquivalentModifier];
                
                // target
                if ( ![item target] ) [item setTarget:CUI_MenuItemTargetObj()];// 20180726
                
                // action
                if ( ![item action] ) [item setAction:@selector(menuItemAction:)];// 20180726
                
            } else {        // create item
                
                NSInteger index = 1;
                while ( [[appMenu itemAtIndex:index] tag] != 0 ) {
                    index++;
                }
                
                if ( index ) {
                    BOOL separator = ( title == nil || [title isEqualToString:@"-"] );
                    
                    NSMenuItem *newAppItem;
                    
                    if ( separator ) {
                        newAppItem = [NSMenuItem separatorItem];
                    } else {
                        newAppItem = [[NSMenuItem alloc] initWithTitle:title action:@selector(menuItemAction:) keyEquivalent:keyEquivalent];
                        if ( attrTitle ) [item setAttributedTitle:attrTitle];
                        
                        // key equivalent modifier
                        if ( inKeyEquivalentModifier != kFBParamMissing ) [newAppItem setKeyEquivalentModifierMask:(NSUInteger)inKeyEquivalentModifier];
                        [newAppItem setTarget:CUI_MenuItemTargetObj()];// 20180726
                    }
                    [newAppItem setTag:-123];
                    [appMenu insertItem:newAppItem atIndex:index];
                }
            }
            
        } else {        // menu other than the application menu
            
            BOOL otherMenuFlag = ( inMenuIndex > 100 ); // non-menubar menu
            
            NSInteger mainMenuItemCount = [mainMenu numberOfItems];
            NSInteger itemCount = 0;
            NSMenu *menu = nil;
            NSMenuItem *menuItem = nil;
            
            if ( otherMenuFlag ) {           // other menu
                menu = CUI_OtherMenuAtIndex( inMenuIndex );
            } else {                         // menu bar menu
                
                itemCount = mainMenuItemCount;
                if ( inMenuIndex < itemCount ) {
                    menuItem = [mainMenu itemAtIndex:inMenuIndex];
                    menu = [menuItem submenu];
                }
            }
            
            if ( menu ) {
                if ( inItemIndex < 0 ) {    // we're changing the menu itself
                    
                    if ( menuItem ) {   // main menu item
                        // enabled
                        if ( inEnabled != kFBParamMissing ) [menuItem setEnabled:(BOOL)inEnabled];
                    }
                    
                    // title
                    if ( title ) [menu setTitle:title];

                } else {    // add/change item
                    NSMenuItem *item = nil;
                    
                    NSInteger itemCount = [menu numberOfItems];
                    
                    if ( inItemIndex < itemCount ) {   // item exists
                        
                        item = [menu itemAtIndex:inItemIndex];
                        
                        // enabled
                        if ( inEnabled != kFBParamMissing ) [item setEnabled:(BOOL)inEnabled];
                        
                        // title
                        if ( title ) [item setTitle:title];
                        if ( attrTitle ) [item setAttributedTitle:attrTitle];

                        // keyEquivalent
                        if ( [keyEquivalent length] ) [item setKeyEquivalent:keyEquivalent];
                        //                        if ( inKeyEquivalent ) [item setKeyEquivalent:keyEquivalent];// 20180726
                        
                        // keyEquivalentModifierMask
                        if ( inKeyEquivalentModifier != kFBParamMissing ) [item setKeyEquivalentModifierMask:(NSUInteger)inKeyEquivalentModifier];
                        
                        // target
                        if ( ![item target] ) [item setTarget:CUI_MenuItemTargetObj()];// 20180726
                        
                        // action
                        if ( ![item action] ) [item setAction:@selector(menuItemAction:)];// 20180726
                        
                    } else {        // create item
                        
                        while ( inItemIndex > itemCount ) {
                            [menu addItem:[NSMenuItem separatorItem]];
                            itemCount = [menu numberOfItems];
                        }
                        
                        BOOL separator = ( title == nil || [title isEqualToString:@"-"] );
                        
                        if ( separator ) {
                            item = [NSMenuItem separatorItem];
                        } else {
                            
                            BOOL sectionHeader = NO;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
                            if (@available(macOS 14.0, *)) {
                                if ( inSectionHeader == YES ) {
                                    sectionHeader = YES;
                                }
                            }
#endif// 140000
                            
                            if ( sectionHeader ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
                                if (@available(macOS 14.0, *)) {
                                    item = [NSMenuItem sectionHeaderWithTitle:title];
                                }
#endif// 140000
                            } else {
                                item = [[NSMenuItem alloc] initWithTitle:title action:@selector(menuItemAction:) keyEquivalent:keyEquivalent];
                                if ( attrTitle ) [item setAttributedTitle:attrTitle];

                                // key equivalent modifier
                                if ( inKeyEquivalentModifier != kFBParamMissing ) [item setKeyEquivalentModifierMask:(NSUInteger)inKeyEquivalentModifier];
                                
                                // enabled
                                if ( inEnabled != kFBParamMissing ) [item setEnabled:(BOOL)inEnabled];
                                
                                // target
                                [item setTarget:CUI_MenuItemTargetObj()];
                            }
                            
                        }
                        [menu insertItem:item atIndex:inItemIndex];
                    }
                    
                }
                
            } else {
                
                if ( inItemIndex >= 0 ) return;    // we're creating a new menu here, so item index must be negative
                
                if ( !title ) title = @"";
                
                menu = [[NSMenu alloc] initWithTitle:title];
                
                if ( otherMenuFlag ) {
                    [menu setTag:inMenuIndex];
                    CUI_OtherMenuAdd( menu );
                } else {
                    
                    CUI_MenuPadItemsToIndex( mainMenu, inMenuIndex );// fill unused items
                    menuItem = [mainMenu insertItemWithTitle:title action:nil keyEquivalent:@"" atIndex:inMenuIndex];
                    [mainMenu setSubmenu:menu forItem:menuItem];
                }
                
                [menu setAutoenablesItems:NO];
            }
            
        }
    }
}

#else// attributed title (menu item only)

void CUI_Menu( NSInteger inMenuIndex, NSInteger inItemIndex, NSInteger inEnabled, CFStringRef inTitle, CFStringRef inKeyEquivalent, NSInteger inKeyEquivalentModifier, NSInteger inSectionHeader )
{
    // title
    NSString *title = (__bridge NSString *)inTitle;
    
    // keyEquivalent
    NSString *keyEquivalent = (__bridge NSString *)inKeyEquivalent;// 20180726
    if ( !keyEquivalent ) keyEquivalent = @"";// 20180726
    
    // make sure we have at least a minimal menu
    if ( ![NSApp mainMenu] ) {
        CUI_BuildMinimalMenu();
    }
    
    // get the main menu
    NSMenu *mainMenu = [NSApp mainMenu];
    if ( mainMenu ) {
        
        if ( inMenuIndex == 0 ) { // application menu
            NSMenu *appMenu = [[mainMenu itemAtIndex:0] submenu];
            
            NSMenuItem *item = [appMenu itemAtIndex:inItemIndex];
            
            BOOL userItemExists = NO;
            if ( item ) {
                if ( [item tag] ) {
                    userItemExists = YES;
                }
            }
            
            if ( userItemExists ) {   // item exists
                
                // enabled
                if ( inEnabled != kFBParamMissing ) [item setEnabled:(BOOL)inEnabled];
                
                // title
                if ( title ) [item setTitle:title];
                
                // keyEquivalent
                if ( [keyEquivalent length] ) [item setKeyEquivalent:keyEquivalent];// 20180726
                
                // keyEquivalentModifierMask
                if ( inKeyEquivalentModifier != kFBParamMissing ) [item setKeyEquivalentModifierMask:inKeyEquivalentModifier];
                
                // target
                if ( ![item target] ) [item setTarget:CUI_MenuItemTargetObj()];// 20180726
                
                // action
                if ( ![item action] ) [item setAction:@selector(menuItemAction:)];// 20180726
                
            } else {        // create item
                
                NSInteger index = 1;
                while ( [[appMenu itemAtIndex:index] tag] != 0 ) {
                    index++;
                }
                
                if ( index ) {
                    BOOL separator = ( title == nil || [title isEqualToString:@"-"] );
                    
                    NSMenuItem *newAppItem;
                    
                    if ( separator ) {
                        newAppItem = [NSMenuItem separatorItem];
                    } else {
                        newAppItem = [[NSMenuItem alloc] initWithTitle:title action:@selector(menuItemAction:) keyEquivalent:keyEquivalent];
                        
                        // key equivalent modifier
                        if ( inKeyEquivalentModifier != kFBParamMissing ) [newAppItem setKeyEquivalentModifierMask:inKeyEquivalentModifier];
                        [newAppItem setTarget:CUI_MenuItemTargetObj()];// 20180726
                    }
                    [newAppItem setTag:-123];
                    [appMenu insertItem:newAppItem atIndex:index];
                }
            }
            
        } else {        // menu other than the application menu
            
            BOOL otherMenuFlag = ( inMenuIndex > 100 ); // non-menubar menu
            
            NSInteger mainMenuItemCount = [mainMenu numberOfItems];
            NSInteger itemCount = 0;
            NSMenu *menu = nil;
            NSMenuItem *menuItem = nil;
            
            if ( otherMenuFlag ) {           // other menu
                menu = CUI_OtherMenuAtIndex( inMenuIndex );
            } else {                         // menu bar menu
                
                itemCount = mainMenuItemCount;
                if ( inMenuIndex < itemCount ) {
                    menuItem = [mainMenu itemAtIndex:inMenuIndex];
                    menu = [menuItem submenu];
                }
            }
            
            if ( menu ) {
                if ( inItemIndex < 0 ) {    // we're changing the menu itself
                    
                    if ( menuItem ) {   // main menu item
                        // enabled
                        if ( inEnabled != kFBParamMissing ) [menuItem setEnabled:(BOOL)inEnabled];
                    }
                    
                    // title
                    if ( title ) [menu setTitle:title];
                    
                } else {    // add/change item
                    
                    NSMenuItem *item = nil;
                    
                    NSInteger itemCount = [menu numberOfItems];
                    
                    if ( inItemIndex < itemCount ) {   // item exists
                        
                        item = [menu itemAtIndex:inItemIndex];
                        
                        // enabled
                        if ( inEnabled != kFBParamMissing ) [item setEnabled:(BOOL)inEnabled];
                        
                        // title
                        if ( title ) [item setTitle:title];
                        
                        // keyEquivalent
                        if ( [keyEquivalent length] ) [item setKeyEquivalent:keyEquivalent];
                        //                        if ( inKeyEquivalent ) [item setKeyEquivalent:keyEquivalent];// 20180726
                        
                        // keyEquivalentModifierMask
                        if ( inKeyEquivalentModifier != kFBParamMissing ) [item setKeyEquivalentModifierMask:inKeyEquivalentModifier];
                        
                        // target
                        if ( ![item target] ) [item setTarget:CUI_MenuItemTargetObj()];// 20180726
                        
                        // action
                        if ( ![item action] ) [item setAction:@selector(menuItemAction:)];// 20180726
                        
                    } else {        // create item
                        
                        while ( inItemIndex > itemCount ) {
                            [menu addItem:[NSMenuItem separatorItem]];
                            itemCount = [menu numberOfItems];
                        }
                        
                        BOOL separator = ( title == nil || [title isEqualToString:@"-"] );
                        
                        if ( separator ) {
                            item = [NSMenuItem separatorItem];
                        } else {
                            
                            BOOL sectionHeader = NO;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
                            if (@available(macOS 14.0, *)) {
                                if ( inSectionHeader == YES ) {
                                    sectionHeader = YES;
                                }
                            }
#endif// 140000
                            
                            if ( sectionHeader ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
                                if (@available(macOS 14.0, *)) {
                                    item = [NSMenuItem sectionHeaderWithTitle:title];
                                }
#endif// 140000
                            } else {
                                item = [[NSMenuItem alloc] initWithTitle:title action:@selector(menuItemAction:) keyEquivalent:keyEquivalent];
                                
                                // key equivalent modifier
                                if ( inKeyEquivalentModifier != kFBParamMissing ) [item setKeyEquivalentModifierMask:inKeyEquivalentModifier];
                                
                                // enabled
                                if ( inEnabled != kFBParamMissing ) [item setEnabled:(BOOL)inEnabled];
                                
                                // target
                                [item setTarget:CUI_MenuItemTargetObj()];
                            }
                            
                        }
                        [menu insertItem:item atIndex:inItemIndex];
                    }
                    
                }
                
            } else {
                
                if ( inItemIndex >= 0 ) return;    // we're creating a new menu here, so item index must be negative
                
                if ( !title ) title = @"";
                
                NSMenu *menu = [[NSMenu alloc] initWithTitle:title];
                
                if ( otherMenuFlag ) {
                    [menu setTag:inMenuIndex];
                    CUI_OtherMenuAdd( menu );
                } else {
                    
                    CUI_MenuPadItemsToIndex( mainMenu, inMenuIndex );// fill unused items
                    NSMenuItem *menuItem = [mainMenu insertItemWithTitle:title action:nil keyEquivalent:@"" atIndex:inMenuIndex];
                    [mainMenu setSubmenu:menu forItem:menuItem];
                }
                
                [menu setAutoenablesItems:NO];
            }
            
        }
    }
}

#endif// attributed title (menu item only)

#pragma mark - filemenu
void CUI_FileMenu( NSInteger inMenuIndex )
{
    // make sure we have at least a minimal menu
    if ( ![NSApp mainMenu] ) CUI_BuildMinimalMenu();
    
    NSMenu *mainMenu = [NSApp mainMenu];
    if ( mainMenu ) {
        
        NSInteger itemCount = [mainMenu numberOfItems];
        if ( inMenuIndex < itemCount ) {
            
            
        } else {
            // fill unused items
            CUI_MenuPadItemsToIndex( mainMenu, inMenuIndex );
            
            NSMenuItem *menuItem = [mainMenu addItemWithTitle:@"File" action:nil keyEquivalent:@""];
            NSMenu *menu = [[NSMenu alloc] initWithTitle:@"File"];
            [mainMenu setSubmenu:menu forItem:menuItem];
            [menu setAutoenablesItems:NO];
            
            NSMenuItem *item;
            
            item = [menu addItemWithTitle:@"New" action:@selector(menuItemAction:) keyEquivalent:@"n"];
            [item setTarget:CUI_MenuItemTargetObj()];
            
            item = [menu addItemWithTitle:@"Open…" action:@selector(menuItemAction:) keyEquivalent:@"o"];
            [item setTarget:CUI_MenuItemTargetObj()];
            
            [menu addItem:[NSMenuItem separatorItem]];
            
            [menu addItemWithTitle:@"Close" action:@selector(performClose:) keyEquivalent:@"w"];
            
            item = [menu addItemWithTitle:@"Close All" action:@selector(performClose:) keyEquivalent:@"W"];
            [item setAlternate:YES];
            
            item = [menu addItemWithTitle:@"Save" action:@selector(performClose:) keyEquivalent:@"s"];
            [item setTarget:CUI_MenuItemTargetObj()];
            
            item = [menu addItemWithTitle:@"Save As…" action:@selector(performClose:) keyEquivalent:@"S"];
            [item setTarget:CUI_MenuItemTargetObj()];
        }
    }
}


#pragma mark - editmenu
void CUI_EditMenu( NSInteger inMenuIndex )
{
    // make sure we have at least a minimal menu
    if ( ![NSApp mainMenu] ) CUI_BuildMinimalMenu();
    
    // get the main menu
    NSMenu *mainMenu = [NSApp mainMenu];
    if ( mainMenu ) {
        NSInteger itemCount = [mainMenu numberOfItems];
        if ( inMenuIndex < itemCount ) {
            
            
        } else {
            CUI_MenuPadItemsToIndex( mainMenu, inMenuIndex );// fill unused items
            
            NSMenuItem *editMenuItem = [mainMenu addItemWithTitle:@"Edit" action:nil keyEquivalent:@""];
            
            NSMenu *mEdit = [[NSMenu alloc] initWithTitle:@"Edit"];
            [mainMenu setSubmenu:mEdit forItem:editMenuItem];
            
            //            [mEdit addItemWithTitle:@"Undo" action:@selector(undo:) keyEquivalent:@"z"];
            //            [mEdit addItemWithTitle:@"Redo" action:@selector(redo:) keyEquivalent:@"Z"];
            [mEdit addItemWithTitle:@"Undo" action:NSSelectorFromString(@"undo:") keyEquivalent:@"z"];// silence Xcode warning 20230719
            [mEdit addItemWithTitle:@"Redo" action:NSSelectorFromString(@"redo:") keyEquivalent:@"Z"];// silence Xcode warning 20230719
            
            [mEdit addItem:[NSMenuItem separatorItem]];
            [mEdit addItemWithTitle:@"Cut" action:@selector(cut:) keyEquivalent:@"x"];
            [mEdit addItemWithTitle:@"Copy" action:@selector(copy:) keyEquivalent:@"c"];
            [mEdit addItemWithTitle:@"Paste" action:@selector(paste:) keyEquivalent:@"v"];
            [mEdit addItemWithTitle:@"Delete" action:@selector(delete:) keyEquivalent:@""];
            [mEdit addItemWithTitle:@"Select All" action:@selector(selectAll:) keyEquivalent:@"a"];
            
        }
    }
}


#pragma mark - findmenu
void CUI_FindMenu( NSInteger inMenuIndex )
{
    // make sure we have at least a minimal menu
    if ( ![NSApp mainMenu] ) CUI_BuildMinimalMenu();
    
    NSMenu *mainMenu = [NSApp mainMenu];
    
    BOOL otherMenuFlag = ( inMenuIndex > 100 ); // non-menubar menu or hierarchical menu
    
    NSInteger mainMenuItemCount = [mainMenu numberOfItems];
    NSInteger itemCount = 0;
    NSMenu *menu = nil;
    NSMenuItem *menuItem = nil;
    
    if ( otherMenuFlag ) {           // other menu
        menu = CUI_OtherMenuAtIndex( inMenuIndex );
    } else {                         // menu bar menu
        itemCount = mainMenuItemCount;
        if ( inMenuIndex < itemCount ) {
            menuItem = [mainMenu itemAtIndex:inMenuIndex];
            menu = [menuItem submenu];
        }
    }
    
    if ( !menu ) {
        menu = [[NSMenu alloc] initWithTitle:@"Find"];
        if ( otherMenuFlag ) {
            [menu setTag:inMenuIndex];
            CUI_OtherMenuAdd( menu );
        } else {
            mainMenu = [NSApp mainMenu];
            CUI_MenuPadItemsToIndex( mainMenu, inMenuIndex );// fill unused items
            menuItem = [mainMenu insertItemWithTitle:@"Find" action:nil keyEquivalent:@"" atIndex:inMenuIndex];
            [mainMenu setSubmenu:menu forItem:menuItem];
        }
        NSMenuItem *item;
        
        item = [menu addItemWithTitle:@"Find…" action:@selector(performFindPanelAction:) keyEquivalent:@"f"];
        [item setTag:NSTextFinderActionShowFindInterface];
        item = [menu addItemWithTitle:@"Find and Replace…" action:@selector(performFindPanelAction:) keyEquivalent:@"f"];
        [item setKeyEquivalentModifierMask:NSCommandKeyMask + NSAlternateKeyMask];
        [item setTag:NSTextFinderActionShowReplaceInterface];
        item = [menu addItemWithTitle:@"Find Next" action:@selector(performFindPanelAction:) keyEquivalent:@"g"];
        [item setTag:NSTextFinderActionNextMatch];
        item = [menu addItemWithTitle:@"Find Previous" action:@selector(performFindPanelAction:) keyEquivalent:@"G"];
        [item setTag:NSTextFinderActionPreviousMatch];
    }
}


#pragma mark - fontmenu
void CUI_FontMenu( NSInteger inMenuIndex )
{
    // make sure we have at least a minimal menu
    if ( ![NSApp mainMenu] ) CUI_BuildMinimalMenu();
    
    NSMenu *mainMenu = [NSApp mainMenu];
    
    BOOL otherMenuFlag = ( inMenuIndex > 100 ); // non-menubar menu or hierarchical menu
    
    NSInteger mainMenuItemCount = [mainMenu numberOfItems];
    NSInteger itemCount = 0;
    NSMenu *menu = nil;
    NSMenuItem *menuItem = nil;
    
    if ( otherMenuFlag ) {           // other menu
        menu = CUI_OtherMenuAtIndex( inMenuIndex );
    } else {                         // menu bar menu
        itemCount = mainMenuItemCount;
        if ( inMenuIndex < itemCount ) {
            menuItem = [mainMenu itemAtIndex:inMenuIndex];
            menu = [menuItem submenu];
        }
    }
    
    if ( !menu ) {
        menu = [[NSFontManager sharedFontManager] fontMenu:YES];
        if ( otherMenuFlag ) {
            [menu setTag:inMenuIndex];
            CUI_OtherMenuAdd( menu );
        } else {
            NSMenu *mainMenu = [NSApp mainMenu];
            CUI_MenuPadItemsToIndex( mainMenu, inMenuIndex );// fill unused items
            NSMenuItem *menuItem = [mainMenu insertItemWithTitle:@"Font" action:nil keyEquivalent:@"" atIndex:inMenuIndex];
            [mainMenu setSubmenu:menu forItem:menuItem];
        }
    }
}


#pragma mark - formatmenu
void CUI_FormatMenu( NSInteger inMenuIndex )
{
    // make sure we have at least a minimal menu
    if ( ![NSApp mainMenu] ) CUI_BuildMinimalMenu();
    
    NSMenu *mainMenu = [NSApp mainMenu];
    
    BOOL otherMenuFlag = ( inMenuIndex > 100 ); // non-menubar menu or hierarchical menu
    
    NSInteger mainMenuItemCount = [mainMenu numberOfItems];
    NSInteger itemCount = 0;
    NSMenu *formatMenu = nil;
    NSMenuItem *formatMenuItem = nil;
    
    if ( otherMenuFlag ) {           // other menu
        formatMenu = CUI_OtherMenuAtIndex( inMenuIndex );
    } else {                         // menu bar menu
        itemCount = mainMenuItemCount;
        if ( inMenuIndex < itemCount ) {
            formatMenuItem = [mainMenu itemAtIndex:inMenuIndex];
            formatMenu = [formatMenuItem submenu];
        }
    }
    
    if ( !formatMenu ) {
        NSMenu *formatMenu = [[NSMenu alloc] initWithTitle:@"Format"];
        if ( otherMenuFlag ) {
            [formatMenu setTag:inMenuIndex];
            CUI_OtherMenuAdd( formatMenu );
        } else {
            NSMenu *mainMenu = [NSApp mainMenu];
            CUI_MenuPadItemsToIndex( mainMenu, inMenuIndex );// fill unused items
            NSMenuItem *formatMenuItem = [mainMenu insertItemWithTitle:@"Format" action:nil keyEquivalent:@"" atIndex:inMenuIndex];
            [mainMenu setSubmenu:formatMenu forItem:formatMenuItem];
        }
        
        // Font menu
        NSMenuItem *fontMenuItem = [formatMenu addItemWithTitle:@"Font" action:nil keyEquivalent:@""];
        NSMenu *fontMenu = [[NSFontManager sharedFontManager] fontMenu:YES];
        [formatMenu setSubmenu:fontMenu forItem:fontMenuItem];
        
        
        // Text menu
        NSMenuItem *item;
        
        NSMenuItem *textMenuItem = [formatMenu addItemWithTitle:@"Text" action:nil keyEquivalent:@""];
        NSMenu *textMenu = [[NSMenu alloc] initWithTitle:@"Text"];
        [formatMenu setSubmenu:textMenu forItem:textMenuItem];
        
        // align
        [textMenu addItemWithTitle:@"Align Left" action:@selector(alignLeft:) keyEquivalent:@"{"];
        [textMenu addItemWithTitle:@"Align Center" action:@selector(alignCenter:) keyEquivalent:@"|"];
        [textMenu addItemWithTitle:@"Justify" action:@selector(alignJustified:) keyEquivalent:@""];
        [textMenu addItemWithTitle:@"Align Right" action:@selector(alignRight:) keyEquivalent:@"}"];
        
        [textMenu addItem:[NSMenuItem separatorItem]];
        
        // writing direction
        NSMenuItem *writingDirectionMenuItem = [textMenu addItemWithTitle:@"Writing Direction" action:nil keyEquivalent:@""];
        NSMenu *writingDirectionMenu = [[NSMenu alloc] initWithTitle:@"Writing Direction"];
        [textMenu setSubmenu:writingDirectionMenu forItem:writingDirectionMenuItem];
        
        [writingDirectionMenu addItemWithTitle:@"Paragraph" action:nil keyEquivalent:@"{"];
        item = [writingDirectionMenu addItemWithTitle:@"Default" action:@selector(makeBaseWritingDirectionNatural:) keyEquivalent:@""];
        [item setIndentationLevel:2];
        
        item = [writingDirectionMenu addItemWithTitle:@"Left to Right" action:@selector(makeBaseWritingDirectionLeftToRight:) keyEquivalent:@""];
        [item setIndentationLevel:2];
        
        item = [writingDirectionMenu addItemWithTitle:@"Right to Left" action:@selector(makeBaseWritingDirectionRightToLeft:) keyEquivalent:@""];
        [item setIndentationLevel:2];
        
        [writingDirectionMenu addItem:[NSMenuItem separatorItem]];
        
        [writingDirectionMenu addItemWithTitle:@"Selection" action:nil keyEquivalent:@"{"];
        item = [writingDirectionMenu addItemWithTitle:@"Default" action:@selector(makeTextWritingDirectionNatural:) keyEquivalent:@""];
        [item setIndentationLevel:2];
        
        item = [writingDirectionMenu addItemWithTitle:@"Left to Right" action:@selector(makeTextWritingDirectionLeftToRight:) keyEquivalent:@""];
        [item setIndentationLevel:2];
        
        item = [writingDirectionMenu addItemWithTitle:@"Right to Left" action:@selector(makeTextWritingDirectionRightToLeft:) keyEquivalent:@""];
        [item setIndentationLevel:2];
        
        [textMenu addItem:[NSMenuItem separatorItem]];
        
        // ruler
        [textMenu addItemWithTitle:@"Show Ruler" action:@selector(toggleRuler:) keyEquivalent:@""];
        item = [textMenu addItemWithTitle:@"Copy Ruler" action:@selector(copyRuler:) keyEquivalent:@"c"];
        [item setKeyEquivalentModifierMask:NSCommandKeyMask + NSControlKeyMask];
        item = [textMenu addItemWithTitle:@"Paste Ruler" action:@selector(pasteRuler:) keyEquivalent:@"v"];
        [item setKeyEquivalentModifierMask:NSCommandKeyMask + NSControlKeyMask];
    }
}

#pragma mark - palettemenu
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
void CUI_PaletteMenu( NSInteger inMenuIndex, CFArrayRef inColors, CFArrayRef inTitles, NSImage *inImage, NSInteger inSelectionMode )
{
    if ( ![NSApp mainMenu] ) CUI_BuildMinimalMenu();// make sure we have at least a minimal menu
    
    if ( inMenuIndex > 100 ) {// must be submenu
        NSArray *colors = (__bridge NSArray*)inColors;
        NSArray *titles = (__bridge NSArray*)inTitles;
        NSMenu *menu = CUI_OtherMenuAtIndex( inMenuIndex );
        if ( !menu ) {
            
            menu = [NSMenu paletteMenuWithColors:colors titles:titles templateImage:inImage selectionHandler:^(NSMenu * _Nonnull m __attribute__ ((__unused__))) {
                //NSLog(@"selectionHandler");
            }];
            
            // tag
            [menu setTag:inMenuIndex];
            
            // selection mode
            if ( inSelectionMode != kFBParamMissing ) {
                [menu setSelectionMode:inSelectionMode];
            }
            
            // target & action
            for ( NSMenuItem *item in [menu itemArray] ) {
                if ( ![item target] ) [item setTarget:CUI_MenuItemTargetObj()];
                if ( ![item action] ) [item setAction:@selector(menuItemAction:)];
            }
            
            CUI_OtherMenuAdd( menu );
        }
    }
}
#endif// 140000


#pragma mark - textmenu
void CUI_TextMenu( NSInteger inMenuIndex )
{
    // make sure we have at least a minimal menu
    if ( ![NSApp mainMenu] ) CUI_BuildMinimalMenu();
    
    NSMenu *mainMenu = [NSApp mainMenu];
    
    BOOL otherMenuFlag = ( inMenuIndex > 100 ); // non-menubar menu or hierarchical menu
    
    NSInteger mainMenuItemCount = [mainMenu numberOfItems];
    NSInteger itemCount = 0;
    NSMenu *menu = nil;
    NSMenuItem *menuItem = nil;
    
    if ( otherMenuFlag ) {           // other menu
        menu = CUI_OtherMenuAtIndex( inMenuIndex );
    } else {                         // menu bar menu
        itemCount = mainMenuItemCount;
        if ( inMenuIndex < itemCount ) {
            menuItem = [mainMenu itemAtIndex:inMenuIndex];
            menu = [menuItem submenu];
        }
    }
    
    if ( !menu ) {
        NSMenu *menu = [[NSMenu alloc] initWithTitle:@"Text"];
        if ( otherMenuFlag ) {
            [menu setTag:inMenuIndex];
            CUI_OtherMenuAdd( menu );
        } else {
            NSMenu *mainMenu = [NSApp mainMenu];
            CUI_MenuPadItemsToIndex( mainMenu, inMenuIndex );// fill unused items
            NSMenuItem *menuItem = [mainMenu insertItemWithTitle:@"Text" action:nil keyEquivalent:@"" atIndex:inMenuIndex];
            [mainMenu setSubmenu:menu forItem:menuItem];
        }
        
        NSMenuItem *item;
        
        // align
        [menu addItemWithTitle:@"Align Left" action:@selector(alignLeft:) keyEquivalent:@"{"];
        [menu addItemWithTitle:@"Align Center" action:@selector(alignCenter:) keyEquivalent:@"|"];
        [menu addItemWithTitle:@"Justify" action:@selector(alignJustified:) keyEquivalent:@""];
        [menu addItemWithTitle:@"Align Right" action:@selector(alignRight:) keyEquivalent:@"}"];
        
        [menu addItem:[NSMenuItem separatorItem]];
        
        // writing direction
        NSMenuItem *writingDirectionMenuItem = [menu addItemWithTitle:@"Writing Direction" action:nil keyEquivalent:@""];
        NSMenu *writingDirectionMenu = [[NSMenu alloc] initWithTitle:@"Writing Direction"];
        [menu setSubmenu:writingDirectionMenu forItem:writingDirectionMenuItem];
        
        [writingDirectionMenu addItemWithTitle:@"Paragraph" action:nil keyEquivalent:@"{"];
        item = [writingDirectionMenu addItemWithTitle:@"Default" action:@selector(makeBaseWritingDirectionNatural:) keyEquivalent:@""];
        [item setIndentationLevel:2];
        
        item = [writingDirectionMenu addItemWithTitle:@"Left to Right" action:@selector(makeBaseWritingDirectionLeftToRight:) keyEquivalent:@""];
        [item setIndentationLevel:2];
        
        item = [writingDirectionMenu addItemWithTitle:@"Right to Left" action:@selector(makeBaseWritingDirectionRightToLeft:) keyEquivalent:@""];
        [item setIndentationLevel:2];
        
        [writingDirectionMenu addItem:[NSMenuItem separatorItem]];
        
        [writingDirectionMenu addItemWithTitle:@"Selection" action:nil keyEquivalent:@"{"];
        item = [writingDirectionMenu addItemWithTitle:@"Default" action:@selector(makeTextWritingDirectionNatural:) keyEquivalent:@""];
        [item setIndentationLevel:2];
        
        item = [writingDirectionMenu addItemWithTitle:@"Left to Right" action:@selector(makeTextWritingDirectionLeftToRight:) keyEquivalent:@""];
        [item setIndentationLevel:2];
        
        item = [writingDirectionMenu addItemWithTitle:@"Right to Left" action:@selector(makeTextWritingDirectionRightToLeft:) keyEquivalent:@""];
        [item setIndentationLevel:2];
        
        [menu addItem:[NSMenuItem separatorItem]];
        
        // ruler
        [menu addItemWithTitle:@"Show Ruler" action:@selector(toggleRuler:) keyEquivalent:@""];
        item = [menu addItemWithTitle:@"Copy Ruler" action:@selector(copyRuler:) keyEquivalent:@"c"];
        [item setKeyEquivalentModifierMask:NSCommandKeyMask + NSControlKeyMask];
        item = [menu addItemWithTitle:@"Paste Ruler" action:@selector(pasteRuler:) keyEquivalent:@"v"];
        [item setKeyEquivalentModifierMask:NSCommandKeyMask + NSControlKeyMask];
    }
}


#pragma mark - viewmenu
void CUI_ViewMenu( NSInteger inMenuIndex )
{
    // make sure we have at least a minimal menu
    if ( ![NSApp mainMenu] ) CUI_BuildMinimalMenu();
    
    NSMenu *mainMenu = [NSApp mainMenu];
    
    BOOL otherMenuFlag = ( inMenuIndex > 100 ); // non-menubar menu or hierarchical menu
    
    NSInteger mainMenuItemCount = [mainMenu numberOfItems];
    NSInteger itemCount = 0;
    NSMenu *menu = nil;
    NSMenuItem *menuItem = nil;
    
    if ( otherMenuFlag ) {           // other menu
        menu = CUI_OtherMenuAtIndex( inMenuIndex );
    } else {                         // menu bar menu
        itemCount = mainMenuItemCount;
        if ( inMenuIndex < itemCount ) {
            menuItem = [mainMenu itemAtIndex:inMenuIndex];
            menu = [menuItem submenu];
        }
    }
    
    if ( !menu ) {
        NSMenu *menu = [[NSMenu alloc] initWithTitle:@"View"];
        if ( otherMenuFlag ) {
            [menu setTag:inMenuIndex];
            CUI_OtherMenuAdd( menu );
        } else {
            NSMenu *mainMenu = [NSApp mainMenu];
            CUI_MenuPadItemsToIndex( mainMenu, inMenuIndex );// fill unused items
            NSMenuItem *menuItem = [mainMenu insertItemWithTitle:@"View" action:nil keyEquivalent:@"" atIndex:inMenuIndex];
            [mainMenu setSubmenu:menu forItem:menuItem];
        }
        
        NSMenuItem *item;
        
        [menu addItem:[NSMenuItem separatorItem]];
        
        item = [menu addItemWithTitle:@"Show Toolbar" action:@selector(toggleToolbarShown:) keyEquivalent:@"t"];
        [item setKeyEquivalentModifierMask:NSCommandKeyMask + NSAlternateKeyMask];
        
        [menu addItemWithTitle:@"Customize Toolbar…" action:@selector(runToolbarCustomizationPalette:) keyEquivalent:@""];
        
        [menu addItem:[NSMenuItem separatorItem]];// 20220808
        item = [menu addItemWithTitle:@"Show Sidebar" action:@selector(toggleSidebar:) keyEquivalent:@"s"];// 20220808
        [item setKeyEquivalentModifierMask:NSCommandKeyMask + NSControlKeyMask];// 20220808
        
    }
}

#pragma mark - windowmenu
void CUI_WindowMenu( NSInteger inMenuIndex )
{
    // make sure we have at least a minimal menu
    if ( ![NSApp mainMenu] ) CUI_BuildMinimalMenu();
    
    NSMenu *mainMenu = [NSApp mainMenu];
    if ( mainMenu ) {
        NSInteger itemCount = [mainMenu numberOfItems];
        if ( inMenuIndex < itemCount ) {
            
            
        } else {
            // fill unused items
            CUI_MenuPadItemsToIndex( mainMenu, inMenuIndex );
            
            NSMenuItem *windowMenuItem = [mainMenu addItemWithTitle:@"Window" action:nil keyEquivalent:@""];
            NSMenu *windowMenu = [[NSMenu alloc] initWithTitle:@"Window"];
            [mainMenu setSubmenu:windowMenu forItem:windowMenuItem];
            [windowMenu addItemWithTitle:@"Minimize" action:@selector(performMiniaturize:) keyEquivalent:@"m"];
            [NSApp setWindowsMenu:windowMenu];
        }
    }
}

#pragma mark - helpmenu
void CUI_HelpMenu( NSInteger inMenuIndex )
{
    // make sure we have at least a minimal menu
    if ( ![NSApp mainMenu] ) CUI_BuildMinimalMenu();
    
    // get the main menu
    NSMenu *mainMenu = [NSApp mainMenu];
    if ( mainMenu ) {
        NSInteger itemCount = [mainMenu numberOfItems];
        if ( inMenuIndex < itemCount ) {
            
            
        } else {
            CUI_MenuPadItemsToIndex( mainMenu, inMenuIndex );// fill unused items
            
            NSMenuItem *helpMenuItem = [mainMenu addItemWithTitle:@"Help" action:nil keyEquivalent:@""];
            NSMenu *mHelp = [[NSMenu alloc] initWithTitle:@"Help"];
            [mainMenu setSubmenu:mHelp forItem:helpMenuItem];
            
            NSString *name = [[NSBundle mainBundle] objectForInfoDictionaryKey:(__bridge NSString *)kCFBundleNameKey];
            [mHelp addItemWithTitle:[NSString stringWithFormat:@"%@ Help",name] action:@selector(showHelp:) keyEquivalent:@"?"];
        }
    }
}


#pragma mark - nibmenu
void CUI_NibMenuSetup( NSMenu *menu )
{
    NSMenu *supermenu = [menu supermenu];
    if ( supermenu ) {
        NSInteger index = [supermenu indexOfItemWithSubmenu:menu];
        NSMenuItem *submenuItem = [supermenu itemAtIndex:index];
        NSInteger tag = [submenuItem tag];
        if ( tag > 100 ) {
            [menu setTag:tag];
            CUI_OtherMenuAdd( menu );
        }
    }
    
    NSArray *items = [menu itemArray];
    for ( NSMenuItem *item in items ) {
        if ( ![item action] ) {
            [item setTarget:CUI_MenuItemTargetObj()];
            [item setAction:@selector(menuItemAction:)];
        }
        NSMenu *submenu = [item submenu];
        if ( submenu ) CUI_NibMenuSetup( submenu );
    }
}

void CUI_NibMenuFixAppNameItems( NSMenu *mainMenu )
{
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    NSMenuItem *item;
    
    // fix app menu items
    NSMenuItem *appMenuItem = [mainMenu itemAtIndex:0];
    if ( appMenuItem ) {
        NSMenu *appMenu = [appMenuItem submenu];
        if ( appMenu ) {
            item = [appMenu itemWithTitle:@"About NewApplication"];
            if ( item ) {
                [item setTitle:[NSString stringWithFormat:@"About %@",appName]];
            }
            
            item = [appMenu itemWithTitle:@"Hide NewApplication"];
            if ( item ) {
                [item setTitle:[NSString stringWithFormat:@"Hide %@",appName]];
            }
            
            item = [appMenu itemWithTitle:@"Quit NewApplication"];
            if ( item ) {
                [item setTitle:[NSString stringWithFormat:@"Quit %@",appName]];
            }
        }
    }
    
    // fix help menu items
    NSMenuItem *helpMenuItem = [mainMenu itemWithTitle:@"Help"];
    if ( helpMenuItem ) {
        NSMenu *helpMenu = [helpMenuItem submenu];
        if ( helpMenu ) {
            item = [helpMenu itemWithTitle:@"NewApplication Help"];
            if ( item ) {
                [item setTitle:[NSString stringWithFormat:@"%@ Help",appName]];
            }
        }
    }
}

void CUI_NibMenu( CFStringRef inNibName )
{
    NSString *nibName = (__bridge NSString *)inNibName;
    
    CUI_NibObject *nibObj = CUI_NibObjectWithName( nibName );
    if ( !nibObj ) {
        NSNib *nib = [[NSNib alloc] initWithNibNamed:nibName bundle:nil];
        if ( nib ) {
            NSArray *objects = nil;
            [nib instantiateWithOwner:nil topLevelObjects:&objects];
            CUI_NibObjectAdd( objectTypeNib, nibName, objects, nil );
            CUI_NibMenuFixAppNameItems( [NSApp mainMenu] );
            CUI_NibMenuSetup( [NSApp mainMenu] );
        }
    }
}


#pragma mark - menu events
// all menu stuff moved to here from AppThings.c - 20211004

CUI_OnMenuFunctionType CUI_OnMenuFunction( void )
{ return sCUI_OnMenuFunction; }

void CUI_SetOnMenuFunction( CUI_OnMenuFunctionType onMenuFn )
{ sCUI_OnMenuFunction = onMenuFn; }

#if 1// user on menu fn with obj param // 20240225
void CallUserDefinedOnMenuFunction( long menuIndex, long itemIndex, NSMenu *m )
{
    CUI_OnMenuFunctionType onMenuFn = CUI_OnMenuFunction();
    if ( onMenuFn ) {
        (*onMenuFn)( menuIndex, itemIndex, (__bridge CFTypeRef)m );
    }
}
#else
void CallUserDefinedOnMenuFunction( long menuIndex, long itemIndex )
{
    CUI_OnMenuFunctionType onMenuFn = CUI_OnMenuFunction();
    if ( onMenuFn ) {
        (*onMenuFn)( menuIndex, itemIndex );
    }
}
#endif
