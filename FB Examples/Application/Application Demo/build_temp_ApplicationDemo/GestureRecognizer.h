/*
 GestureRecognizer.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// dialog events
enum {
    gestureRecognizerClick = 2700,
    gestureRecognizerMagnification,
    gestureRecognizerPan,
    gestureRecognizerPress,
    gestureRecognizerRotation
};

/*
 Target
 */
typedef void (*CUI_GestureRecognizerCallbackType)(id,NSInteger,void *);

@interface CUI_GestureRecognizerTarget : NSObject

@property (nonatomic,assign) CUI_GestureRecognizerCallbackType callback;
@property (nonatomic,assign) void *userData;

- (id)initWithCallback:(CUI_GestureRecognizerCallbackType)cb userData:(void *)ud;

- (void)action:(id)object;
- (void)clickAction:(id)object;
- (void)magnificationAction:(id)object;
- (void)panAction:(id)object;
- (void)pressAction:(id)object;
- (void)rotationAction:(id)object;
@end


/*
 Subclass
 */
@interface CUI_GestureRecognizer : NSGestureRecognizer
@end

// Class
Class GestureRecognizerClass( void );

// Init
//NSGestureRecognizer *GestureRecognizerWithCallback( CUI_GestureRecognizerCallbackType callback, void *userData );

// - location of events -
CGPoint GestureRecognizerLocationInView( NSGestureRecognizer *ref, NSInteger tag );

// - state -
NSGestureRecognizerState GestureRecognizerState( NSGestureRecognizer *ref );
NSInteger GestureRecognizerView( NSGestureRecognizer *ref );
BOOL GestureRecognizerIsEnabled( NSGestureRecognizer *ref );
void GestureRecognizerSetEnabled( NSGestureRecognizer *ref, BOOL flag );

// - delaying -
BOOL GestureRecognizerDelaysPrimaryMouseButtonEvents( NSGestureRecognizer *ref );
void GestureRecognizerSetDelaysPrimaryMouseButtonEvents( NSGestureRecognizer *ref, BOOL flag );
BOOL GestureRecognizerDelaysSecondaryMouseButtonEvents( NSGestureRecognizer *ref );
void GestureRecognizerSetDelaysSecondaryMouseButtonEvents( NSGestureRecognizer *ref, BOOL flag );
BOOL GestureRecognizerDelaysOtherMouseButtonEvents( NSGestureRecognizer *ref );
void GestureRecognizerSetDelaysOtherMouseButtonEvents( NSGestureRecognizer *ref, BOOL flag );
BOOL GestureRecognizerDelaysKeyEvents( NSGestureRecognizer *ref );
void GestureRecognizerSetDelaysKeyEvents( NSGestureRecognizer *ref, BOOL flag );
BOOL GestureRecognizerDelaysMagnificationEvents( NSGestureRecognizer *ref );
void GestureRecognizerSetDelaysMagnificationEvents( NSGestureRecognizer *ref, BOOL flag );
BOOL GestureRecognizerDelaysRotationEvents( NSGestureRecognizer *ref );
void GestureRecognizerSetDelaysRotationEvents( NSGestureRecognizer *ref, BOOL flag );

// - methods for subclasses -

// Pressure
NSPressureConfiguration *GestureRecognizerPressureConfiguration( NSGestureRecognizer *ref );
void GestureRecognizerSetPressureConfiguration( NSGestureRecognizer *ref, NSPressureConfiguration *config );

// Instance properties
NSTouchTypeMask GestureRecognizerAllowedTouchTypes( NSGestureRecognizer *ref );
void GestureRecognizerSetAllowedTouchTypes( NSGestureRecognizer *ref, NSTouchTypeMask touchTypes );

// instance methods


