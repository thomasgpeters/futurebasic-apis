//
//  BreakpointWindowController.h
//
//  Created by Bernie Wylde on 08/09/2024.
//

#import <Cocoa/Cocoa.h>
#import "CUI_AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeactivateButton : NSButton
@end

@interface ContinueButton : NSButton
@end

@interface StepOverButton : NSButton
@end

@interface BreakpointWindow : NSPanel
@end

@interface BreakpointWindowController : NSWindowController <NSWindowDelegate>
@property (nonatomic,assign) BOOL deactivate;

- (void)buildWindow;
- (void)breakpointWithFile:(NSString *)filename function:(NSString *)function line:(NSInteger)lineNum string:(NSString *)string;

- (IBAction)stopAction:(id)sender;
- (IBAction)deactivateAction:(id)sender;
- (IBAction)continueAction:(id)sender;
- (IBAction)skipAction:(id)sender;

@end

void FBBreakpoint( NSString *filename, NSString *functionname, NSInteger lineNum, ... );
void FBBreakpointStop( void );

NS_ASSUME_NONNULL_END
