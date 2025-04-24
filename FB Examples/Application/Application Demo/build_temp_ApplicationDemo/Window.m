/*
 Window.m

 Bernie Wylde
 */

#import "Window.h"


#pragma mark - PrintToWindow

#define CUI_PRINT_TO_WINDOW_TEXT_DEFAULTS @{NSFontAttributeName:[NSFont fontWithName:@"Menlo" size:12],NSForegroundColorAttributeName:[NSColor textColor],NSBackgroundColorAttributeName:[NSColor clearColor]}

@implementation CUI_PrintToWindowDefaults
#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.font release];
    [super dealloc];
}
#endif
@end

@implementation CUI_PrintToWindowItem

- (id)initWithString:(NSString *)string point:(NSPoint)pt attributes:(NSDictionary *)attributes {
    if ( (self = [super init]) ) {
        self.type = CUI_PrintToWindowItemTypeText;
        self.string = [[NSString alloc] initWithString:string];
        self.pt = pt;
        self.attributes = [[NSDictionary alloc] initWithDictionary:attributes];
        self.shadow = [[NSShadow alloc] init];
    }
    return self;
}

+ (id)itemWithString:(NSString *)string point:(NSPoint)pt attributes:(NSDictionary *)attributes {
    return [[CUI_PrintToWindowItem alloc] initWithString:string point:pt attributes:attributes];
}

- (id)initWithLinePoint1:(NSPoint)pt1 linePoint2:(NSPoint)pt2 {
    if ( (self = [super init]) ) {
        self.type = CUI_PrintToWindowItemTypeLine;
        self.linePt1 = pt1;
        self.linePt2 = pt2;
    }
    return self;
}

+ (id)itemWithLinePoint1:(NSPoint)pt1 linePoint2:(NSPoint)pt2 {
    return [[CUI_PrintToWindowItem alloc] initWithLinePoint1:pt1 linePoint2:pt2];
}

// oval and rect
- (id)initWithType:(NSInteger)type rect:(NSRect)r strokeColor:(NSColor *)strokeCol fillColor:(NSColor *)fillCol cornerRadius:(CGFloat)cornerRad {
    if ( (self = [super init]) ) {
        self.type = type;
        self.rect = r;
        self.strokeColor = strokeCol;
        self.fillColor = fillCol;
        self.cornerRadius = cornerRad;
        self.shadow = [[NSShadow alloc] init];
    }
    return self;
}

+ (id)itemWithType:(NSInteger)type rect:(NSRect)r strokeColor:(NSColor *)strokeCol fillColor:(NSColor *)fillCol cornerRadius:(CGFloat)cornerRad {
    return [[CUI_PrintToWindowItem alloc] initWithType:type rect:r strokeColor:strokeCol fillColor:fillCol cornerRadius:cornerRad];
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.string release];
    [self.attributes release];
    [self.lineDashPattern release];
    [self.strokeColor release];
    [self.fillColor release];
    [self.shadow release];
    [super dealloc];
}
#endif
@end

@implementation CUI_PrintToWindowScrollView

- (id)initWithFrame:(NSRect)r {
    if ( (self = [super initWithFrame:r]) ) {
        self.borderType = NSNoBorder;
        self.hasHorizontalScroller = NO;
        self.hasVerticalScroller = YES;
        self.autohidesScrollers = YES;
        self.drawsBackground = NO;
        self.backgroundColor = [NSColor windowBackgroundColor];
        self.verticalScrollElasticity = NSScrollElasticityNone;
        self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    }
    return self;
}

+ (id)scrollViewWithFrame:(NSRect)r {
    id view = [[CUI_PrintToWindowScrollView alloc] initWithFrame:r];
#if !__has_feature(objc_arc)
    [view autorelease];
#endif
    return view;
}
@end

@implementation CUI_PrintToWindowView

- (id)initWithFrame:(NSRect)r {
    if ( (self = [super initWithFrame:r]) ) {
        
        [self setAutoresizingMask:NSViewWidthSizable];
        
        self.flipView = YES;

        // item array
        self.items = [[NSMutableArray alloc] initWithCapacity:0];
        
        // text
        self.textInset = 3.0;
        self.currentPoint = NSMakePoint(self.textInset,0);
        self.currentAttributes = [[NSMutableDictionary alloc] initWithCapacity:0];
        [self.currentAttributes setDictionary:CUI_PRINT_TO_WINDOW_TEXT_DEFAULTS];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setDefaultTabInterval:28.0];
        [style setTabStops:[NSArray array]];
        [self.currentAttributes setValue:style forKey:NSParagraphStyleAttributeName];
        self.currentAlignment = NSTextAlignmentLeft;
        
        // graphics
        self.currentLineWidth = 1.0;
        self.currentStrokeColor = [NSColor textColor];// change from blackColor to textColor // 20241001
        self.antialias = YES;
        
        // contextual menu// 20231005
        NSMenu *menu = [NSMenu new];
        [menu addItemWithTitle:@"Copy" action:@selector(copyAction:) keyEquivalent:@""];
        self.menu = menu;
    }
    return self;
}

+ (id)viewWithFrame:(NSRect)r {
    return [[CUI_PrintToWindowView alloc] initWithFrame:r];
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.items release];
    [self.currentAttributes release];
    [self.currentLineDashPattern release];
    [self.currentStrokeColor release];
    [self.currentFillColor release];
    [self.textString release];
    [super dealloc];
}
#endif

- (void)copyAction:(id)sender {
    NSString *string = [self textString];
    if ( string ) {
        NSPasteboard *pb = [NSPasteboard generalPasteboard];
        [pb clearContents];
        [pb declareTypes:@[NSPasteboardTypeString] owner:nil];
        [pb writeObjects:@[string]];
    }
}

- (void)fixFrameHeight:(CGFloat)height {
    NSRect r = [self bounds];
    if ( height >= self.viewH ) {
        self.viewH = height + 20;
        if ( r.size.height < self.viewH ) {
            r.size.height = self.viewH;
        }
        [self setFrameSize:r.size];
    }
}

- (void)scrollToBottom {
    NSClipView *clipView = [self.scrollView contentView];
    NSRect bounds = [[[self window] contentView] bounds];
    NSRect r = [self bounds];
    if ( r.size.height > bounds.size.height ) {
        [clipView scrollToPoint:NSMakePoint(0, self.frame.size.height - self.scrollView.contentSize.height)];
        [self.scrollView reflectScrolledClipView:clipView];
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    NSGraphicsContext *ctx = [NSGraphicsContext currentContext];
    [ctx saveGraphicsState];
    [ctx setShouldAntialias:self.antialias];
    
    
    NSBezierPath *path;
    for ( CUI_PrintToWindowItem *item in self.items ) {
        switch ( [item type] ) {
            case CUI_PrintToWindowItemTypeLine:
                if ( [item lineWidth] >= 0.0 ) {
                    
                    // shadow
                    if ( [item shadow] ) [[item shadow] set];

                    path = [NSBezierPath bezierPath];
                    [path moveToPoint:[item linePt1]];
                    [path lineToPoint:[item linePt2]];

                    // stroke width
                    [path setLineWidth:[item lineWidth]];
                    
                    // cap style
                    if ( [item lineCapStyle] ) [path setLineCapStyle:[item lineCapStyle]];
                                        
                    // dash
                    if ( [item lineDashPattern] ) {
                        NSUInteger count = [[item lineDashPattern] count];
                        CGFloat *pattern = malloc(sizeof(CGFloat)*count);
                        for ( NSUInteger index = 0; index < count; index++ ) {
                            pattern[index] = [[[item lineDashPattern] objectAtIndex:index] doubleValue];
                        }
                        [path setLineDash:pattern count:count phase:[item lineDashPhase]];
                        free(pattern);
                    }
                    
                    // stroke color
                    [[item strokeColor] set];
                    
                    [path stroke];
                }
                break;
                
            case CUI_PrintToWindowItemTypeOval:
                
                // shadow
                if ( [item shadow] ) [[item shadow] set];

                path = [NSBezierPath bezierPathWithOvalInRect:[item rect]];
                
                if ( [item fillColor] ) {
                    [[item fillColor] set];
                    [path fill];
                }
                
                if ( [item lineWidth] >= 0.0 ) {
                    // line width
                    [path setLineWidth:[item lineWidth]];
                    
                    // cap style
                    if ( [item lineCapStyle] ) [path setLineCapStyle:[item lineCapStyle]];
                    
                    // dash
                    if ( [item lineDashPattern] ) {
                        NSUInteger count = [[item lineDashPattern] count];
                        CGFloat *pattern = malloc(sizeof(CGFloat)*count);
                        for ( NSUInteger index = 0; index < count; index++ ) {
                            pattern[index] = [[[item lineDashPattern] objectAtIndex:index] doubleValue];
                        }
                        [path setLineDash:pattern count:count phase:[item lineDashPhase]];
                        free(pattern);
                    }
                    
                    [[item strokeColor] set];
                    [path stroke];
                }
                break;
                
            case CUI_PrintToWindowItemTypeRect:
                
                // shadow
                if ( [item shadow] ) [[item shadow] set];

                // corner radius
                if ( [item cornerRadius] > 0.0 ) {
                    path = [NSBezierPath bezierPathWithRoundedRect:[item rect] xRadius:[item cornerRadius] yRadius:[item cornerRadius]];
                } else {
                    path = [NSBezierPath bezierPathWithRect:[item rect]];
                }
                
                // fill color
                if ( [item fillColor] ) {
                    [[item fillColor] set];
                    [path fill];
                }
                
                if ( [item lineWidth] >= 0.0 ) {
                //if ( [item strokeColor] ) {
                    // line width
                    [path setLineWidth:[item lineWidth]];
                    
                    // cap style
                    if ( [item lineCapStyle] ) [path setLineCapStyle:[item lineCapStyle]];
                        
                    // dash
                    if ( [item lineDashPattern] ) {
                        NSUInteger count = [[item lineDashPattern] count];
                        CGFloat *pattern = malloc(sizeof(CGFloat)*count);
                        for ( NSUInteger index = 0; index < count; index++ ) {
                            pattern[index] = [[[item lineDashPattern] objectAtIndex:index] doubleValue];
                        }
                        [path setLineDash:pattern count:count phase:[item lineDashPhase]];
                        free(pattern);
                    }
                    [[item strokeColor] set];

                    [path stroke];
                }
                break;
                
            case CUI_PrintToWindowItemTypeText:
            default:
                // shadow
                if ( [item shadow] ) [[item shadow] set];
                
                [[item string] drawAtPoint:[item pt] withAttributes:[item attributes]];
                break;
        }
    }
    
    [ctx restoreGraphicsState];

    if ( self.autoscrolls && self.scrollNow ) {// 20240425
        //[self performSelector:@selector(scrollToBottom) withObject:nil afterDelay:0.0];
        dispatch_async( dispatch_get_main_queue(),^{ // 20241221
            [self scrollToBottom];
        });
        self.scrollNow = NO;
    }
}

- (BOOL)isFlipped {
    return self.flipView;
}

- (NSPoint)addString:(NSString *)string {
    BOOL alert = NO, lineFeed = YES;// 20231130
    
    if ( [string containsString:@"\a"] ) {
        alert = YES;
        string = [string stringByReplacingOccurrencesOfString:@"\a" withString:@""];
    }
    
    long tabCount = 0;
    while ( [string hasSuffix:@"\b"] || [string hasSuffix:@"\t"] ) {
        if ( [string hasSuffix:@"\b"] ) {
            lineFeed = NO;
        }
        if ( [string hasSuffix:@"\t"] ) {
            tabCount++;
            lineFeed = NO;
        }
        string = [string substringToIndex:[string length]-1];
    }
    if ( tabCount ) {
        for ( long i = 0; i < tabCount; i++ ) {
            string = [string stringByAppendingString:@"\t"];
        }
    }
    
    if ( alert ) {
        //string = [string substringToIndex:[string length]-1];
        NSString *msg = string;
        NSString *info = nil;
        NSRange range = [string rangeOfString:@"\n"];
        if ( range.location != NSNotFound ) {
            msg = [string substringToIndex:range.location];
            info = [string substringFromIndex:range.location+1];
        }
        NSAlert *alert = [[NSAlert alloc] init];
#if !__has_feature(objc_arc)
        [alert autorelease];
#endif
        [alert setMessageText:msg];
        if ( info ) [alert setInformativeText:info];
        [alert addButtonWithTitle:@"Continue"];
        [alert runModal];
    }

    if ( lineFeed ) {
        string = [string stringByAppendingString:@"\n"];
    }
        
//    CGFloat maxX = 0.0;
    
    if ( !self.textString ) self.textString = [[NSMutableString alloc] initWithCapacity:0];
    [self.textString appendString:string];
    
    NSFont *font = [self.currentAttributes objectForKey:NSFontAttributeName];
    CGFloat lineHeight = [[[NSLayoutManager alloc] init] defaultLineHeightForFont:font];
    NSArray *lines = [string componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSUInteger count = [lines count];
    for ( NSUInteger index = 0; index < count; index++ ) {
        NSString *line = lines[index];
        
        NSAttributedString *aString = [[NSAttributedString alloc] initWithString:line attributes:self.currentAttributes];
        CGRect lineRect = [aString boundingRectWithSize:CGSizeMake(10000,10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];

//        if ( (lineRect.origin.x + lineRect.size.width) > maxX ) maxX = lineRect.origin.x + lineRect.size.width;
        
        NSPoint pt = self.currentPoint;
        
        switch ( self.currentAlignment ) {
            case NSTextAlignmentCenter:
                pt.x = ([self bounds].size.width - lineRect.size.width)/2.0;
                break;
            case NSTextAlignmentRight:
                pt.x = [self bounds].size.width - lineRect.size.width;
                break;
            default:
            case NSTextAlignmentLeft:
                pt = self.currentPoint;
                break;
        }
        
        CUI_PrintToWindowItem *item = [CUI_PrintToWindowItem itemWithString:line point:pt attributes:[NSDictionary dictionaryWithDictionary:self.currentAttributes]];
                
        // shadow
        if ( self.currentShadow ) [item setShadow:self.currentShadow];// 20240217

        [self.items addObject:item];

        if ( index == count - 1 ) {
            //_currentPoint.x += lineRect.size.width;
            NSPoint tempPoint = self.currentPoint;
            tempPoint.x += lineRect.size.width;
            self.currentPoint = tempPoint;
            
        } else {
            //_currentPoint.x = self.textInset;
            NSPoint tempPoint = self.currentPoint;
            tempPoint.x = self.textInset;
            self.currentPoint = tempPoint;

            //_currentPoint.y += lineHeight;
            tempPoint = self.currentPoint;
            tempPoint.y += lineHeight;
            self.currentPoint = tempPoint;
        }
    }
    
    //[self fixFrameWidth:maxX height:self.currentPoint.y];
    [self fixFrameHeight:self.currentPoint.y+lineHeight];// +lineHeight added to stop text clipping at bottom 20221128

    self.scrollNow = self.autoscrolls;
    [self setNeedsDisplay:YES];
        
    return self.currentPoint;
}

- (NSPoint)addString:(NSString *)string at:(NSPoint)pt {
    self.currentPoint = pt;
    return [self addString:string];
}

- (void)setColumn:(CGFloat)col row:(CGFloat)row {
    NSFont *font = [self.currentAttributes objectForKey:NSFontAttributeName];
    CGFloat lineHeight = [[[NSLayoutManager alloc] init] defaultLineHeightForFont:font];
    CGFloat charWidth = [[[NSAttributedString alloc] initWithString:@"0" attributes:self.currentAttributes] size].width;
    CGFloat x = charWidth * col;
    CGFloat y = lineHeight * row;
    self.currentPoint = NSMakePoint(x,y);
        
    //[self fixFrameWidth:self.currentPoint.x height:self.currentPoint.y];
    [self fixFrameHeight:self.currentPoint.y];
}

- (void)setFontName:(NSString *)name {
    NSFont *font = [self.currentAttributes objectForKey:NSFontAttributeName];
    NSFont *newFont = [NSFont fontWithName:name size:[font pointSize]];
    if ( newFont ) [self.currentAttributes setValue:newFont forKey:NSFontAttributeName];
}

- (void)setFontSize:(CGFloat)size {
    NSFont *font = [self.currentAttributes objectForKey:NSFontAttributeName];
    [self.currentAttributes setValue:[NSFont fontWithName:[font fontName] size:size] forKey:NSFontAttributeName];
}

- (void)setForegroundColor:(NSColor *)col {
    [self.currentAttributes setValue:col forKey:NSForegroundColorAttributeName];
}

- (void)setBackgroundColor:(NSColor *)col {
    [self.currentAttributes setValue:col forKey:NSBackgroundColorAttributeName];
}

- (void)setAttributes:(NSDictionary *)attributes {
    for ( NSString *key in [attributes allKeys] ) {
        [self.currentAttributes setValue:[attributes objectForKey:key] forKey:key];
    }
}

- (void)setAlignment:(NSTextAlignment)alignment {
    self.currentAlignment = alignment;
}

- (void)setTabInterval:(CGFloat)interval {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setDefaultTabInterval:interval];
    [style setTabStops:[NSArray array]];
    [self.currentAttributes setValue:style forKey:NSParagraphStyleAttributeName];
}

- (void)resetAttributes {
    self.currentAttributes = [[NSMutableDictionary alloc] initWithCapacity:0];
    [self.currentAttributes setDictionary:CUI_PRINT_TO_WINDOW_TEXT_DEFAULTS];
    [self setTabInterval:28.0];
    self.currentAlignment = NSTextAlignmentLeft;
    self.antialias = YES;
}

- (void)clear {
    [self.items removeAllObjects];
#if !__has_feature(objc_arc)
    [self.textString release];
#endif
    self.textString = nil;
    self.currentPoint = NSMakePoint(self.textInset,0);
    
    self.viewH = 0.0;
    self.viewW = 0.0;
    NSRect r = [[[self window] contentView] bounds];
    r.size.height = 1.0;
    [self setFrameSize:r.size];
    
    [self setNeedsDisplay:YES];
}

// draw
- (void)setLineStyleForItem:(CUI_PrintToWindowItem *)item {
    [item setLineWidth:self.currentLineWidth];
    [item setStrokeColor:self.currentStrokeColor];
    [item setLineCapStyle:self.currentLineCapStyle];
    [item setLineDashPattern:self.currentLineDashPattern];
    [item setLineDashPhase:self.currentLineDashPhase];
}


- (void)addLines:(NSArray *)lines fromCurrentLocation:(BOOL)from {
    NSPoint prevPt = NSZeroPoint;
    if ( from ) {
        prevPt = self.currentLinePoint;
    } else {
        prevPt = [[lines objectAtIndex:0] pointValue];
        if ( [lines count] == 1 ) {
            self.currentLinePoint = prevPt;
            return;
        }
    }
    
    //CGFloat maxX = 0.0;
    CGFloat maxY = 0.0;
    
    for ( NSUInteger index = 0; index < [lines count]; index++) {
        NSPoint pt1 = prevPt;
        NSPoint pt2 = [[lines objectAtIndex:index] pointValue];
        CUI_PrintToWindowItem *item = [CUI_PrintToWindowItem itemWithLinePoint1:pt1 linePoint2:pt2];
        
        // shadow
        if ( self.currentShadow ) [item setShadow:self.currentShadow];

        [self setLineStyleForItem:item];
        [self.items addObject:item];
        prevPt = pt2;
        
        //if ( prevPt.x > maxX ) maxX = prevPt.x + [item lineWidth] / 2;
        if ( prevPt.y > maxY ) maxY = prevPt.y + [item lineWidth] / 2;

    }
    self.currentLinePoint = prevPt;
    
    //[self fixFrameWidth:maxX height:maxY];
    [self fixFrameHeight:maxY];

}

- (void)addOvalWithRect:(NSRect)r strokeColor:(NSColor *)strokeCol fillColor:(NSColor *)fillCol {
    CUI_PrintToWindowItem *item = [CUI_PrintToWindowItem itemWithType:CUI_PrintToWindowItemTypeOval rect:r strokeColor:strokeCol fillColor:fillCol cornerRadius:-1.0];
    
    [self setLineStyleForItem:item];

    // stroke color
    [item setStrokeColor:strokeCol];

    // fill color
    [item setFillColor:fillCol];

    // line cap style
    [item setLineCapStyle:self.currentLineCapStyle];
    
    // dash pattern
    [item setLineDashPattern:self.currentLineDashPattern];

    // dash phase
    [item setLineDashPhase:self.currentLineDashPhase];

    // shadow
    if ( self.currentShadow ) [item setShadow:self.currentShadow];

    [self.items addObject:item];
    
    //[self fixFrameWidth:r.origin.x + r.size.width + [item lineWidth] / 2 height:r.origin.y + r.size.height + [item lineWidth] / 2];
    [self fixFrameHeight:r.origin.y + r.size.height + [item lineWidth] / 2];
    
}

- (void)addRectWithRect:(NSRect)r strokeColor:(NSColor *)strokeCol fillColor:(NSColor *)fillCol cornerRadius:(CGFloat)cornerRadius {
    CUI_PrintToWindowItem *item = [CUI_PrintToWindowItem itemWithType:CUI_PrintToWindowItemTypeRect rect:r strokeColor:strokeCol fillColor:fillCol cornerRadius:cornerRadius];
    [item setLineWidth:self.currentLineWidth];
    
    [self setLineStyleForItem:item];

    // stroke color
    [item setStrokeColor:strokeCol];

    // fill color
    [item setFillColor:fillCol];
    
    // line cap style
    [item setLineCapStyle:self.currentLineCapStyle];
    
    // dash pattern
    [item setLineDashPattern:self.currentLineDashPattern];

    // dash phase
    [item setLineDashPhase:self.currentLineDashPhase];

    // shadow
    if ( self.currentShadow ) [item setShadow:self.currentShadow];
    
    [self.items addObject:item];
    
    //[self fixFrameWidth:r.origin.x + r.size.width + [item lineWidth] / 2 height:r.origin.y + r.size.height + [item lineWidth] / 2];
    [self fixFrameHeight:r.origin.y + r.size.height + [item lineWidth] / 2];
    
}

- (NSArray *)itemArray {
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
    for ( CUI_PrintToWindowItem *item in self.items ) {
        NSDictionary *dict = @{@"type":@(item.type),
                               @"pt":[NSValue valueWithPoint:item.pt],
                               @"pt1":[NSValue valueWithPoint:item.linePt1],
                               @"pt2":[NSValue valueWithPoint:item.linePt2],
                               @"rect":[NSValue valueWithRect:item.rect],
                               @"lineWidth":@(item.lineWidth),
                               @"lineCapStyle":@(item.lineCapStyle),
                               @"lineDashPhase":@(item.lineDashPhase),
                               @"strokeFlag":@(item.strokeFlag),
                               @"fillFlag":@(item.fillFlag)
        };
        NSMutableDictionary *mutDict = [NSMutableDictionary dictionaryWithCapacity:0];
        [mutDict addEntriesFromDictionary:dict];
        if ( item.string ) [mutDict setValue:item.string forKey:@"text"];
        if ( item.attributes ) [mutDict setValue:item.string forKey:@"attributes"];
        if ( item.lineDashPattern ) [mutDict setValue:item.lineDashPattern forKey:@"lineDashPattern"];
        if ( item.strokeColor ) [mutDict setValue:item.strokeColor forKey:@"strokeColor"];
        if ( item.fillColor ) [mutDict setValue:item.fillColor forKey:@"fillColor"];
        
        [items addObject:mutDict];
    }
    return items;
}
@end

NSWindow *CUI_PrintToWindowWindow( void )
{
    // if no windows exist, create one with tag 999999 // 20220804
    NSInteger wndTag = kFBParamMissing;
    NSWindow *w = CUI_TargetWindow( &wndTag );
    if ( !w ) {
        CUI_Window( 999999, (__bridge CFStringRef)@"• Print to Window •", CGRectZero, kFBParamMissing );
        wndTag = kFBParamMissing;
        w = CUI_TargetWindow( &wndTag );
    }
    return w;
}

CUI_PrintToWindowView *CUI_PrintToWindowViewObj( NSWindow *w )
{
    NSView *contentView = [w contentView];
    NSArray *subviews = [contentView subviews];
    for ( NSView *view in subviews ) {
        if ( [view isKindOfClass:[CUI_PrintToWindowScrollView class]] ) {
            return (CUI_PrintToWindowView *)[(CUI_PrintToWindowScrollView *)view documentView];
        }
    }

    // create
    NSRect r = [contentView bounds];
    CUI_PrintToWindowScrollView *scrollView = [CUI_PrintToWindowScrollView scrollViewWithFrame:r];
    r = [[scrollView contentView] bounds]; // 20221116
    r.size.height = 1;                     // 20221116
    //CUI_PrintToWindowView *view = [CUI_PrintToWindowView viewWithFrame:NSMakeRect(r.origin.x,r.origin.y,r.size.width,1)];
    CUI_PrintToWindowView *view = [CUI_PrintToWindowView viewWithFrame:r]; // 20221116
    [view setTextInset:3];
    
    [scrollView setDocumentView:view];
    [contentView addSubview:scrollView positioned:NSWindowBelow relativeTo:nil];
    [view setScrollView:scrollView];
    
    return view;
}


CUI_PrintToWindowScrollView *CUI_PrintToWindowScrollViewObj( NSInteger wndTag )
{
    NSWindow *w = nil;
    if ( wndTag == kFBParamMissing ) {
        w = CUI_TargetWindow( &wndTag );
    } else {
        w = CUI_WindowWithTag( wndTag );
    }
    if ( w ) {
        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
        if ( view ) return [view scrollView];
    }
    return nil;
}

void CUI_PrintToWindowSetXY( NSWindow *w, CGFloat x, CGFloat y )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view setCurrentPoint:NSMakePoint(x,y)];
}

