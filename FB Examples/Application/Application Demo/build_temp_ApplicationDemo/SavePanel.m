/*
 SavePanel.m

 Bernie Wylde
 */

#import "SavePanel.h"

@implementation CUI_OpenSavePanelDelegate
- (NSString *)panel:(id)sender userEnteredFilename:(NSString *)filename confirmed:(BOOL)okFlag {
    DialogEventSetNSString( filename );
    DialogEventSetBool( okFlag );
    CallUserDefinedOnDialogFunction( savePanelUserEnteredFilename, [sender tag], [sender tag], (__bridge CFStringRef)filename );
    return DialogEventNSString();
}

- (void)panelSelectionDidChange:(id)sender {
    CallUserDefinedOnDialogFunction( savePanelSelectionDidChange, [sender tag], [sender tag], (__bridge CFTypeRef)sender );
}

- (void)panel:(id)sender didChangeToDirectoryURL:(NSURL *)url {
    DialogEventSetNSURL( url );
    CallUserDefinedOnDialogFunction( savePanelDidChangeToDirectoryURL, [sender tag], [sender tag], (__bridge CFURLRef)url );
}

- (void)panel:(id)sender willExpand:(BOOL)expanding {
    DialogEventSetBool( expanding );
    CallUserDefinedOnDialogFunction( savePanelWillExpand, [sender tag], [sender tag], (__bridge CFTypeRef)sender );
}

- (BOOL)panel:(id)sender shouldEnableURL:(NSURL *)url {
    DialogEventSetBool( YES );
    DialogEventSetNSURL( url );
    CallUserDefinedOnDialogFunction( savePanelShouldEnableURL, [sender tag], [sender tag], (__bridge CFURLRef)url );
    return DialogEventBool();
}

- (BOOL)panel:(id)sender validateURL:(NSURL *)url error:(NSError **)outError {
    DialogEventSetBool( YES );
    DialogEventSetNSURL( url );
    //DialogEventSetError( outError );
    CallUserDefinedOnDialogFunction( savePanelValidateURL, [sender tag], [sender tag], (NSError **)outError );
    return DialogEventBool();
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
- (NSString *)panel:(id)sender displayNameForType:(UTType *)type API_AVAILABLE(macos(15.0)) {
    DialogEventSetNSString( nil );
    DialogEventSetUTType( type );
    CallUserDefinedOnDialogFunction( savePanelDisplayNameForType, [sender tag], [sender tag], (__bridge CFTypeRef)type );
    return DialogEventNSString();
}

- (void)panel:(id)sender didSelectType:(UTType *)type API_AVAILABLE(macos(15.0)) {
    DialogEventSetUTType( type );
    CallUserDefinedOnDialogFunction( savePanelDidSelectType, [sender tag], [sender tag], (__bridge CFTypeRef)type );
}
#endif // 150000

@end

CUI_OpenSavePanelDelegate *CUI_OpenSavePanelDelegateObj( void )
{
    static CUI_OpenSavePanelDelegate *sCUI_OpenSavePanelDelegate;
    if ( !sCUI_OpenSavePanelDelegate ) sCUI_OpenSavePanelDelegate = [[CUI_OpenSavePanelDelegate alloc] init];
    return sCUI_OpenSavePanelDelegate;
}




NSSavePanel *CUI_SavePanelWithTag( NSInteger tag, BOOL create )
{
    if ( tag ) {
        if ( tag > 1000000 ) {
            //return (NSSavePanel *)tag;
            return (__bridge NSSavePanel *)(void *)tag;
        }
        
        if ( sCUI_SavePanels ) {
            for ( NSSavePanel *sp in sCUI_SavePanels ) {
                if ( [sp tag] == tag ) return sp;
            }
        }
        if ( create ) return SavePanelInit( tag );
    }
    return nil;
}

void CUI_SavePanelAdd( NSSavePanel *sp )
{
    if ( !sCUI_SavePanels ) sCUI_SavePanels = [[NSMutableArray alloc] initWithCapacity:0];
    [sCUI_SavePanels addObject:sp];
}

void CUI_SavePanelRemove( NSSavePanel *sp )
{ [sCUI_SavePanels removeObject:sp]; }


@implementation NSSavePanel (Additions)
@dynamic tagNumber;
@dynamic sheetNumber;

- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)sheet {
    return [objc_getAssociatedObject(self, @selector(sheetNumber)) boolValue];
}

