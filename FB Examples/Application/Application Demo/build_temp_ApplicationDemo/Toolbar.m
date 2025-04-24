/*
 Toolbar.m

 Bernie Wylde
 */

#import "Toolbar.h"

@implementation ToolbarSC
@end

@implementation CUI_ToolbarItemTarget
- (void)toolbarItemAction:(id)sender {
    CUI_EventSetEvent( [NSApp currentEvent] );// 20240723
    CUI_OutputWindowSetTag( AppKeyWindow() );// 20171216
    CallUserDefinedOnDialogFunction( toolbarItemClick, [sender tag], CUI_OutputWindowTag(), (__bridge CFTypeRef)sender );
}

- (BOOL)validateToolbarItem:(NSToolbarItem *)item {
    CUI_OutputWindowSetTag( AppKeyWindow() );
    //DialogEventSetBool( [item isEnabled] );
    DialogEventSetBool( YES );// 20230712
    CallUserDefinedOnDialogFunction( toolbarItemValidate, [item tag], CUI_OutputWindowTag(), (__bridge CFTypeRef)item );
    return DialogEventBool();
}

//- (BOOL)validateToolbarItem:(NSToolbarItem *)item {
//    return [item isEnabled];
//}
@end

// private
CUI_ToolbarItemTarget *CUI_ToolbarItemTargetObj( void )
{
    static CUI_ToolbarItemTarget *sCUI_ToolbarItemTarget = nil;
    if ( !sCUI_ToolbarItemTarget ) sCUI_ToolbarItemTarget = [[CUI_ToolbarItemTarget alloc] init];
    return sCUI_ToolbarItemTarget;
}


@implementation CUI_ToolbarDelegate

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar {
    NSInteger tag = [[toolbar identifier] integerValue];
    CUI_ToolbarObj *obj = CUI_ToolbarObjWithTag( tag );
    if ( obj ) {
        return [obj allowedIdentifiers];
    }
    return nil;
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
    NSInteger tag = [[toolbar identifier] integerValue];
    CUI_ToolbarObj *obj = CUI_ToolbarObjWithTag( tag );
    if ( obj ) {
        return [obj defaultIdentifiers];
    }
    return nil;
}

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
    NSToolbarItem *item = [[NSToolbarItem alloc] initWithItemIdentifier:itemIdentifier];
    NSInteger tag = [[toolbar identifier] integerValue];
    CUI_ToolbarObj *obj = CUI_ToolbarObjWithTag( tag );
    if ( obj ) {
        NSDictionary *itemDict = [[obj items] objectForKey:itemIdentifier];
        if ( itemDict ) {
            
            NSInteger itemTag = [[itemDict objectForKey:@"Tag"] integerValue];
            NSString *label = [itemDict objectForKey:@"Label"];
            NSImage *image = [itemDict objectForKey:@"Image"];
            
            [item setTag:itemTag];
            if ( label ) [item setLabel:label];
            
            if ( image ) [item setImage:image];
            
            // target
            [item setTarget:CUI_ToolbarItemTargetObj()];
            
            // action
            [item setAction:@selector(toolbarItemAction:)];
        }
    }
    return item;
}