void CUI_PrintToWindowSetColRow( NSWindow *w, CGFloat col, CGFloat row )// 20211207
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view setColumn:col row:row];
}

void CUI_PrintToWindowPrint( NSWindow *w, NSString *string )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view addString:string];
}

void CUI_PrintToWindowTextSetFontName( NSWindow *w, NSString *name )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view setFontName:name];
}

void CUI_PrintToWindowTextSetFontSize( NSWindow *w, CGFloat size )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view setFontSize:size];
}

void CUI_PrintToWindowTextSetForegroundColor( NSWindow *w, NSColor *col )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view setForegroundColor:col];
}

void CUI_PrintToWindowTextSetBackgroundColor( NSWindow *w, NSColor *col )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view setBackgroundColor:col];
}

void CUI_PrintToWindowTextSetAlignment( NSWindow *w, NSTextAlignment alignment )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view setAlignment:alignment];
}

void CUI_PrintToWindowTextSetTabInterval( NSWindow *w, CGFloat interval )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view setTabInterval:interval];
}

void CUI_PrintToWindowClear( NSWindow *w )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view clear];
}

void CUI_PrintToWindowTextReset( NSWindow *w )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view resetAttributes];
}


// draw to window
void CUI_DrawToWindowLines( NSWindow *w, NSArray *lines )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view addLines:lines fromCurrentLocation:NO];
    [view setNeedsDisplay:YES];
}

void CUI_DrawToWindowToLines( NSWindow *w, NSArray *lines )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view addLines:lines fromCurrentLocation:YES];
    [view setNeedsDisplay:YES];
}

void CUI_DrawToWindowLineWidth( NSWindow *w, CGFloat width )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view setCurrentLineWidth:width];
}

void CUI_DrawToWindowPen( NSWindow *w, CGFloat width, NSColor *col, long capStyle, NSArray *dashPattern, CGFloat dashPhase, NSShadow *inShadow )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );

    // line width
    if ( (long)width != kFBParamMissing ) {
        [view setCurrentLineWidth:width];
    }
        
    // stroke color
    if ( col ) [view setCurrentStrokeColor:col];

    // cap style
    if ( capStyle != kFBParamMissing ) [view setCurrentLineCapStyle:capStyle];
        
    // dash pattern
    if ( dashPattern ) [view setCurrentLineDashPattern:dashPattern];
    
    // dash phase
    if ( (long)dashPhase != kFBParamMissing ) {
        [view setCurrentLineDashPhase:dashPhase];
    }
    
    // shadow
    if ( inShadow ) {
        [view setCurrentShadow:inShadow];
     }
}

void CUI_DrawToWindowPenReset( NSWindow *w )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    [view setCurrentLineWidth:1.0];
    [view setCurrentLineCapStyle:0];
    [view setCurrentLineDashPattern:nil];
    [view setCurrentLineDashPhase:0.0];
    [view setCurrentStrokeColor:[NSColor textColor]];// change from blackColor to textColor // 20241001
    [view setCurrentFillColor:nil];
    [view setCurrentCornerRadius:0.0];
    [view setCurrentShadow:[[NSShadow alloc] init]];
    [view setAntialias:YES];
}

void CUI_DrawToWindowOval( NSWindow *wnd, NSRect rect, NSColor *fillCol, BOOL fillFlag )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( wnd );

    NSColor *strokeColor = [view currentStrokeColor];
    
    NSColor *fillColor = nil;
    if ( fillFlag == YES ) {
        if ( fillCol ) {
            fillColor = fillCol;
        } else {
            fillColor = [view currentFillColor];
        }
    }
    if ( fillCol ) [view setCurrentFillColor:fillCol];

    [view addOvalWithRect:rect strokeColor:strokeColor fillColor:fillColor];
    [view setNeedsDisplay:YES];
}

void CUI_DrawToWindowRect( NSWindow *wnd, NSRect rect, NSColor *fillCol, CGFloat cornerRadius, BOOL fillFlag )
{
    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( wnd );

    NSColor *strokeColor = [view currentStrokeColor];

    NSColor *fillColor = nil;
    if ( fillFlag == YES ) {
        if ( fillCol ) {
            fillColor = fillCol;
        } else {
            fillColor = [view currentFillColor];
        }
    }
    if ( fillCol ) [view setCurrentFillColor:fillCol];

    if ( cornerRadius > 0.0 ) {
        [view setCurrentCornerRadius:cornerRadius];
    } else {
        if ( cornerRadius < 0.0 ) cornerRadius = [view currentCornerRadius];
    }
    
    [view addRectWithRect:rect strokeColor:strokeColor fillColor:fillColor cornerRadius:cornerRadius];
    [view setNeedsDisplay:YES];
}

// print to window statements
void CUI_PrintToWindowSetXYStatement( CGFloat x, CGFloat y )
{
    //NSInteger wndTag = kFBParamMissing;
    //NSWindow *w = CUI_TargetWindow( &wndTag );
    NSWindow *w = CUI_PrintToWindowWindow();// 20220804
    if ( w ) {
        CUI_PrintToWindowSetXY( w, x, y );
    }
}

void CUI_PrintToWindowSetColRowStatement( CGFloat col, CGFloat row )// 20211207
{
    //NSInteger wndTag = kFBParamMissing;
    //NSWindow *w = CUI_TargetWindow( &wndTag );
    NSWindow *w = CUI_PrintToWindowWindow();// 20220804
    if ( w ) {
        CUI_PrintToWindowSetColRow( w, col, row );
    }
}


#pragma mark - Print to window utilities
CUI_PrintToWindowView *WindowPrintView( NSInteger tag )
{
    NSWindow *w = nil;
    if ( tag == 0 ) {
        tag = kFBParamMissing;
        w = CUI_TargetWindow( &tag );
    } else {
        w = CUI_WindowWithTag( tag );
    }
    if ( w ) return CUI_PrintToWindowViewObj( w );
    return nil;
}

CFStringRef WindowPrintViewString( NSInteger tag )
{
//    NSWindow *w = nil;
//    if ( tag == 0 ) {
//        tag = kFBParamMissing;
//        w = CUI_TargetWindow( &tag );
//    } else {
//        w = CUI_WindowWithTag( tag );
//    }
//    if ( w ) {
//        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    CUI_PrintToWindowView *view = WindowPrintView( tag );
    if ( view ) {
        NSString *string = [view textString];
        if ( !string ) string = @"";
        return (__bridge CFStringRef)string;
    }
//    }
    return (__bridge CFStringRef)@"";
}

CFArrayRef WindowPrintViewItems( NSInteger tag )
{
//    NSWindow *w = nil;
//    if ( tag == 0 ) {
//        tag = kFBParamMissing;
//        w = CUI_TargetWindow( &tag );
//    } else {
//        w = CUI_WindowWithTag( tag );
//    }
//    if ( w ) {
//        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    CUI_PrintToWindowView *view = WindowPrintView( tag );
    if ( view ) {
        NSArray *array = [view itemArray];
        if ( !array ) array = @[];
        return (__bridge CFArrayRef)array;
    }
//    }
    return (__bridge CFArrayRef)@[];
}

CGFloat WindowPrintViewTextInset( NSInteger tag )
{
//    NSWindow *w = nil;
//    if ( tag == 0 ) {
//        tag = kFBParamMissing;
//        w = CUI_TargetWindow( &tag );
//    } else {
//        w = CUI_WindowWithTag( tag );
//    }
//    if ( w ) {
//        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    CUI_PrintToWindowView *view = WindowPrintView( tag );
    if ( view ) return [view textInset];
//    }
    return 0.0;
}

void WindowPrintViewSetTextInset( NSInteger tag, CGFloat inset )
{
//    NSWindow *w = nil;
//    if ( tag == 0 ) {
//        tag = kFBParamMissing;
//        w = CUI_TargetWindow( &tag );
//    } else {
//        w = CUI_WindowWithTag( tag );
//    }
//    if ( w ) {
//        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
        CUI_PrintToWindowView *view = WindowPrintView( tag );
    if ( view ) {
        [view setTextInset:inset];
        NSPoint pt = [view currentPoint];
        [view setCurrentPoint:NSMakePoint(inset,pt.y)];
    }
//    }
}

void WindowPrintViewSetPosition( NSInteger tag, NSWindowOrderingMode place, NSInteger otherViewTag )// 20211206
{
    NSWindow *w = nil;
    if ( tag == 0 ) {
        tag = kFBParamMissing;
        w = CUI_TargetWindow( &tag );
    } else {
        w = CUI_WindowWithTag( tag );
    }
    if ( w ) {
        
//        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
//        if ( view ) {
//            NSView *otherView = nil;
//            if ( otherViewTag ) otherView = CUI_ViewWithTag( otherViewTag );
//            [view removeFromSuperview];
//            [[w contentView] addSubview:view positioned:place relativeTo:otherView];
//        }
        
        // 20240206
        CUI_PrintToWindowScrollView *scrollView = CUI_PrintToWindowScrollViewObj( tag );
        if ( scrollView ) {
            NSView *otherView = nil;
            if ( otherViewTag ) otherView = CUI_ViewWithTag( otherViewTag );
            [scrollView removeFromSuperview];
            [[w contentView] addSubview:scrollView positioned:place relativeTo:otherView];
        }

    }
}

void WindowPrintViewSetFlipped( NSInteger wndTag, BOOL flag )
{
//    NSWindow *w = nil;
//    if ( wndTag == 0 ) {
//        wndTag = kFBParamMissing;
//        w = CUI_TargetWindow( &wndTag );
//    } else {
//        w = CUI_WindowWithTag( wndTag );
//    }
//    if ( w ) {
//        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    CUI_PrintToWindowView *view = WindowPrintView( wndTag );
    if ( view ) {
        [view setFlipView:flag];
    }
//    }
}

CGPoint WindowPrintViewCurrentLocation( NSInteger wndTag )// 20221103
{
//    NSWindow *w = nil;
//    if ( wndTag == 0 ) {
//        wndTag = kFBParamMissing;
//        w = CUI_TargetWindow( &wndTag );
//    } else {
//        w = CUI_WindowWithTag( wndTag );
//    }
//    if ( w ) {
//        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    CUI_PrintToWindowView *view = WindowPrintView( wndTag );
    if ( view ) return NSPointToCGPoint([view currentPoint]);
//    }
    return CGPointZero;
}

void WindowPrintViewSetAttributes( NSInteger wndTag, CFDictionaryRef attributes ) // 20230220
{
//    NSWindow *w = nil;
//    if ( wndTag == 0 ) {
//        wndTag = kFBParamMissing;
//        w = CUI_TargetWindow( &wndTag );
//    } else {
//        w = CUI_WindowWithTag( wndTag );
//    }
//    if ( w ) {
//        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    CUI_PrintToWindowView *view = WindowPrintView( wndTag );
    if ( view ) {
        [[view currentAttributes] setDictionary:(__bridge NSDictionary *)attributes];
    }
//    }
}

