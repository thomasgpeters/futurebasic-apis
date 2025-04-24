
/*
 Input.h
 
 Bernie Wylde 20230421
*/

@interface FBInputFormat : NSObject
@property (nonatomic,retain) NSString *characters;
@property (nonatomic,assign) BOOL pass;
@property (nonatomic,assign) NSInteger maxLength;
@property (nonatomic,assign) NSInteger option;
@property (nonatomic,assign) BOOL password;
@end

@interface FBInputWindow : NSWindow <NSWindowDelegate,NSTextFieldDelegate,NSControlTextEditingDelegate>
@property (nonatomic,retain) IBOutlet NSTextField *label;
@property (nonatomic,retain) IBOutlet NSTextField *field;
@property (nonatomic,assign) NSInteger xPos;
@property (nonatomic,assign) NSInteger yPos;

- (id)initWithPrompt:(NSString *)prompt x:(NSInteger)x y:(NSInteger)y password:(BOOL)password;
- (void)resize;
@end

CFStringRef FBInput( NSInteger x, NSInteger y, CFStringRef prompt, CFStringRef characters, long passFlag, long maxLength, long option );

// ancillary functions
void InputSetFormat( CFStringRef characters, long pass, long maxLength, long option );
void InputRemoveFormat( void );

//void InputSetToolTip( CFStringRef string );

NSWindow *InputWindow( void );


