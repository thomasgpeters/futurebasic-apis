//
//  BreakpointWindowController.m
//
//  Created by Bernie Wylde on 08/09/2024.
//

#import "BreakpointWindowController.h"

@implementation DeactivateButton
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSRect r = [self bounds];
    r.origin.x += 1.5;
    r.size.width = r.size.height;
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:r];
    [path setLineWidth:1.2];
    [[NSColor grayColor] set];
    [path stroke];
}
@end

@implementation ContinueButton
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSRect r = [self bounds];
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:NSMakePoint(0,0)];
    [path lineToPoint:NSMakePoint(0,r.size.height)];
    [path lineToPoint:NSMakePoint(3,r.size.height)];
    [path lineToPoint:NSMakePoint(3,0)];
    [path closePath];
    [path moveToPoint:NSMakePoint(6,0)];
    [path lineToPoint:NSMakePoint(6,r.size.height)];
    [path lineToPoint:NSMakePoint(r.size.width,r.size.height/2)];
    [path closePath];
    [path setLineWidth:1.2];
    [[NSColor grayColor] set];
    [path stroke];
}
@end

@implementation StepOverButton
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSRect r = [self bounds];
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path moveToPoint:NSMakePoint(2,r.size.height)];
    [path lineToPoint:NSMakePoint(2,r.size.height-2)];
    [path lineToPoint:NSMakePoint(r.size.width-2,r.size.height-2)];
    [path lineToPoint:NSMakePoint(r.size.width-2,r.size.height)];
    [path closePath];
    [path moveToPoint:NSMakePoint(0,6)];
    [path lineToPoint:NSMakePoint(r.size.width/2,0)];
    [path lineToPoint:NSMakePoint(r.size.width,6)];
    [path moveToPoint:NSMakePoint(r.size.width-4,6)];
    [path lineToPoint:NSMakePoint(r.size.width,6)];
    [path lineToPoint:NSMakePoint(r.size.width,2)];
    [path setLineWidth:1.2];
    [[NSColor grayColor] set];
    [path stroke];
}
@end

@implementation BreakpointWindow

- (void)keyDown:(NSEvent *)event {
    switch ( [event keyCode] ) {
        case 124:// right arrow - continue
            [(BreakpointWindowController *)[self delegate] continueAction:event];
            break;
        case 125:// down arrow - step over
        case 126:// up arrow - step over
            [(BreakpointWindowController *)[self delegate] skipAction:event];
            break;
        case 123:// left arrow - stop
            [(BreakpointWindowController *)[self delegate] deactivateAction:event];
            break;
        default:
            [super keyDown:event];
    }
}

@end

@interface BreakpointWindowController ()
@property (nonatomic, strong) BreakpointWindow *wnd;
@property (nonatomic, unsafe_unretained) NSTextField *fileFld;
@property (nonatomic, unsafe_unretained) NSTextField *functionFld;
@property (nonatomic, unsafe_unretained) NSTextField *lineFld;
@property (nonatomic, unsafe_unretained) NSTextView *textView;
@property (nonatomic, assign) long line;
@property (nonatomic, assign) BOOL skip;
@property (nonatomic, assign) NSRect frame;
@end

@implementation BreakpointWindowController

- (void)dealloc {
    [self.wnd release];
    [super dealloc];
}

- (NSTextField *)view:(NSView *)view addLabelWithText:(NSString *)text rect:(NSRect)r {
    NSTextField *label = [[[NSTextField alloc] initWithFrame:r] autorelease];
    [label setStringValue:text];
    [label setBordered:NO];
    [label setSelectable:NO];
    [label setDrawsBackground:NO];
    [label setControlSize:NSControlSizeSmall];
    [label setFont:[NSFont systemFontOfSize:[NSFont systemFontSizeForControlSize:NSControlSizeSmall]]];
    [label setAutoresizingMask:NSViewMinYMargin];
    [view addSubview:label];
    return label;
}

- (void)view:(NSView *)view addButton:(NSButton *)btn action:(SEL)action tooltip:(NSString *)tooltip {
    [btn setTitle:@""];
    [btn setBezelStyle:NSBezelStyleSmallSquare];
    [btn setBordered:NO];
    [btn setAction:action];
    [btn setTarget:self];
    [btn setToolTip:tooltip];
    [view addSubview:btn];
}

