/*
 Nib.m

 Bernie Wylde
 */

#import "Nib.h"

#pragma mark - nibs
static NSMutableArray *sCUI_NibObjects;

@implementation CUI_NibObject
- (id)initWithType:(NSInteger)type name:(NSString *)name objects:(NSArray *)tlObjects controller:(id)controller {
    if ( (self = [super init]) ) {
        self.fileType = type;// 20200219
#if __has_feature(objc_arc)
        self.nibName = name;
        self.topLevelObjects = tlObjects;
        self.initialController = controller;
#else
        self.nibName = [name retain];// 20190401
        self.topLevelObjects = [tlObjects retain];// 20190401
        self.initialController = [controller retain];// 20200219
#endif
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.nibName release];
    [self.topLevelObjects release];
    [self.initialController release];
    [super dealloc];
}
#endif

@end

CUI_NibObject *CUI_NibObjectWithName( NSString *name )
{
    if ( sCUI_NibObjects ) {
        for ( CUI_NibObject *nibObj in sCUI_NibObjects ) {
            if ( [[nibObj nibName] isEqualToString:name] ) return nibObj;
        }
    }
    return nil;
}

void CUI_NibObjectAdd( NSInteger type, NSString *name, NSArray *objects, id controller )
{
    CUI_NibObject *nibObj = CUI_NibObjectWithName( name );
    if ( !nibObj ) {
        nibObj = [[CUI_NibObject alloc] initWithType:type name:name objects:objects controller:controller ];
        if ( !sCUI_NibObjects ) sCUI_NibObjects = [[NSMutableArray alloc] initWithCapacity:0];
        [sCUI_NibObjects addObject:nibObj];
#if !__has_feature(objc_arc)
        [nibObj release];
#endif
    }
}

void CUI_NibObjectRemove( NSString *name )
{
    CUI_NibObject *nibObj = CUI_NibObjectWithName( name );
    if ( nibObj ) {
        [sCUI_NibObjects removeObject:nibObj];
    }
}

NSArray *CUI_NibObjects( NSString *name )
{
    CUI_NibObject *nibObj = CUI_NibObjectWithName( name );
    if ( nibObj ) return [nibObj topLevelObjects];
    return nil;
}

#pragma mark - nibviewsetup
void CUI_ProcessViewMenu( NSMenu *menu )// 20200630
{
    NSInteger menuIndex = [[menu identifier] integerValue];
    if ( menuIndex ) {
        [menu setTag:menuIndex];
        CUI_OtherMenuAdd( menu );
    }
        
    // ----- 20200629 -----
    NSArray *items = [menu itemArray];
    for ( NSMenuItem *item in items ) {
        if ( [item hasSubmenu] ) {
            CUI_ProcessViewMenu( [item submenu] );
        } else {
            if ( [menu supermenu] || menuIndex > 100 ) {
                [item setTarget:CUI_MenuItemTargetObj()];
                [item setAction:@selector(menuItemAction:)];
            }
        }
    }
    // ----- 20200629 -----
}

void CUI_ProcessMenuForView( NSView *view )// 20200619
{
    NSMenu *menu = [view menu];
    if ( menu ) {
        NSString *identifier = [menu identifier];
        if ( identifier ) {
            NSInteger menuID = [identifier integerValue];
            if ( menuID > 100 ) {
                CUI_ProcessViewMenu( menu );
            }
        }
    }
}