- (void)setSheet:(BOOL)sheet {
    objc_setAssociatedObject(self, @selector(sheetNumber), [NSNumber numberWithBool:sheet], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end

#pragma mark - private
NSInteger CUI_SavePanelContainingAccessorySubview( NSSavePanel *sp, id parentView, id view )
{
    NSArray *subviews = [parentView subviews];
    if ( [subviews count] ) {
        for ( id subview in subviews ) {
            if ( [subview isEqualTo:view] ) return [sp tag];
            NSInteger spTag = CUI_SavePanelContainingAccessorySubview( sp, subview, view );
            if ( spTag > 0 ) return spTag;
        }
    }
    return 0;
}

NSInteger CUI_SavePanelContainingAccessoryView( id view )
{
    if ( sCUI_SavePanels ) {
        for ( NSSavePanel *sp in sCUI_SavePanels ) {
            NSView *accessoryView = [sp accessoryView];
            if ( accessoryView ) {
                if ( [accessoryView isEqualTo:view] ) return [sp tag];
                NSInteger spTag = CUI_SavePanelContainingAccessorySubview( sp, accessoryView, view );
                if ( spTag > 0 ) return spTag;
            }
        }
    }
    return 0;
}


#pragma mark - public
// Class
Class SavePanelClass( void )
{ return [NSSavePanel class]; }

NSSavePanel *SavePanelWithTag( NSInteger tag )
{ return CUI_SavePanelWithTag( tag, NO ); }

BOOL SavePanelExists( NSInteger tag )
{
    if ( sCUI_SavePanels ) {
        for ( NSSavePanel *sp in sCUI_SavePanels ) {
            if ( [sp tag] == tag ) return YES;
        }
    }
    return NO;
}


// Configure
NSView *SavePanelAccessoryView( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return [sp accessoryView];
    return nil;
}

void SavePanelSetAccessoryView( NSInteger tag, NSView *ref )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setAccessoryView:ref];
}

CFStringRef SavePanelTitle( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return (__bridge CFStringRef)[sp title];
    return nil;
}

void SavePanelSetTitle( NSInteger tag, CFStringRef title )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setTitle:(__bridge NSString *)title];
}

CFStringRef SavePanelPrompt( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return (__bridge CFStringRef)[sp prompt];
    return nil;
}

void SavePanelSetPrompt( NSInteger tag, CFStringRef prompt )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setPrompt:(__bridge NSString *)prompt];
}

CFStringRef SavePanelNameFieldLabel( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return (__bridge CFStringRef)[sp nameFieldLabel];
    return nil;
}

void SavePanelSetNameFieldLabel( NSInteger tag, CFStringRef label )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setNameFieldLabel:(__bridge NSString *)label];
}

CFStringRef SavePanelMessage( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return (__bridge CFStringRef)[sp message];
    return nil;
}

void SavePanelSetMessage( NSInteger tag, CFStringRef message )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setMessage:(__bridge NSString *)message];
}

BOOL SavePanelCanCreateDirectories( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return [sp canCreateDirectories];
    return NO;
}

void SavePanelSetCanCreateDirectories( NSInteger tag, BOOL flag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setCanCreateDirectories:flag];
}

BOOL SavePanelShowsHiddenFiles( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return [sp showsHiddenFiles];
    return NO;
}

void SavePanelSetShowsHiddenFiles( NSInteger tag, BOOL flag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setShowsHiddenFiles:flag];
}

BOOL SavePanelShowsTagField( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return [sp showsTagField];
    return NO;
}

void SavePanelSetShowsTagField( NSInteger tag, BOOL flag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setShowsTagField:flag];
}

CFArrayRef SavePanelTagNames( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return (__bridge CFArrayRef)[sp tagNames];
    return nil;
}

