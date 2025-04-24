/*
 CATransaction.m

 Bernie Wylde
 */

#import "CATransaction.h"

// Create and commit
void CATransactionBegin( void )
{ [CATransaction begin]; }

void CATransactionCommit( void )
{ [CATransaction commit]; }

void CATransactionFlush( void )
{ [CATransaction flush]; }

// Override duration and timing
CFTimeInterval CATransactionAnimationDuration( void )
{ return [CATransaction animationDuration]; }

void CATransactionSetAnimationDuration( CFTimeInterval ti )
{ [CATransaction setAnimationDuration:ti]; }

CAMediaTimingFunction *CATransactionAnimationTimingFunction( void )
{ return [CATransaction animationTimingFunction]; }

void CATransactionSetAnimationTimingFunction( CAMediaTimingFunction *function )
{ [CATransaction setAnimationTimingFunction:function]; }

// Temporarily disable property animations
BOOL CATransactionDisableActions( void )
{ return [CATransaction disableActions]; }

void CATransactionSetDisableActions( BOOL flag )
{ [CATransaction setDisableActions:flag]; }

// Concurrency
void CATransactionLock( void )
{ [CATransaction lock]; }

void CATransactionUnlock( void )
{ [CATransaction unlock]; }

// Properties
void CATransactionSetValueForKey( id value, CFStringRef key )
{ [CATransaction setValue:value forKey:(__bridge NSString *)key]; }

id CATransactionValueForKey( CFStringRef key )
{ return [CATransaction valueForKey:(__bridge NSString *)key]; }