void CUI_NibViewSetup( NSInteger wndTag, NSView *superview )
{
    CUI_ProcessMenuForView( superview );

    NSArray *subviews = [superview subviews];
    for ( id subview in subviews ) {
        // wndTag
        [(NSObject *)subview setWndTag:wndTag];
        
        // get view tag
        NSInteger tag = 0;
        if ( [(NSObject *)subview respondsToSelector:@selector(tag)] ) tag = [(NSView *)subview tag];
        
        if ( tag <= 0 ) {   // try to get tag from identifier
            NSString *identifier = [(NSView *)subview identifier];
            if ( identifier ) {
                if ( [(NSObject *)subview respondsToSelector:@selector(setTag:)] ) {
                    tag = [identifier integerValue];
                    [subview setTag:tag];
                }
            }
        } else {    // we've got the view's tag. now see if the identifier has a value 1-10 for its control actionID
            if ( [(NSObject *)subview isKindOfClass:[NSControl class]] ) {
                NSInteger actionID = [[(NSControl *)subview identifier] integerValue];
                if ( actionID > 0 && actionID <= 10 ) {
                    ControlSetActionID( tag, actionID );
                }
            }
        }
        
//        NSRect r = [subview frame];
//        NSLog(@"%ld,%@,%f,%f,%f,%f",tag,subview,r.origin.x,r.origin.y,r.size.width,r.size.height);

        // contextual menu
        CUI_ProcessMenuForView( subview );
                
        
        if ( [(NSObject *)subview isKindOfClass:NSClassFromString(@"AVPlayerView")] ) {
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:NSClassFromString(@"WKWebView")] ) {
            if ( [(NSObject *)subview isKindOfClass:NSClassFromString(@"WebViewSC")] ) {
                CUI_ShowAlert( NSWarningAlertStyle, @"\"WebViewSC\" is deprecated.", @"Use \"WKWebViewSC\" instead." );
            }
            continue;
        }

        
        
        if ( [(NSObject *)subview isKindOfClass:NSClassFromString(@"SCNView")] ) {// 20221005
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:NSClassFromString(@"MKMapView")] ) {
            if ( [(NSObject *)subview isKindOfClass:NSClassFromString(@"MapViewSC")] ) {
                CUI_ShowAlert( NSWarningAlertStyle, @"\"MapViewSC\" is deprecated.", @"Use \"MKMapViewSC\" instead." );
            }
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSBrowser class]] ) {
            //CUI_BrowserDelegate *browserDelegate = CUI_BrowserDelegateObj();
            //[subview setDelegate:browserDelegate];
            //[(NSBrowser *)subview setTarget:browserDelegate];
           // [subview setDoubleAction:@selector(doubleAction:)];
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSButton class]] ) {
            if ( [(NSButton *)subview action] == 0 ) {
                if ( [(NSButton *)subview target] == nil ) [(NSButton *)subview setTarget:CUI_ControlTargetObj()];
                if ( [(NSButton *)subview action] == 0 ) [(NSButton *)subview setAction:@selector(controlAction:)];
            }
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSCollectionView class]] ) {
            continue;
        }

        if ( [(NSObject *)subview isKindOfClass:[NSColorWell class]] ) {
            if ( [(NSColorWell *)subview action] == 0 ) {
                if ( [(NSColorWell *)subview target] == nil ) [(NSColorWell *)subview setTarget:CUI_ControlTargetObj()];
                if ( [(NSColorWell *)subview action] == 0 ) [(NSColorWell *)subview setAction:@selector(controlAction:)];
            }
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSComboBox class]] ) {
            if ( [(NSComboBox *)subview delegate] == nil ) [(NSComboBox *)subview setDelegate:CUI_ComboBoxDelegateObj()];
            continue;
        }
        
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
        if (@available(macOS 13.0, *)) {
            if ( [(NSObject *)subview isKindOfClass:[NSComboButton class]] ) {
                if ( [(NSComboButton *)subview action] == 0 ) {
                    if ( [(NSComboButton *)subview target] == nil ) [(NSComboButton *)subview setTarget:CUI_ControlTargetObj()];
                    if ( [(NSComboButton *)subview action] == 0 ) [(NSComboButton *)subview setAction:@selector(controlAction:)];
                }
                continue;
            }
        }
