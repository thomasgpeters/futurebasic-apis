
/*
 Inkey.h
 
 Bernie Wylde 20230424
*/

@interface FBInkeyFormat : NSObject
@property (nonatomic,retain) NSCharacterSet *characterSet;
@property (nonatomic,retain) NSString *characters;
@property (nonatomic,assign) BOOL pass;
@property (nonatomic,assign) NSInteger option;
@end

@interface FBInkeyWindow : NSWindow <NSWindowDelegate>
@property (nonatomic,retain) NSTimer *cursorTimer;
@property (nonatomic,retain) IBOutlet NSTextField *promptLabel;
@property (nonatomic,retain) IBOutlet NSTextField *cursorLabel;
@property (nonatomic,assign) NSInteger xPos;
@property (nonatomic,assign) NSInteger yPos;

- (id)initWithPrompt:(NSString *)prompt x:(NSInteger)x y:(NSInteger)y;
- (void)resize;
@end

CFStringRef FBInkey( NSInteger x, NSInteger y, CFStringRef prompt, CFStringRef characters, long passFlag, long option );

// ancillary functions
void InkeySetFormat( CFStringRef characters, long pass, long option );
void InkeyRemoveFormat( void );

