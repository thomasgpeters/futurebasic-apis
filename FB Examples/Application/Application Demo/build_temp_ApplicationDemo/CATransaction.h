/*
 CATransaction.h

 Bernie Wylde
 */

#import "CocoaUI.h"

// Create and commit
void CATransactionBegin( void );
void CATransactionCommit( void );
void CATransactionFlush( void );

// Override duration and timing
CFTimeInterval CATransactionAnimationDuration( void );
void CATransactionSetAnimationDuration( CFTimeInterval ti );
CAMediaTimingFunction *CATransactionAnimationTimingFunction( void );
void CATransactionSetAnimationTimingFunction( CAMediaTimingFunction *function );

// Temporarily disable property animations
BOOL CATransactionDisableActions( void );
void CATransactionSetDisableActions( BOOL flag );

// Concurrency
void CATransactionLock( void );
void CATransactionUnlock( void );

// Properties
void CATransactionSetValueForKey( id value, CFStringRef key );
id CATransactionValueForKey( CFStringRef key );