void WindowPrintViewUndo( NSInteger wndTag )// 20221103
{
//    NSWindow *w = nil;
//    if ( wndTag == 0 ) {
//        wndTag = kFBParamMissing;
//        w = CUI_TargetWindow( &wndTag );
//    } else {
//        w = CUI_WindowWithTag( wndTag );
//    }
//    if ( w ) {
//        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    CUI_PrintToWindowView *view = WindowPrintView( wndTag );
    if ( view ) {
        [[view items] removeLastObject];
        [view setNeedsDisplay:YES];
    }
//    }
}

void WindowPrintViewSetHasVerticalScroller( NSInteger wndTag, BOOL flag ) // 20221107
{
    CUI_PrintToWindowScrollView *scrollView = CUI_PrintToWindowScrollViewObj( wndTag );
    if ( scrollView ) [scrollView setHasVerticalScroller:flag];
}

void WindowPrintViewSetAutoscrolls( NSInteger wndTag, BOOL flag )         // 20240425
{
    NSWindow *w = nil;
    if ( wndTag == 0 ) {
        wndTag = kFBParamMissing;
        w = CUI_TargetWindow( &wndTag );
    } else {
        w = CUI_WindowWithTag( wndTag );
    }
    if ( w ) {
        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
        
    //CUI_PrintToWindowView *view = WindowPrintView( wndTag );
    if ( view ) {
        [view setAutoscrolls:flag];
    }
   }
}

void WindowPrintViewScrollToTop( NSInteger wndTag )                       // 20221108
{
    CUI_PrintToWindowScrollView *scrollView = CUI_PrintToWindowScrollViewObj( wndTag );
    if ( scrollView ) {
        NSClipView *clipView = [scrollView contentView];
        [clipView scrollToPoint:NSZeroPoint];
        [scrollView reflectScrolledClipView:clipView];
    }
}

void WindowPrintViewScrollToBottom( NSInteger wndTag )                    // 20221108
{
    CUI_PrintToWindowScrollView *scrollView = CUI_PrintToWindowScrollViewObj( wndTag );
    if ( scrollView ) {
        NSWindow *w = CUI_PrintToWindowWindow();
        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
        [view scrollToBottom];
    }
}

void WindowPrintViewScrollToPoint( NSInteger wndTag, CGPoint pt )         // 20221108
{
    CUI_PrintToWindowScrollView *scrollView = CUI_PrintToWindowScrollViewObj( wndTag );
    if ( scrollView ) {
        NSClipView *clipView = [scrollView contentView];
        NSRect r = [clipView bounds];
        if ( pt.y > r.size.height ) pt.y = r.size.height;
        [clipView scrollToPoint:NSPointFromCGPoint(pt)];
        [scrollView reflectScrolledClipView:clipView];
    }
}

void WindowPrintViewScrollerSetHidden( NSInteger wndTag, BOOL flag )    // 20240210
{
    CUI_PrintToWindowScrollView *scrollView = CUI_PrintToWindowScrollViewObj( wndTag );
    if ( scrollView ) [scrollView setHidden:flag];
}

NSInteger WindowPrintViewItemCount( NSInteger wndTag )                        // 20241011
{
    CUI_PrintToWindowView *view = WindowPrintView( wndTag );
    if ( view ) {
        return [[view items] count];
    }
    return 0;
}

NSInteger WindowPrintViewItemTypeAtIndex( NSInteger wndTag, NSInteger index ) // 20241011
{
    CUI_PrintToWindowView *view = WindowPrintView( wndTag );
    if ( view ) {
        NSArray *items = [view items];
        NSInteger count = [items count];
        if ( index < count ) {
            CUI_PrintToWindowItem *item = items[index];
            return [item type];
        }
    }
    return -1;
}

void WindowPrintViewRemoveItemAtIndex( NSInteger wndTag, NSInteger index )      // 20241010
{
//    NSWindow *w = nil;
//    if ( wndTag == 0 ) {
//        wndTag = kFBParamMissing;
//        w = CUI_TargetWindow( &wndTag );
//    } else {
//        w = CUI_WindowWithTag( wndTag );
//    }
//    if ( w ) {
//        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    CUI_PrintToWindowView *view = WindowPrintView( wndTag );
    if ( view ) {
        NSMutableArray *items = [view items];
        [items removeObjectAtIndex:index];
        [view setNeedsDisplay:YES];
    }
//    }
}

void WindowPrintViewSetShouldAntialias( NSInteger wndTag, BOOL flag ) // 20241011
{
//    NSWindow *w = nil;
//    if ( wndTag == 0 ) {
//        wndTag = kFBParamMissing;
//        w = CUI_TargetWindow( &wndTag );
//    } else {
//        w = CUI_WindowWithTag( wndTag );
//    }
//    if ( w ) {
//        CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
    CUI_PrintToWindowView *view = WindowPrintView( wndTag );
    if ( view ) {
        [view setAntialias:flag];
    }
//    }
}

void WindowSetPrintViewPosition( NSInteger tag, NSWindowOrderingMode place, NSInteger otherViewTag )// deprecated 20220707
{ WindowPrintViewSetPosition( tag, place, otherViewTag ); }

void WindowSetPrintViewFlipped( NSInteger wndTag, BOOL flag )// deprecated 20220707
{ WindowPrintViewSetFlipped( wndTag, flag ); }

void CUI_PrintToWindowPrintStatement( id obj, ... )
{
    va_list ap;
    va_start(ap,obj);
    NSWindow *w = CUI_PrintToWindowWindow();// 20220804
    if ( w ) {
        NSMutableArray *strings = [NSMutableArray arrayWithCapacity:0];
        while ( obj ) {
            [strings addObject:obj];
            obj = va_arg( ap, id );
        }
        NSString *string = [strings componentsJoinedByString:@""];
        CUI_PrintToWindowPrint( w, string );
    }
    va_end(ap);
}

void CUI_PrintToWindowPrintFStatement( id fmt, ... )
{
    va_list ap;
    va_start(ap,fmt);
    NSWindow *w = CUI_PrintToWindowWindow();// 20220804
    if ( w ) {
        NSString *string = [[NSString alloc] initWithFormat:fmt arguments:ap];
        CUI_PrintToWindowPrint( w, string );
    }
    va_end(ap);
}

void CUI_PrintToWindowClearStatement( void )
{
    //NSInteger wndTag = kFBParamMissing;
    //NSWindow *w = CUI_TargetWindow( &wndTag );
    NSWindow *w = CUI_PrintToWindowWindow();// 20220804
    if ( w ) CUI_PrintToWindowClear( w );
}

void CUI_PrintToWindowTextStatement( CFStringRef fontName, CGFloat fontSize, long inForeColor, long inBackColor, NSInteger alignment, NSInteger tabInterval )
{
    NSColor *foreColor = CUI_FixColor( inForeColor );
    NSColor *backColor = CUI_FixColor( inBackColor );
    NSWindow *w = CUI_PrintToWindowWindow();// 20220804
    if ( w ) {
        if ( fontName ) CUI_PrintToWindowTextSetFontName( w, (__bridge NSString *)fontName );
        if ( fontSize > 0.0 ) CUI_PrintToWindowTextSetFontSize( w, fontSize );
        if ( foreColor ) CUI_PrintToWindowTextSetForegroundColor( w, foreColor );
        if ( backColor ) CUI_PrintToWindowTextSetBackgroundColor( w, backColor );
        if ( alignment != kFBParamMissing ) CUI_PrintToWindowTextSetAlignment( w, alignment );
        if ( tabInterval != kFBParamMissing ) CUI_PrintToWindowTextSetTabInterval( w, tabInterval );
    }
}

void CUI_PrintToWindowTextResetStatement( void )
{
    NSWindow *w = CUI_PrintToWindowWindow();// 20220804
    if ( w ) CUI_PrintToWindowTextReset( w );
}


// draw to window statements
void CUI_DrawToWindowLineStatement( id obj, ... )
{
    va_list ap;
    va_start(ap,obj);
    //NSInteger wndTag = kFBParamMissing;
    //NSWindow *w = CUI_TargetWindow( &wndTag );
    NSWindow *w = CUI_PrintToWindowWindow();// 20220804
    if ( w ) {
        BOOL xFlag = YES;
        CGFloat xValue = 0.0;
        CGFloat yValue = 0.0;
        NSMutableArray *lines = [NSMutableArray arrayWithCapacity:0];
        while ( obj ) {
            if ( xFlag ) {
                xValue = [obj doubleValue];
                xFlag = NO;
            } else {
                yValue = [obj doubleValue];
                [lines addObject:[NSValue valueWithPoint:NSMakePoint(xValue,yValue)]];
                xFlag = YES;
            }
            obj = va_arg( ap, id );
        }
        CUI_DrawToWindowLines( w, lines );
    }
    va_end(ap);
}

void CUI_DrawToWindowLineToStatement( id obj, ... )
{
    va_list ap;
    va_start(ap,obj);
    NSWindow *w = CUI_PrintToWindowWindow();// 20220804
    if ( w ) {
        BOOL xFlag = YES;
        CGFloat xValue = 0.0;
        CGFloat yValue = 0.0;
        NSMutableArray *lines = [NSMutableArray arrayWithCapacity:0];
        while ( obj ) {
            if ( xFlag ) {
                xValue = [obj doubleValue];
                xFlag = NO;
            } else {
                yValue = [obj doubleValue];
                [lines addObject:[NSValue valueWithPoint:NSMakePoint(xValue,yValue)]];
                xFlag = YES;
            }
            obj = va_arg( ap, id );
        }
        CUI_DrawToWindowToLines( w, lines );
    }
    va_end(ap);
}

void CUI_DrawToWindowPenStatement( CGFloat width, long inCol, long capStyle, NSArray *dashPattern, CGFloat dashPhase, NSShadow *inShadow )
{
    NSColor *col = CUI_FixColor( inCol );
    NSWindow *w = CUI_PrintToWindowWindow();// 20220804
    if ( w ) {
        CUI_DrawToWindowPen( w, width, col, capStyle, dashPattern, dashPhase, inShadow );
    }
}

void CUI_DrawToWindowPenResetStatement( void )
{
    //NSInteger wndTag = kFBParamMissing;
    //NSWindow *w = CUI_TargetWindow( &wndTag );
    NSWindow *w = CUI_PrintToWindowWindow();// 20220804
    if ( w ) {
        CUI_DrawToWindowPenReset( w );
    }
}

void CUI_DrawToWindowOvalStatement( CGRect inRect, long inFillCol, BOOL fillFlag )
{
    NSColor *fillCol = CUI_FixColor( inFillCol );
    NSWindow *wnd = CUI_PrintToWindowWindow();// 20220804
    if ( wnd ) {
        CUI_DrawToWindowOval( wnd, NSRectFromCGRect(inRect), fillCol, fillFlag );
    }
}

void CUI_DrawToWindowRectStatement( CGRect inRect, long inFillCol, CGFloat inCornerRadius, BOOL fillFlag )
{
    NSColor *fillCol = CUI_FixColor( inFillCol );
    NSWindow *wnd = CUI_PrintToWindowWindow();// 20220804
    if ( wnd ) {
        CUI_DrawToWindowRect( wnd, NSRectFromCGRect(inRect), fillCol, inCornerRadius, fillFlag );
    }
}



#pragma mark - titlebar accessory view
id TitlebarAccessoryViewWithTag( NSInteger tag )
{
    id view = nil;
    id w = CUI_OutputWindow();
    if ( [(NSObject *)w isKindOfClass:[NSWindow class]] ) {
        if ( [(NSWindow *)w hasTitleBar] ) {
            NSArray *controllers = [(NSWindow *)w titlebarAccessoryViewControllers];
            if ( controllers ) {
                for ( NSTitlebarAccessoryViewController *c in controllers ) {
                    NSView *view = [c view];
                    NSInteger viewTag = [[view identifier] integerValue];
                    if ( viewTag == tag ) return view;
                    NSView *subview = CUI_ViewSubviewWithTag( view, tag );
                    if ( subview ) return subview;
                }
            }
        }
    }
    return view;
}


#pragma mark - window controller
@implementation CUI_WindowController
@end


#pragma mark - window

#pragma mark - subclass
@implementation WindowSC

- (BOOL)canBecomeKeyWindow {
    CUI_WindowSubclassCanBecomeKeyWindow( self );
    return DialogEventBool();
}

- (void)mouseDown:(NSEvent *)event {
    CUI_WindowSubclassMouseDown( self, event );
    if ( !DialogEventBool() ) [super mouseDown:event];
}

- (void)mouseUp:(NSEvent *)event {
    CUI_WindowSubclassMouseUp( self, event );
}

- (void)keyDown:(NSEvent *)event {
    CUI_WindowSubclassKeyDown( self, event );
    if ( !DialogEventBool() ) [super keyDown:event];
}

- (void)keyUp:(NSEvent *)event {
    CUI_WindowSubclassKeyUp( self, event );
}

- (void)flagsChanged:(NSEvent *)event {
    CUI_WindowSubclassFlagsChanged( self, event );
}

- (void)mouseEntered:(NSEvent *)event {
    CUI_WindowSubclassMouseEntered( self, event );
}

- (void)mouseExited:(NSEvent *)event {
    CUI_WindowSubclassMouseExited( self, event );
}

- (void)rightMouseUp:(NSEvent *)event {
    CUI_WindowSubclassRightMouseUp( self, event );
}

- (void)otherMouseUp:(NSEvent *)event {
    CUI_WindowSubclassOtherMouseUp( self, event );
}

- (void)rightMouseDown:(NSEvent *)event {
    CUI_WindowSubclassRightMouseDown( self, event );
}

- (void)otherMouseDown:(NSEvent *)event {
    CUI_WindowSubclassOtherMouseDown( self, event );
}

- (void)mouseMoved:(NSEvent *)event {
    CUI_WindowSubclassMouseMoved( self, event );
}

- (void)mouseDragged:(NSEvent *)event {
    CUI_WindowSubclassMouseDragged( self, event );
}

- (void)rightMouseDragged:(NSEvent *)event {
    CUI_WindowSubclassRightMouseDragged( self, event );
}

- (void)otherMouseDragged:(NSEvent *)event {
    CUI_WindowSubclassOtherMouseDragged( self, event );
}

- (void)awakeFromNib {
    CUI_WindowSubclassAwakeFromNib( self );
}
@end

void CUI_WindowSubclassCanBecomeKeyWindow( NSWindow *w )
{
    DialogEventSetBool( YES );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowCanBecomeKeyWindow, [w tag], [w tag], (__bridge CFTypeRef)w );
}

