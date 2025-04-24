/*
 ProgressIndicator.h

 Bernie Wylde
 */

#import "CocoaUI.h"

@interface ProgressIndicatorObject : NSObject
@property (nonatomic,assign) float progressIndicatorValue;
@end

@interface ProgressIndicatorSC : NSProgressIndicator
@end

@interface NSProgressIndicator (Additions)
@property (nonatomic,retain) NSNumber *tagNumber;

- (NSInteger)tag;
- (void)setTag:(NSInteger)tag;
@end

// Class
Class ProgressIndicatorClass( void );

NSProgressIndicator *ProgressIndicatorWithTag( NSInteger tag );
BOOL ProgressIndicatorExists( NSInteger tag );

// - animating -
void ProgressIndicatorStartAnimation( NSInteger tag );
void ProgressIndicatorStopAnimation( NSInteger tag );
BOOL ProgressIndicatorUsesThreadedAnimation( NSInteger tag );
void ProgressIndicatorSetUsesThreadedAnimation( NSInteger tag, BOOL flag );

// - advancing -
void ProgressIndicatorIncrementBy( NSInteger tag, double delta );
double ProgressIndicatorDoubleValue( NSInteger tag );
void ProgressIndicatorSetDoubleValue( NSInteger tag, double value );
double ProgressIndicatorMinValue( NSInteger tag );
void ProgressIndicatorSetMinValue( NSInteger tag, double value );
double ProgressIndicatorMaxValue( NSInteger tag );
void ProgressIndicatorSetMaxValue( NSInteger tag, double value );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
NSProgress *ProgressIndicatorObservedProgress( NSInteger tag );
API_AVAILABLE(macos(14.0))
void ProgressIndicatorSetObservedProgress( NSInteger tag, NSProgress *progress );
#endif// 140000

// - appearance -
NSControlSize ProgressIndicatorControlSize( NSInteger tag );
void ProgressIndicatorSetControlSize( NSInteger tag, NSControlSize size );
NSControlTint ProgressIndicatorControlTint( NSInteger tag );
void ProgressIndicatorSetControlTint( NSInteger tag, NSControlTint tint );
BOOL ProgressIndicatorIsBezeled( NSInteger tag );
void ProgressIndicatorSetBezeled( NSInteger tag, BOOL flag );
BOOL ProgressIndicatorIsIndeterminate( NSInteger tag );
void ProgressIndicatorSetIndeterminate( NSInteger tag, BOOL flag );
NSUInteger ProgressIndicatorStyle( NSInteger tag );
void ProgressIndicatorSetStyle( NSInteger tag, NSUInteger style );
void ProgressIndicatorSizeToFit( NSInteger tag );
BOOL ProgressIndicatorIsDisplayedWhenStopped( NSInteger tag );
void ProgressIndicatorSetDisplayedWhenStopped( NSInteger tag, BOOL flag );


// Init
NSProgressIndicator *ProgressIndicatorInit( NSInteger inTag, CGRect inRect, NSProgressIndicatorStyle inStyle );

// Statement
void CUI_ProgressBar( NSInteger inTag, double inValue, CGRect inRect, double inMinValue, double inMaxValue, NSInteger inWndTag );
void CUI_ProgressIndicator( NSInteger inTag, double inValue, CGRect inRect, double inMinValue, double inMaxValue, NSInteger inWndTag );

#pragma mark - progressbar functions
// Class
Class ProgressBarClass( void );

NSProgressIndicator *ProgressBarWithTag( NSInteger tag );
BOOL ProgressBarExists( NSInteger tag );

// - animating -
void ProgressBarStartAnimation( NSInteger tag );
void ProgressBarStopAnimation( NSInteger tag );
BOOL ProgressBarUsesThreadedAnimation( NSInteger tag );
void ProgressBarSetUsesThreadedAnimation( NSInteger tag, BOOL flag );

// - advancing -
void ProgressBarIncrementBy( NSInteger tag, double delta );
double ProgressBarDoubleValue( NSInteger tag );
void ProgressBarSetDoubleValue( NSInteger tag, double value );
double ProgressBarMinValue( NSInteger tag );
void ProgressBarSetMinValue( NSInteger tag, double value );
double ProgressBarMaxValue( NSInteger tag );
void ProgressBarSetMaxValue( NSInteger tag, double value );
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140000
API_AVAILABLE(macos(14.0))
NSProgress *ProgressBarObservedProgress( NSInteger tag );
API_AVAILABLE(macos(14.0))
void ProgressBarSetObservedProgress( NSInteger tag, NSProgress *progress );
#endif// 140000

// - appearance -
NSControlSize ProgressBarControlSize( NSInteger tag );
void ProgressBarSetControlSize( NSInteger tag, NSControlSize size );
NSControlTint ProgressBarControlTint( NSInteger tag );
void ProgressBarSetControlTint( NSInteger tag, NSControlTint tint );
BOOL ProgressBarIsBezeled( NSInteger tag );
void ProgressBarSetBezeled( NSInteger tag, BOOL flag );
BOOL ProgressBarIsIndeterminate( NSInteger tag );
void ProgressBarSetIndeterminate( NSInteger tag, BOOL flag );
NSUInteger ProgressBarStyle( NSInteger tag );
void ProgressBarSetStyle( NSInteger tag, NSUInteger style );
void ProgressBarSizeToFit( NSInteger tag );
BOOL ProgressBarIsDisplayedWhenStopped( NSInteger tag );
void ProgressBarSetDisplayedWhenStopped( NSInteger tag, BOOL flag );


// Init
NSProgressIndicator *ProgressBarInit( NSInteger inTag, CGRect inRect, NSProgressIndicatorStyle inStyle );