#endif// 130000

        if ( [(NSObject *)subview isKindOfClass:[NSDatePicker class]] ) {
            if ( [(NSDatePicker *)subview action] == 0 ) {
                [(NSDatePicker *)subview setTarget:CUI_ControlTargetObj()];
                [(NSDatePicker *)subview setAction:@selector(controlAction:)];
            }
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSLevelIndicator class]] ) {
            if ( [(NSLevelIndicator *)subview target] == nil ) [(NSLevelIndicator *)subview setTarget:CUI_ControlTargetObj()];
            if ( [(NSLevelIndicator *)subview action] == 0 ) [(NSLevelIndicator *)subview setAction:@selector(controlAction:)];
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSOutlineView class]] ) {
            if ( [(NSOutlineView *)subview delegate] == nil || [(NSOutlineView *)subview dataSource] == nil ) {
                BOOL flag = YES;
                NSArray *columns = [(NSOutlineView *)subview tableColumns];
                for ( NSTableColumn *col in columns ) {
                    if ( [col infoForBinding:NSValueBinding] ) {
                        [(NSOutlineView *)subview setDelegate:nil];
                        [(NSOutlineView *)subview setDataSource:nil];
                        flag = NO;
                        break;
                    }
                }
                
                if ( flag ) {
                    CUI_OutlineViewDelegate *delegate = [[CUI_OutlineViewDelegate alloc] init];
                    if ( [(NSOutlineView *)subview delegate] == nil ) {
                        [(NSOutlineView *)subview setDelegate:delegate];
                        [delegate setTable:subview];
                    }
                    if ( [(NSOutlineView *)subview action] == 0 ) {
                        [(NSOutlineView *)subview setTarget:delegate];
                        if ( ![(NSOutlineView *)subview action] ) [(NSOutlineView *)subview setAction:@selector(singleAction:)];
                        [(NSOutlineView *)subview setDoubleAction:@selector(doubleAction:)];
                    }
                    if ( [(NSOutlineView *)subview dataSource] == nil ) [(NSOutlineView *)subview setDataSource:delegate];
                }
                
            }
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSPathControl class]] ) {
            if ( [(NSPathControl *)subview target] == nil ) [(NSPathControl *)subview setTarget:CUI_ControlTargetObj()];
            if ( [(NSPathControl *)subview action] == 0 ) [(NSPathControl *)subview setAction:@selector(controlAction:)];
            if ( [(NSPathControl *)subview delegate] == nil ) [(NSPathControl *)subview setDelegate:CUI_PathControlDelegateObj()];
            continue;
        }

        if ( [(NSObject *)subview isKindOfClass:NSClassFromString(@"PDFView")] ) {
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:NSClassFromString(@"PDFThumbnailView")] ) {
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSPopUpButton class]] ) {
            if ( [(NSPopUpButton *)subview action] == 0 ) {
                if ( [(NSPopUpButton *)subview target] == nil ) [(NSPopUpButton *)subview setTarget:CUI_ControlTargetObj()];
                if ( [(NSPopUpButton *)subview action] == 0 ) [(NSPopUpButton *)subview setAction:@selector(controlAction:)];
            }
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSSearchField class]] ) {
            if ( [(NSSearchField *)subview delegate] == nil ) [(NSSearchField *)subview setDelegate:CUI_SearchFieldDelegateObj()];
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSSecureTextField class]] ) {
            if ( [(NSSecureTextField *)subview delegate] == nil ) [(NSSecureTextField *)subview setDelegate:CUI_TextFieldDelegateObj()];
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSSegmentedControl class]] ) {
            if ( [(NSSegmentedControl *)subview action] == 0 ) {
                if ( [(NSSegmentedControl *)subview target] == nil ) [(NSSegmentedControl *)subview setTarget:CUI_ControlTargetObj()];
                if ( [(NSSegmentedControl *)subview action] == 0 ) [(NSSegmentedControl *)subview setAction:@selector(controlAction:)];
            }
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSSlider class]] ) {
            if ( [(NSSlider *)subview action] == 0 ) {
                if ( [(NSSlider *)subview target] == nil ) [(NSSlider *)subview setTarget:CUI_ControlTargetObj()];
                if ( [(NSSlider *)subview action] == 0 ) [(NSSlider *)subview setAction:@selector(controlAction:)];
            }
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSSplitView class]] ) {
            if ( [(NSSplitView *)subview delegate] == nil ) [(NSSplitView *)subview setDelegate:CUI_SplitViewDelegateObj()];
            //continue;
            goto Done;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSStackView class]] ) {
            if ( [(NSStackView *)subview delegate] == nil ) [(NSStackView *)subview setDelegate:CUI_StackViewDelegateObj()];
            //continue;
            goto Done;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSStepper class]] ) {
            if ( [(NSStepper *)subview action] == 0 ) {
                if ( [(NSStepper *)subview target] == nil ) [(NSStepper *)subview setTarget:CUI_ControlTargetObj()];
                if ( [(NSStepper *)subview action] == 0 ) [(NSStepper *)subview setAction:@selector(controlAction:)];
            }
            continue;
        }
        
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
        if (@available(macOS 10.15, *)) {
            if ( [(NSObject *)subview isKindOfClass:[NSSwitch class]] ) {
                if ( [(NSSwitch *)subview action] == 0 ) {
                    if ( [(NSSwitch *)subview target] == nil ) [(NSSwitch *)subview setTarget:CUI_ControlTargetObj()];
                    if ( [(NSSwitch *)subview action] == 0 ) [(NSSwitch *)subview setAction:@selector(controlAction:)];
                }
                continue;
            }
        }