void CUI_WindowSubclassMouseDown( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowMouseDown, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassMouseUp( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowMouseUp, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassKeyDown( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowKeyDown, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassKeyUp( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowKeyUp, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassFlagsChanged( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowFlagsChanged, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassMouseEntered( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowMouseEntered, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassMouseExited( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowMouseExited, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassRightMouseUp( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowRightMouseUp, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassOtherMouseUp( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowOtherMouseUp, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassRightMouseDown( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowRightMouseDown, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassOtherMouseDown( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowOtherMouseDown, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassMouseMoved( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowMouseMoved, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassMouseDragged( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowMouseDragged, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassRightMouseDragged( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowRightMouseDragged, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassOtherMouseDragged( NSWindow *w, NSEvent *event )
{
    DialogEventSetBool( NO );
    CUI_EventSetEvent( event );
    CUI_OutputWindowSetTag( [w tag] );
    CallUserDefinedOnDialogFunction( windowOtherMouseDragged, [w tag], [w tag], (__bridge CFTypeRef)event );
    CUI_EventSetEvent( nil );
}

void CUI_WindowSubclassAwakeFromNib( id w )
{
    NSInteger tag = [[w identifier] integerValue];
    CUI_OutputWindowSetTag( tag );
    CallUserDefinedOnDialogFunction( windowAwakeFromNib, tag, tag, (__bridge CFTypeRef)w );
}

#pragma mark - output window
static NSInteger sCUI_OutputWindowTag;

NSInteger CUI_OutputWindowTag( void )
{ return sCUI_OutputWindowTag; }

void CUI_OutputWindowSetTag( NSInteger tag )
{ sCUI_OutputWindowTag = ABS(tag); }

id CUI_VisibleOutputWindow( void )
{
    id w = nil;
    NSInteger tag = CUI_OutputWindowTag();
    if ( tag ) {
        w = CUI_VisibleWindowWithTag( tag );
        if ( !w ) {
            w = CUI_PopoverWithTag( tag );
        }
    }
    return w;
}

id CUI_OutputWindow( void )
{
    id w = nil;
    NSInteger tag = CUI_OutputWindowTag();
    if ( tag ) {
        w = CUI_WindowWithTag( tag );
        if ( !w ) {
            w = CUI_PopoverWithTag( tag );
        }
    }
    return w;
}

NSView *CUI_OutputWindowContentView( void )
{
    NSView *contentView = nil;
    id w = CUI_OutputWindow();
    if ( w ) {
        if ( [(NSObject *)w isKindOfClass:[NSWindow class]] ) {
            contentView = [(NSWindow *)w contentView];
        } else if ( [(NSObject *)w isKindOfClass:[NSPopover class]] ) {
            contentView = [[(NSPopover *)w contentViewController] view];
        } else {
            // ... it's not a window, panel or popover
        }
    }
    return contentView;
}

NSInteger CUI_ParentTagForView( id view )
{
    NSPopover *popover = CUI_PopoverForView( [(NSView *)view superview] );
    if ( popover ) {
        return [popover tag];
    } else {
        return [[(NSView *)view window] tag];
    }
}

id CUI_TargetWithTag( NSInteger tag )
{
    id target = CUI_WindowWithTag( tag );
    if ( !target ) {
        target = CUI_PopoverWithTag( tag );
    }
    return target;
}

id CUI_VisibleTargetWithTag( NSInteger tag )
{
    id target = CUI_VisibleWindowWithTag( tag );
    if ( !target ) {
        target = CUI_PopoverWithTag( tag );
    }
    return target;
}

id CUI_VisibleTargetWindow( NSInteger *inWndTag )
{
    id w = nil;
    if ( *inWndTag ) {
        w = CUI_VisibleTargetWithTag( *inWndTag ); // get window or popover
    } else {
        w = CUI_OutputWindow();
        if ( w ) {
            if ( ![(NSWindow *)w isVisible] ) {
                w = CUI_VisibleFrontWindow();
            }
        } else {
            w = CUI_VisibleFrontWindow();
        }
        if ( w ) *inWndTag = [(NSWindow *)w tag];
    }
    return w;
}


id CUI_TargetWindow( NSInteger *inWndTag )
{
    id w = nil;
    if ( *inWndTag == 0 ) {
        w = CUI_AppDelegateOffscreenWindow();
    } else {
        if ( *inWndTag == kFBParamMissing ) {
            w = CUI_OutputWindow();
            if ( !w ) {
                w = CUI_FrontWindow();
            }
            if ( w ) *inWndTag = [(NSWindow *)w tag];
        } else {
            w = CUI_TargetWithTag( *inWndTag ); // get window or popover
        }
    }
    return w;
}

NSView *CUI_TargetContentView( id w )
{
    NSView *contentView = nil;
    if ( [(NSObject *)w isKindOfClass:[NSWindow class]] ) {
        contentView = [(NSWindow *)w contentView];
    } else if ( [(NSObject *)w isKindOfClass:[NSPopover class]] ) {
        contentView = [[(NSPopover *)w contentViewController] view];
    } else {
        // ... it isn't a window, panel or popover
    }
    return contentView;
}


#pragma mark - ContentViewSC
@implementation ContentViewSC
#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.dragFileTypes release];
    [self.dragFileExtensions release];
    [super dealloc];
}
#endif

- (void)viewWillMoveToWindow:(NSWindow *)newWindow {
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveAlways;
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:options owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
    //[trackingArea release];
}

- (void)updateTrackingAreas {
    NSArray *areas = [self trackingAreas];
    if ( [areas count] > 0 ) {
        NSTrackingArea *trackingArea = [areas objectAtIndex:0];
        [self removeTrackingArea:trackingArea];
#if !__has_feature(objc_arc)
        [trackingArea release];
#endif
        NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited | NSTrackingMouseMoved | NSTrackingActiveAlways;
        trackingArea = [[NSTrackingArea alloc] initWithRect:[self bounds] options:options owner:self userInfo:nil];
        [self addTrackingArea:trackingArea];
        //[trackingArea release];
    }
    [super updateTrackingAreas];
}

- (void)drawRect:(NSRect)dirtyRect {
    if ( [self suspendDrawRect] ) return;
    
    [super drawRect:dirtyRect];
    NSWindow *window = [self window];
    
    if ( self.subclassFlag ) {
        DialogEventSetNSRect( dirtyRect );
        CUI_OutputWindowSetTag( [window tag] );
        CallUserDefinedOnDialogFunction( viewDrawRect, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
    }
}

- (void)mouseDown:(NSEvent *)event {
    if ( self.subclassFlag ) {
        DialogEventSetBool( NO );
        CUI_EventSetEvent( event );
        NSWindow *window = [self window];
        CUI_OutputWindowSetTag( [window tag] );
        CallUserDefinedOnDialogFunction( viewMouseDown, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
        if ( !DialogEventBool() ) [super mouseDown:event];
        CUI_EventSetEvent( nil );
    } else {
        [super mouseDown:event];
    }
}

- (void)mouseUp:(NSEvent *)event {
    if ( self.subclassFlag ) {
        NSWindow *window = [self window];
        CUI_EventSetEvent( event );
        CUI_OutputWindowSetTag( [window tag] );
        CallUserDefinedOnDialogFunction( viewMouseUp, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
        CUI_EventSetEvent( nil );
    } else {
        [super mouseUp:event];
    }
}

- (void)mouseEntered:(NSEvent *)event {
    if ( self.subclassFlag ) {
        NSWindow *window = [self window];
        CUI_EventSetEvent( event );
        CUI_OutputWindowSetTag( [window tag] );
        CallUserDefinedOnDialogFunction( viewMouseEntered, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
        CUI_EventSetEvent( nil );
    } else {
        [super mouseEntered:event];
    }
}

- (void)mouseExited:(NSEvent *)event {
    if ( self.subclassFlag ) {
        NSWindow *window = [self window];
        CUI_EventSetEvent( event );
        CUI_OutputWindowSetTag( [window tag] );
        CallUserDefinedOnDialogFunction( viewMouseExited, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
        CUI_EventSetEvent( nil );
    } else {
        [super mouseExited:event];
    }
}

- (void)mouseDragged:(NSEvent *)event {
    if ( self.subclassFlag ) {
        NSWindow *window = [self window];
        CUI_EventSetEvent( event );
        CUI_OutputWindowSetTag( [window tag] );
        CallUserDefinedOnDialogFunction( viewMouseDragged, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
        CUI_EventSetEvent( nil );
    } else {
        [super mouseDragged:event];
    }
}

- (void)mouseMoved:(NSEvent *)event {
    if ( self.subclassFlag ) {
        NSWindow *window = [self window];
        CUI_EventSetEvent( event );
        CUI_OutputWindowSetTag( [window tag] );
        CallUserDefinedOnDialogFunction( viewMouseMoved, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
        CUI_EventSetEvent( nil );
    } else {
        [super mouseMoved:event];
    }
}

- (void)rightMouseDown:(NSEvent *)event {
    if ( self.subclassFlag ) {
        NSWindow *window = [self window];
        CUI_EventSetEvent( event );
        CUI_OutputWindowSetTag( [window tag] );
        CallUserDefinedOnDialogFunction( viewRightMouseDown, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
        CUI_EventSetEvent( nil );
    } else {
        [super rightMouseDown:event];
    }
}

- (void)rightMouseUp:(NSEvent *)event {
    if ( self.subclassFlag ) {
        NSWindow *window = [self window];
        CUI_EventSetEvent( event );
        CUI_OutputWindowSetTag( [window tag] );
        CallUserDefinedOnDialogFunction( viewRightMouseUp, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
        CUI_EventSetEvent( nil );
    } else {
        [super rightMouseUp:event];
    }
}

- (void)rightMouseDragged:(NSEvent *)event {
    if ( self.subclassFlag ) {
        NSWindow *window = [self window];
        CUI_EventSetEvent( event );
        CUI_OutputWindowSetTag( [window tag] );
        CallUserDefinedOnDialogFunction( viewRightMouseDragged, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
        CUI_EventSetEvent( nil );
    } else {
        [super rightMouseDragged:event];
    }
}

// this is required for key events
- (BOOL)acceptsFirstResponder {
    return self.responderFlag;
}

- (void)keyDown:(NSEvent *)event {
    if ( self.subclassFlag ) {
        NSWindow *window = [self window];
        CUI_EventSetEvent( event );
        CUI_OutputWindowSetTag( [window tag] );
        DialogEventSetBool(NO);
        CallUserDefinedOnDialogFunction( viewKeyDown, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
        if ( !DialogEventBool() ) [super keyDown:event];
        CUI_EventSetEvent( nil );
    } else {
        [super keyDown:event];
    }
}

- (void)keyUp:(NSEvent *)event {
    if ( self.subclassFlag ) {
        NSWindow *window = [self window];
        CUI_EventSetEvent( event );
        CUI_OutputWindowSetTag( [window tag] );
        DialogEventSetBool(NO);
        CallUserDefinedOnDialogFunction( viewKeyUp, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
        if ( !DialogEventBool() ) [super keyUp:event];
        CUI_EventSetEvent( nil );
    } else {
        [super keyUp:event];
    }
}

- (void)flagsChanged:(NSEvent *)event {
    if ( self.subclassFlag ) {
        NSWindow *window = [self window];
        CUI_EventSetEvent( event );
        CUI_OutputWindowSetTag( [window tag] );
        DialogEventSetBool(NO);
        CallUserDefinedOnDialogFunction( viewFlagsChanged, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
        if ( !DialogEventBool() ) [super flagsChanged:event];
        CUI_EventSetEvent( nil );
    } else {
        [super flagsChanged:event];
    }
}

- (void)resetCursorRects {
    CUI_ViewSubclassResetCursorRects( self );
}

#pragma mark - dragging
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSDragOperation dragOperation = NSDragOperationNone;
        
    DialogEventSetLong(dragOperation);
    NSArray *regTypes = [self registeredDraggedTypes];
    
    if ( [regTypes containsObject:NSFilenamesPboardType] ) {
        NSWindow *window = [self window];
        CUI_OutputWindowSetTag( [window tag] );
        
        NSPasteboard *pb = [sender draggingPasteboard];
        NSArray *pbTypes = [pb types];
        if ( [pbTypes containsObject:NSFilenamesPboardType] ) {
            DialogEventSetDraggingInfo(sender);
            
            NSArray *files = [pb propertyListForType:NSFilenamesPboardType];
            
            BOOL validFile = NO;
            
            if ( self.dragFileTypes != nil || self.dragFileExtensions != nil ) {
                for ( NSString *path in files ) {
                    validFile = NO;
                    
                    if ( self.dragFileTypes ) {
                        NSString *utiType = [[NSWorkspace sharedWorkspace] typeOfFile:path error:nil];
                        for ( NSString *type in self.dragFileTypes ) {
                            if ( [[NSWorkspace sharedWorkspace] type:utiType conformsToType:(id)type] ) {
                                validFile = YES;
                                break;
                            }
                        }
                    }
                    
                    if ( !validFile ) {
                        if ( self.dragFileExtensions ) {
                            NSString *extension = [path pathExtension];
                            if ( extension ) {
                                if ( [self.dragFileExtensions containsObject:extension] ) {
                                    validFile = YES;
                                }
                            }
                        }
                    }
                    
                    if ( !validFile ) break;
                }
            } else {
                validFile = YES;
            }
            
            if ( validFile ) {
                dragOperation = NSDragOperationLink;
                NSMutableArray *urls = [NSMutableArray arrayWithCapacity:[files count]];
                for ( NSString *path in files ) {
                    [urls addObject:[NSURL fileURLWithPath:path]];
                }
                DialogEventSetNSArray( urls );
                DialogEventSetNSURL( [urls objectAtIndex:0] );
                self.dragInside = YES;
                DialogEventSetLong(dragOperation);
                CallUserDefinedOnDialogFunction( viewDraggingEntered, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
                DialogEventSetDraggingInfo(nil);
                DialogEventSetNSArray( nil );
                DialogEventSetNSURL( nil );
            }
        }
    }
    return DialogEventLong();
}

//- (BOOL)wantsPeriodicDraggingUpdates {
//    return NO;
//}

//- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
//
//    return NSDragOperationNone;
//}

- (void)draggingEnded:(id<NSDraggingInfo>)sender {
    
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    NSWindow *window = [self window];
    CUI_OutputWindowSetTag( [window tag] );
    DialogEventSetDraggingInfo(sender);
    self.dragInside = NO;
    CallUserDefinedOnDialogFunction( viewDraggingExited, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
    DialogEventSetDraggingInfo(nil);
    DialogEventSetNSArray( nil );
    DialogEventSetNSURL( nil );
}

//- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
//    return NO;
//}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    [[NSCursor arrowCursor] set];
    
    NSWindow *window = [self window];
    CUI_OutputWindowSetTag( [window tag] );
    
    NSPasteboard *pb = [sender draggingPasteboard];
    
    NSArray *files = [pb propertyListForType:NSFilenamesPboardType];
    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:[files count]];
    
    for ( NSString *path in files ) {
        [urls addObject:[NSURL fileURLWithPath:path]];
    }
    
    DialogEventSetNSArray( urls );
    DialogEventSetNSURL( [urls objectAtIndex:0] );
    DialogEventSetDraggingInfo(sender);
    DialogEventSetBool(NO);
    
    CallUserDefinedOnDialogFunction( viewPerformDragOperation, windowContentViewTag, [window tag], (__bridge CFTypeRef)window );
    
    [self draggingExited:sender];
    //    return DialogEventBool();
    return YES;
}

- (void)concludeDragOperation:(id<NSDraggingInfo>)sender {
    
}

- (void)updateDraggingItemsForDrag:(id<NSDraggingInfo>)sender {
    
}

- (BOOL)isFlipped {
    return self.flip;
}

- (void)viewDidChangeEffectiveAppearance {
    CUI_ViewSubclassViewDidChangeEffectiveAppearance( self );
}


- (NSMenu *)menuForEvent:(NSEvent *)event {
    NSWindow *window = [self window];
    DialogEventSetNSMenu( [self menu] );
    CallUserDefinedOnDialogFunction( viewMenuForEvent, CUI_ViewTag(self), [window tag], (__bridge CFTypeRef)event );
    return DialogEventNSMenu();
}

@end




@implementation CUI_WindowDelegate

#pragma mark - window delegate methods
#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.dragFileTypes release];
    [self.dragFileExtensions release];
    [super dealloc];
}
#endif

- (void)window:(NSWindow *)w forwardEvent:(NSInteger)event tag:(NSInteger)tag obj:(id)obj {
    CUI_WindowCallbackType callback = [w cuiWindowCallback];
    if ( callback ) {
        void *userData = [w cuiWindowUserData];
        (*callback)([w tag],event,userData);
    } else if ( self.allWindowsCallback ) {
        (*self.allWindowsCallback)([w tag],event,NULL);
    } else {
        CallUserDefinedOnDialogFunction( event, tag, [w tag], (__bridge CFTypeRef)obj );
    }
}

// sheet
- (NSRect)window:(NSWindow *)window willPositionSheet:(NSWindow *)sheet usingRect:(NSRect)rect {
    DialogEventSetNSRect(rect);
    [self window:window forwardEvent:windowWillPositionSheet tag:[window tag] obj:sheet];
    return DialogEventRect();
}

- (void)windowWillBeginSheet:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    CUI_OutputWindowSetTag( tag );
    [self window:w forwardEvent:windowWillBeginSheet tag:tag obj:nil];
}

- (void)windowDidEndSheet:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    CUI_OutputWindowSetTag( tag );
    [self window:w forwardEvent:windowDidEndSheet tag:tag obj:nil];
}

// size
- (NSSize)windowWillResize:(NSWindow *)sender toSize:(NSSize)frameSize {
    NSInteger tag = [sender tag];
    CUI_OutputWindowSetTag( tag );
    DialogEventSetNSSize( frameSize );
    [self window:sender forwardEvent:windowWillResize tag:tag obj:nil];
    return DialogEventNSSize();
}

- (void)windowDidResize:(NSNotification *)notification {
    NSWindow *w = [notification object];
    
//    CUI_PrintToWindowView *view = CUI_PrintToWindowViewObj( w );
//    if ( view ) [view fitToWindow];
    
    NSInteger tag = [w tag];
    [self window:w forwardEvent:windowDidResize tag:tag obj:nil];
}

- (void)windowWillStartLiveResize:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    [self window:w forwardEvent:windowWillStartLiveResize tag:tag obj:nil];
}

- (void)windowDidEndLiveResize:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    CUI_OutputWindowSetTag( tag );
    [self window:w forwardEvent:windowDidEndLiveResize tag:tag obj:nil];
}

// minimize
- (void)windowWillMiniaturize:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    [self window:w forwardEvent:windowWillMiniaturize tag:tag obj:nil];
}

- (void)windowDidMiniaturize:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    [self window:w forwardEvent:windowDidMiniaturize tag:tag obj:nil];
}

- (void)windowDidDeminiaturize:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    CUI_OutputWindowSetTag( tag );
    [self window:w forwardEvent:windowDidDeminiaturize tag:tag obj:nil];
}

// zoom
- (NSRect)windowWillUseStandardFrame:(NSWindow *)window defaultFrame:(NSRect)newFrame {
    DialogEventSetNSRect(newFrame);
    [self window:window forwardEvent:windowWillUseStandardFrame tag:[window tag] obj:nil];
    return DialogEventRect();
}

- (BOOL)windowShouldZoom:(NSWindow *)window toFrame:(NSRect)newFrame {
    NSInteger tag = [window tag];
    DialogEventSetBool( YES );
    DialogEventSetNSRect( newFrame );
    [self window:window forwardEvent:windowShouldZoom tag:tag obj:nil];
    return DialogEventBool();
}

// full-screen
- (NSSize)window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize {
    DialogEventSetNSSize(proposedSize);
    [self window:window forwardEvent:windowWillUseFullScreenContentSize tag:[window tag] obj:nil];
    return DialogEventNSSize();
}

- (NSApplicationPresentationOptions)window:(NSWindow *)window willUseFullScreenPresentationOptions:(NSApplicationPresentationOptions)proposedOptions {
    DialogEventSetLong(proposedOptions);
    [self window:window forwardEvent:windowWillUseFullScreenPresentationOptions tag:[window tag] obj:nil];
    return DialogEventLong();
}

- (void)windowWillEnterFullScreen:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    [self window:w forwardEvent:windowWillEnterFullScreen tag:tag obj:nil];
}

- (void)windowDidEnterFullScreen:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    CUI_OutputWindowSetTag( tag );
    [self window:w forwardEvent:windowDidEnterFullScreen tag:tag obj:nil];
}

- (void)windowWillExitFullScreen:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    [self window:w forwardEvent:windowWillExitFullScreen tag:tag obj:nil];
}

- (void)windowDidExitFullScreen:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    CUI_OutputWindowSetTag( tag );
    [self window:w forwardEvent:windowDidExitFullScreen tag:tag obj:nil];
}

// full-screen animations
//- (NSArray<NSWindow *> *)customWindowsToEnterFullScreenForWindow:(NSWindow *)window;

//- (NSArray<NSWindow *> *)customWindowsToEnterFullScreenForWindow:(NSWindow *)window onScreen:(NSScreen *)screen;

//- (void)window:(NSWindow *)window startCustomAnimationToEnterFullScreenWithDuration:(NSTimeInterval)duration;

//- (void)window:(NSWindow *)window startCustomAnimationToEnterFullScreenOnScreen:(NSScreen *)screen withDuration:(NSTimeInterval)duration;

- (void)windowDidFailToEnterFullScreen:(NSWindow *)window {
    NSInteger tag = [window tag];
    [self window:window forwardEvent:windowDidFailToEnterFullScreen tag:tag obj:nil];
}

//- (NSArray<NSWindow *> *)customWindowsToExitFullScreenForWindow:(NSWindow *)window;

//- (void)window:(NSWindow *)window startCustomAnimationToExitFullScreenWithDuration:(NSTimeInterval)duration;

- (void)windowDidFailToExitFullScreen:(NSWindow *)window {
    NSInteger tag = [window tag];
    [self window:window forwardEvent:windowDidFailToExitFullScreen tag:tag obj:nil];
}

// move
- (void)windowWillMove:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    CUI_OutputWindowSetTag( tag );
    [self window:w forwardEvent:windowWillMove tag:tag obj:nil];
}

- (void)windowDidMove:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    CUI_OutputWindowSetTag( tag );
    [self window:w forwardEvent:windowDidMove tag:tag obj:nil];
}

- (void)windowDidChangeScreen:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    CUI_OutputWindowSetTag( tag );
    [self window:w forwardEvent:windowDidChangeScreen tag:tag obj:nil];
}

//- (void)windowDidChangeScreenProfile:(NSNotification *)notification;

//- (void)windowDidChangeBackingProperties:(NSNotification *)notification;

// close
- (BOOL)windowShouldClose:(NSWindow *)window {
    NSInteger tag = [window tag];
    DialogEventSetBool( YES );
    [self window:window forwardEvent:windowShouldClose tag:tag obj:nil];
    return DialogEventBool();
}

- (void)windowWillClose:(NSNotification *)notification {
    NSWindow *w = notification.object;
    NSInteger tag = [w tag];
    [self window:w forwardEvent:windowWillClose tag:tag obj:nil];
    
    // if window is set to release when closed, remove from window list
    if ( [w isReleasedWhenClosed] ) {
        CUI_AppDelegateRemoveWindow( w );
    }
}

// key
- (void)windowDidBecomeKey:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    CUI_OutputWindowSetTag( tag );
    [self window:w forwardEvent:windowDidBecomeKey tag:tag obj:nil];
}

- (void)windowDidResignKey:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    [self window:w forwardEvent:windowDidResignKey tag:tag obj:nil];
}

// main
- (void)windowDidBecomeMain:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    CUI_OutputWindowSetTag( tag );
    [self window:w forwardEvent:windowDidBecomeMain tag:tag obj:nil];
}

- (void)windowDidResignMain:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    [self window:w forwardEvent:windowDidResignMain tag:tag obj:nil];
}

// field editor
//- (id)windowWillReturnFieldEditor:(NSWindow *)sender toObject:(id)client {
//    if ( [client isKindOfClass:[NSTextField class]] ) {
//        NSInteger tag = [sender tag];
//        [self window:sender forwardEvent:windowWillReturnFieldEditorToObject tag:tag obj:client];
//    }    
//    return nil;
//}

// update
- (void)windowDidUpdate:(NSNotification *)notification {
    NSWindow *w = [notification object];
    NSInteger tag = [w tag];
    [self window:w forwardEvent:windowDidUpdate tag:tag obj:nil];
}

// exposing
//- (void)windowDidExpose:(NSNotification *)notification;

// occlusion state
//- (void)windowDidChangeOcclusionState:(NSNotification *)notification;

// dragging
//- (BOOL)window:(NSWindow *)window shouldDragDocumentWithEvent:(NSEvent *)event from:(NSPoint)dragImageLocation withPasteboard:(NSPasteboard *)pasteboard;

// undo manager
//- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window;

// title
- (BOOL)window:(NSWindow *)window shouldPopUpDocumentPathMenu:(NSMenu *)menu {
    DialogEventSetBool(YES);
    [self window:window forwardEvent:windowShouldPopUpDocumentPathMenu tag:[window tag] obj:menu];
    return DialogEventBool();
}

// restorable state
//- (void)window:(NSWindow *)window willEncodeRestorableState:(NSCoder *)state;

//- (void)window:(NSWindow *)window didDecodeRestorableState:(NSCoder *)state;

// version browser
//- (NSSize)window:(NSWindow *)window willResizeForVersionBrowserWithMaxPreferredSize:(NSSize)maxPreferredFrameSize maxAllowedSize:(NSSize)maxAllowedFrameSize;

//- (void)windowWillEnterVersionBrowser:(NSNotification *)notification;

//- (void)windowDidEnterVersionBrowser:(NSNotification *)notification;

//- (void)windowWillExitVersionBrowser:(NSNotification *)notification;

//- (void)windowDidExitVersionBrowser:(NSNotification *)notification;



#pragma mark - subclass events
- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSDragOperation dragOperation = NSDragOperationNone;
        
    DialogEventSetLong(dragOperation);
    
    NSWindow *window = [sender draggingDestinationWindow];
    
    CUI_OutputWindowSetTag( [window tag] );
    
    
    NSPasteboard *pb = [sender draggingPasteboard];
    NSArray *pbTypes = [pb types];
    if ( [pbTypes containsObject:NSFilenamesPboardType] ) {
        
        DialogEventSetDraggingInfo(sender);
        
        NSArray *files = [pb propertyListForType:NSFilenamesPboardType];
        
        BOOL validFile = NO;
        
        for ( NSString *path in files ) {
            validFile = NO;
            
            if ( self.dragFileTypes ) {
            NSString *utiType = [[NSWorkspace sharedWorkspace] typeOfFile:path error:nil];
            for ( NSString *type in self.dragFileTypes ) {
                if ( [[NSWorkspace sharedWorkspace] type:utiType conformsToType:(id)type] ) {
                    validFile = YES;
                    break;
                }
            }
            }
            
            if ( !validFile ) {
                if ( self.dragFileExtensions ) {
                    NSString *extension = [path pathExtension];
                    if ( extension ) {
                        if ( [self.dragFileExtensions containsObject:extension] ) {
                            validFile = YES;
                        }
                    }
                }
            }
            
            if ( !validFile ) break;
        }
        
        if ( validFile ) {
            dragOperation = NSDragOperationLink;
            NSMutableArray *urls = [NSMutableArray arrayWithCapacity:[files count]];
            for ( NSString *path in files ) {
                [urls addObject:[NSURL fileURLWithPath:path]];
            }
            DialogEventSetNSArray( urls );
            DialogEventSetNSURL( [urls objectAtIndex:0] );
            self.dragInside = YES;
            DialogEventSetLong(dragOperation);
            CallUserDefinedOnDialogFunction( windowDraggingEntered, [window tag], [window tag], (__bridge CFTypeRef)window );
            DialogEventSetDraggingInfo(nil);
            DialogEventSetNSArray( nil );
            DialogEventSetNSURL( nil );
        }
    }
    return DialogEventLong();
}

- (void)draggingExited:(id <NSDraggingInfo>)sender {
    NSWindow *window = [sender draggingDestinationWindow];
    CUI_OutputWindowSetTag( [window tag] );
    DialogEventSetDraggingInfo(sender);
    self.dragInside = NO;
    CallUserDefinedOnDialogFunction( windowDraggingExited, [window tag], [window tag], (__bridge CFTypeRef)window );
    DialogEventSetDraggingInfo(nil);
    DialogEventSetNSArray( nil );
    DialogEventSetNSURL( nil );
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    [[NSCursor arrowCursor] set];

    NSWindow *window = [sender draggingDestinationWindow];

    CUI_OutputWindowSetTag( [window tag] );

    NSPasteboard *pb = [sender draggingPasteboard];

    NSArray *files = [pb propertyListForType:NSFilenamesPboardType];
    NSMutableArray *urls = [NSMutableArray arrayWithCapacity:[files count]];

    for ( NSString *path in files ) {
        [urls addObject:[NSURL fileURLWithPath:path]];
    }

    DialogEventSetNSArray( urls );
    DialogEventSetNSURL( [urls objectAtIndex:0] );
    DialogEventSetDraggingInfo(sender);
    DialogEventSetBool(NO);

    CallUserDefinedOnDialogFunction( windowPerformDragOperation, [window tag], [window tag], (__bridge CFTypeRef)window );

    [self draggingExited:sender];
    return YES;
}

@end

CUI_WindowDelegate *CUI_WindowDelegateObj( void )
{
    static CUI_WindowDelegate *sCUI_WindowDelegate = nil;
    if ( !sCUI_WindowDelegate ) sCUI_WindowDelegate = [[CUI_WindowDelegate alloc] init];
    return sCUI_WindowDelegate;
}


@implementation NSWindow (Additions)
@dynamic tagNumber;
@dynamic callbackValue;
@dynamic userDataValue;

- (NSInteger)tag {
    return [objc_getAssociatedObject(self, @selector(tagNumber)) integerValue];
}

- (void)setTag:(NSInteger)tag {
    objc_setAssociatedObject(self, @selector(tagNumber), [NSNumber numberWithInteger:tag], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CUI_WindowCallbackType)cuiWindowCallback {
    return (CUI_WindowCallbackType)[objc_getAssociatedObject(self, @selector(callbackValue)) pointerValue];
}

- (void *)cuiWindowUserData {
    return [objc_getAssociatedObject(self, @selector(userDataValue)) pointerValue];
}

- (void)setCuiWindowCallback:(CUI_WindowCallbackType)callback {
    objc_setAssociatedObject(self, @selector(callbackValue), [NSValue valueWithPointer:(void *)callback], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCuiWindowUserData:(void *)userData {
    objc_setAssociatedObject(self, @selector(userDataValue), [NSValue valueWithPointer:userData], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end


// private
BOOL CUI_ObjectIsPopover( NSInteger tag )
{
    if ( CUI_PopoverWithTag( tag ) ) {
        CUI_ShowAlert( NSWarningAlertStyle, @"Window tag error.", @"Windows and Popovers cannot share the same tag value." );
        return YES;
    }
    return NO;
}

BOOL CUI_ObjectIsWindow( NSInteger tag )
{
    if ( CUI_WindowWithTag( tag ) ) {
        CUI_ShowAlert( NSWarningAlertStyle, @"Popover tag error.", @"Popovers and Windows cannot share the same tag value." );
        return YES;
    }
    return NO;
}

id CUI_VisibleWindowWithTag( NSInteger tag )
{
    id w = nil;
    if ( tag ) {
        if ( tag > 1000000 ) {
            //return (id)tag;// it's a NSWindow *
            return (__bridge id)(void *)tag;
        }
        NSArray *windows = [NSApp windows];
        //NSArray *delegateWindows = CUI_AppDelegateWindows();// 20220404
        
        if ( windows ) {
            for ( NSObject *obj in windows ) {
                if ( [obj isKindOfClass:[NSWindow class]] ) {
                    //if ( [delegateWindows containsObject:obj] ) {// 20220404
                        if ( [(NSWindow *)obj tag] == tag ) {
                            if ( [(NSWindow *)obj isVisible] ) {
                                w = (NSWindow *)obj;
                                break;
                            }
                        }
                    //}
                }
            }
        }
    }
    return w;
}

id CUI_WindowWithTag( NSInteger tag )
{
    id w = nil;
    tag = ABS(tag);
    if ( tag ) {
        if ( tag > 1000000 ) {
            //return (id)tag;// it's a NSWindow *
            return (__bridge id)(void *)tag;
        }
        
        NSArray *windows = [NSApp windows];
        //NSArray *delegateWindows = CUI_AppDelegateWindows();// 20220404

        if ( windows ) {
            for ( NSObject *obj in windows ) {
                //if ( [delegateWindows containsObject:obj] ) {// 20220404
                    if ( [obj isKindOfClass:[NSWindow class]] ) {
                        if ( [(NSWindow *)obj tag] == tag ) {
                            w = (NSWindow *)obj;
                            break;
                        }
                    }
                //}
            }
        }
    }
    return w;
}

NSWindow *CUI_VisibleFrontWindow( void )
{
    NSWindow *w = nil;
    NSArray *windows = [NSApp orderedWindows];
    //NSArray *delegateWindows = CUI_AppDelegateWindows();// 20220404

    for ( NSObject *obj in windows ) {
        //if ( [delegateWindows containsObject:obj] ) {// 20220404
            if ( [obj isKindOfClass:[NSWindow class]] ) {
                if ( [(NSWindow *)obj isVisible] ) {
                    w = (NSWindow *)obj;
                    break;
                }
            }
        //}
    }
    return w;
}


NSWindow *CUI_FrontWindow( void )
{
    NSWindow *w = nil;
    NSArray *windows = [NSApp orderedWindows];
    //NSArray *delegateWindows = CUI_AppDelegateWindows();// 20220404

    for ( NSObject *obj in windows ) {
        //if ( [delegateWindows containsObject:obj] ) {// 20220404
            if ( [obj isKindOfClass:[NSWindow class]] ) {
                w = (NSWindow *)obj;
                break;
            }
        //}
    }
    return w;
}

void CUI_WindowSetTitle( NSInteger tag, CFStringRef title )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setTitle:(__bridge NSString *)title];
}

void CUI_WindowMakeFirstTextViewResponder( NSWindow *w )
{
    NSArray *views = [[w contentView] subviews];
    for ( NSView *view in views ) {
        if ( [view acceptsFirstResponder] ) {
            Class cls = [view class];
            if ( cls == [NSTextField class] || cls == [NSSearchField class] || cls == [NSComboBox class] || cls == [NSTokenField class]  || cls == [NSSecureTextField class] ) {
                [w makeFirstResponder:view];
                break;
            }
        }
    }
}


// === public ===
Class WindowClass( void )
{ return [NSWindow class]; }

NSInteger WindowTag( NSWindow *wnd )
{ return [wnd tag]; }

// Configure
BOOL WindowWorksWhenModal( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w worksWhenModal];
    return NO;
}

CGFloat WindowAlphaValue( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w alphaValue];
    return 0.0;
}

void WindowSetAlphaValue( NSInteger tag, CGFloat value )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setAlphaValue:value];
}

NSColor *WindowBackgroundColor( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w backgroundColor];
    return nil;
}

void WindowSetBackgroundColor( NSInteger tag, NSColor *col )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setBackgroundColor:col];
}

NSColorSpace *WindowColorSpace( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w colorSpace];
    return nil;
}

