/*
 CocoaUI.m
 
 Bernie Wylde 20170712
 */

#import "CocoaUI.h"

#pragma mark - subclass flag
static BOOL sCUI_SubclassFlag;

BOOL CUI_IsSubclassFlag( void )
{
    BOOL flag = sCUI_SubclassFlag;
    sCUI_SubclassFlag = NO;// reset
    return flag;
}

void CUI_SetSubclassFlag( BOOL flag )
{ sCUI_SubclassFlag = flag; }


#pragma mark - suppress CocoaUI alerts
static BOOL sCUI_SuppressAlerts;

BOOL CUI_SuppressAlerts( void )
{ return sCUI_SuppressAlerts; }

void CUI_SetSuppressAlerts( BOOL flag )
{ sCUI_SuppressAlerts = flag; }


#pragma mark - superview
static NSMutableArray *sCUI_Superviews;
static BOOL sCUI_SuperviewFlag;

BOOL CUI_IsSuperview( void )
{
    BOOL flag = sCUI_SuperviewFlag;
    sCUI_SuperviewFlag = NO;// reset
    return flag;
}

void CUI_SetSuperviewFlag( BOOL flag )
{ sCUI_SuperviewFlag = flag; }

void CUI_AddSuperview( id superview )
{
    if ( !sCUI_Superviews ) sCUI_Superviews = [[NSMutableArray alloc] initWithCapacity:0];
    [sCUI_Superviews addObject:superview];
}

id CUI_CurrentSuperview( void )
{
    if ( sCUI_Superviews ) {
        if ( [sCUI_Superviews count] > 0 ) return [sCUI_Superviews lastObject];
    }
    return nil;
}

id CUI_PenultimateSuperview( void )
{
    if ( sCUI_Superviews ) {
        NSInteger count = [sCUI_Superviews count];
        if ( count > 1 ) return sCUI_Superviews[count-2];
    }
    return nil;
}

void CUI_RemoveSuperview( void )
{ if ( sCUI_Superviews ) [sCUI_Superviews removeLastObject]; }

void CUI_SuperviewEndStatement( void )
{
    sCUI_SuperviewFlag = NO;
    if ( sCUI_Superviews ) [sCUI_Superviews removeLastObject];
}


#pragma mark - alerts
void CUI_ShowAlert( NSAlertStyle style, NSString *msg, NSString *info )
{
    if ( CUI_SuppressAlerts() ) {
        NSLog(@"%@ %@",msg,info);
        return;
    }
    
    dispatch_async( dispatch_get_main_queue(), ^{   // show alert on main thread 20200504
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setAlertStyle:style];
        [alert setMessageText:msg];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:@"OK"];
        [alert addButtonWithTitle:@"Quit"];
        if ( [alert runModal] == NSAlertSecondButtonReturn ) {
            //[NSApp terminate:nil]; // this doesn't quit the app when a modal window is displayed
            exit(0);// 20240718
        }
#if !__has_feature(objc_arc)
        [alert release];
#endif
    });
}

void CUI_ShowWindowDoesNotExistAlert( NSInteger tag )
{ CUI_ShowAlert( NSWarningAlertStyle, @"Window error.", [NSString stringWithFormat:@"Window %ld does not exist.",(long)tag] ); }


