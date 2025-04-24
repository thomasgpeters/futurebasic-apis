/*
 Popover.h

 Bernie Wylde
 */

@interface PopoverSC : NSPopover
@end

static NSMutableArray *sCUI_Popovers;

// dialog events
enum {
    popoverDetachableWindow = 1300,
    popoverShouldClose,
    popoverWillShow,
    popoverDidShow,
    popoverWillClose,
    popoverDidClose,
    popoverDidDetach,
    popoverShouldDetach
};

@interface CUI_PopoverDelegate : NSObject <NSPopoverDelegate,NSWindowDelegate>
@property (nonatomic,retain) NSWindow *detachableWindow;
@end

@interface NSPopover (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;
- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
@end

void CUI_PopoverAdd( NSPopover *popover, NSInteger tag );

NSPopover *CUI_PopoverForView( id view );
NSPopover *CUI_PopoverWithTag( NSInteger tag );
NSPopover *CUI_PopoverShown( void );// 20220721

// Class
Class PopoverClass( void );

NSPopover *PopoverWithTag( NSInteger tag );
BOOL PopoverExists( NSInteger tag );

// Content view controller
NSViewController *PopoverContentViewController( NSInteger tag );


NSPopoverBehavior PopoverBehavior( NSInteger tag );
void PopoverSetBehavior( NSInteger tag, NSPopoverBehavior behavior );
void PopoverShow( NSInteger tag, CGRect inRect, NSInteger viewTag, CGRectEdge preferredEdge );
CGRect PopoverPositioningRect( NSInteger tag );
void PopoverSetPositioningRect( NSInteger tag, CGRect rect );

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
BOOL PopoverHasFullSizeContent( NSInteger tag );
API_AVAILABLE(macos(14.0))
void PopoverSetHasFullSizeContent( NSInteger tag, BOOL flag );
API_AVAILABLE(macos(14.0))
void PopoverShowRelativeToToolbarItem( NSInteger tag, NSInteger tbTag, NSInteger itemTag );
#endif// 140000

NSAppearance *PopoverAppearance( NSInteger tag );
void PopoverSetAppearance( NSInteger tag, NSAppearance *app );
void PopoverSetAppearanceNamed( NSInteger tag, CFStringRef name );
NSAppearance *PopoverEffectiveAppearance( NSInteger tag );

BOOL PopoverAnimates( NSInteger tag );
void PopoverSetAnimates( NSInteger tag, BOOL flag );
CGSize PopoverContentSize( NSInteger tag );
void PopoverSetContentSize( NSInteger tag, CGSize size );
BOOL PopoverIsShown( NSInteger tag );

BOOL PopoverIsDetached( NSInteger tag );

void PopoverSetDetachableWindow( NSInteger popoverTag, NSInteger wndTag );

void PopoverPerformClose( NSInteger tag );
void PopoverClose( NSInteger tag );

// -- convenience --
void PopoverAddSubview( NSInteger tag, NSInteger subviewTag );


// Init
NSPopover *PopoverInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_Popover( NSInteger inTag, CGRect inRect, NSInteger inBehavior, NSInteger inAnimates );

