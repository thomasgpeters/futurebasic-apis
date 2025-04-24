/*
 OpenPanel.m

 Bernie Wylde
 */

#import "OpenPanel.h"

NSOpenPanel *CUI_OpenPanelWithTag( NSInteger tag, BOOL create )
{
    if ( tag ) {
        if ( tag > 1000000 ) {
            //return (NSOpenPanel *)tag;// it's an NSOpenPanel *
            return (__bridge NSOpenPanel *)(void *)tag;
        }
        if ( sCUI_OpenPanels ) {
            for ( NSOpenPanel *op in sCUI_OpenPanels ) {
                if ( [op tag] == tag ) return op;
            }
        }
        if ( create ) return OpenPanelInit( tag );
    }
    return nil;
}

void CUI_OpenPanelAdd( NSOpenPanel *op )
{
    if ( !sCUI_OpenPanels ) sCUI_OpenPanels = [[NSMutableArray alloc] initWithCapacity:0];
    [sCUI_OpenPanels addObject:op];
}

void CUI_OpenPanelRemove( NSOpenPanel *op )
{ [sCUI_OpenPanels removeObject:op]; }

@implementation NSOpenPanel (Additions)
@dynamic tagNumber;
@dynamic sheetNumber;

- (NSInteger)tag {
    return [(NSNumber *)objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)sheet {
    return [(NSNumber *)objc_getAssociatedObject(self, @selector(sheetNumber)) boolValue];
}

- (void)setSheet:(BOOL)sheet {
    objc_setAssociatedObject(self, @selector(sheetNumber), [NSNumber numberWithBool:sheet], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end


#pragma mark - private
NSInteger CUI_OpenPanelContainingAccessorySubview( NSOpenPanel *op, id parentView, id view )
{
    NSArray *subviews = [(NSView *)parentView subviews];
    if ( [subviews count] ) {
        for ( id subview in subviews ) {
            if ( subview == view ) {
                return [op tag];
            }
            NSInteger opTag = CUI_OpenPanelContainingAccessorySubview( op, subview, view );
            if ( opTag > 0 ) return opTag;
        }
    }
    return 0;
}

NSInteger CUI_OpenPanelContainingAccessoryView( id view )
{
    if ( sCUI_OpenPanels ) {
        for ( NSOpenPanel *op in sCUI_OpenPanels ) {
            NSView *accessoryView = [op accessoryView];
            if ( accessoryView ) {
                if ( accessoryView == view ) return [op tag];
                NSInteger opTag = CUI_OpenPanelContainingAccessorySubview( op, accessoryView, view );
                if ( opTag > 0 ) return opTag;
            }
        }
    }
    return 0;
}

void CUI_OpenPanelSetAccessoryViewWndTag( NSInteger opTag, id superview )
{
    [(NSView *)superview setWndTag:opTag];
    NSArray *subviews = [(NSView *)superview subviews];
    if ( [subviews count] ) {
        for ( id subview in subviews ) {
            CUI_OpenPanelSetAccessoryViewWndTag( opTag, subview );
        }
    }
}


#pragma mark - public
// Class
Class OpenPanelClass( void )
{ return [NSOpenPanel class]; }

NSOpenPanel *OpenPanelWithTag( NSInteger tag )
{ return CUI_OpenPanelWithTag( tag, NO ); }

BOOL OpenPanelExists( NSInteger tag )
{
    if ( sCUI_OpenPanels ) {
        for ( NSOpenPanel *op in sCUI_OpenPanels ) {
            if ( [op tag] == tag ) return YES;
        }
    }
    return NO;
}



// Configure
BOOL OpenPanelCanChooseFiles( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return [op canChooseFiles];
    return NO;
}

void OpenPanelSetCanChooseFiles( NSInteger tag, BOOL flag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setCanChooseFiles:flag];
}

BOOL OpenPanelCanChooseDirectories( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return [op canChooseDirectories];
    return NO;
}


void OpenPanelSetCanChooseDirectories( NSInteger tag, BOOL flag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setCanChooseDirectories:flag];
}

BOOL OpenPanelResolvesAliases( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return [op resolvesAliases];
    return NO;
}

void OpenPanelSetResolvesAliases( NSInteger tag, BOOL flag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setResolvesAliases:flag];
}

BOOL OpenPanelAllowsMultipleSelection( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return [op allowsMultipleSelection];
    return NO;
}

void OpenPanelSetAllowsMultipleSelection( NSInteger tag, BOOL flag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setAllowsMultipleSelection:flag];
}

// User selection
CFArrayRef OpenPanelURLs( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return (__bridge CFArrayRef)[op URLs];
    return nil;
}