- (NSArray*)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar {
    NSInteger tag = [[toolbar identifier] integerValue];
    CUI_ToolbarObj *obj = CUI_ToolbarObjWithTag( tag );
    if ( obj ) {
        return [obj selectableIdentifiers];
    }
    return nil;
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000

- (NSSet *)toolbarImmovableItemIdentifiers:(NSToolbar *)toolbar API_AVAILABLE(macos(13.0)) {
    NSInteger tag = [[toolbar identifier] integerValue];
    CUI_ToolbarObj *obj = CUI_ToolbarObjWithTag( tag );
    if ( obj ) {
        return [obj immovableIdentifiers];
    }
    return nil;
}

- (void)toolbarWillAddItem:(NSNotification *)notification API_AVAILABLE(macos(13.0)) {// 20230712
    NSToolbarItem *item = notification.userInfo[@"item"];
    if ( !NSStringFromSelector([item action]) ) {
        [item setTarget:CUI_ToolbarItemTargetObj()];
        [item setAction:@selector(toolbarItemAction:)];
    }
}

//- (BOOL)toolbar:(NSToolbar *)toolbar itemIdentifier:(NSToolbarItemIdentifier)itemIdentifier canBeInsertedAtIndex:(NSInteger)index {
//    return YES;
//}

#endif// 130000

@end

CUI_ToolbarDelegate *CUI_ToolbarDelegateObj( void )
{
    static CUI_ToolbarDelegate *sCUI_ToolbarDelegate = nil;
    if ( !sCUI_ToolbarDelegate ) sCUI_ToolbarDelegate = [[CUI_ToolbarDelegate alloc] init];
    return sCUI_ToolbarDelegate;
}

static NSMutableArray *sCUI_Toolbars;

@implementation CUI_ToolbarObj

- (id)initWithToolbar:(NSToolbar *)tb {
    if ( (self = [super init]) ) {
        self.toolbar = tb;
        self.items = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.allowedIdentifiers = [[NSMutableArray alloc] initWithCapacity:0];
        self.defaultIdentifiers = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.toolbar dealloc];
    [self.items dealloc];
    [self.allowedIdentifiers dealloc];
    [self.defaultIdentifiers dealloc];
    [self.selectableIdentifiers dealloc];
    [super dealloc];
}
#endif
@end

CUI_ToolbarObj *CUI_ToolbarObjWithTag( NSInteger tag )
{
    if ( sCUI_Toolbars ) {
        NSString *identifier = [NSString stringWithFormat:@"%ld",(long)tag];
        for ( CUI_ToolbarObj *obj in sCUI_Toolbars ) {
            NSToolbar *toolbar = [obj toolbar];
            if ( [[toolbar identifier] isEqualToString:identifier] ) return obj;
        }
    }
    return nil;
}

void CUI_ToolbarObjAdd( NSToolbar *tb )
{
    if ( !sCUI_Toolbars ) sCUI_Toolbars = [[NSMutableArray alloc] initWithCapacity:0];
    CUI_ToolbarObj *obj = [[CUI_ToolbarObj alloc] initWithToolbar:tb];
    [sCUI_Toolbars addObject:obj];
    //[obj release];
}

void CUI_ToolbarObjAddItem( CUI_ToolbarObj *obj, NSString *identifier, NSInteger tag, NSString *label, NSImage *image, BOOL allowed, BOOL dflt )
{
    NSDictionary *itemDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:tag], @"Tag", label, @"Label", image, @"Image", nil];
    [[obj items] setObject:itemDict forKey:identifier];
    if ( allowed ) [[obj allowedIdentifiers] addObject:identifier];
    if ( dflt ) [[obj defaultIdentifiers] addObject:identifier];
}

void CUI_ToolbarObjAddSelectableItem( CUI_ToolbarObj *obj, NSString *identifier )
{
    if ( !obj.selectableIdentifiers ) obj.selectableIdentifiers = [[NSMutableArray alloc] initWithCapacity:0];
    if ( ![obj.selectableIdentifiers containsObject:identifier] ) {
        [obj.selectableIdentifiers addObject:identifier];
    }
}

NSInteger CUI_ToolbarTag( NSToolbar *tb )
{
    if ( sCUI_Toolbars ) {
        for ( CUI_ToolbarObj *obj in sCUI_Toolbars ) {
            NSToolbar *toolbar = [obj toolbar];
            if ( toolbar == tb ) {
                return [[toolbar identifier] integerValue];
            }
        }
    }
    return 0;
}

NSInteger CUI_ToolbarLastTag( void )
{
    if ( sCUI_Toolbars ) {
        CUI_ToolbarObj *obj = [sCUI_Toolbars lastObject];
        if ( obj ) {
            return [[[obj toolbar] identifier] integerValue];
        }
    }
    return 0;
}

NSToolbar *CUI_ToolbarWithTag( NSInteger tag )
{
    if ( tag ) {
        if ( tag > 1000000 ) {
            //return (NSToolbar *)tag;// it's a NSToolbar *
            return (__bridge NSToolbar *)(void *)tag;
        }
        CUI_ToolbarObj *obj = CUI_ToolbarObjWithTag( tag );
        if ( obj ) return [obj toolbar];
    }
    return nil;
}

// Class
Class ToolbarClass( void )
{ return [NSToolbar class]; }

NSToolbar *ToolbarWithTag( NSInteger tag )
{ return CUI_ToolbarWithTag( tag ); }

BOOL ToolbarExists( NSInteger tag )
{ return ( CUI_ToolbarWithTag( tag ) != nil ); }