#endif
        
        if ( [(NSObject *)subview isKindOfClass:[NSTableView class]] ) {
            if ( [(NSTableView *)subview delegate] == nil || [(NSTableView *)subview dataSource] == nil ) {
                CUI_TableViewDelegate *delegate = [[CUI_TableViewDelegate alloc] init];
                if ( [(NSTableView *)subview delegate] == nil ) {
                    [(NSTableView *)subview setDelegate:delegate];
                    [delegate setTable:subview];
                }
                if ( [(NSTableView *)subview action] == 0 ) {
                    [(NSTableView *)subview setTarget:delegate];
                    if ( ![(NSTableView *)subview action] ) [(NSTableView *)subview setAction:@selector(singleAction:)];
                    [(NSTableView *)subview setDoubleAction:@selector(doubleAction:)];
                }
                if ( [(NSTableView *)subview dataSource] == nil ) [(NSTableView *)subview setDataSource:delegate];
            }
            
            // if identifier has not been set, use header title// 20210129
            if ( [subview headerView] ) {
                for ( NSTableColumn *column in [subview tableColumns] ) {
                    NSString *title = [column title];
                    if ( [title length] ) {
                        if ( [[column identifier] hasPrefix:@"AutomaticTableColumnIdentifier"] ) {
                            [column setIdentifier:title];
                        }
                    }
                }
            }
            
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSTabView class]] ) {
            if ( [(NSTabView *)subview delegate] == nil ) [(NSTabView *)subview setDelegate:CUI_TabViewDelegateObj()];
            // special handling for tab view items
            for ( NSTabViewItem *item in [(NSTabView *)subview tabViewItems] ) {
                CUI_NibViewSetup( wndTag, [item view] );
            }
            goto Done;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSTextField class]] ) {
            if ( [(NSTextField *)subview isEditable] ) {
                [(NSTextField *)subview setDelegate:CUI_TextFieldDelegateObj()];
                [subview setTarget:CUI_TextFieldDelegateObj()];// 20230710
                [subview setAction:@selector(textFieldAction:)];// 20230710
                [[subview cell] setSendsActionOnEndEditing:YES];// 20230710
            }
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSTextView class]] ) {
            if ( [(NSTextView *)subview isEditable] ) [(NSTextView *)subview setDelegate:CUI_TextViewDelegateObj()];
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSTokenField class]] ) {
            if ( [(NSTokenField *)subview delegate] == nil ) [(NSTokenField *)subview setDelegate:CUI_TokenFieldDelegateObj()];
            continue;
        }
        
        if ( [(NSObject *)subview isKindOfClass:[NSView class]] ) {
            goto Done;  // container view - check subviews
        }
        
    Done:
        CUI_NibViewSetup( wndTag, subview );
    }
}


