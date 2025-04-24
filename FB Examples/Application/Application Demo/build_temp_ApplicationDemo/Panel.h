/*
 Panel.h

 Bernie Wylde
 */



#import "Window.h"

@interface PanelSC : NSPanel
@end

@interface NSPanel (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;
- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
@end

// Class
Class PanelClass( void );

NSPanel *PanelWithTag( NSInteger tag );
BOOL PanelExists( NSInteger tag );

void PanelSetFloatingPanel( NSInteger tag, BOOL flag );
void PanelSetBecomesKeyOnlyIfNeeded( NSInteger tag, BOOL flag );
void PanelSetWorksWhenModal( NSInteger tag, BOOL flag );


// Init
NSPanel *PanelInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_Panel( NSInteger inTag, CFStringRef inTitle, CGRect inRect, NSInteger inStyle );