//void ToolbarInsertItem( NSInteger toolbarTag, NSInteger itemTag, CFStringRef inIdentifier, CFStringRef inLabel, CFStringRef inImageName, BOOL allowed, BOOL dflt )
//{
//    CUI_ToolbarObj *obj = CUI_ToolbarObjWithTag( toolbarTag );
//    if ( obj ) {
//        NSToolbar *toolbar = [obj toolbar];
//        if ( toolbar ) {
//            if ( inIdentifier ) {
//                NSString *identifier = (__bridge NSString *)inIdentifier;
//                NSString *label = (__bridge NSString *)inLabel;
//                NSString *imageName = (__bridge NSString *)inImageName;
//
//                [toolbar insertItemWithItemIdentifier:identifier atIndex:0];
//
//                CUI_ToolbarObjAddItem( obj, identifier, itemTag, label, imageName, allowed, dflt );
//            }
//        }
//    }
//}


// Attributes
CFStringRef ToolbarIdentifier( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return (__bridge CFStringRef)[toolbar identifier];
    return nil;
}

NSToolbarDisplayMode ToolbarDisplayMode( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return [toolbar displayMode];
    return 0;
}

void ToolbarSetDisplayMode( NSInteger tag, NSToolbarDisplayMode mode )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) [toolbar setDisplayMode:mode];
}

BOOL ToolbarShowsBaselineSeparator( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return [toolbar showsBaselineSeparator];
    return NO;
}

void ToolbarSetShowsBaselineSeparator( NSInteger tag, BOOL flag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) [toolbar setShowsBaselineSeparator:flag];
}

BOOL ToolbarAllowsUserCustomization( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return [toolbar allowsUserCustomization];
    return NO;
}

void ToolbarSetAllowsUserCustomization( NSInteger tag, BOOL flag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) [toolbar setAllowsUserCustomization:flag];
}

BOOL ToolbarAllowsExtensionItems( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return [toolbar allowsExtensionItems];
    return NO;
}

void ToolbarSetAllowsExtensionItems( NSInteger tag, BOOL flag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) [toolbar setAllowsExtensionItems:flag];
}

CFArrayRef ToolbarItems( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    return (__bridge CFArrayRef)[toolbar items];
    return nil;
}

CFArrayRef ToolbarVisibleItems( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    return (__bridge CFArrayRef)[toolbar visibleItems];
    return nil;
}

NSToolbarSizeMode ToolbarSizeMode( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return [toolbar sizeMode];
    return 0;
}

void ToolbarSetSizeMode( NSInteger tag, NSToolbarSizeMode size )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) {
        [toolbar setSizeMode:size];
    }
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
BOOL ToolbarAllowsDisplayModeCustomization( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return [toolbar allowsDisplayModeCustomization];
    return NO;
}

void ToolbarSetAllowsDisplayModeCustomization( NSInteger tag, BOOL flag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) [toolbar setAllowsDisplayModeCustomization:flag];
}
#endif // 150000

// Managing items
CFStringRef ToolbarSelectedItemIdentifier( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) {
        return (__bridge CFStringRef)[toolbar selectedItemIdentifier];
    }
    return nil;
}

void ToolbarSetSelectedItemIdentifier( NSInteger tag, CFStringRef itemIdentifier )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) {
        [toolbar setSelectedItemIdentifier:(__bridge NSString *)itemIdentifier];
    }
}

NSToolbarItem *ToolbarSelectedItem( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) {
        NSString *identifier = [toolbar selectedItemIdentifier];
        if ( identifier ) {
            NSArray *items = [toolbar items];
            for ( NSToolbarItem *item in items ) {
                if ( [[item itemIdentifier] isEqualToString:identifier] ) return item;
            }
        }
    }
    return nil;
}

NSInteger ToolbarSelectedItemTag( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) {
        NSString *identifier = [toolbar selectedItemIdentifier];
        if ( identifier ) {
            NSArray *items = [toolbar items];
            for ( NSToolbarItem *item in items ) {
                if ( [[item itemIdentifier] isEqualToString:identifier] ) return [item tag];
            }
        }
    }
    return 0;
}

void ToolbarSetSelectedItem( NSInteger tag, NSInteger itemTag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) {
        NSToolbarItem *item = ToolbarItemWithTag( tag, itemTag );
        [toolbar setSelectedItemIdentifier:[item itemIdentifier]];
    }
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
CFStringRef ToolbarCenteredItemIdentifier( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return (__bridge CFStringRef)[toolbar centeredItemIdentifier];
    return nil;
}
#endif// 101400

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
CFSetRef ToolbarCenteredItemIdentifiers( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return (__bridge CFSetRef)[toolbar centeredItemIdentifiers];
    return nil;
}