void WindowSetColorSpace( NSInteger tag, NSColorSpace *cs )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setColorSpace:cs];
}

NSViewController *WindowContentViewController( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w contentViewController];
    return nil;
}
void WindowSetContentViewController( NSInteger tag, NSViewController *viewController )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setContentViewController:viewController];
}

NSView *WindowContentView( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w contentView];
    return nil;
}

void WindowSetContentView( NSInteger tag, NSInteger vwTag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSView *view = ViewWithTag( vwTag );
        if ( view ) {
            [view setIdentifier:[NSString stringWithFormat:@"%ld",(long)windowContentViewTag]];
            [w setContentView:view];
            
            //CUI_ViewConfigureSubviews( view );
            
        }
    }
}

void WindowInvalidateShadow( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w invalidateShadow];
}

BOOL WindowAutorecalculatesContentBorderThickness( NSInteger tag, CGRectEdge edge )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        return [w autorecalculatesContentBorderThicknessForEdge:(NSRectEdge)edge];
    }
    return NO;
}

void WindowSetAutorecalculatesContentBorderThickness( NSInteger tag, BOOL flag, CGRectEdge edge )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        [w setAutorecalculatesContentBorderThickness:flag forEdge:(NSRectEdge)edge];
    }
}

CGFloat WindowContentBorderThickness( NSInteger tag, CGRectEdge edge )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        switch ( edge ) {
            case CGRectMaxYEdge: {
                NSUInteger style = [w styleMask];
                if ( (style & NSTexturedBackgroundWindowMask) == 0 ) break;
            }
            case CGRectMinYEdge:
                return [w contentBorderThicknessForEdge:(NSRectEdge)edge];
                break;
            default:
                break;
        }
    }
    return 0.0;
}

void WindowSetContentBorderThickness( NSInteger tag, CGFloat thickness, CGRectEdge edge )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        switch ( edge ) {
            case CGRectMaxYEdge: {
                NSUInteger style = [w styleMask];
                if ( (style & NSTexturedBackgroundWindowMask) == 0 ) break;
            }
            case CGRectMinYEdge:
                [w setContentBorderThickness:thickness forEdge:(NSRectEdge)edge];
                break;
            default:
                break;
        }
    }
}

BOOL WindowPreventsApplicationTerminationWhenModal( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w preventsApplicationTerminationWhenModal];
    return NO;
}

void WindowSetPreventsApplicationTerminationWhenModal( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setPreventsApplicationTerminationWhenModal:flag];
}

NSWindowDepth WindowDefaultDepthLimit( void )
{ return [NSWindow defaultDepthLimit]; }

NSInteger WindowNumber( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w windowNumber];
    return 0;
}

CFArrayRef WindowNumbersWithOptions( NSWindowNumberListOptions options )
{ return (__bridge CFArrayRef)[NSWindow windowNumbersWithOptions:options]; }

NSInteger WindowAttachedSheet( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSWindow *sheet = [w attachedSheet];
        if ( sheet ) {
            return [sheet tag];
        }
    }
    return 0;
}

CFDictionaryRef WindowDeviceDescription( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFDictionaryRef)[w deviceDescription];
    return nil;
}

BOOL WindowCanBecomeVisibleWithoutLogin( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w canBecomeVisibleWithoutLogin];
    return NO;
}

void WindowSetCanBecomeVisibleWithoutLogin( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setCanBecomeVisibleWithoutLogin:flag];
}

NSWindowSharingType WindowSharingType( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w sharingType];
    return 0;
}

void WindowSetSharingType( NSInteger tag, NSWindowSharingType type )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setSharingType:type];
}

NSBackingStoreType WindowBackingType( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w backingType];
    return 0;
}

void WindowSetBackingType( NSInteger tag, NSBackingStoreType type )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setBackingType:type];
}

NSWindowDepth WindowDepthLimit( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w depthLimit];
    return 0;
}

void WindowSetDepthLimit( NSInteger tag, NSWindowDepth depth )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setDepthLimit:depth];
}

BOOL WindowHasDynamicDepthLimit( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w hasDynamicDepthLimit];
    return NO;
}

BOOL WindowIsSheet( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isSheet];
    return NO;
}

CGSize WindowAspectRatio( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSSizeToCGSize([w aspectRatio]);
    return CGSizeZero;
}

void WindowSetAspectRatio( NSInteger tag, CGSize size )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setAspectRatio:NSSizeFromCGSize( size )];
}

CFStringRef WindowTitle( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFStringRef)[w title];
    return NULL;
}

void WindowSetTitle( NSInteger tag, CFStringRef title )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setTitle:(__bridge NSString *)title];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
CFStringRef WindowSubtitle( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFStringRef)[w subtitle];
    return nil;
}

void WindowSetSubtitle( NSInteger tag, CFStringRef subtitle )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setSubtitle:(__bridge NSString *)subtitle];
}
#endif// 110000

CFURLRef WindowRepresentedURL( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFURLRef)[w representedURL];
    return NULL;
}

void WindowSetRepresentedURL( NSInteger tag, CFURLRef url )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setRepresentedURL:(__bridge NSURL *)url];
}

NSScreen *WindowScreen( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w screen];
    return nil;
}

NSScreen *WindowDeepestScreen( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w deepestScreen];
    return nil;
}

BOOL WindowDisplaysWhenScreenProfileChanges( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w displaysWhenScreenProfileChanges];
    return NO;
}

void WindowSetDisplaysWhenScreenProfileChanges( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setDisplaysWhenScreenProfileChanges:flag];
}