void CUI_NibWindowToolbarItemSetup( __attribute__ ((unused)) NSInteger wndTag, NSToolbar *toolbar )
{
    NSArray *toolbarItems = [toolbar items];
    for ( NSToolbarItem *item in toolbarItems ) {
        id view = [item view];
        if ( view ) {
            // tag
            NSInteger viewTag = 0;
            if ( [(NSObject *)view respondsToSelector:@selector(tag)] ) viewTag = [view tag];
            
            if ( viewTag <= 0 ) {   // try to get tag from identifier
                NSString *identifier = [(NSView *)view identifier];
                if ( identifier ) {
                    if ( [(NSObject *)view respondsToSelector:@selector(setTag:)] ) {
                        viewTag = [identifier integerValue];
                        [view setTag:viewTag];
                    }
                }
            }
            
            // button
            if ( [(NSObject *)view isKindOfClass:[NSButton class]] ) {
                if ( [(NSButton *)view action] == 0 ) {
                    [item setTarget:CUI_ToolbarItemTargetObj()];
                    [item setAction:@selector(toolbarItemAction:)];
                }
                continue;
            }
            
            // colorwell
            if ( [(NSObject *)view isKindOfClass:[NSColorWell class]] ) {
                if ( [(NSColorWell *)view action] == 0 ) {
                    [item setTarget:CUI_ToolbarItemTargetObj()];
                    [item setAction:@selector(toolbarItemAction:)];
                }
                continue;
            }
            
            // combobox
            if ( [(NSObject *)view isKindOfClass:[NSComboBox class]] ) {
                if ( [(NSComboBox *)view delegate] == nil ) [(NSComboBox *)view setDelegate:CUI_ComboBoxDelegateObj()];
                continue;
            }
            
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 130000
        if (@available(macOS 13.0, *)) {
            if ( [(NSObject *)view isKindOfClass:[NSComboButton class]] ) {
                if ( [(NSComboButton *)view action] == 0 ) {
                    [item setTarget:CUI_ToolbarItemTargetObj()];
                    [item setAction:@selector(toolbarItemAction:)];
                }
                continue;
            }
        }
#endif// 130000

            // datepicker
            if ( [(NSObject *)view isKindOfClass:[NSDatePicker class]] ) {
                if ( [(NSDatePicker *)view action] == 0 ) {
                    [item setTarget:CUI_ToolbarItemTargetObj()];
                    [item setAction:@selector(toolbarItemAction:)];
                }
                continue;
            }
            
            // levelindicator
            if ( [(NSObject *)view isKindOfClass:[NSLevelIndicator class]] ) {
                [item setTarget:CUI_ToolbarItemTargetObj()];
                [item setAction:@selector(toolbarItemAction:)];
                continue;
            }
            
            if ( [(NSObject *)view isKindOfClass:[NSPopUpButton class]] ) {
                if ( [(NSPopUpButton *)view action] == 0 ) {
                    [item setTarget:CUI_ToolbarItemTargetObj()];
                    [item setAction:@selector(toolbarItemAction:)];
                }
                continue;
            }
            
            // pathcontrol
            if ( [(NSObject *)view isKindOfClass:[NSPathControl class]] ) {
                if ( [(NSPathControl *)view action] == 0 ) {
                    [item setTarget:CUI_ToolbarItemTargetObj()];
                    [item setAction:@selector(toolbarItemAction:)];
                }
                if ( [(NSPathControl *)view delegate] == nil ) [(NSPathControl *)view setDelegate:CUI_PathControlDelegateObj()];
                continue;
            }

            // searchfield
            if ( [(NSObject *)view isKindOfClass:[NSSearchField class]] ) {
                if ( [(NSSearchField *)view delegate] == nil ) [(NSSearchField *)view setDelegate:CUI_SearchFieldDelegateObj()];
                continue;
            }
            
            // securetextfield
            if ( [(NSObject *)view isKindOfClass:[NSSecureTextField class]] ) {
                if ( [(NSSecureTextField *)view delegate] == nil ) [(NSSecureTextField *)view setDelegate:CUI_TextFieldDelegateObj()];
                continue;
            }
            
            // segmentedcontrol
            if ( [(NSObject *)view isKindOfClass:[NSSegmentedControl class]] ) {
                if ( [(NSSegmentedControl *)view action] == 0 ) {
                    [item setTarget:CUI_ToolbarItemTargetObj()];
                    [item setAction:@selector(toolbarItemAction:)];
                }
                continue;
            }
            
            // slider
            if ( [(NSObject *)view isKindOfClass:[NSSlider class]] ) {
                if ( [(NSSlider *)view action] == 0 ) {
                    [item setTarget:CUI_ToolbarItemTargetObj()];
                    [item setAction:@selector(toolbarItemAction:)];
                }
                continue;
            }
            
            // stepper
            if ( [(NSObject *)view isKindOfClass:[NSStepper class]] ) {
                if ( [(NSStepper *)view action] == 0 ) {
                    [item setTarget:CUI_ToolbarItemTargetObj()];
                    [item setAction:@selector(toolbarItemAction:)];
                }
                continue;
            }
            
            // textfield
            if ( [(NSObject *)view isKindOfClass:[NSTextField class]] ) {
                if ( [(NSTextField *)view isEditable] ) [(NSTextField *)view setDelegate:CUI_TextFieldDelegateObj()];
                continue;
            }
            
            // tokenfield
            if ( [(NSObject *)view isKindOfClass:[NSTokenField class]] ) {
                if ( [(NSTokenField *)view delegate] == nil ) [(NSTokenField *)view setDelegate:CUI_TokenFieldDelegateObj()];
                continue;
            }
            
        } else {
            
            if ( [item tag] > 0 ) {
                [item setTarget:CUI_ToolbarItemTargetObj()];// 20210126
                [item setAction:@selector(toolbarItemAction:)];// 20210126
            }
        }
    }
}

