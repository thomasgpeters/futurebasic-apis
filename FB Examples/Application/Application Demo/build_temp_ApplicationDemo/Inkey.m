
/*
 Inkey.m
 
 Bernie Wylde 20230424
*/

#import "Inkey.h"
#import "CUI_AppDelegate.h"

@implementation FBInkeyFormat
#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.characterSet release];
    [super dealloc];
}
#endif
@end

static FBInkeyFormat *sFBInkeyFormat;


@implementation FBInkeyWindow

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.cursorTimer release];
    [self.promptLabel release];
    [self.cursorLabel release];
    [super dealloc];
}
#endif

- (id)initWithPrompt:(NSString *)prompt x:(NSInteger)x y:(NSInteger)y {
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

        // prompt label
        self.promptLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(8,10,4,16)];
        [self.promptLabel setBordered:NO];
        [self.promptLabel setDrawsBackground:NO];
        [self.promptLabel setSelectable:NO];
        [self.promptLabel setTextColor:[NSColor textColor]];
        if ( prompt ) [self.promptLabel setStringValue:prompt];
        [view addSubview:self.promptLabel];
        
        // cursor label
        self.cursorLabel = [[NSTextField alloc] initWithFrame:NSMakeRect(49,10,12,16)];
        [self.cursorLabel setBordered:NO];
        [self.cursorLabel setDrawsBackground:NO];
        [self.cursorLabel setSelectable:NO];
        [self.cursorLabel setStringValue:@"_"];
        [self.cursorLabel setTextColor:[NSColor textColor]];
        [view addSubview:self.cursorLabel];

        [self resize];
        
        [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer __attribute__ ((__unused__))) {
            if ( [self.cursorLabel isHidden] ) {
                [self.cursorLabel setHidden:NO];
            } else {
                [self.cursorLabel setHidden:YES];
            }
        }];

    }
    return self;
}

- (BOOL)canBecomeKeyWindow {
    return YES;
}

- (void)timerFired {
    if ( [self.cursorLabel isHidden] ) {
        [self.cursorLabel setHidden:NO];
    } else {
        [self.cursorLabel setHidden:YES];
    }
}

- (void)makeFrontWindowKey {
    NSArray *windows = [NSApp orderedWindows];
    NSWindow *wnd = windows[0];
    if ( wnd ) [wnd makeKeyAndOrderFront:nil];
}

- (void)windowDidBecomeKey:(NSNotification *)notification {
    if ( !self.cursorTimer ) {
        self.cursorTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.cursorTimer forMode:NSModalPanelRunLoopMode];
    }
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
        [wnd addChildWindow:self ordered:NSWindowAbove];
        [self setFrameOrigin:NSMakePoint(x,y)];
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

- (void)keyDown:(NSEvent *)event {
    CUI_EventSetEvent( event );
    NSString *key = nil;
    if ( [event keyCode] != 53 ) key = [event characters];
        
    if ( key ) {
        if ( sFBInkeyFormat ) {
            switch ( sFBInkeyFormat.option ) {
                case formatLowercase:
                    key = [key lowercaseString];
                    break;
                case formatUppercase:
                    key = [key uppercaseString];
                    break;
                default:
                    break;
            }
            
            if ( ![sFBInkeyFormat.characterSet characterIsMember:[key characterAtIndex:0]] ) {
                [super keyDown:event];
                return;
            }
        }
    }

    [(CUI_AppDelegate *)[NSApp delegate] setInkeyResponseString:key];
    [NSApp stopModalWithCode:NSModalResponseOK];
    [self.cursorTimer invalidate];
    self.cursorTimer = nil;
    [self performSelectorOnMainThread:@selector(makeFrontWindowKey) withObject:nil waitUntilDone:NO];
}

- (void)resize {
    CGFloat x = 10.0;
    
    // prompt label
    NSAttributedString *aString = [self.promptLabel attributedStringValue];
    CGSize size = [aString size];
    NSRect rPrompt = [self.promptLabel frame];
    if ( size.width > 0.0 ) {
        size.width += 5;
        x += size.width;
        rPrompt.size.width = size.width;
        [self.promptLabel setFrame:rPrompt];
    }
    
    // cursor label
    aString = [self.cursorLabel attributedStringValue];
    size = [aString size];
    size.width += 5;
    NSRect rCursor = [self.cursorLabel frame];
    rCursor.origin.x = x;
    rCursor.size.width = size.width;
    [self.cursorLabel setFrame:rCursor];

    // window
    NSRect rWnd = [self frame];
    rWnd.size.width = x + rCursor.size.width + 10;
    if ( rWnd.size.width < 40 ) rWnd.size.width = 40;
    [self setFrame:rWnd display:YES animate:NO];
}

@end

CFStringRef FBInkey( NSInteger x, NSInteger y, CFStringRef prompt, CFStringRef characters, long passFlag, long option )
{
    if ( characters ) {
        if ( [(__bridge NSString *)characters length] ) {
            if ( passFlag == kFBParamMissing ) passFlag = YES;
            if ( option == kFBParamMissing ) option = 0;
            InkeySetFormat( characters, passFlag, option );
        }
    } else {
        InkeyRemoveFormat();
    }
    NSString *responseString = nil;
    CUI_AppDelegate *delegate = (CUI_AppDelegate *)[NSApp delegate];
    delegate.inkeyWnd = [[FBInkeyWindow alloc] initWithPrompt:(__bridge NSString *)prompt x:x y:y];
    NSModalResponse response = [NSApp runModalForWindow:delegate.inkeyWnd];
    if ( response == NSModalResponseOK ) responseString = [delegate inkeyResponseString];
    [delegate.inkeyWnd orderOut:nil];
    [delegate.inkeyWnd close];
    delegate.inkeyWnd = nil;// 20240516
    return (__bridge CFStringRef)responseString;
}

// ancillary functions
void InkeySetFormat( CFStringRef characters, long pass, long option )
{
    sFBInkeyFormat = [[FBInkeyFormat alloc] init];
    NSCharacterSet *set;
    
    if ( option == formatLowercase || option == formatUppercase ) {
        [sFBInkeyFormat setOption:option];
        option = formatCaseInsensitive;
    }

    switch ( option ) {
        case formatCaseInsensitive:
            set = [NSCharacterSet characterSetWithCharactersInString:[NSString stringWithFormat:@"%@%@",[(__bridge NSString *)characters uppercaseString],[(__bridge NSString *)characters lowercaseString]]];
            break;
        default:
            set = [NSCharacterSet characterSetWithCharactersInString:(__bridge NSString *)characters];
            break;
    }
        
    if ( !pass ) set = [set invertedSet];
    [sFBInkeyFormat setCharacterSet:set];
}

void InkeyRemoveFormat( void )
{ sFBInkeyFormat = nil; }


