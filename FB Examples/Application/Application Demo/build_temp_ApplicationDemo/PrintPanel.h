/*
 PrintPanel.h

 Bernie Wylde
 */

#import "Window.h"

typedef void (*CUI_PrintPanelDelegateCallbackType)(NSPrintPanel *,NSInteger,void*);// printPanel,returnCode,userData

@interface CUI_PrintPanelDelegate : NSObject
@property (nonatomic,assign) CUI_PrintPanelDelegateCallbackType callback;
@end

// Class
Class PrintPanelClass( void );

NSPrintPanel *PrintPanelInit( void );

CFStringRef PrintPanelJobStyleHint( NSPrintPanel *ref );
void PrintPanelSetJobStyleHint( NSPrintPanel *ref, CFStringRef hint );

NSPrintPanelOptions PrintPanelOptions( NSPrintPanel *ref );
void PrintPanelSetOptions( NSPrintPanel *ref, NSPrintPanelOptions options );
CFStringRef PrintPanelDefaultButtonTitle( NSPrintPanel *ref );
void PrintPanelSetDefaultButtonTitle( NSPrintPanel *ref, CFStringRef string );
CFStringRef PrintPanelHelpAnchor( NSPrintPanel *ref );
void PrintPanelSetHelpAnchor( NSPrintPanel *ref, CFStringRef string );

void PrintPanelBeginSheet( NSPrintPanel *ref, NSPrintInfo *printInfo, NSInteger wndTag, CUI_PrintPanelDelegateCallbackType callback, void *userData );
NSInteger PrintPanelRunModal( NSPrintPanel *ref );
NSInteger PrintPanelRunModalWithPrintInfo( NSPrintPanel *ref, NSPrintInfo *printInfo );

NSPrintInfo *PrintPanelPrintInfo( NSPrintPanel *ref );