void CUI_NibWindowToolbarSetup( NSInteger wndTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        NSToolbar *toolbar = [w toolbar];
        if ( toolbar ) {
            [toolbar setDelegate:CUI_ToolbarDelegateObj()];// 20230712
            CUI_ToolbarObjAdd( toolbar );
            CUI_NibWindowToolbarItemSetup( wndTag, toolbar );
        }
    }
}


void CUI_WindowConfigureViews( NSInteger tag, NSWindow *w )
{
    // create content view subclass for intercepting content view drawRect: method to issue dialog viewDrawRect event.
    // copy views to new content view
    NSView *contentView = [w contentView];
    NSArray *subviews = [[contentView subviews] copy];
    ContentViewSC *newContentView = [[ContentViewSC alloc] initWithFrame:[[w contentView] frame]];
    if ( [contentView menu] ) [newContentView setMenu:[contentView menu]];// 20240820
    [newContentView setSubviews:subviews];
    [w setContentView:newContentView];
    
    [newContentView setIdentifier:[NSString stringWithFormat:@"%d",windowContentViewTag]];
#if !__has_feature(objc_arc)
    [subviews release];
#endif
    
    // tag
    [w setTag:tag];
    
    // window delegate
    [w setDelegate:CUI_WindowDelegateObj()];
    
    // add window to app delegate
    CUI_AppDelegateAddWindow( w );
    
    // set subview actions, targets, etc.
    CUI_NibViewSetup( tag, [w contentView] );
    
    // set toolbar and custom items
    CUI_NibWindowToolbarSetup( tag );
    
    // focus first editable view
    CUI_WindowMakeFirstTextViewResponder( w );    
}

id CUI_WindowFromNibObjects( NSInteger tag, NSString *nibName, NSString *wndIdentifier )
{
    NSWindow *w = nil;
    
    CUI_NibObject *nibObj = CUI_NibObjectWithName( nibName );
    if ( nibObj ) {
        
        switch ( [nibObj fileType] ) {
            case objectTypeStoryboard:
            {
                NSWindowController *controller = [nibObj initialController];
                w = [controller window];
                if ( w ) {
                    if ( [w tag] ) return w;
                    CUI_WindowConfigureViews( tag, w );
                }
            }

            case objectTypeNib:
            default:
            {
                NSArray *objects = [nibObj topLevelObjects];
                for ( id obj in objects ) {
                    w = nil;
                    if ( [(NSObject *)obj isKindOfClass:[NSWindow class]] || [(NSObject *)obj isKindOfClass:[NSPanel class]] ) {
                        if ( wndIdentifier ) {
                            if ( class_respondsToSelector( [(NSObject *)obj class], NSSelectorFromString( @"identifier" ) ) ) {
                                if ( [obj identifier] != nil ) {
                                    if ( [(NSString *)[obj identifier] isEqualToString:(NSString *)wndIdentifier] ) {
                                        w = obj;
                                    }
                                }
                            }
                        } else {
                            w = obj;
                        }
                        
                        if ( w ) {
                            if ( [obj tag] ) return w;
                            CUI_WindowConfigureViews( tag, w );
                            break;
                        }
                    }
                }
                
            }
        }
    }
    return w;
}


void CUI_ViewFromNibObjects( NSInteger tag, NSString *nibName, NSString *viewIdentifier, NSPoint origin, NSView *superview )
{
    BOOL show = ( tag > 0 );
    tag = ABS(tag);
    
    NSView *view = nil;
    
    CUI_NibObject *nibObj = CUI_NibObjectWithName( nibName );
    if ( nibObj ) {
        switch ( [nibObj fileType] ) {
            case objectTypeStoryboard:
            {
                
            }
                
            case objectTypeNib:
            default:
            {
                NSArray *objects = [nibObj topLevelObjects];
                
                for ( id obj in objects ) {
                    view = nil;
                    
                    if ( [(NSObject *)obj class] == [NSView class] || [(NSObject *)obj class] == [ViewSC class] ) {
                        if ( viewIdentifier ) {
                            if ( class_respondsToSelector( [(NSObject *)obj class], NSSelectorFromString( @"identifier" ) ) ) {
                                if ( [obj identifier] != nil ) {
                                    if ( [(NSString *)[obj identifier] isEqualToString:viewIdentifier] ) {
                                        view = obj;
                                    }
                                }
                            }
                        } else {
                            view = obj;
                        }
                        
                        if ( view ) {
                            CUI_ProcessMenuForView( view );
                            
                            // origin
                            if ( origin.x != 0.0 || origin.y != 0.0 ) [view setFrameOrigin:origin];
                            [superview addSubview:view];
                            
                            // tag
                            if ( tag ) {
                                [view setIdentifier:[NSString stringWithFormat:@"%ld",(long)tag]];
                            }
                            
                            // set subviews action, target, etc.
                            CUI_NibViewSetup( [[superview window] tag], view );
                            
                            break;
                        }
                    }
                }
            }
        }
        
        if ( view ) {
            [view setHidden:!show];
        }
    }
}


