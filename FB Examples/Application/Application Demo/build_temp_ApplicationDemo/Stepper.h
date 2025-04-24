/*
 Stepper.h

 Bernie Wylde
 */


#import "CocoaUI.h"

@interface StepperObject : NSObject
@property (nonatomic,assign) float stepperValue;
@end

@interface StepperSC : NSStepper
@end

@interface CUI_StepperTarget : NSObject
@end

// Class
Class StepperClass( void );

NSStepper *StepperWithTag( NSInteger tag );
BOOL StepperExists( NSInteger tag );

double StepperMaxValue( NSInteger tag );
void StepperSetMaxValue( NSInteger tag, double value );
double StepperMinValue( NSInteger tag );
void StepperSetMinValue( NSInteger tag, double value );
double StepperIncrement( NSInteger tag );
void StepperSetIncrement( NSInteger tag, double increment );

BOOL StepperAutorepeat( NSInteger tag );
void StepperSetAutorepeat( NSInteger tag, BOOL flag );
BOOL StepperValueWraps( NSInteger tag );
void StepperSetValueWraps( NSInteger tag, BOOL flag );


// Init
NSStepper *StepperInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_Stepper( NSInteger inTag, NSInteger inEnabled, double inValue, CGRect inRect, double inMinValue, double inMaxValue, NSInteger inWndTag );