// Ubiquitous documents
BOOL OpenPanelCanDownloadUbiquitousContents( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return [op canDownloadUbiquitousContents];
    return NO;
}

void OpenPanelSetCanDownloadUbiquitousContents( NSInteger tag, BOOL flag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setCanDownloadUbiquitousContents:flag];
}

BOOL OpenPanelCanResolveUbiquitousConflicts( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return [op canResolveUbiquitousConflicts];
    return NO;
}

void OpenPanelSetCanResolveUbiquitousConflicts( NSInteger tag, BOOL flag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setCanResolveUbiquitousConflicts:flag];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
CFArrayRef OpenPanelAllowedContentTypes( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return (__bridge CFArrayRef)[op allowedContentTypes];
    return nil;
}

void OpenPanelSetAllowedContentTypes( NSInteger tag, CFArrayRef types )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setAllowedContentTypes:(__bridge NSArray *)types];
}
#endif// 110000

// Instance properties
BOOL OpenPanelIsAccessoryViewDisclosed( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return [op isAccessoryViewDisclosed];
    return NO;
}

void OpenPanelSetAccessoryViewDisclosed( NSInteger tag, BOOL flag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setAccessoryViewDisclosed:flag];
}



// Convenience - SavePanel functions -
// Configure
NSView *OpenPanelAccessoryView( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return [op accessoryView];
    return nil;
}

void OpenPanelSetAccessoryView( NSInteger tag, NSView *ref )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) {
        [op setAccessoryView:ref];
        
        CUI_OpenPanelSetAccessoryViewWndTag( tag, ref );

        // set wndTag of all views
//        NSArray *subviews = [ref subviews];
//        for ( id view in subviews ) {
//            [view setWndTag:tag];
//
//        }
    }
}

CFStringRef OpenPanelTitle( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return (__bridge CFStringRef)[op title];
    return nil;
}

void OpenPanelSetTitle( NSInteger tag, CFStringRef title )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setTitle:(__bridge NSString *)title];
}

CFStringRef OpenPanelPrompt( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return (__bridge CFStringRef)[op prompt];
    return nil;
}

void OpenPanelSetPrompt( NSInteger tag, CFStringRef prompt )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setPrompt:(__bridge NSString *)prompt];
}

CFStringRef OpenPanelMessage( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return (__bridge CFStringRef)[op message];
    return nil;
}

void OpenPanelSetMessage( NSInteger tag, CFStringRef message )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setMessage:(__bridge NSString *)message];
}

BOOL OpenPanelCanCreateDirectories( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return [op canCreateDirectories];
    return NO;
}

void OpenPanelSetCanCreateDirectories( NSInteger tag, BOOL flag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setCanCreateDirectories:flag];
}

BOOL OpenPanelShowsHiddenFiles( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return [op showsHiddenFiles];
    return NO;
}

void OpenPanelSetShowsHiddenFiles( NSInteger tag, BOOL flag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setShowsHiddenFiles:flag];
}

// Panel content
CFURLRef OpenPanelDirectoryURL( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return (__bridge CFURLRef)[op directoryURL];
    return nil;
}

void OpenPanelSetDirectoryURL( NSInteger tag, CFURLRef url )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setDirectoryURL:(__bridge NSURL *)url];
}

CFArrayRef OpenPanelAllowedFileTypes( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return (__bridge CFArrayRef)[op allowedFileTypes];
    return nil;
}

void OpenPanelSetAllowedFileTypes( NSInteger tag, CFArrayRef fileTypes )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setAllowedFileTypes:(__bridge NSArray *)fileTypes];
}

BOOL OpenPanelAllowsOtherFileTypes( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return [op allowsOtherFileTypes];
    return NO;
}

void OpenPanelSetAllowsOtherFileTypes( NSInteger tag, BOOL flag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setAllowsOtherFileTypes:flag];
}

BOOL OpenPanelTreatsFilePackagesAsDirectories( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return [op treatsFilePackagesAsDirectories];
    return NO;
}

void OpenPanelSetTreatsFilePackagesAsDirectories( NSInteger tag, BOOL flag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) [op setTreatsFilePackagesAsDirectories:flag];
}

// Running
void OpenPanelBeginSheetModal( NSInteger tag, NSInteger wndTag, CUI_OpenSavePanelCallbackType callback, void *userData )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) {
        NSWindow *window = WindowWithTag( wndTag );
        if ( window ) {
            [op beginSheetModalForWindow: window completionHandler:^(NSInteger returnCode) {
                if ( callback ) (*callback)(returnCode,userData);
            }];
        }
    }
}