NSView *CUI_ViewFromNibObjects2( NSInteger tag, NSString *nibName, NSString *viewIdentifier )
{
    NSView *view = nil;
    CUI_NibObject *nibObj = CUI_NibObjectWithName( nibName );
    if ( nibObj ) {
        switch ( [nibObj fileType] ) {
            case objectTypeStoryboard: {
                
            }
            case objectTypeNib:
            default: {
                NSArray *objects = [nibObj topLevelObjects];
                for ( id obj in objects ) {
                    view = nil;
                    if ( [(NSObject *)obj class] == [NSView class] || [(NSObject *)obj class] == [ViewSC class] ) {
                        if ( viewIdentifier ) {
                            if ( class_respondsToSelector( [(NSObject *)obj class], NSSelectorFromString( @"identifier" ) ) ) {
                                if ( [obj identifier] != nil ) {
                                    if ( [(NSString *)[obj identifier] isEqualToString:viewIdentifier] ) {
                                        view = obj;
                                    }
                                }
                            }
                        } else {
                            view = obj;
                        }
                        
                        if ( view ) {
                            CUI_ProcessMenuForView( view );

                            // tag
                            if ( tag ) {
                                [view setIdentifier:[NSString stringWithFormat:@"%ld",(long)tag]];
                            }
                            
                            // set subviews action, target, etc.
                            CUI_NibViewSetup( 0, view );
                            
                            break;
                        }
                    }
                }
            }
        }
    }
    return view;
}

void CUI_NibView( NSInteger inTag, CFStringRef inNibName, CFStringRef inViewIdentifier, CGPoint inOrigin, NSInteger inSuperviewTag )
{
    //inTag = ABS(inTag);
    
    NSPoint origin = NSPointFromCGPoint( inOrigin );
    NSView *superview = nil;
    
    NSInteger dummyTag = kFBParamMissing;
    id w = CUI_TargetWindow( &dummyTag );
    if ( w ) {
        superview = CUI_TargetContentView( w );
        if ( inSuperviewTag ) {
            superview = CUI_ViewSubviewWithTag( superview, inSuperviewTag );
        }
    }
    
    if ( superview ) {
        NSString *nibName = (__bridge NSString *)inNibName;
        NSString *viewIdentifier = (__bridge NSString *)inViewIdentifier;
        CUI_NibObject *nibObj = CUI_NibObjectWithName( nibName );
        if ( !nibObj ) {
            NSNib *nib = [[NSNib alloc] initWithNibNamed:nibName bundle:nil];
            if ( nib ) {
                NSArray *objects = nil;                
                [nib instantiateWithOwner:nil topLevelObjects:&objects];
                CUI_NibObjectAdd( objectTypeNib, nibName, objects, nil );
            }
        }
        CUI_ViewFromNibObjects( inTag, nibName, viewIdentifier, origin, superview );
    }
}

id CUI_NibViewFunction( NSInteger inTag, CFStringRef inNibName, CFStringRef inViewIdentifier )
{
    NSString *nibName = (__bridge NSString *)inNibName;
    NSString *viewIdentifier = (__bridge NSString *)inViewIdentifier;
    CUI_NibObject *nibObj = CUI_NibObjectWithName( nibName );
    if ( !nibObj ) {
        NSNib *nib = [[NSNib alloc] initWithNibNamed:nibName bundle:nil];
        if ( nib ) {
            NSArray *objects = nil;
            [nib instantiateWithOwner:nil topLevelObjects:&objects];
            CUI_NibObjectAdd( objectTypeNib, nibName, objects, nil );
        }
    }
    return CUI_ViewFromNibObjects2( inTag, nibName, viewIdentifier );
}