void ToolbarSetCenteredItemIdentifiers( NSInteger tag, CFSetRef identifiers )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) [toolbar setCenteredItemIdentifiers:(__bridge NSSet *)identifiers];
}
#endif// 130000

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
CFArrayRef ToolbarItemIdentifiers( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return (__bridge CFArrayRef)[toolbar itemIdentifiers];
    return nil;
}

void ToolbarSetItemIdentifiers( NSInteger tag, CFArrayRef identifiers )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) [toolbar setItemIdentifiers:(__bridge NSArray *)identifiers];
}
#endif // 150000

// Display
BOOL ToolbarIsVisible( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return [toolbar isVisible];
    return NO;
}

void ToolbarSetVisible( NSInteger tag, BOOL flag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) [toolbar setVisible:flag];
}

// Customization
void ToolbarRunCustomizationPalette( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) [toolbar runCustomizationPalette:nil];
}

BOOL ToolbarCustomizationPaletteIsRunning( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return [toolbar customizationPaletteIsRunning];
    return NO;
}

// Autosaving
BOOL ToolbarAutosavesConfiguration( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return [toolbar autosavesConfiguration];
    return NO;
}

void ToolbarSetAutosavesConfiguration( NSInteger tag, BOOL flag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) [toolbar setAutosavesConfiguration:flag];
}

CFDictionaryRef ToolbarConfigurationDictionary( NSInteger tag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) return (__bridge CFDictionaryRef)[toolbar configurationDictionary];
    return nil;
}

void ToolbarSetConfigurationFromDictionary( NSInteger tag, CFDictionaryRef dict )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) [toolbar setConfigurationFromDictionary:(__bridge NSDictionary *)dict];
}

// Custom
void ToolbarSetSelectableItemIdentifiers( NSInteger tag, CFTypeRef identifiers )
{
    CUI_ToolbarObj *obj = CUI_ToolbarObjWithTag( tag );
    if ( obj ) {
        NSArray *array = nil;
        if ( [(__bridge id)identifiers isKindOfClass:[NSArray class]] ) {
            array = (__bridge NSArray *)identifiers;
        } else if ( [(__bridge id)identifiers isKindOfClass:[NSString class]] ) {
            array = [(__bridge id)identifiers componentsSeparatedByString:@";"];
        }
        
        if ( array ) {
            obj.selectableIdentifiers = [[NSMutableArray alloc] initWithCapacity:0];
            [obj.selectableIdentifiers addObjectsFromArray:array];
        }
    }
}

// Hide/show tooltips
void ToolbarSetToolTipsHidden( NSInteger tag, BOOL flag )
{
    NSToolbar *toolbar = CUI_ToolbarWithTag( tag );
    if ( toolbar ) {
        NSArray *items = [toolbar items];
        for ( NSToolbarItem *item in items ) {
            NSString *toolTip = [item toolTip];
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
}


// Init
NSToolbar *ToolbarInit( NSInteger inTag )
{
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    NSString *identifier = [NSString stringWithFormat:@"%ld",(long)inTag];

    NSToolbar *toolbar;
#if __has_feature(objc_arc)
    if ( subclass ) {
        toolbar = [[ToolbarSC alloc] initWithIdentifier:identifier];
    } else {
        toolbar = [[NSToolbar alloc] initWithIdentifier:identifier];
    }
#else
    if ( subclass ) {
        toolbar = [[[ToolbarSC alloc] initWithIdentifier:identifier] autorelease];
    } else {
        toolbar = [[[NSToolbar alloc] initWithIdentifier:identifier] autorelease];
    }
#endif
    
    // delegate
    [toolbar setDelegate:CUI_ToolbarDelegateObj()];
    
    // add to toolbars array
    CUI_ToolbarObjAdd( toolbar );
    
    return toolbar;
}


// Statement
void CUI_Toolbar( NSInteger inTag )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    NSToolbar *toolbar = CUI_ToolbarWithTag( inTag );
    if ( toolbar ) {    // exists
        // clear subclass flag
        CUI_SetSubclassFlag(NO);
    } else {        // create
        toolbar = ToolbarInit( inTag );
    }
    [toolbar setVisible:show];
}