BOOL WindowIsMovableByWindowBackground( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isMovableByWindowBackground];
    return NO;
}

void WindowSetMovableByWindowBackground( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setMovableByWindowBackground:flag];
}

BOOL WindowIsMovable( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isMovable];
    return YES;
}

void WindowSetMovable( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setMovable:flag];
}

void WindowCenter( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w center];
}

void WindowPerformClose( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w performClose:nil];
}

void WindowClose( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w close];
}

BOOL WindowIsReleasedWhenClosed( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isReleasedWhenClosed];
    return NO;
}

void WindowSetReleasedWhenClosed( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setReleasedWhenClosed:flag];
}

BOOL WindowIsMiniaturized( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isMiniaturized];
    return NO;
}

void WindowPerformMiniaturize( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w performMiniaturize:nil];
}

void WindowMiniaturize( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w miniaturize:nil];
}

void WindowDeminiaturize( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w deminiaturize:nil];
}

NSImage *WindowMiniwindowImage( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w miniwindowImage];
    return nil;
}

void WindowSetMiniwindowImage( NSInteger tag, CFTypeRef inImage )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSImage *image = CUI_FixImageValue( inImage );
        [w setMiniwindowImage:image];
    }
}

void WindowSetMiniwindowImageNamed( NSInteger tag, CFStringRef imageName )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setMiniwindowImage:CUI_ImageResource( (__bridge NSString *)imageName )];
}

CFStringRef WindowMiniwindowTitle( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFStringRef)[w miniwindowTitle];
    return nil;
}

void WindowSetMiniwindowTitle( NSInteger tag, CFStringRef title )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setMiniwindowTitle:(__bridge NSString *)title];
}

NSDockTile *WindowDockTile( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w dockTile];
    return nil;
}

void WindowPrint( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w print:nil];
}

CFDataRef WindowDataWithEPSInsideRect( NSInteger tag, CGRect r )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFDataRef)[w dataWithEPSInsideRect:NSRectFromCGRect(r)];
    return nil;
}

CFDataRef WindowDataWithPDFInsideRect( NSInteger tag, CGRect r )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFDataRef)[w dataWithPDFInsideRect:NSRectFromCGRect(r)];
    return nil;
}

// Scripting attributes
BOOL WindowHasCloseBox( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w hasCloseBox];
    return NO;
}

BOOL WindowHasTitleBar( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w hasTitleBar];
    return NO;
}

void WindowSetIsMiniaturized( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setIsMiniaturized:flag];
}

void WindowSetIsVisible( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setIsVisible:flag];
}

void WindowSetIsZoomed( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setIsZoomed:flag];
}

// Ordered indices
NSInteger WindowOrderedIndex( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w orderedIndex];
    return 0;
}

void WindowSetOrderedIndex( NSInteger tag, NSInteger index )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setOrderedIndex:index];
}

CGRect WindowFrame( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSRectToCGRect([w frame]);
    return CGRectZero;
}

CGRect WindowContentRect( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSRectToCGRect([w contentRectForFrameRect:[w frame]]);
    return CGRectZero;
}

void WindowSetFrameTopLeftPoint( NSInteger tag, CGPoint pt )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setFrameTopLeftPoint:NSPointFromCGPoint( pt )];
}

void WindowConstrainFrameRect( NSInteger tag, CGRect frame, NSScreen *screen )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w constrainFrameRect:NSRectFromCGRect(frame) toScreen:screen];
}

void WindowSetMinSize( NSInteger tag, CGSize size )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setMinSize:NSSizeFromCGSize(size)];
}

void WindowSetMaxSize( NSInteger tag, CGSize size )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setMaxSize:NSSizeFromCGSize(size)];
}

void WindowSetContentAspectRatio( NSInteger tag, CGSize size )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setContentAspectRatio:NSSizeFromCGSize( size )];
}

CGSize WindowContentMinSize( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSSizeToCGSize([w contentMinSize]);
    return CGSizeZero;
}

void WindowSetContentMinSize( NSInteger tag, CGSize size )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setContentMinSize:NSSizeFromCGSize(size)];
}

CGSize WindowContentMaxSize( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSSizeToCGSize([w contentMaxSize]);
    return CGSizeZero;
}

void WindowSetContentMaxSize( NSInteger tag, CGSize size )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setContentMaxSize:NSSizeFromCGSize(size)];
}

void WindowOrderOut( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w orderOut:nil];
}

void WindowOrderBack( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w orderBack:nil];
}

void WindowOrderFront( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w orderFront:nil];
}

void WindowOrderFrontRegardless( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w orderFrontRegardless];
}

NSWindowOcclusionState WindowOcclusionState( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w occlusionState];
    return 0;
}

BOOL WindowIsKey( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isKeyWindow];
    return NO;
}

BOOL WindowCanBecomeKey( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w canBecomeKeyWindow];
    return NO;
}

void WindowMakeKey( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w makeKeyWindow];
}

void WindowMakeKeyAndOrderFront( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w makeKeyAndOrderFront:nil];
}

BOOL WindowIsMain( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isMainWindow];
    return NO;
}

BOOL WindowCanBecomeMain( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w canBecomeMainWindow];
    return NO;
}

void WindowMakeMain( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w makeMainWindow];
}

void WindowSetFrameUsingName( NSInteger tag, CFStringRef name )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setFrameUsingName:(__bridge NSString *)name];
}

void WindowSetFrameUsingNameForce( NSInteger tag, CFStringRef name, BOOL force )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setFrameUsingName:(__bridge NSString *)name force:force];
}

void WindowSaveFrameUsingName( NSInteger tag, CFStringRef name )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setFrameUsingName:(__bridge NSString *)name];
}

CFStringRef WindowFrameAutosaveName( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFStringRef)[w frameAutosaveName];
    return nil;
}

CFStringRef WindowStringWithSavedFrame( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFStringRef)[w stringWithSavedFrame];
    return nil;
}

void WindowSetFrameFromString( NSInteger tag, CFStringRef string )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setFrameFromString:(__bridge NSString *)string];
}


void WindowBeginSheet( NSInteger tag, NSInteger sheetTag )
{
    if ( tag != sheetTag ) {
        NSWindow *w = CUI_WindowWithTag( tag );
        if ( w ) {
            NSWindow *sheet = CUI_WindowWithTag( sheetTag );
            if ( sheet ) {
                [w beginSheet:sheet completionHandler:^(__attribute__ ((unused)) NSModalResponse returnCode) {
                }];
                WindowSetOutput( sheetTag );// ensure UI statements/calls are directed to the sheet 20240718
            }
        }
    }
}

void WindowBeginCriticalSheet( NSInteger tag, NSInteger sheetTag )
{
    if ( tag != sheetTag ) {
        NSWindow *w = CUI_WindowWithTag( tag );
        if ( w ) {
            NSWindow *sheet = CUI_WindowWithTag( sheetTag );
            if ( sheet ) {
                [w beginCriticalSheet:sheet completionHandler:^(__attribute__ ((unused)) NSModalResponse returnCode) {
                }];
                WindowSetOutput( sheetTag );// ensure UI statements/calls are directed to the sheet 20240718
            }
        }
    }
}

void WindowEndSheet( NSInteger tag, NSInteger sheetTag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSWindow *sheet = CUI_WindowWithTag( sheetTag );
        if ( sheet ) [w endSheet:sheet];
    }
}

void WindowEndSheetWithReturnCode( NSInteger tag, NSInteger sheetTag, NSInteger returnCode )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSWindow *sheet = CUI_WindowWithTag( sheetTag );
        if ( sheet ) {
            [w endSheet:sheet returnCode:returnCode];
        }
    }
}


void WindowFlush( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w flushWindow];
}

// Default buttons
void WindowEnableKeyEquivalentForDefaultButtonCell( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w enableKeyEquivalentForDefaultButtonCell];
}

void WindowDisableKeyEquivalentForDefaultButtonCell( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w disableKeyEquivalentForDefaultButtonCell];
}

NSInteger WindowInitialFirstResponder( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSView *view = [w initialFirstResponder];
        if ( view ) return [view tag];
    }
    return 0;
}

void WindowSetInitialFirstResponder( NSInteger wndTag, NSInteger responderTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        NSView *view = CUI_ViewWithTag( responderTag );
        if ( view ) [w setInitialFirstResponder:view];
    }
}

NSInteger WindowFirstResponder( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSText *fe = [w fieldEditor:NO forObject:nil];
        if ( fe ) {
            return [(NSView *)[fe delegate] tag];
        } else {
            return [(NSView *)[w firstResponder] tag];
        }
    }
    return 0;
}

void WindowMakeFirstResponder( NSInteger wndTag, NSInteger viewTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        if ( viewTag ) {
            NSView *view = CUI_ViewWithTag( viewTag );
            if ( view ) [w makeFirstResponder:view];
        } else {
            [w makeFirstResponder:nil];
        }
    }
}

void WindowSelectKeyViewPrecedingView( NSInteger wndTag, NSInteger viewTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        NSView *view = CUI_ViewWithTag( viewTag );
        if ( view ) [w selectKeyViewPrecedingView:view];
    }
}

void WindowSelectKeyViewFollowingView( NSInteger wndTag, NSInteger viewTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        NSView *view = CUI_ViewWithTag( viewTag );
        if ( view ) [w selectKeyViewFollowingView:view];
    }
}

void WindowSelectPreviousKeyView( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w selectPreviousKeyView:nil];
}

void WindowSelectNextKeyView( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w selectNextKeyView:nil];
}

NSSelectionDirection WindowKeyViewSelectionDirection( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w keyViewSelectionDirection];
    return 0;
}

BOOL WindowAutorecalculatesKeyViewLoop( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w autorecalculatesKeyViewLoop];
    return NO;
}

void WindowSetAutorecalculatesKeyViewLoop( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setAutorecalculatesKeyViewLoop:flag];
}

void WindowRecalculateKeyViewLoop( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w recalculateKeyViewLoop];
}

BOOL WindowAcceptsMouseMovedEvents( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w acceptsMouseMovedEvents];
    return NO;
}

void WindowSetAcceptsMouseMovedEvents( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setAcceptsMouseMovedEvents:flag];
}

BOOL WindowIgnoresMouseEvents( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w ignoresMouseEvents];
    return NO;
}

void WindowSetIgnoresMouseEvents( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setIgnoresMouseEvents:flag];
}

CGPoint WindowMouseLocationOutsideOfEventStream( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSPointToCGPoint([w mouseLocationOutsideOfEventStream]);
    return CGPointZero;
}

NSInteger WindowNumberAtPoint( CGPoint pt, NSInteger belowWindowNumber )
{ return [NSWindow windowNumberAtPoint:NSPointFromCGPoint(pt) belowWindowWithWindowNumber:belowWindowNumber]; }

void WindowSetToolbar( NSInteger wndTag, NSInteger toolbarTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        NSToolbar *toolbar = CUI_ToolbarWithTag( toolbarTag );
        if ( toolbar ) {
            [w setToolbar:toolbar];
        }
    }
}

NSInteger WindowToolbar( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSToolbar *toolbar = [w toolbar];
        if ( toolbar ) return [[toolbar identifier] integerValue];
    }
    return 0;
}

void WindowToggleToolbarShown( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w toggleToolbarShown:nil];
}

void WindowRunToolbarCustomizationPalette( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w runToolbarCustomizationPalette:nil];
}

void WindowSetDocumentEdited( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setDocumentEdited:flag];
}

BOOL WindowDocumentEdited( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isDocumentEdited];
    return NO;
}

// Converting coordinates
CGFloat WindowBackingScaleFactor( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w backingScaleFactor];
    return 0.0;
}

CGRect WindowBackingAlignedRect( NSInteger tag, CGRect r, NSAlignmentOptions options )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSRectToCGRect([w backingAlignedRect:NSRectFromCGRect(r) options:options]);
    return CGRectZero;
}

CGRect WindowConvertRectFromBacking( NSInteger tag, CGRect r )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSRectToCGRect([w convertRectFromBacking:NSRectFromCGRect(r)]);
    return CGRectZero;
}

CGRect WindowConvertRectToBacking( NSInteger tag, CGRect r )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSRectToCGRect([w convertRectToBacking:NSRectFromCGRect(r)]);
    return CGRectZero;
}

CGRect WindowConvertRectToScreen( NSInteger tag, CGRect r )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSRectToCGRect([w convertRectToScreen:NSRectFromCGRect(r)]);
    return CGRectZero;
}

CGRect WindowConvertRectFromScreen( NSInteger tag, CGRect r )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSRectToCGRect([w convertRectFromScreen:NSRectFromCGRect(r)]);
    return CGRectZero;
}

void WindowToggleFullScreen( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w toggleFullScreen:nil];
}

BOOL WindowCanHide( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w canHide];
    return NO;
}

void WindowSetCanHide( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setCanHide:flag];
}

BOOL WindowTitlebarAppearsTransparent( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w titlebarAppearsTransparent];
    return NO;
}

void WindowSetTitlebarAppearsTransparent( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setTitlebarAppearsTransparent:flag];
}

void WindowAddTitlebarAccessoryViewController( NSInteger wndTag, NSTitlebarAccessoryViewController *controller )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( wndTag ) [w addTitlebarAccessoryViewController:controller];
}

void WindowInsertTitlebarAccessoryViewController( NSInteger wndTag, NSTitlebarAccessoryViewController *controller, NSInteger index )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( wndTag ) [w insertTitlebarAccessoryViewController:controller atIndex:index];
}

void WindowRemoveTitlebarAccessoryViewController( NSInteger wndTag, NSInteger index )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( wndTag ) [w removeTitlebarAccessoryViewControllerAtIndex:index];
}

CFArrayRef WindowTitlebarAccessoryViewControllers( NSInteger wndTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( wndTag ) [w titlebarAccessoryViewControllers];
    return nil;
}

// titlebar accessory view convenience functions
void WindowAddTitlebarAccessoryView( NSInteger wndTag, NSInteger viewTag, NSLayoutAttribute layout )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        NSView *view = CUI_ViewWithTag( viewTag );
        if ( view ) {
            NSTitlebarAccessoryViewController *controller = [[NSTitlebarAccessoryViewController alloc] init];
            [controller setView:view];
            [controller setLayoutAttribute:layout];
            [w addTitlebarAccessoryViewController:controller];
#if !__has_feature(objc_arc)
            [controller release];
#endif
        }
    }
}

void WindowInsertTitlebarAccessoryView( NSInteger wndTag, NSInteger viewTag, NSInteger index, NSLayoutAttribute layout )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        NSView *view = CUI_ViewWithTag( viewTag );
        if ( view ) {
            NSTitlebarAccessoryViewController *controller = [[NSTitlebarAccessoryViewController alloc] init];
            [controller setView:view];
            [controller setLayoutAttribute:layout];
            [w insertTitlebarAccessoryViewController:controller atIndex:index];
#if !__has_feature(objc_arc)
            [controller release];
#endif
        }
    }
}

void WindowRemoveTitlebarAccessoryView( NSInteger wndTag, NSInteger index )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        [w removeTitlebarAccessoryViewControllerAtIndex:index];
    }
}


#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSWindowToolbarStyle WindowToolbarStyle( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w toolbarStyle];
    return 0;
}

void WindowSetToolbarStyle( NSInteger tag, NSWindowToolbarStyle style )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setToolbarStyle:style];
}
#endif// 110000


void WindowPerformWindowDragWithEvent( NSInteger wndTag, NSEvent *evnt )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        [w performWindowDragWithEvent:evnt];
    }
}


// Tabs
BOOL WindowAllowsAutomaticWindowTabbing( void )
{ return [NSWindow allowsAutomaticWindowTabbing]; }

void WindowSetAllowsAutomaticWindowTabbing( BOOL flag )
{ [NSWindow setAllowsAutomaticWindowTabbing:flag]; }

NSWindowUserTabbingPreference WindowUserTabbingPreference( void )
{ return [NSWindow userTabbingPreference]; }

NSWindowTab *WindowTab( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w tab];
    return nil;
}

CFStringRef WindowTabbingIdentifier( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFStringRef)[w tabbingIdentifier];
    return nil;
}

void WindowSetTabbingIdentifier( NSInteger tag, CFStringRef identifier )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setTabbingIdentifier:(__bridge NSString *)identifier];
}

void WindowAddTabbedWindow( NSInteger tag, NSInteger otherTag, NSWindowOrderingMode orderingMode )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSWindow *otherWnd = CUI_WindowWithTag( otherTag );
        if ( otherWnd ) {
            [w addTabbedWindow:otherWnd ordered:orderingMode];
        }
    }
}

NSWindowTabbingMode WindowTabbingMode( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w tabbingMode];
    return 0;
}

CFArrayRef WindowTabbedWindows( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSArray *windows = [w tabbedWindows];
        if ( windows ) {
            NSMutableArray *tagsArray = [NSMutableArray arrayWithCapacity:0];
            for ( NSWindow *wnd in windows ) {
                NSInteger wndTag = [wnd tag];
                if ( wndTag ) {
                    [tagsArray addObject:[NSNumber numberWithInteger:wndTag]];
                }
            }
            return (__bridge CFArrayRef)tagsArray;
        }
    }
    return nil;
}

void WindowSelectNextTab( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w selectNextTab:nil];
}

void WindowSelectPreviousTab( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w selectPreviousTab:nil];
}

void WindowMoveTabToNewWindow( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w moveTabToNewWindow:nil];
}

void WindowToggleTabBar( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w toggleTabBar:nil];
}

void WindowToggleTabOverview( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w toggleTabOverview:nil];
}

NSWindowTabGroup *WindowTabGroup( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w tabGroup];
    return nil;
}

void WindowSetAllowsToolTipsWhenApplicationIsInactive( NSInteger tag, BOOL flag)
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setAllowsToolTipsWhenApplicationIsInactive:flag];
}

void WindowSetTitleWithRepresentedFilename( NSInteger tag, CFStringRef filename )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setTitleWithRepresentedFilename:(__bridge NSString *)filename];
}

CFArrayRef WindowChildWindows( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSArray *children = [w childWindows];
        if ( children ) {
            NSMutableArray *childTags = [NSMutableArray arrayWithCapacity:0];
            for ( NSWindow *child in children ) {
                NSInteger childTag = [child tag];
                if ( childTag ) [childTags addObject:[NSNumber numberWithInteger:childTag]];
            }
            return (__bridge CFArrayRef)childTags;
        }
    }
    return nil;
}