#pragma mark - nibpopover
void CUI_PopoverFromNibObjects( NSInteger tag, NSString *nibName )
{
    CUI_NibObject *nibObj = CUI_NibObjectWithName( nibName );
    if ( nibObj ) {
        switch ( [nibObj fileType] ) {
            case objectTypeStoryboard:
            {
                
            }
                
            case objectTypeNib:
            default:
            {
                NSArray *objects = [nibObj topLevelObjects];
                
                for ( id obj in objects ) {
                    if ( [(NSObject *)obj isKindOfClass:[NSPopover class]] ) {
                        
                        // tag
                        if ( tag ) [obj setTag:tag];
                        
                        // add popover
                        CUI_PopoverAdd( obj, tag );
                        
                        // set subviews action, target, etc.
                        NSView *view = [[(NSPopover *)obj contentViewController] view];
                        CUI_NibViewSetup( tag, view );
                        
                        break;
                    }
                }
            }
        }
        
        CUI_OutputWindowSetTag( tag );// 20220721
    }
}

void CUI_NibPopover( NSInteger inTag, CFStringRef inNibName )
{
    inTag = ABS(inTag);
    
    if ( CUI_ObjectIsWindow( inTag ) ) return;
        
    NSPopover *popover = CUI_PopoverWithTag( inTag );
    if ( !popover ) {
        NSString *nibName = (__bridge NSString *)inNibName;
        CUI_NibObject *nibObj = CUI_NibObjectWithName( nibName );
        if ( !nibObj ) {
            NSNib *nib = [[NSNib alloc] initWithNibNamed:nibName bundle:nil];
            if ( nib ) {
                NSArray *objects = nil;
                [nib instantiateWithOwner:nil topLevelObjects:&objects];
                CUI_NibObjectAdd( objectTypeNib, nibName, objects, nil );
            }
        }
        CUI_PopoverFromNibObjects( inTag, nibName );
    }
}


#pragma mark - nibtoolbar
void CUI_ToolbarFromNibObjects( __attribute__ ((unused)) NSInteger tag, NSString *nibName )
{
    CUI_NibObject *nibObj = CUI_NibObjectWithName( nibName );
    if ( nibObj ) {
        switch ( [nibObj fileType] ) {
            case objectTypeStoryboard:
            {
                // .....
            }
                
            case objectTypeNib:
            default:
            {
                NSArray *objects = [nibObj topLevelObjects];
                
                for ( id obj in objects ) {
                    if ( [(NSObject *)obj isKindOfClass:[NSToolbar class]] ) {
                        
                        // set item action, target, etc.
                        NSArray *items = [(NSToolbar *)obj items];
                        for ( NSToolbarItem *item in items ) {
                            if ( [item tag] > 0 ) {
                                [item setTarget:CUI_ToolbarItemTargetObj()];
                                [item setAction:@selector(toolbarItemAction:)];
                            }
                        }
                        
                        [obj setDelegate:CUI_ToolbarDelegateObj()];// 20230712
                        // add to toolbars list
                        CUI_ToolbarObjAdd( obj );
                        break;
                    }
                }
            }
        }
        
    }
}

void CUI_NibToolbar( NSInteger inTag, CFStringRef inNibName )
{
    inTag = ABS(inTag);
    
    NSToolbar *toolbar = CUI_ToolbarWithTag( inTag );
    if ( !toolbar ) {
        NSString *nibName = (__bridge NSString *)inNibName;
        CUI_NibObject *nibObj = CUI_NibObjectWithName( nibName );
        if ( !nibObj ) {
            NSNib *nib = [[NSNib alloc] initWithNibNamed:nibName bundle:nil];
            if ( nib ) {
                NSArray *objects = nil;
                [nib instantiateWithOwner:nil topLevelObjects:&objects];
                CUI_NibObjectAdd( objectTypeNib, nibName, objects, nil );
            }
        }
        CUI_ToolbarFromNibObjects( inTag, nibName );
    }
}


#pragma mark - view controller




#pragma mark - nib <everything>
void CUI_Nib( CFStringRef inNibName )
{
    NSString *nibName = (__bridge NSString *)inNibName;
    CUI_NibObject *nibObj = CUI_NibObjectWithName( nibName );
    if ( !nibObj ) {
        NSNib *nib = [[NSNib alloc] initWithNibNamed:nibName bundle:nil];
        if ( nib ) {
            NSArray *objects = nil;
            [nib instantiateWithOwner:nil topLevelObjects:&objects];
            CUI_NibObjectAdd( objectTypeNib, nibName, objects, nil );
            
            // menus
            
            // windows
            
            // popovers
            
            // toolbars
            
            // views
            
        }
    }
}

// Class
Class NibClass( void )
{ return [NSNib class]; }