#pragma mark - utilities
NSColor *CUI_FixColor( long col )
{
    if ( col == kFBParamMissing ) return nil;
    if ( col >= 0 && col < 1000000 ) {
        switch ( col ) {
            case zYellow:
                return [NSColor yellowColor];
            case zGreen:
                return [NSColor greenColor];
            case zCyan:
                return [NSColor cyanColor];
            case zBlue:
                return [NSColor blueColor];
            case zMagenta:
                return [NSColor magentaColor];
            case zRed:
                return [NSColor redColor];
            case zBlack:
                return [NSColor blackColor];
            case zWhite:
                return [NSColor whiteColor];
            case zBrown:
                return [NSColor brownColor];
            case zGray:
                return [NSColor grayColor];
            case zDarkGray:
                return [NSColor darkGrayColor];
            case zLightGray:
                return [NSColor lightGrayColor];
            case zOrange:
                return [NSColor orangeColor];
            case zPurple:
                return [NSColor purpleColor];
            case zClear:
                return [NSColor clearColor];
            case zText:
                return [NSColor textColor];
            case zSystemBlue:
                return [NSColor systemBlueColor];
            case zSystemBrown:
                return [NSColor systemBrownColor];
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
            case zSystemCyan:
                if ( @available(macOS 12.0, *) ) {
                    return [NSColor systemCyanColor];
                }
#endif // 120000
            case zSystemGray:
                return [NSColor systemGrayColor];
            case zSystemGreen:
                return [NSColor systemGreenColor];
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
            case zSystemIndigo:
                if ( @available(macOS 10.15, *) ) {
                    return [NSColor systemIndigoColor];
                }
#endif // 101500
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000
            case zSystemMint:
                if ( @available(macOS 12.0, *) ) {
                    return [NSColor systemMintColor];
                }
#endif // 120000
            case zSystemOrange:
                return [NSColor systemOrangeColor];
            case zSystemPink:
                return [NSColor systemPinkColor];
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
            case zSystemTeal:
                if ( @available(macOS 10.15, *) ) {
                    return [NSColor systemTealColor];
                }
#endif // 101500
            case zSystemYellow:
                return [NSColor systemYellowColor];
            default:
                return nil;
        }
    } else {
        return (__bridge id)(void *)col;
    }
    return nil;
}

#if 0
// taken from Apple documentation
CGPathRef CUI_BezierPathCGPath( NSBezierPath *bezierPath )
{
    // Need to begin a path here.
    CGPathRef cgPath = NULL;

    // Then draw the path elements.
    NSInteger numElements = [bezierPath elementCount];
    if ( numElements > 0 ) {
        CGMutablePathRef    mutPath = CGPathCreateMutable();
        NSPoint             points[3];
        BOOL                didClosePath = YES;
        
        for ( NSInteger i = 0; i < numElements; i++ ) {
            switch ( [bezierPath elementAtIndex:i associatedPoints:points] ) {
                case NSMoveToBezierPathElement:
                    CGPathMoveToPoint( mutPath, NULL, points[0].x, points[0].y );
                    break;
                    
                case NSLineToBezierPathElement:
                    CGPathAddLineToPoint( mutPath, NULL, points[0].x, points[0].y );
                    didClosePath = NO;
                    break;

                case NSCurveToBezierPathElement:
                    CGPathAddCurveToPoint( mutPath, NULL, points[0].x, points[0].y,
                                          points[1].x, points[1].y,
                                          points[2].x, points[2].y );
                    didClosePath = NO;
                    break;

                case NSClosePathBezierPathElement:
                    CGPathCloseSubpath( mutPath );
                    didClosePath = YES;
                    break;
                    
                default:
                    break;
            }
        }

        // Be sure the path is closed or Quartz may not do valid hit detection.
        if ( !didClosePath ) CGPathCloseSubpath( mutPath );

        cgPath = CGPathCreateCopy( mutPath );
        CGPathRelease( mutPath );
    }
    return cgPath;
}

#else

CGPathRef CUI_BezierPathCGPath( NSBezierPath *bezierPath )
{
    NSInteger numElements = [bezierPath elementCount];
    CGMutablePathRef path = CGPathCreateMutable();

    for ( NSInteger i = 0; i < numElements; i++) {
        NSPoint points[3];

        NSBezierPathElement element = [bezierPath elementAtIndex:i associatedPoints:points];

        switch (element) {
            case NSMoveToBezierPathElement: {
                CGPathMoveToPoint(path, NULL, points[0].x, points[0].y);
                break;
            }

            case NSLineToBezierPathElement: {
                CGPathAddLineToPoint(path, NULL, points[0].x, points[0].y);
                break;
            }

            case NSCurveToBezierPathElement: {
                CGPathAddCurveToPoint(path, NULL, points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y);
                break;
            }
                
            case NSClosePathBezierPathElement:
                CGPathCloseSubpath(path);
                break;
                
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
            case NSBezierPathElementQuadraticCurveTo:
#endif // 140000
            default:
                break;
        }
    }
    CGPathRef cgPath = CGPathCreateCopy(path);
    CGPathRelease(path);

    //return cgPath;
    id __autoreleasing obj = CFBridgingRelease(cgPath);
    return (__bridge CGPathRef)obj;
}
#endif