void WindowAddChildWindow( NSInteger parTag, NSInteger childTag, NSWindowOrderingMode ordered )
{
    NSWindow *parW = CUI_WindowWithTag( parTag );
    if ( parW ) {
        NSWindow *childW = CUI_WindowWithTag( childTag );
        if ( childW ) {
            [parW addChildWindow:childW ordered:ordered];
        }
    }
}

void WindowRemoveChildWindow( NSInteger parTag, NSInteger childTag )
{
    NSWindow *parW = CUI_WindowWithTag( parTag );
    if ( parW ) {
        NSWindow *childW = CUI_WindowWithTag( childTag );
        if ( childW ) {
            [parW removeChildWindow:childW];
        }
    }
}

NSInteger WindowParentWindow( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        return [[w parentWindow] tag];
    }
    return 0;
}

BOOL WindowHidesOnDeactivate( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w hidesOnDeactivate];
    return NO;
}

void WindowSetHidesOnDeactivate( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setHidesOnDeactivate:flag];
}

BOOL WindowIsOnActiveSpace( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isOnActiveSpace];
    return NO;
}

NSWindowCollectionBehavior WindowCollectionBehavior( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w collectionBehavior];
    return 0;
}

void WindowSetCollectionBehavior( NSInteger tag, NSWindowCollectionBehavior behavior )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setCollectionBehavior:behavior];
}

BOOL WindowIsOpaque( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isOpaque];
    return NO;
}

void WindowSetOpaque( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setOpaque:flag];
}

BOOL WindowHasShadow( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w hasShadow];
    return NO;
}

void WindowSetHasShadow( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setHasShadow:flag];
}

void WindowSetFrameOrigin( NSInteger tag, CGPoint pt )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setFrameOrigin:NSPointFromCGPoint(pt)];
}

void WindowSetFrame( NSInteger tag, CGRect frame, BOOL display, BOOL animate )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setFrame:NSRectFromCGRect(frame) display:display animate:animate];
}

CGPoint WindowCascadeTopLeftFromPoint( NSInteger tag, CGPoint pt )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSPointToCGPoint([w cascadeTopLeftFromPoint:NSPointFromCGPoint(pt)]);
    return CGPointZero;
}

CFTimeInterval WindowAnimationResizeTime( NSInteger tag, CGRect newFrame )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w animationResizeTime:NSRectFromCGRect(newFrame)];
    return 0.0;
}

BOOL WindowIsZoomed( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isZoomed];
    return NO;
}

void WindowPerformZoom( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w performZoom:nil];
}

void WindowZoom( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w zoom:nil];
}

BOOL WindowShowsResizeIndicator( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w showsResizeIndicator];
    return YES;
}

void WindowSetShowsResizeIndicator( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setShowsResizeIndicator:flag];
}

CGSize WindowMaxFullScreenContentSize( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSSizeToCGSize([w maxFullScreenContentSize]);
    return CGSizeZero;
}

void WindowSetMaxFullScreenContentSize( NSInteger tag, CGSize size )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setMaxFullScreenContentSize:NSSizeFromCGSize(size)];
}

CGSize WindowMinFullScreenContentSize( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSSizeToCGSize([w minFullScreenContentSize]);
    return CGSizeZero;
}

void WindowSetMinFullScreenContentSize( NSInteger tag, CGSize size )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setMinFullScreenContentSize:NSSizeFromCGSize(size)];
}

BOOL WindowIsVisible( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isVisible];
    return NO;
}

void WindowRemoveFrameUsingName( CFStringRef name )
{ [NSWindow removeFrameUsingName:(__bridge NSString *)name]; }

BOOL WindowIsExcludedFromWindowsMenu( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isExcludedFromWindowsMenu];
    return NO;
}

void WindowSetExcludedFromWindowsMenu( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setExcludedFromWindowsMenu:flag];
}

// Window restoration
BOOL WindowIsRestorable( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isRestorable];
    return NO;
}

void WindowSetRestorable( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setRestorable:flag];
}

Class WindowRestorationClass( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w restorationClass];
    return nil;
}

void WindowDisableSnapshotRestoration( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w disableSnapshotRestoration];
}

void WindowEnableShapshotRestoration( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w enableSnapshotRestoration];
}

// Drawing
void WindowDisplay( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w display];
}

void WindowDisplayIfNeeded( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w displayIfNeeded];
}

BOOL WindowViewsNeedDisplay( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w viewsNeedDisplay];
    return NO;
}

void WindowSetViewsNeedDisplay( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setViewsNeedDisplay:flag];
}

CGContextRef WindowGraphicsContext( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        return [[w graphicsContext] CGContext];
    }
    return NULL;
}

BOOL WindowAllowsConcurrentViewDrawing( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w allowsConcurrentViewDrawing];
    return NO;
}

void WindowSetAllowsConcurrentViewDrawing( NSInteger tag, BOOL flag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setAllowsConcurrentViewDrawing:flag];
}

BOOL WindowAreCursorRectsEnabled( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w areCursorRectsEnabled];
    return NO;
}

void WindowEnableCursorRects( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w enableCursorRects];
}

void WindowDisableCursorRects( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w disableCursorRects];
}

void WindowDiscardCursorRects( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w discardCursorRects];
}

void WindowInvalidateCursorRectsForView( NSInteger tag, NSInteger vwTag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSView *view = CUI_ViewWithTag( vwTag );
        if ( view ) [w invalidateCursorRectsForView:view];
    }
}

void WindowResetCursorRects( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w resetCursorRects];
}

// Animation
NSWindowAnimationBehavior WindowAnimationBehavior( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w animationBehavior];
    return 0;
}

void WindowSetAnimationBehavior( NSInteger tag, NSWindowAnimationBehavior behavior )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setAnimationBehavior:behavior];
}

// Dragging items
void WindowRegisterForDraggedTypes( NSInteger tag, CFArrayRef types )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w registerForDraggedTypes:(__bridge NSArray *)types];
}

void WindowUnregisterDraggedTypes( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w unregisterDraggedTypes];
}

CGRect WindowContentRectForFrameRectAndStyle( CGRect r, NSInteger styleMask )
{ return NSRectToCGRect([NSWindow contentRectForFrameRect:NSRectFromCGRect(r) styleMask:styleMask]); }

CGRect WindowFrameRectForContentRectAndStyle( CGRect r, NSInteger styleMask )
{ return NSRectToCGRect([NSWindow frameRectForContentRect:NSRectFromCGRect(r) styleMask:styleMask]); }

CGFloat WindowMinFrameWidthWithTitle( CFStringRef title, NSInteger styleMask )
{ return [NSWindow minFrameWidthWithTitle:(__bridge NSString *)title styleMask:styleMask]; }

CGRect WindowContentRectForFrameRect( NSInteger tag, CGRect r )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSRectToCGRect([w contentRectForFrameRect:NSRectFromCGRect(r)]);
    return CGRectZero;
}

CGRect WindowFrameRectForContentRect( NSInteger tag, CGRect r )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSRectToCGRect([w frameRectForContentRect:NSRectFromCGRect(r)]);
    return CGRectZero;
}

NSInteger WindowSheetParent( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [[w sheetParent] tag];
    return 0;
}

CFArrayRef WindowSheets( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSArray *sheets = [w sheets];
        if ( sheets ) {
            NSMutableArray *tagsArray = [NSMutableArray arrayWithCapacity:0];
            for ( NSWindow *sheet in sheets ) {
                NSInteger sheetTag = [sheet tag];
                if ( sheetTag ) [tagsArray addObject:[NSNumber numberWithInteger:sheetTag]];
            }
            return (__bridge CFArrayRef)tagsArray;
        }
    }
    return nil;
}

CGSize WindowResizeIncrements( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSSizeToCGSize([w resizeIncrements]);
    return CGSizeZero;
}

void WindowSetResizeIncrements( NSInteger tag, CGSize size )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setResizeIncrements:NSSizeFromCGSize(size)];
}

BOOL WindowInLiveResize( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w inLiveResize];
    return NO;
}

void WindowSetContentSize( NSInteger tag, CGSize size )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setContentSize:NSSizeFromCGSize(size)];
}

CGSize WindowContentResizeIncrements( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) NSSizeToCGSize([w contentResizeIncrements]);
    return CGSizeZero;
}

void WindowSetContentResizeIncrements( NSInteger tag, CGSize size )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setContentResizeIncrements:NSSizeFromCGSize(size)];
}

void WindowOrderRelativeTo( NSInteger wndTag, NSWindowOrderingMode order, NSInteger otherWndTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        if ( otherWndTag ) {
            NSWindow *otherWnd = CUI_WindowWithTag( otherWndTag );
            if ( otherWnd ) {
                [w orderWindow:order relativeTo:[otherWnd windowNumber]];
            }
        } else {
            [w orderWindow:order relativeTo:0];
        }
    }
}

NSInteger WindowLevel( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w level];
    return 0;
}

void WindowSetLevel( NSInteger tag, NSInteger level )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setLevel:level];
}

void *WindowStandardWindowButtonForStyleMask( NSWindowButton btn, NSUInteger styleMask )
{ return (__bridge void *)[NSWindow standardWindowButton:btn forStyleMask:styleMask]; }

void *WindowStandardWindowButton( NSInteger tag, NSWindowButton btn )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge void *)[w standardWindowButton:btn];
    return nil;
}

NSWindowTitleVisibility WindowTitleVisibility( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w titleVisibility];
    return 0;
}

void WindowSetTitleVisibility( NSInteger tag, NSWindowTitleVisibility visibility )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setTitleVisibility:visibility];
}

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
NSTitlebarSeparatorStyle WindowTitlebarSeparatorStyle( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w titlebarSeparatorStyle];
    return 0;
}

void WindowSetTitlebarSeparatorStyle( NSInteger tag, NSTitlebarSeparatorStyle style )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setTitlebarSeparatorStyle:style];
}
#endif// 110000

NSUInteger WindowResizeFlags( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w resizeFlags];
    return 0;
}

// Instance properties
BOOL WindowIsFloatingPanel( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isFloatingPanel];
    return NO;
}

BOOL WindowIsMiniaturizable( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isMiniaturizable];
    return NO;
}

BOOL WindowIsModalPanel( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isModalPanel];
    return NO;
}

BOOL WindowIsResizable( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isResizable];
    return NO;
}

NSUInteger WindowStyleMask( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w styleMask];
    return 0;
}

void WindowSetStyleMask( NSInteger tag, NSUInteger mask )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setStyleMask:mask];
}

BOOL WindowIsZoomable( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w isZoomable];
    return NO;
}

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
CGPoint WindowConvertPointFromScreen( NSInteger tag, CGPoint pt )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSPointToCGPoint([w convertPointFromScreen:NSPointFromCGPoint(pt)]);
    return CGPointZero;
}

CGPoint WindowConvertPointToScreen( NSInteger tag, CGPoint pt )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSPointToCGPoint([w convertPointToScreen:NSPointFromCGPoint(pt)]);
    return CGPointZero;
}

CGPoint WindowConvertPointFromBacking( NSInteger tag, CGPoint pt )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSPointToCGPoint([w convertPointFromBacking:NSPointFromCGPoint(pt)]);
    return CGPointZero;
}

CGPoint WindowConvertPointToBacking( NSInteger tag, CGPoint pt )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return NSPointToCGPoint([w convertPointToBacking:NSPointFromCGPoint(pt)]);
    return CGPointZero;
}
#endif// 101400

void WindowMergeAllWindows( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w mergeAllWindows:nil];
}

void WindowSetFrameAutosaveName( NSInteger tag, CFStringRef name )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setFrameAutosaveName:(__bridge NSString *)name];
}

// DisplayLink
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
CADisplayLink *WindowDisplayLinkWithTarget( NSInteger tag, id target, CFStringRef selector )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        return [w displayLinkWithTarget:target selector:NSSelectorFromString((__bridge NSString *)selector)];
    }
    return nil;
}
#endif// 140000

/*
 NSAppearanceCustomization
 */
NSAppearance *WindowAppearance( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w appearance];
    return nil;
}

void WindowSetAppearance( NSInteger tag, NSAppearance *appearance )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setAppearance:appearance];
}

void WindowSetAppearanceNamed( NSInteger tag, CFStringRef name )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setAppearance:[NSAppearance appearanceNamed:(__bridge NSString *)name]];
}

NSAppearance *WindowEffectiveAppearance( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return [w effectiveAppearance];
    return nil;
}


#pragma mark - convenience
// Animation
CFTypeRef WindowAnimator( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFTypeRef)[w animator];
    return nil;
}

CFDictionaryRef WindowAnimations( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFDictionaryRef)[w animations];
    return nil;
}

void WindowSetAnimations( NSInteger tag, CFDictionaryRef animations )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setAnimations:(__bridge NSDictionary *)animations];
}

// Identifier (same as UserInterfaceItemIdentificationIdentifier)
CFStringRef WindowIdentifier( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return (__bridge CFStringRef)[w identifier];
    return nil;
}

void WindowSetIdentifier( NSInteger tag, CFStringRef identifier )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setIdentifier:(__bridge NSString *)identifier];
}


#pragma mark - custom
void WindowSetOutput( NSInteger tag )
{ CUI_OutputWindowSetTag( ABS(tag) ); }

void WindowAddSubview( NSInteger tag, NSView *vwRef )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        [[w contentView] addSubview:vwRef];
    }
}

void WindowSetTitleWithRepresentedURL( NSInteger tag, CFURLRef url )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) [w setTitleWithRepresentedFilename:[(__bridge NSURL *)url path]];
}

// Class
//Class WindowClass( void )
//{ return [NSWindow class]; }

BOOL WindowExists( NSInteger tag )
{ return CUI_TargetWithTag( tag ) != nil; }

id WindowWithTag( NSInteger tag )
{ return (id)CUI_WindowWithTag( tag ); }

id WindowViewWithTag( NSInteger wndTag, NSInteger viewTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        NSView *contentView = [w contentView];
        if ( viewTag == windowContentViewTag ) return contentView;
        return CUI_ViewSubviewWithTag( contentView, viewTag );
    }
    return nil;
}

void WindowSetDelegateCallback( NSInteger tag, CUI_WindowCallbackType callback, void *userData )
{
    if ( tag == 0 ) {   // all windows
        CUI_WindowDelegate *delegate = CUI_WindowDelegateObj();
        [delegate setAllWindowsCallback:callback];
    } else {            // one window
        NSWindow *w = CUI_WindowWithTag( tag );
        if ( w ) {
            [w setCuiWindowCallback:callback];
            [w setCuiWindowUserData:userData];
        }
    }
}

void WindowSubclassContentView( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        ContentViewSC *view = (ContentViewSC *)[w contentView];
        [(ContentViewSC *)view setSubclassFlag:YES];
    }
}

void WindowRecalculateKeyViewLoopByTagOrder( NSInteger wndTag )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        NSArray *subviews = [[w contentView] subviews];
        if ( subviews ) {
            [w setAutorecalculatesKeyViewLoop:NO];
            NSSortDescriptor *ascendingSort = [[NSSortDescriptor alloc] initWithKey:@"tag" ascending:YES];
            NSArray *sortedSubviews = [subviews sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascendingSort]];
            NSView *firstView = [sortedSubviews objectAtIndex:0];
            [w setInitialFirstResponder:firstView];
            NSUInteger count = [sortedSubviews count];
            for ( NSUInteger index = 0; index < count; index++ ) {
                NSView *view = [sortedSubviews objectAtIndex:index];
                if ( index == count - 1 ) {
                    [view setNextKeyView:firstView];
                } else {
                    [view setNextKeyView:[sortedSubviews objectAtIndex:index+1]];
                }
            }
        }
    }
}


void WindowSetKeyViewLoop( NSInteger wndTag, CFTypeRef views )
{
    NSWindow *w = CUI_WindowWithTag( wndTag );
    if ( w ) {
        [w setAutorecalculatesKeyViewLoop:NO];
        NSObject *objects = (__bridge NSObject *)views;
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
        
        if ( [objects isKindOfClass:[NSString class]] ) {
            [array addObjectsFromArray:[(NSString *)objects componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]]];
        } else if ( [objects isKindOfClass:[NSOrderedSet class]] ) {
            [array addObjectsFromArray:[(NSOrderedSet *)objects array]];
        } else if ( [objects isKindOfClass:[NSArray class]] ) {
            [array addObjectsFromArray:(NSArray *)objects];
        }
        
        NSUInteger count = [array count];
        if ( count ) {

            //NSView *contentView = [w contentView];
            
            id firstObj = [array objectAtIndex:0];
            NSView *firstView = nil;
            if ( [(NSObject *)firstObj isKindOfClass:[NSString class]] ) {
                firstView = CUI_ViewWithTag( [firstObj integerValue] );
            } else if ( [(NSObject *)firstObj isKindOfClass:[NSNumber class]] ) {
                firstView = CUI_ViewWithTag( [(NSNumber *)firstObj integerValue] );
            } else {
                firstView = (NSView *)firstObj;
            }
                        
            [w setInitialFirstResponder:firstView];

            for ( NSUInteger index = 0; index < count; index++ ) {
                id obj = [array objectAtIndex:index];
                
                NSView *view = nil;
                
                if ( [(NSObject *)obj isKindOfClass:[NSString class]] ) {
                    view = CUI_ViewWithTag( [obj integerValue] );
                } else if ( [(NSObject *)obj isKindOfClass:[NSNumber class]] ) {
                    view = CUI_ViewWithTag( [(NSNumber *)obj integerValue] );
                } else {
                    view = (NSView *)obj;
                }
                
                NSView *nextView = nil;
                if ( view ) {
                    if ( index == count-1 ) {
                        nextView = firstView;
                    } else {
                        id nextObj = [array objectAtIndex:index+1];
                        if ( [(NSObject *)obj isKindOfClass:[NSString class]] ) {
                            nextView = CUI_ViewWithTag( [nextObj integerValue] );
                        } else if ( [(NSObject *)obj isKindOfClass:[NSNumber class]] ) {
                            nextView = CUI_ViewWithTag( [(NSNumber *)nextObj integerValue] );
                        } else {
                            nextView = (NSView *)nextObj;
                        }
                    }
                    if ( nextView ) {
                        [view setNextKeyView:nextView];
                    }
                }
            }
        }
    }
}

CFTypeRef WindowProperty( NSInteger tag, CFStringRef key )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return ObjectProperty( (__bridge CFTypeRef)w, key );
    return nil;
}

void WindowSetProperty( NSInteger tag, CFStringRef key, CFTypeRef value )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectSetProperty( (__bridge CFTypeRef)w, key, value );
}

