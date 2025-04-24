/*
 LevelIndicator.h

 Bernie Wylde
 */


#import "CocoaUI.h"

//#import "DialogEvent.h"
//#import "View.h"
//#import "Window.h"

@interface LevelIndicatorSC : NSLevelIndicator
@end

//@interface CUI_LevelIndicatorTarget : NSObject
//@end
//
//CUI_LevelIndicatorTarget *CUI_LevelIndicatorTargetGet( void );

// Class
Class LevelIndicatorClass( void );

NSLevelIndicator *LevelIndicatorWithTag( NSInteger tag );
BOOL LevelIndicatorExists( NSInteger tag );

// - range -
double LevelIndicatorMinValue( NSInteger tag );
void LevelIndicatorSetMinValue( NSInteger tag, double value );
double LevelIndicatorMaxValue( NSInteger tag );
void LevelIndicatorSetMaxValue( NSInteger tag, double value );
double LevelIndicatorWarningValue( NSInteger tag );
void LevelIndicatorSetWarningValue( NSInteger tag, double value );
double LevelIndicatorCriticalValue( NSInteger tag );
void LevelIndicatorSetCriticalValue( NSInteger tag, double value );

// - tick marks and style -
NSTickMarkPosition LevelIndicatorTickMarkPosition( NSInteger tag );
void LevelIndicatorSetTickMarkPosition( NSInteger tag, NSTickMarkPosition position );
NSInteger LevelIndicatorNumberOfTickMarks( NSInteger tag );
void LevelIndicatorSetNumberOfTickMarks( NSInteger tag, NSInteger tickMarks );
NSInteger LevelIndicatorNumberOfMajorTickMarks( NSInteger tag );
void LevelIndicatorSetNumberOfMajorTickMarks( NSInteger tag, NSInteger tickMarks );
CGRect LevelIndicatorRectOfTickMarkAtIndex( NSInteger tag, NSInteger index );
NSLevelIndicatorStyle LevelIndicatorStyle( NSInteger tag );
void LevelIndicatorSetStyle( NSInteger tag, NSLevelIndicatorStyle style );

// - instance properties -
BOOL LevelIndicatorIsEditable( NSInteger tag );
void LevelIndicatorSetEditable( NSInteger tag, BOOL flag );
NSImage *LevelIndicatorImage( NSInteger tag );
void LevelIndicatorSetImage( NSInteger tag, CFTypeRef inImage );
void LevelIndicatorSetImageNamed( NSInteger tag, CFStringRef imageName );

NSColor *LevelIndicatorCriticalFillColor( NSInteger tag );
void LevelIndicatorSetCriticalFillColor( NSInteger tag, NSColor *col );
BOOL LevelIndicatorDrawsTieredCapacityLevels( NSInteger tag );
void LevelIndicatorSetDrawsTieredCapacityLevels( NSInteger tag, BOOL flag );
NSColor *LevelIndicatorFillColor( NSInteger tag );
void LevelIndicatorSetFillColor( NSInteger tag, NSColor *col );
NSLevelIndicatorPlaceholderVisibility LevelIndicatorPlaceholderVisibility( NSInteger tag );
void LevelIndicatorSetPlaceholderVisibility( NSInteger tag, NSLevelIndicatorPlaceholderVisibility visibility );
NSImage *LevelIndicatorRatingImage( NSInteger tag );
void LevelIndicatorSetRatingImage( NSInteger tag, CFTypeRef inImage );
NSImage *LevelIndicatorRatingPlaceholderImage( NSInteger tag );
void LevelIndicatorSetRatingPlaceholderImage( NSInteger tag, CFTypeRef inImage );
void LevelIndicatorSetRatingPlaceholderImageNamed( NSInteger tag, CFStringRef imageName );
NSColor *LevelIndicatorWarningFillColor( NSInteger tag );
void LevelIndicatorSetWarningFillColor( NSInteger tag, NSColor *col );


// Init
NSLevelIndicator *LevelIndicatorInit( NSInteger inTag, CGRect inRect );

// Statement
void CUI_LevelIndicator( NSInteger inTag, NSInteger inEnabled, double inValue, CGRect inRect, double inMinValue, double inMaxValue, double inWarningValue, double inCriticalValue, NSInteger inTickMarks, NSInteger inMajorTickMarks, NSInteger inWndTag );

