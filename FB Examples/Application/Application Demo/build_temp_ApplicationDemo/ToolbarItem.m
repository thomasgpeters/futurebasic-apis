/*
 ToolbarItem.m

 Bernie Wylde
 */

#import "ToolbarItem.h"

@implementation ToolbarItemSC
@end

// Class
Class ToolbarItemClass( void )
{ return [NSToolbarItem class]; }

NSToolbarItem *ToolbarItemWithTag( NSInteger toolbarTag, NSInteger itemTag )
{
    if ( itemTag > 1000000 ) {
        //return (NSToolbarItem *)itemTag;// it's a NSToolbarItem *
        return (__bridge NSToolbarItem *)(void *)itemTag;
    }
    
    NSToolbar *toolbar = CUI_ToolbarWithTag( toolbarTag );
    if ( toolbar ) {
        NSArray *items = [toolbar items];
        for ( NSToolbarItem *item in items ) {
            if ( [item tag] == itemTag ) {
                return item;
            }
        }
    }
    return nil;
}

//BOOL ToolbarItemExists( NSInteger toolbarTag, NSInteger itemTag )
//{
//    NSToolbar *toolbar = CUI_ToolbarWithTag( toolbarTag );
//    if ( toolbar ) {
//        NSArray *items = [toolbar items];
//        for ( NSToolbarItem *item in items ) {
//            if ( [item tag] == itemTag ) {
//                return YES;
//            }
//        }
//    }
//    return NO;
//}


// Attributes
CFStringRef ToolbarItemIdentifier( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return (__bridge CFStringRef)[item itemIdentifier];
    return nil;
}

CFStringRef ToolbarItemLabel( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return (__bridge CFStringRef)[item label];
    return nil;
}

void ToolbarItemSetLabel( NSInteger toolbarTag, NSInteger itemTag, CFStringRef label )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setLabel:(__bridge NSString *)label];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
CFStringRef ToolbarItemTitle( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return (__bridge CFStringRef)[item title];
    return nil;
}

void ToolbarItemSetTitle( NSInteger toolbarTag, NSInteger itemTag, CFStringRef title )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setTitle:(__bridge NSString *)title];
}
#endif// 101500

CFStringRef ToolbarItemPaletteLabel( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return (__bridge CFStringRef)[item paletteLabel];
    return nil;
}

void ToolbarItemSetPaletteLabel( NSInteger toolbarTag, NSInteger itemTag, CFStringRef label )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setPaletteLabel:(__bridge NSString *)label];
}

CFStringRef ToolbarItemToolTip( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return (__bridge CFStringRef)[item toolTip];
    return nil;
}

void ToolbarItemSetToolTip( NSInteger toolbarTag, NSInteger itemTag, CFStringRef toolTip )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setToolTip:(__bridge NSString *)toolTip];
}

NSMenuItem *ToolbarItemMenuFormRepresentation( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return [item menuFormRepresentation];
    return nil;
}

void ToolbarItemSetMenuFormRepresentation( NSInteger toolbarTag, NSInteger itemTag, NSMenuItem *menuItem )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setMenuFormRepresentation:menuItem];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
CFSetRef ToolbarItemPossibleLabels( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return (__bridge CFSetRef)[item possibleLabels];
    return nil;
}

void ToolbarItemSetPossibleLabels( NSInteger toolbarTag, NSInteger itemTag, CFSetRef labels )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setPossibleLabels:(__bridge NSSet *)labels];
}
#endif// 130000

BOOL ToolbarItemIsEnabled( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return [item isEnabled];
    return NO;
}

void ToolbarItemSetEnabled( NSInteger toolbarTag, NSInteger itemTag, BOOL flag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setEnabled:flag];
}

NSImage *ToolbarItemImage( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return [item image];
    return nil;
}

void ToolbarItemSetImage( NSInteger toolbarTag, NSInteger itemTag, NSImage *image )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setImage:image];
}

NSView *ToolbarItemView( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return [item view];
    return nil;
}

void ToolbarItemSetView( NSInteger toolbarTag, NSInteger itemTag, NSInteger vwTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) {
        NSView *view = CUI_ViewWithTag( vwTag );
        if ( view ) [item setView:view];
    }
}

CGSize ToolbarItemMinSize( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) NSSizeToCGSize([item minSize]);
    return CGSizeZero;
}

void ToolbarItemSetMinSize( NSInteger toolbarTag, NSInteger itemTag, CGSize size )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setMinSize:NSSizeFromCGSize( size )];
}