- (void)buildWindow {
    self.wnd = [[BreakpointWindow alloc] initWithContentRect:NSMakeRect(145,91,424,185)
                                      styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskResizable | NSWindowStyleMaskUtilityWindow
                                        backing:NSBackingStoreBuffered
                                          defer:NO];
    [self.wnd setTitle:@"Breakpoint"];
    [self.wnd setContentMinSize:NSMakeSize(300,120)];
    [self.wnd setTitlebarAppearsTransparent:YES];
    [self.wnd setDelegate:self];
    
    NSView *contentView = [self.wnd contentView];
    
    NSVisualEffectView *visEffectView = [[NSVisualEffectView alloc] initWithFrame:NSMakeRect(0,0,424,185)];
    [visEffectView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [contentView addSubview:visEffectView];
    
    [self view:visEffectView addLabelWithText:@"File:" rect:NSMakeRect(8,170,26,14)];
    
    self.fileFld = [self view:visEffectView addLabelWithText:@"FileFld" rect:NSMakeRect(65,170,351,14)];
    [self.fileFld setAutoresizingMask:NSViewMinYMargin | NSViewWidthSizable];
    
    [self view:visEffectView addLabelWithText:@"Function:" rect:NSMakeRect(8,154,53,14)];
    
    self.functionFld = [self view:visEffectView addLabelWithText:@"FunctionFld" rect:NSMakeRect(65,154,351,14)];
    [self.functionFld setAutoresizingMask:NSViewMinYMargin | NSViewWidthSizable];
    
    [self view:visEffectView addLabelWithText:@"Line:" rect:NSMakeRect(8,138,30,14)];
    
    self.lineFld = [self view:visEffectView addLabelWithText:@"LineFld" rect:NSMakeRect(65,138,351,14)];
    [self.lineFld setAutoresizingMask:NSViewMinYMargin | NSViewWidthSizable];
    
    NSBox *line = [[NSBox alloc] initWithFrame:NSMakeRect(0,131,424,5)];
    [line setBoxType:NSBoxSeparator];
    [line setAutoresizingMask:NSViewMinYMargin | NSViewWidthSizable];
    [visEffectView addSubview:line];
    
    NSScrollView *scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(8,25,408,100)];
    [scrollView setDrawsBackground:NO];
    [scrollView setHasVerticalScroller:YES];
    [scrollView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [visEffectView addSubview:scrollView];
    
    self.textView = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, 408, 100)];
    [self.textView setString:@"abc"];
    [self.textView setFont:[NSFont fontWithName:@"Menlo" size:12]];
    [self.textView setDrawsBackground:NO];
    [self.textView setSelectable:NO];
    [self.textView setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    [scrollView setDocumentView:self.textView];
    
    NSView *controlView = [[NSView alloc] initWithFrame:NSMakeRect(177,10,73,10)];
    [visEffectView addSubview:controlView];
    [controlView setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin | NSViewMaxYMargin];
        
    DeactivateButton *deactivateBtn = [[[DeactivateButton alloc] initWithFrame:NSMakeRect(0,0,13,10)] autorelease];
    [self view:controlView addButton:deactivateBtn action:@selector(deactivateAction:) tooltip:@"Deactivate breakpoints"];
    
    ContinueButton *continueBtn = [[[ContinueButton alloc] initWithFrame:NSMakeRect(30,0,13,10)] autorelease];
    [self view:controlView addButton:continueBtn action:@selector(continueAction:) tooltip:@"Continue program execution"];
    
    StepOverButton *stepOverBtn = [[[StepOverButton alloc] initWithFrame:NSMakeRect(60,0,13,10)] autorelease];
    [self view:controlView addButton:stepOverBtn action:@selector(skipAction:) tooltip:@"Step over"];

    [self.wnd setFrameAutosaveName:@"BreakpointWindow"];
}

- (void)breakpointWithFile:(NSString *)filename function:(NSString *)function line:(NSInteger)lineNum string:(NSString *)string {
    [self.wnd makeKeyAndOrderFront:nil];
    if ( !NSEqualRects(self.frame,NSZeroRect) ) [self.wnd setFrame:self.frame display:YES];
    
    if ( lineNum != self.line ) self.skip = NO;
    
    if ( !self.skip ) {
        self.line = lineNum;
        [self.fileFld setStringValue:[filename lastPathComponent]];
        [self.functionFld setStringValue:function];
        [self.lineFld setIntegerValue:self.line];
        [self.textView setString:string];
        [self.textView setFont:[NSFont fontWithName:@"Menlo" size:12]];
        [NSApp runModalForWindow:self.wnd];
    } else {
        [self.wnd orderOut:nil];
    }
}

- (IBAction)stopAction:(id)sender {
    [NSApp stopModalWithCode:NSModalResponseOK];
    [NSApp terminate:nil];
}

- (IBAction)deactivateAction:(id)sender {
    self.deactivate = YES;
    [NSApp stopModalWithCode:NSModalResponseOK];
    [self.wnd orderOut:nil];
}

- (IBAction)continueAction:(id)sender {
    self.skip = NO;
    [NSApp stopModalWithCode:NSModalResponseOK];
    [self.wnd orderOut:nil];
}

- (IBAction)skipAction:(id)sender {
    self.skip = YES;
    [NSApp stopModalWithCode:NSModalResponseOK];
    [self.wnd orderOut:nil];
    [NSTimer scheduledTimerWithTimeInterval:0.3 repeats:NO block:^(NSTimer __attribute__ ((__unused__)) *timer) {
        self.skip = NO;
    }];
}

- (void)windowDidMove:(NSNotification *)notification {
    self.frame = [self.wnd frame];
}

- (void)windowDidResize:(NSNotification *)notification {
    self.frame = [self.wnd frame];
}
@end

void FBBreakpoint( NSString *filename, NSString *functionName, NSInteger lineNum, ... )
{
    CUI_AppDelegate *appDelegate = [NSApp delegate];
    if ( !appDelegate.breakpointController ) {
        appDelegate.breakpointController = [[BreakpointWindowController alloc] init];
        [appDelegate.breakpointController buildWindow];
    }
    if ( appDelegate.breakpointController.deactivate ) return;
    
    va_list ap;
    va_start(ap,lineNum);

    if ( [functionName length] == 0 ) functionName = @"---";
    
    BOOL valueFlag = NO;
    id obj = va_arg(ap,id);
    NSMutableString *string = [NSMutableString new];
    if ( !obj ) [string appendString:@"---"];
    while ( obj ) {
        if ( valueFlag ) {
            [string appendFormat:@"%@\n",obj];
        } else {
            [string appendFormat:@"%@ = ",obj];
        }
        valueFlag = !valueFlag;
        obj = va_arg(ap,id);
    }

    [appDelegate.breakpointController breakpointWithFile:filename function:functionName line:lineNum string:string];

    va_end(ap);
}

void FBBreakpointStop( void )
{
    CUI_AppDelegate *appDelegate = [NSApp delegate];
    if ( !appDelegate.breakpointController ) {
        appDelegate.breakpointController = [[BreakpointWindowController alloc] init];
        [appDelegate.breakpointController buildWindow];
    }
    appDelegate.breakpointController.deactivate = YES;
}