void SavePanelSetTagNames( NSInteger tag, CFArrayRef tagNames )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setTagNames:(__bridge NSArray *)tagNames];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
BOOL SavePanelShowsContentTypes( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return [sp showsContentTypes];
    return NO;
}
void SavePanelSetShowsContentTypes( NSInteger tag, BOOL flag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setShowsContentTypes:flag];
}
#endif // 150000

// Panel content
BOOL SavePanelIsExtensionHidden( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return [sp isExtensionHidden];
    return NO;
}

void SavePanelSetExtensionHidden( NSInteger tag, BOOL flag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setExtensionHidden:flag];
}

CFURLRef SavePanelDirectoryURL( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return (__bridge CFURLRef)[sp directoryURL];
    return nil;
}

void SavePanelSetDirectoryURL( NSInteger tag, CFURLRef url )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setDirectoryURL:(__bridge NSURL *)url];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
CFArrayRef SavePanelAllowedContentTypes( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return (__bridge CFArrayRef)[sp allowedContentTypes];
    return nil;
}

void SavePanelSetAllowedContentTypes( NSInteger tag, CFArrayRef types )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setAllowedContentTypes:(__bridge NSArray *)types];
}
#endif// 110000

BOOL SavePanelCanSelectHiddenExtension( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return [sp canSelectHiddenExtension];
    return NO;
}

void SavePanelSetCanSelectHiddenExtension( NSInteger tag, BOOL flag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setCanSelectHiddenExtension:flag];
}

CFArrayRef SavePanelAllowedFileTypes( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return (__bridge CFArrayRef)[sp allowedFileTypes];
    return nil;
}

void SavePanelSetAllowedFileTypes( NSInteger tag, CFArrayRef fileTypes )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setAllowedFileTypes:(__bridge NSArray *)fileTypes];
}

BOOL SavePanelAllowsOtherFileTypes( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return [sp allowsOtherFileTypes];
    return NO;
}

void SavePanelSetAllowsOtherFileTypes( NSInteger tag, BOOL flag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setAllowsOtherFileTypes:flag];
}

BOOL SavePanelTreatsFilePackagesAsDirectories( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return [sp treatsFilePackagesAsDirectories];
    return NO;
}

void SavePanelSetTreatsFilePackagesAsDirectories( NSInteger tag, BOOL flag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setTreatsFilePackagesAsDirectories:flag];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
UTType *SavePanelCurrentContentType( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return [sp currentContentType];
    return nil;
}

void SavePanelSetCurrentContentType( NSInteger tag, UTType *type )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp setCurrentContentType:type];
}
#endif // 150000


// Running
void SavePanelBeginSheetModal( NSInteger tag, NSInteger wndTag, CUI_OpenSavePanelCallbackType callback, void *userData )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) {
        NSWindow *window = WindowWithTag( wndTag );
        if ( window ) {
            [sp beginSheetModalForWindow: window completionHandler:^(NSInteger returnCode) {
                if ( callback ) (*callback)(returnCode,userData);
            }];
        }
    }
}

void SavePanelBegin( NSInteger tag, CUI_OpenSavePanelCallbackType callback, void *userData )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) {
        [sp beginWithCompletionHandler:^(NSInteger returnCode) {
            if ( callback ) (*callback)(returnCode,userData);
        }];
    }
}

NSInteger SavePanelRunModal( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) return [sp runModal];
    return 0;
}

void SavePanelValidateVisibleColumns( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, YES );
    if ( sp ) [sp validateVisibleColumns];
}

// User selection
CFURLRef SavePanelURL( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return (__bridge CFURLRef)[sp URL];
    return nil;
}

BOOL SavePanelIsExpanded( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return [sp isExpanded];
    return NO;
}

CFStringRef SavePanelNameFieldStringValue( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) return (__bridge CFStringRef)[sp nameFieldStringValue];
    return nil;
}

void SavePanelSetNameFieldStringValue( NSInteger tag, CFStringRef string )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) [sp setNameFieldStringValue:(__bridge NSString *)string];
}

// Actions
void SavePanelOK( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) [sp ok:nil];
}

void SavePanelCancel( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) [sp cancel:nil];
}

// -- custom --
void SavePanelRemove( NSInteger tag )
{
    NSSavePanel *sp = CUI_SavePanelWithTag( tag, NO );
    if ( sp ) {
        [sCUI_SavePanels removeObject:sp];
    }
}