void WindowPropertySet( NSInteger tag, CFStringRef key, CFTypeRef value )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectPropertySet( (__bridge CFTypeRef)w, key, value );
}


BOOL WindowPropertyBool( NSInteger tag, CFStringRef key )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return ObjectPropertyBool( (__bridge CFTypeRef)w, key );
    return NO;
}

void WindowPropertySetBool( NSInteger tag, CFStringRef key, BOOL value )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectPropertySetBool( (__bridge CFTypeRef)w, key, value );
}

long WindowPropertyLong( NSInteger tag, CFStringRef key )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return ObjectPropertyLong( (__bridge CFTypeRef)w, key );
    return 0;
}

void WindowPropertySetLong( NSInteger tag, CFStringRef key, long value )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectPropertySetLong( (__bridge CFTypeRef)w, key, value );
}

double WindowPropertyDouble( NSInteger tag, CFStringRef key )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return ObjectPropertyDouble( (__bridge CFTypeRef)w, key );
    return 0.0;
}

void WindowPropertySetDouble( NSInteger tag, CFStringRef key, double value )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectPropertySetDouble( (__bridge CFTypeRef)w, key, value );
}

CGRect WindowPropertyRect( NSInteger tag, CFStringRef key )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return ObjectPropertyRect( (__bridge CFTypeRef)w, key );
    return CGRectZero;
}

void WindowPropertySetRect( NSInteger tag, CFStringRef key, CGRect r )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectPropertySetRect( (__bridge CFTypeRef)w, key, r );
}

CGPoint WindowPropertyPoint( NSInteger tag, CFStringRef key )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return ObjectPropertyPoint( (__bridge CFTypeRef)w, key );
    return CGPointZero;
}

void WindowPropertySetPoint( NSInteger tag, CFStringRef key, CGPoint pt )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectPropertySetPoint( (__bridge CFTypeRef)w, key, pt );
}

CGSize WindowPropertySize( NSInteger tag, CFStringRef key )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return ObjectPropertySize( (__bridge CFTypeRef)w, key );
    return CGSizeZero;
}

void WindowPropertySetSize( NSInteger tag, CFStringRef key, CGSize sz )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectPropertySetSize( (__bridge CFTypeRef)w, key, sz );
}

CFRange WindowPropertyRange( NSInteger tag, CFStringRef key )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return ObjectPropertyRange( (__bridge CFTypeRef)w, key );
    return CFRangeMake(NSNotFound,0);
}

void WindowPropertySetRange( NSInteger tag, CFStringRef key, CFRange range )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectPropertySetRange( (__bridge CFTypeRef)w, key, range );
}

CFURLRef WindowPropertyBookmarkURL( NSInteger tag, CFStringRef key )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return ObjectPropertyBookmarkURL( (__bridge CFTypeRef)w, key );
    return nil;
}

void WindowPropertySetBookmarkURL( NSInteger tag, CFStringRef key, CFURLRef url )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectPropertySetBookmarkURL( (__bridge CFTypeRef)w, key, url );
}

BOOL WindowPropertyGetBytes( NSInteger tag, CFStringRef key, void *bytes )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) return ObjectPropertyGetBytes( (__bridge CFTypeRef)w, key, bytes );
    return NO;
}

void WindowPropertySetBytes( NSInteger tag, CFStringRef key, void *bytes, long length )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectPropertySetBytes( (__bridge CFTypeRef)w, key, bytes, length );
}


void WindowRemoveProperty( NSInteger tag, CFStringRef key )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectRemoveProperty( (__bridge CFTypeRef)w, key );
}

void WindowPropertyRemove( NSInteger tag, CFStringRef key )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectPropertyRemove( (__bridge CFTypeRef)w, key );
}

void WindowRemoveAllProperties( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectRemoveAllProperties( (__bridge CFTypeRef)w );
}

void WindowPropertyRemoveAll( NSInteger tag )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) ObjectPropertyRemoveAll( (__bridge CFTypeRef)w );
}

// Cascade
void WindowCascadeTopLeftFromWindow( NSInteger tag, NSInteger otherTag )
{
    NSWindow *w1 = CUI_WindowWithTag( tag );
    if ( w1 ) {
        NSWindow *w2 = CUI_WindowWithTag( otherTag );
        if ( w2 ) {
            NSRect r = [w2 frame];
            NSPoint pt = NSMakePoint(r.origin.x+21,r.origin.y+r.size.height-23);
            [w1 cascadeTopLeftFromPoint:pt];
        }
    }
}

void WindowCascadeTopLeftFromNextWindow( NSInteger tag )
{
    NSWindow *w1 = CUI_WindowWithTag( tag );
    if ( w1 ) {
        //NSArray *delegateWindows = CUI_AppDelegateWindows();// 20220404
        //if ( [delegateWindows containsObject:w1] ) {// 20220404
            NSWindow *w2 = nil;
            NSArray *windows = [NSApp orderedWindows];

            NSUInteger count = [windows count];
            if ( count > 1 ) {
                for ( NSUInteger index = 0; index < count - 1; index++ ) {
                    if ( [(NSWindow *)[windows objectAtIndex:index] isEqual:w1] ) {
                        w2 = [windows objectAtIndex:index+1];
                        //if ( ![delegateWindows containsObject:w2] ) {// 20220404
                            //w2 = nil;// 20220404
                        //}// 20220404
                        break;
                    }
                }
            }
            NSPoint pt = NSMakePoint(0,1);
            if ( w2 ) {
                NSRect r = [w2 frame];
                pt = NSMakePoint(r.origin.x+21,r.origin.y+r.size.height-23);
            }
            [w1 cascadeTopLeftFromPoint:pt];
        //}// 20220404
    }
}

// SheetAlert
void WindowEndSheetAlert( NSInteger tag, NSInteger alertTag )
{
    NSWindow *w = WindowWithTag( tag );
    if ( w ) {
        NSAlert *alert = AlertWithTag( alertTag );
        if ( alert ) {
            [w endSheet:[alert window]];
        }
    }
}

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
CGRect WindowCascadingReferenceFrame( NSInteger tag )
{
    NSWindow *w = WindowWithTag( tag );
    if ( w ) {
        return NSRectToCGRect([w cascadingReferenceFrame]);
    }
    return CGRectZero;
}
#endif// 150000

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
NSDraggingSession *WindowBeginDraggingSessionWithItems( NSInteger tag, CFArrayRef items, NSEvent *event, id<NSDraggingSource> source )
{
    NSWindow *w = WindowWithTag( tag );
    if ( w ) {
        return [w beginDraggingSessionWithItems:(__bridge NSArray *)items event:event source:source];
    }
    return nil;
}

void WindowRequestSharingOfWindow( NSInteger tag, NSWindow *wnd, CUI_WindowRequestSharingOfWindowType completionHandler, void *userData )
{
    NSWindow *w = WindowWithTag( tag );
    if ( w ) {
        [w requestSharingOfWindow:wnd completionHandler:^(NSError * error) {
            (*completionHandler)(tag,error,userData);
        }];
    }
}

void WindowRequestSharingOfWindowUsingPreview( NSInteger tag, NSImage *image, CFStringRef title, CUI_WindowRequestSharingOfWindowType completionHandler, void *userData )
{
    NSWindow *w = WindowWithTag( tag );
    if ( w ) {
        [w requestSharingOfWindowUsingPreview:image title:(__bridge NSString *)title completionHandler:^(NSError * error) {
            (*completionHandler)(tag,error,userData);
        }];
    }
}
#endif// 150000


void WindowRegisterForDraggedFileTypes( NSInteger tag, CFTypeRef inFileTypes )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSArray *fileTypes = nil;
        if ( inFileTypes ) {
            if ( CFGetTypeID( inFileTypes ) == CFStringGetTypeID() ) {
                fileTypes = [(__bridge NSString *)inFileTypes componentsSeparatedByString:@";"];
            } else if ( CFGetTypeID( inFileTypes ) == CFArrayGetTypeID() ) {
                fileTypes = (__bridge NSArray *)inFileTypes;
            }
        }
        [(CUI_WindowDelegate *)[w delegate] setDragFileTypes:fileTypes];// 20210103
        [w registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
    }
}

void WindowRegisterForDraggedFileExtensions( NSInteger tag, CFTypeRef inFileExtensions )
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        NSArray *fileExtensions = nil;
        if ( inFileExtensions ) {
            if ( CFGetTypeID( inFileExtensions ) == CFStringGetTypeID() ) {
                fileExtensions = [(__bridge NSString *)inFileExtensions componentsSeparatedByString:@";"];
            } else if ( CFGetTypeID( inFileExtensions ) == CFArrayGetTypeID() ) {
                fileExtensions = (__bridge NSArray *)inFileExtensions;
            }
        }
        [(CUI_WindowDelegate *)[w delegate] setDragFileExtensions:fileExtensions];
        [w registerForDraggedTypes:[NSArray arrayWithObject:NSFilenamesPboardType]];
    }
}

// Hide/show tooltips
void WindowSetToolTipsHidden( NSInteger tag, BOOL flag )// 20240622
{
    NSWindow *w = CUI_WindowWithTag( tag );
    if ( w ) {
        // toolbar items
        NSToolbar *toolbar = [w toolbar];
        if ( toolbar ) ToolbarSetToolTipsHidden( (NSInteger)toolbar, flag );
        
        // views
        ViewSetToolTipsHidden( (NSInteger)[w contentView], flag );
    }
}
    
#pragma mark - window function
NSInteger CUI_WindowFunction( NSInteger inSelector )
{
    NSInteger result = 0;
    
    if ( inSelector == kFBParamMissing ) inSelector = windowKey;// key

    if ( inSelector < 0 ) {
        id w = CUI_WindowWithTag( ABS(inSelector) );
        if ( w ) result = 1;
    } else {
        // output window
        id w = CUI_OutputWindow();
        
        switch ( inSelector ) {
            case windowKey: {
                id w = [NSApp keyWindow];
                if ( w ) result = [w tag];
                break;
            }
            case windowMain: {
                id w = [NSApp mainWindow];
                if ( w ) result = [w tag];
                break;
            }
            case windowOutput: {
                if ( w ) result = [w tag];
                break;
            }
            case windowWidth: {
                if ( w ) {
                    NSRect frame = [w frame];
                    result = (NSInteger)frame.size.width;
                }
                break;
            }
            case windowHeight: {
                if ( w ) {
                    NSRect frame = [w frame];
                    result = (NSInteger)frame.size.height;
                }
                break;
            }
            case windowContentWidth: {
                if ( w ) {
                    NSRect frame = [w contentRectForFrameRect:[w frame]];
                    result = (NSInteger)frame.size.width;
                }
                break;
            }
            case windowContentHeight: {
                if ( w ) {
                    NSRect frame = [w contentRectForFrameRect:[w frame]];
                    result = (NSInteger)frame.size.height;
                }
                break;
            }
            default:
                CUI_ShowAlert( NSWarningAlertStyle, @"Window function error.", [NSString stringWithFormat:@"Selector (%ld) is out of range.",inSelector] );
                break;
        }
    }
    return result;
}


#pragma mark - init
// Init
NSWindow *WindowInit( NSInteger inTag, CGRect inRect )
{
    // rect
    NSRect rect = NSRectFromCGRect( inRect );
    BOOL center = NO;
    if ( NSIsEmptyRect( rect ) ) {
        rect = NSMakeRect( 0, 0, 550, 400 );
    }
//    else {
//        center = ( rect.origin.x == 0.0 && rect.origin.y == 0.0 );
//    }
    center = ( rect.origin.x == 0.0 && rect.origin.y == 0.0 );// change default position to centered rather than bottom left  20220712

    // style
    NSUInteger style = NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask;
    
    // subclass
    BOOL subclass = CUI_IsSubclassFlag();

    // init
    NSWindow *w;
    if ( subclass ) {
        w = [[WindowSC alloc] initWithContentRect:rect styleMask:style backing:NSBackingStoreBuffered defer:NO];
    } else {
        w = [[NSWindow alloc] initWithContentRect:rect styleMask:style backing:NSBackingStoreBuffered defer:NO];
    }

    // window controller
    CUI_WindowController *controller = [[CUI_WindowController alloc] init];
    [controller setWindow:w];
    [w setWindowController:controller];

    // content view
    /*create content view subclass for:
     intercepting content view drawRect:, etc. to issue dialog event events.
     */
    ContentViewSC *contentView = [[ContentViewSC alloc] initWithFrame:[[w contentView] frame]];
    [w setContentView:contentView];
    [contentView setIdentifier:[NSString stringWithFormat:@"%d",windowContentViewTag]];

    // key view loop
    [w setAutorecalculatesKeyViewLoop:YES];
    
    // tag
    [w setTag:inTag];
    
    // title
    [w setTitle:@"Untitled"];

    // center
    if ( center ) [w center];
    
    // delegate
    [w setDelegate:CUI_WindowDelegateObj()];
    
    // add window to app delegate
    CUI_AppDelegateAddWindow( w );
    
    [w setReleasedWhenClosed:YES];// 20211014
    
    return w;
}

// Statement
void CUI_Window( NSInteger inTag, CFStringRef inTitle, CGRect inRect, NSInteger inStyle )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
    
    if ( inTag == 0 ) return;// 20240110
    
    if ( CUI_ObjectIsPopover( inTag ) ) return;
    
    NSString *title = (__bridge NSString *)inTitle;
    NSRect rect = NSRectFromCGRect( inRect );
    
    NSWindow *w = CUI_WindowWithTag( inTag );
    if ( w ) {      // exists
        // clear subclass flag
        CUI_SetSubclassFlag(NO);

        // title
        if ( title ) [w setTitle:title];
        
        // rect
        if ( !NSIsEmptyRect( rect ) ) {
            [w setFrame:[w frameRectForContentRect:rect] display:YES];
        }
        
        if ( (int)inStyle != kFBParamMissing ) [w setStyleMask:inStyle];
        
    } else {    // create
        // init
        w = WindowInit( inTag, inRect );
        
        // style mask
        if ( (int)inStyle != kFBParamMissing ) [w setStyleMask:inStyle];
                 
        // title
        if ( title ) [w setTitle:title];
    }
    
    // show
    if ( show ) {
        [w makeKeyAndOrderFront:nil];
    } else {
        [w orderOut:nil];
    }
        
    CUI_OutputWindowSetTag( inTag );    
}


#pragma mark - sidebar splitview controller
//void CUI_ProcessSidebarSplitViewController( NSWindow *window, NSString *nibName )
//{
//    NSSplitViewController *splitViewController = nil;
//    NSViewController *leftViewController = nil;
//    NSViewController *rightViewController = nil;
//
//    NSArray *objects = CUI_NibObjects( nibName );
//    if ( objects ) {
//        for ( id obj in objects ) {
//            if ( [obj isKindOfClass:[NSSplitViewController class]] ) {
//                splitViewController = [obj retain];
//            } else if ( [obj isKindOfClass:[NSViewController class]] ) {
//                id superview = [[obj view] superview];
//                if ( [superview isKindOfClass:[NSSplitView class]] ) {
//                    NSArray *subviews = [superview subviews];
//                    if ( [[obj view] isEqual:subviews[0]] ) {
//                        leftViewController = obj;
//                    } else {
//                        rightViewController = obj;
//                    }
//                }
//            }
//        }
//    }
//
//    if ( splitViewController != nil && leftViewController != nil && rightViewController != nil ) {
//        NSSplitViewItem *leftItem = [NSSplitViewItem sidebarWithViewController:leftViewController];
//        NSSplitViewItem *rightItem = [NSSplitViewItem splitViewItemWithViewController:rightViewController];
//        [splitViewController setSplitViewItems:@[leftItem,rightItem]];
//        [window setContentViewController:splitViewController];
//    }
//}


#pragma mark - nib window

void CUI_NibWindow( NSInteger inTag, CFStringRef inNibName, CFStringRef inWndIdentifier )
{
    BOOL show = ( inTag > 0 );
    inTag = ABS(inTag);
        
    BOOL isNib = NO;
    
    if ( CUI_ObjectIsPopover( inTag ) ) return;
        
    NSWindow *w = CUI_WindowWithTag( inTag );
    if ( !w ) {             // ensure another window doesn't already exist with this tag number
        
        NSString *nibName = (__bridge NSString *)inNibName;
        NSString *wndIdentifier = (__bridge NSString *)inWndIdentifier;
        
        CUI_NibObject *nibObj = CUI_NibObjectWithName( nibName );
        if ( !nibObj ) {
            NSURL *url = [[NSBundle mainBundle] URLForResource:nibName withExtension:@"nib"];// see if it's a nib
            if ( url ) {    // it's a nib
                NSNib *nib = [[NSNib alloc] initWithNibNamed:nibName bundle:nil];
                if ( nib ) {
                    NSArray *objects = nil;
                    [nib instantiateWithOwner:nil topLevelObjects:&objects];
                    CUI_NibObjectAdd( objectTypeNib, nibName, objects, nil );
                    isNib = YES;
                }
            } else {        // maybe it's a storyboard
                
                url = [[NSBundle mainBundle] URLForResource:nibName withExtension:@"storyboardc"];
                if ( url ) {
                    NSStoryboard *sb = [NSStoryboard storyboardWithName:nibName bundle:nil];
                    if ( sb ) {
                        NSWindowController *controller = [sb instantiateInitialController];
#if !__has_feature(objc_arc)
                        [controller retain];// retain?
#endif
                        if ( controller ) {
                            CUI_NibObjectAdd( objectTypeStoryboard, nibName, nil, controller );
                        }
                    }
                }
                
            }
        }
        
        w = CUI_WindowFromNibObjects( inTag, nibName, wndIdentifier );
        if ( w ) {
            // grab the release when closed flag here because setting the window controller resets it 20211014
            BOOL releasedWhenClosed = [w isReleasedWhenClosed];
            
            CUI_WindowController *controller = nil;
            if ( isNib ) {
                controller = [[CUI_WindowController alloc] init];
                [controller setWindow:w];
                [w setWindowController:controller];
            }
            
            [w setReleasedWhenClosed:releasedWhenClosed];// restore released when closed flag 20211014
            
//     CUI_ProcessSidebarSplitViewController( w, nibName );
        }
        
    }
    CUI_OutputWindowSetTag( inTag );
    
    // show
    if ( show ) {
        [w makeKeyAndOrderFront:nil];
    } else {
        [w orderOut:nil];
    }
    
}