CGSize ToolbarItemMaxSize( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) NSSizeToCGSize([item maxSize]);
    return CGSizeZero;
}

void ToolbarItemSetMaxSize( NSInteger toolbarTag, NSInteger itemTag, CGSize size )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setMaxSize:NSSizeFromCGSize( size )];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
BOOL ToolbarItemIsBordered( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return [item isBordered];
    return NO;
}
void ToolbarItemSetBordered( NSInteger toolbarTag, NSInteger itemTag, BOOL flag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setBordered:flag];
}
#endif// 101500

// VisibilityPriority
NSInteger ToolbarItemVisibilityPriority( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return [item visibilityPriority];
    return 0;
}

void ToolbarItemSetVisibilityPriority( NSInteger toolbarTag, NSInteger itemTag, NSInteger priority )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setVisibilityPriority:priority];
}

// Validation
void ToolbarItemValidate( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item validate];
}

BOOL ToolbarItemAutovalidates( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return [item autovalidates];
    return NO;
}

void ToolbarItemSetAutovalidates( NSInteger toolbarTag, NSInteger itemTag, BOOL flag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setAutovalidates:flag];
}

// Duplicates
BOOL ToolbarItemAllowsDuplicatesInToolbar( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return [item allowsDuplicatesInToolbar];
    return NO;
}

// Configuration
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
BOOL ToolbarItemIsVisible( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return [item isVisible];
    return NO;
}
#endif// 130000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
BOOL ToolbarItemIsHidden( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return [item isHidden];
    return NO;
}

void ToolbarItemSetHidden( NSInteger toolbarTag, NSInteger itemTag, BOOL flag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setHidden:flag];
}
#endif // 150000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
BOOL ToolbarItemIsNavigational( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) return [item isNavigational];
    return NO;
}

void ToolbarItemSetNavigational( NSInteger toolbarTag, NSInteger itemTag, BOOL flag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) [item setNavigational:flag];
}
#endif// 110000

// Custom
void ToolbarItemSetSelectable( NSInteger toolbarTag, NSInteger itemTag )
{
    NSToolbarItem *item = ToolbarItemWithTag( toolbarTag, itemTag );
    if ( item ) {
        CUI_ToolbarObj *obj = CUI_ToolbarObjWithTag( toolbarTag );
        if ( obj ) {
            CUI_ToolbarObjAddSelectableItem( obj, [item itemIdentifier] );
        }
    }
}


// Init
//NSToolbarItem *ToolbarItemInit( NSInteger inTags, CFStringRef inIdentifier )
//{
//    // subclass
//    BOOL subclass = CUI_IsSubclassFlag();
//
//    // init
//    NSToolbarItem *item;
//    if ( subclass ) {
//        item = [[[ToolbarItemSC alloc] init] autorelease];
//    } else {
//        item = [[[NSToolbarItem alloc] init] autorelease];
//    }
//    
//    return item;
//}


// Statement
void CUI_ToolbarItem( NSInteger inTag, CFStringRef inIdentifier, CFStringRef inLabel, void *inImage, NSInteger inAllowed, NSInteger inDefault, NSInteger inToolbarTag )
{
    // get target toolbar
    if ( inToolbarTag == 0 ) inToolbarTag = CUI_ToolbarLastTag();
    
    if ( inToolbarTag ) {
        CUI_ToolbarObj *obj = CUI_ToolbarObjWithTag( inToolbarTag );
        if ( obj ) {
            // subclass
            CUI_IsSubclassFlag();// clear the subclass flag

            NSToolbar *toolbar = [obj toolbar];
            
            NSString *identifier = (__bridge NSString *)inIdentifier;
            if ( !identifier ) {
                identifier = [NSString stringWithFormat:@"%ld",inTag];// 20221020
            }

            NSString *label = (__bridge NSString *)inLabel;
            
            // imageName, imagePath, CGImage, NSImage, symbolName
            NSImage *image = CUI_FixImageValue( inImage );
            
            BOOL allowed = YES;
            BOOL dflt = YES;
            if ( inAllowed != kFBParamMissing ) allowed = (BOOL)inAllowed;
            if ( inDefault != kFBParamMissing ) dflt = (BOOL)inDefault;
            
            // insert item
            [toolbar insertItemWithItemIdentifier:identifier atIndex:0];
            
            CUI_ToolbarObjAddItem( obj, identifier, inTag, label, image, allowed, dflt );
        }
    } else {
        // show warning - can't find toolbar
    }
}