static void CUI_BezierPathWithCGPathApplierFunction( void *info, const CGPathElement *element )
{
    NSBezierPath *bezierPath = (__bridge NSBezierPath *)info;
    CGPoint *points = element->points;
    switch(element->type) {
        case kCGPathElementMoveToPoint: [bezierPath moveToPoint:points[0]];
            break;
        case kCGPathElementAddLineToPoint: [bezierPath lineToPoint:points[0]];
            break;
        case kCGPathElementAddQuadCurveToPoint: {
            NSPoint qp0 = bezierPath.currentPoint, qp1 = points[0], qp2 = points[1], cp1, cp2;
            CGFloat m = (2.0 / 3.0);
            cp1.x = (qp0.x + ((qp1.x - qp0.x) * m));
            cp1.y = (qp0.y + ((qp1.y - qp0.y) * m));
            cp2.x = (qp2.x + ((qp1.x - qp2.x) * m));
            cp2.y = (qp2.y + ((qp1.y - qp2.y) * m));
            [bezierPath curveToPoint:qp2 controlPoint1:cp1 controlPoint2:cp2];
            break;
        }
        case kCGPathElementAddCurveToPoint: [bezierPath curveToPoint:points[2] controlPoint1:points[0] controlPoint2:points[1]];
            break;
        case kCGPathElementCloseSubpath: [bezierPath closePath];
            break;
        default:
            break;
    }
}

NSBezierPath *CUI_BezierPathWithCGPath( CGPathRef cgPath )
{
    NSBezierPath *bezierPath = [NSBezierPath bezierPath];
    CGPathApply( cgPath, (__bridge void *)bezierPath, CUI_BezierPathWithCGPathApplierFunction );
    return bezierPath;
}

NSString *CUI_PathForResource( NSString *name )
{ return [[NSBundle mainBundle] pathForResource:name ofType:nil]; }

NSImage *CUI_ImageResource( NSString *path )
{
    NSImage *image = [NSImage imageNamed:path];
    if ( !image ) {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
        if ( fullPath ) {
#if __has_feature(objc_arc)
            image = [[NSImage alloc] initWithContentsOfFile:fullPath];
#else
            image = [[[NSImage alloc] initWithContentsOfFile:fullPath] autorelease];
#endif
        }
    }
    return image;
}

NSImage *CUI_FixImageValue( CFTypeRef inImage )
{
    if ( inImage ) {
        if ( CFGetTypeID( inImage ) == CFStringGetTypeID() ) {
            
            NSImage *image = CUI_ImageResource( (__bridge NSString *)inImage );
            if ( image ) return image;

            // maybe it's a symbol?
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 110000
            if (@available(macOS 11.0, *)) {
                return [NSImage imageWithSystemSymbolName:(__bridge NSString *)inImage accessibilityDescription:@""];
            }
#endif
        } else if ( [(__bridge id)inImage isKindOfClass:[NSImage class]] ) {
            return (__bridge NSImage *)inImage;
        }
    }
    return nil;
}

NSSound *CUI_SoundResource( NSString *path )// 20240725
{
    NSSound *sound = [NSSound soundNamed:path];
    if ( !sound ) {
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
        if ( fullPath ) {
#if __has_feature(objc_arc)
            sound = [[NSSound alloc] initWithContentsOfFile:fullPath byReference:YES];
#else
            sound = [[[NSSound alloc] initWithContentsOfFile:fullPath byReference:YES] autorelease];
#endif
            if ( sound ) {
                NSString *name = [sound name];
                if ( !name ) {
                    name = [[path lastPathComponent] stringByDeletingPathExtension];
                    [sound setName:name];
                }
            }
        }
    }
    return sound;
}

NSFont *CUI_FixFont( const void *inFont )
{ return (__bridge NSFont *)inFont; }

/*
 NSRangeToCFRange
 NSRangeFromCFRange
 */
CFRange NSRangeToCFRange( NSRange range )
{ return CFRangeMake((CFIndex)range.location,(CFIndex)range.length); }

NSRange NSRangeFromCFRange( CFRange range )
{ return NSMakeRange((NSUInteger)range.location,(NSUInteger)range.length); }