id CUI_SavePanelSetDialogEventObjects( NSSavePanel *sp, NSInteger response )
{
    id obj = nil;
    if ( response == NSOKButton ) {
        obj = [sp URL];
        DialogEventSetNSURL( obj );
    } else {
        DialogEventSetNSURL( nil );
    }
    return obj;
}


// Init
NSSavePanel *SavePanelInit( NSInteger inTag )
{
    // init
    NSSavePanel *sp = [NSSavePanel savePanel];
    
    // tag
    [sp setTag:inTag];
    
    // add to save panels array
    CUI_SavePanelAdd( sp );

    // set delegate
    [sp setDelegate:CUI_OpenSavePanelDelegateObj()];

    return sp;
}


// Statement
CFTypeRef CUI_SavePanel( NSInteger inTag, CFStringRef inMsg, CFTypeRef inFileTypes, CFStringRef inNameFieldString, CFStringRef inPrompt, CFURLRef inDirURL, NSInteger inSheetFlag )
{
    id obj = nil;
    
    // tag
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    // msg
    NSString *msg = (__bridge NSString *)inMsg;
    
    // nameFldString
    NSString *nameFieldString = (__bridge NSString *)inNameFieldString;
    
    // prompt
    NSString *prompt = (__bridge NSString *)inPrompt;
    
    // dirURL
    NSURL *dirURL = (__bridge NSURL *)inDirURL;
    
    NSSavePanel *sp = CUI_SavePanelWithTag( inTag, YES );
    
    // msg
    if ( msg ) [sp setMessage:msg];
    
    // allowed file types
    if ( inFileTypes ) {
        NSArray *fileTypes = nil;
        
        if ( [(__bridge id)inFileTypes isKindOfClass:NSClassFromString(@"UTType")] ) {
            fileTypes = @[(__bridge id)inFileTypes];
        } else {
            if ( CFGetTypeID(inFileTypes) == CFStringGetTypeID() ) {
                fileTypes = [(__bridge NSString *)inFileTypes componentsSeparatedByString:@";"];
            } else if ( CFGetTypeID(inFileTypes) == CFArrayGetTypeID() ) {
                fileTypes = (__bridge NSArray *)inFileTypes;
            }
        }
        
        if ( fileTypes ) {
            if ( [fileTypes[0] isKindOfClass:NSClassFromString(@"UTType")] ) {
                
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
                if (@available(macOS 11.0, *)) {
                    [sp setAllowedContentTypes:fileTypes];
                }
#endif// 110000
                
            } else {
                [sp setAllowedFileTypes:fileTypes];
            }
        }
    }
    
    // nameFieldSring
    if ( nameFieldString ) [sp setNameFieldStringValue:nameFieldString];
    
    // prompt
    if ( prompt ) [sp setPrompt:prompt];
    
    // dirURL
    if ( dirURL ) [sp setDirectoryURL:dirURL];
    
    // show
    if ( ![sp isVisible] ) {
        
        // sheet
        if ( inSheetFlag != kFBParamMissing ) [sp setSheet:(BOOL)inSheetFlag];
        
        if ( show ) {
            // get front window
            NSInteger wndTag = 0;
            
            NSWindow *window = CUI_VisibleTargetWindow( &wndTag );
            
            if ( [sp sheet] && window ) {  // sheet
                
                // beginSheet
                [sp beginSheetModalForWindow:window completionHandler:^(NSInteger result) {
                    id obj = CUI_SavePanelSetDialogEventObjects( sp, result );
                    CallUserDefinedOnDialogFunction( savePanelDidEnd, result, [sp tag], (__bridge CFTypeRef)obj );
                    CUI_SavePanelRemove( sp );
                }];
                
            } else {
                
                NSInteger response = [sp runModal];
                obj = CUI_SavePanelSetDialogEventObjects( sp, response );                
                CallUserDefinedOnDialogFunction( savePanelDidEnd, response, [sp tag], (__bridge CFTypeRef)obj );
                CUI_SavePanelRemove( sp );
            }
        }
    }
    return (__bridge CFTypeRef)obj;
}
