/*
 Slider.h

 Bernie Wylde
 */

#import "CocoaUI.h"

@interface SliderObject : NSObject
@property (nonatomic,assign) float sliderValue;
@end

@interface SliderSC : NSSlider
@end

@interface CUI_SliderTarget : NSObject
@end

// Class
Class SliderClass( void );

NSSlider *SliderWithTag( NSInteger tag );
BOOL SliderExists( NSInteger tag );

// - create -

// - appearance -
NSSliderType SliderType( NSInteger tag );
void SliderSetType( NSInteger tag, NSSliderType type );
double SliderAltIncrementValue( NSInteger tag );
void SliderSetAltIncrementValue( NSInteger tag, double value );
CGFloat SliderKnobThickness( NSInteger tag );
BOOL SliderIsVertical( NSInteger tag );

// - limits -
double SliderMaxValue( NSInteger tag );
void SliderSetMaxValue( NSInteger tag, double value );
double SliderMinValue( NSInteger tag );
void SliderSetMinValue( NSInteger tag, double value );

// - mouse events -

// - tick marks -
BOOL SliderAllowsTickMarkValuesOnly( NSInteger tag );
void SliderSetAllowsTickMarkValuesOnly( NSInteger tag, BOOL flag );
double SliderClosestTickMarkValueToValue( NSInteger tag, double value );
NSInteger SliderIndexOfTickMarkAtPoint( NSInteger tag, CGPoint pt );
void SliderSetNumberOfTickMarks( NSInteger tag, NSInteger value );
NSInteger SliderNumberOfTickMarks( NSInteger tag );
CGRect SliderRectOfTickMarkAtIndex( NSInteger tag, NSInteger index );
NSTickMarkPosition SliderTickMarkPosition( NSInteger tag );
void SliderSetTickMarkPosition( NSInteger tag, NSTickMarkPosition position );
double SliderTickMarkValueAtIndex( NSInteger tag, NSInteger index );

// Instance properties
NSColor *SliderTrackFillColor( NSInteger tag );
void SliderSetTrackFillColor( NSInteger tag, NSColor *col );

// Init
NSSlider *SliderInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_Slider( NSInteger inTag, NSInteger inEnabled, double inValue, CGRect inRect, double inMinValue, double inMaxValue, NSInteger inTickMarks, NSInteger inWndTag );