void OpenPanelBegin( NSInteger tag, CUI_OpenSavePanelCallbackType callback, void *userData )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) {
        [op beginWithCompletionHandler:^(NSInteger returnCode) {
            if ( callback ) (*callback)(returnCode,userData);
        }];
    }
}

NSInteger OpenPanelRunModal( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, YES );
    if ( op ) return [op runModal];
    return 0;
}

void OpenPanelValidateVisibleColumns( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) [op validateVisibleColumns];
}

// User selection
CFURLRef OpenPanelURL( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) return (__bridge CFURLRef)[op URL];
    return nil;
}

// Actions
void OpenPanelOK( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) [op ok:nil];
}

void OpenPanelCancel( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) [op cancel:nil];
}

// -- custom --
void OpenPanelRemove( NSInteger tag )
{
    NSOpenPanel *op = CUI_OpenPanelWithTag( tag, NO );
    if ( op ) {
        [sCUI_OpenPanels removeObject:op];
    }
}


id CUI_OpenPanelSetDialogEventObjects( NSOpenPanel *op, NSInteger response )
{
    id obj = nil;
    if ( response == NSOKButton ) {
        if ( [op allowsMultipleSelection] ) {
            obj = [op URLs];
            DialogEventSetNSArray( obj );
            DialogEventSetNSURL( [(NSArray *)obj objectAtIndex:0] );
        } else {
            obj = [op URL];
            DialogEventSetNSArray( [op URLs] );
            DialogEventSetNSURL( obj );
        }
    } else {
        DialogEventSetNSArray( nil );
        DialogEventSetNSURL( nil );
    }
    return obj;
}


// Init
NSOpenPanel *OpenPanelInit( NSInteger inTag )
{
    // init
    NSOpenPanel *op = [NSOpenPanel openPanel];

    // tag
    [op setTag:inTag];

    // add to open panels array
    CUI_OpenPanelAdd( op );

    // set delegate
    [op setDelegate:CUI_OpenSavePanelDelegateObj()];

    return op;
}


// statement/function
CFTypeRef CUI_OpenPanel( NSInteger inTag, CFStringRef inMsg, CFTypeRef inFileTypes, CFStringRef inPrompt, CFURLRef inDirURL, NSInteger inSheetFlag )
{
    id obj = nil;
    
    // tag
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    // msg
    NSString *msg = (__bridge NSString *)inMsg;
    
    // prompt
    NSString *prompt = (__bridge NSString *)inPrompt;
    
    // dirURL
    NSURL *dirURL = (__bridge NSURL *)inDirURL;
    
    NSOpenPanel *op = CUI_OpenPanelWithTag( inTag, YES );
        
    // msg
    if ( msg ) [op setMessage:msg];
    
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
                    [op setAllowedContentTypes:fileTypes];
                }
#endif// 110000
                
            } else {
                [op setAllowedFileTypes:fileTypes];
            }
        }
    }
    // prompt
    if ( prompt ) [op setPrompt:prompt];
    
    // dirURL
    if ( dirURL ) [op setDirectoryURL:dirURL];
    
    // show
    if ( ![op isVisible] ) {
        
        // sheet
        if ( inSheetFlag != kFBParamMissing ) [op setSheet:(BOOL)inSheetFlag];
        
        if ( show ) {
            // get front window
            NSInteger wndTag = 0;
            NSWindow *window = CUI_VisibleTargetWindow( &wndTag );
            
            sCUI_OuptutWindowTag = wndTag; // 20250312
            
            if ( [op sheet] && window ) {  // sheet
                // beginSheet
                [op beginSheetModalForWindow:window completionHandler:^(NSInteger result) {
                    if ( sCUI_OuptutWindowTag ) CUI_OutputWindowSetTag( sCUI_OuptutWindowTag ); // 20250312

                    id obj2 = CUI_OpenPanelSetDialogEventObjects( op, result );
                    CallUserDefinedOnDialogFunction( openPanelDidEnd, result, [op tag], (__bridge CFTypeRef)obj2 );
                    CUI_OpenPanelRemove( op );
                }];
            } else {
                // runModal
                NSInteger response = [op runModal];
                
                if ( sCUI_OuptutWindowTag ) CUI_OutputWindowSetTag( sCUI_OuptutWindowTag ); // 20250312
                
                obj = CUI_OpenPanelSetDialogEventObjects( op, response );
                CallUserDefinedOnDialogFunction( openPanelDidEnd, response, [op tag], (__bridge CFTypeRef)obj );
                CUI_OpenPanelRemove( op );
            }
        }
    }
    
    return (__bridge CFTypeRef)obj;
}
