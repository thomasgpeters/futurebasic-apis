
/*
 Input.m
 
 Bernie Wylde 20230421
*/

#import "Input.h"
#import "CUI_AppDelegate.h"

@implementation FBInputFormat
#if !__has_feature(objc_arc)
- (void)dealloc {
    [_characters release];
    [super dealloc];
}
#endif
@end

static FBInputFormat *sFBInputFormat;

@implementation FBInputWindow

#if !__has_feature(objc_arc)
- (void)dealloc {
    [_label release];
    [_field release];
    [super dealloc];
}
#endif

- (id)initWithPrompt:(NSString *)prompt x:(NSInteger)x y:(NSInteger)y password:(BOOL)password {
    if ( (self = [super initWithContentRect:NSMakeRect(0,0,110,36) styleMask:NSWindowStyleMaskBorderless backing:NSBackingStoreBuffered defer:YES]) ) {
                
        self.xPos = x;
        self.yPos = y;

        // window
        [self setHasShadow:YES];
        [self setOpaque:NO];
        [self setLevel:NSFloatingWindowLevel];
        [self setReleasedWhenClosed:YES];
        [self center];
        [self setDelegate:self];
        [self setBackgroundColor:[NSColor clearColor]];

        // content view
        NSView *view = [self contentView];
        [view setWantsLayer:YES];
        view.layer.cornerRadius = 10;
        
        // visual effect view
        NSVisualEffectView *veView = [[NSVisualEffectView alloc] initWithFrame:NSMakeRect(0,0,110,36)];
        [veView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
        [view addSubview:veView];
        
        // label
        _label = [[NSTextField alloc] initWithFrame:NSMakeRect(8,10,4,16)];
        [_label setBordered:NO];
        [_label setDrawsBackground:NO];
        [_label setSelectable:NO];
        [_label setTextColor:[NSColor textColor]];
        if ( prompt ) {
            if ( [prompt length] ) [_label setStringValue:prompt];
        }
        [view addSubview:_label];
        
        // field
        if ( password ) {
            _field = [[NSSecureTextField alloc] initWithFrame:NSMakeRect(49,10,43,16)];
        } else {
            _field = [[NSTextField alloc] initWithFrame:NSMakeRect(49,10,43,16)];
        }
        [_field setBordered:NO];
        [_field setDrawsBackground:NO];
        [_field setEditable:YES];
        [_field setFocusRingType:NSFocusRingTypeNone];
        [_field setStringValue:@""];
        [_field setTextColor:[NSColor textColor]];
        [_field setDelegate:self];
        [view addSubview:_field];
        
        [self makeFirstResponder:_field];
        
        [self resize];
    }
    return self;
}

- (BOOL)canBecomeKeyWindow {
    return YES;
}

- (void)center {
    NSArray *windows = [NSApp orderedWindows];
    NSWindow *wnd = windows[0];
    if ( wnd != NULL && wnd != self ) {
        NSRect frame = [self frame];
        NSRect r = [wnd contentRectForFrameRect:[wnd frame]];
        CGFloat x, y;
        if ( self.xPos == kFBParamMissing && self.yPos == kFBParamMissing ) {
            x = r.origin.x + 20;
            y = r.origin.y + (r.size.height - frame.size.height)/2;
        } else {
            x = r.origin.x + self.xPos;
            y = r.origin.y + r.size.height - self.yPos;
         }
        [self setFrameOrigin:NSMakePoint(x,y)];
        [wnd addChildWindow:self ordered:NSWindowAbove];
    } else {
        if ( self.xPos == kFBParamMissing && self.yPos == kFBParamMissing ) {
            [super center];
        } else {
            NSRect screenR = [[NSScreen mainScreen] frame];
            [self setFrameOrigin:NSMakePoint(self.xPos,screenR.size.height-self.yPos)];
        }
    }
}

- (void)mouseDown:(NSEvent *)event {
    [self performWindowDragWithEvent:event];
}

- (void)resize {
    CGFloat x = 10.0;
    
    // label
    NSAttributedString *aString = [self.label attributedStringValue];
    CGSize size = [aString size];
    NSRect rLabel = [self.label frame];
    if ( size.width > 0.0 ) {
        size.width += 5;
        x += size.width;
        rLabel.size.width = size.width;
        [self.label setFrame:rLabel];
    }
    
    // field
    aString = [self.field attributedStringValue];
    if ( [self.field isKindOfClass:[NSSecureTextField class]] ) {
        NSString *bullets = [@"" stringByPaddingToLength:[aString length]
                                                          withString:@"M"
                                                        startingAtIndex:0];
        aString = [[NSAttributedString alloc] initWithString:bullets attributes:@{NSFontAttributeName:[NSFont boldSystemFontOfSize:9]}]; // kludge to match bullet size
    } else {
        aString = [self.field attributedStringValue];
    }
    size = [aString size];
    size.width += 5;

    NSRect rField = [self.field frame];
    rField.origin.x = x;
    rField.size.width = size.width;
    [self.field setFrame:rField];

    // window
    NSRect rWnd = [self frame];
    rWnd.size.width = x + rField.size.width + 10;
    if ( rWnd.size.width < 110 ) rWnd.size.width = 110;
    [self setFrame:rWnd display:YES animate:NO];
}

- (void)makeFrontWindowKey {// 20240522
    NSArray *windows = [NSApp orderedWindows];
    NSWindow *wnd = windows[0];
    if ( wnd ) [wnd makeKeyAndOrderFront:nil];
}

- (void)controlTextDidChange:(NSNotification *)obj {
    [self resize];
}

- (void)controlTextDidEndEditing:(NSNotification *)obj {
    CUI_EventSetEvent( [NSApp currentEvent] );    
    [(CUI_AppDelegate *)[NSApp delegate] setInputResponseString:[self.field stringValue]];
    [NSApp stopModalWithCode:NSModalResponseOK];
    [self performSelectorOnMainThread:@selector(makeFrontWindowKey) withObject:nil waitUntilDone:NO];
}

- (BOOL)control:(NSControl *)control textView:(NSTextView *)fieldEditor doCommandBySelector:(SEL)commandSelector {
    if ( commandSelector == @selector(cancelOperation:) ) {
        [NSApp stopModalWithCode:NSModalResponseCancel];// 20230712
        [self performSelectorOnMainThread:@selector(makeFrontWindowKey) withObject:nil waitUntilDone:NO];
        return YES;
    }
    return NO;
}
@end

CFStringRef FBInput( NSInteger x, NSInteger y, CFStringRef prompt, CFStringRef characters, long passFlag, long maxLength, long option )
{
    BOOL password = NO; // 20250401
    if ( option & formatPassword ) {
        option -= formatPassword;
        password = YES;
    }
    
    switch ( option ) {
        case formatInteger:
            characters = (__bridge CFStringRef)@"0123456789-";
            passFlag = YES;
            break;
        case formatUnsignedInteger:
            characters = (__bridge CFStringRef)@"0123456789";
            passFlag = YES;
            break;
        case formatFloat:
            characters = (__bridge CFStringRef)@"0123456789-.";
            passFlag = YES;
            break;
        case formatUnsignedFloat:
            characters = (__bridge CFStringRef)@"0123456789.";
            passFlag = YES;
            break;
        default:
            break;
    }
    
    if ( option == kFBParamMissing ) option = 0;
    
    if ( [(__bridge NSString *)characters length] > 0 || maxLength != 0 || option != kFBParamMissing ) {
        //if ( [(__bridge NSString *)characters length] ) InputSetFormat( characters, passFlag, maxLength, option );
        InputSetFormat( characters, passFlag, maxLength, option );
    } else {
        InputRemoveFormat();
    }
    
    NSString *responseString = nil;
    CUI_AppDelegate *delegate = (CUI_AppDelegate *)[NSApp delegate];
    delegate.inputWnd = [[FBInputWindow alloc] initWithPrompt:(__bridge NSString *)prompt x:x y:y password:password];
        
    if ( sFBInputFormat ) {
        ControlSetFormat( (NSInteger)[delegate.inputWnd field], (__bridge CFStringRef)sFBInputFormat.characters, sFBInputFormat.pass, sFBInputFormat.maxLength, sFBInputFormat.option );
    }
    NSModalResponse response = [NSApp runModalForWindow:delegate.inputWnd];
    if ( response == NSModalResponseOK ) responseString = [delegate inputResponseString];
    [delegate.inputWnd orderOut:nil];
    [delegate.inputWnd close];
    delegate.inputWnd = nil;// 20240516
    return (__bridge CFStringRef)responseString;
}

// ancillary functions
void InputSetFormat( CFStringRef characters, long pass, long maxLength, long option )
{
    sFBInputFormat = [[FBInputFormat alloc] init];
    [sFBInputFormat setCharacters:(__bridge NSString *)characters];
    if ( pass != kFBParamMissing ) {
        [sFBInputFormat setPass:pass];
    } else {
        [sFBInputFormat setPass:YES];
    }
    if ( maxLength != kFBParamMissing ) {
        [sFBInputFormat setMaxLength:maxLength];
    } else {
        [sFBInputFormat setMaxLength:0];
    }
    if ( option != kFBParamMissing ) {
        if ( option & formatPassword ) { // 20250401
            option -= formatPassword;
            [sFBInputFormat setPassword:YES];
        }
        [sFBInputFormat setOption:option];
    } else {
        [sFBInputFormat setOption:0];
    }
}

void InputRemoveFormat( void )
{ sFBInputFormat = nil; }

NSWindow *InputWindow( void )
{
    CUI_AppDelegate *delegate = (CUI_AppDelegate *)[NSApp delegate];
    return delegate.inputWnd;
}

