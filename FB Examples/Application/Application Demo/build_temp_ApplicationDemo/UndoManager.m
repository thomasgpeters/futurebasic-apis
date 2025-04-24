/*
 UndoManager.m

 Bernie Wylde
 */

#import "UndoManager.h"

@implementation CUI_UndoManagerTarget

//static CUI_UndoManagerTarget *sCUI_UndoManagerTarget;
static NSMutableArray *sCUI_UndoManagerTargets;

- (id)initWithCallback:(CUI_UndoManagerTargetCallbackType)cb {
    if ( (self = [super init]) ) {
        self.callback = cb;
    }
    return self;
}

- (void)undoAction:(id)obj {
    if ( self.callback ) (*self.callback)( (__bridge CFTypeRef)obj );
}
@end

NSMutableArray *CUI_UndoManagerTargetsArray( void )
{
    if ( !sCUI_UndoManagerTargets ) sCUI_UndoManagerTargets = [[NSMutableArray alloc] initWithCapacity:0];
    return sCUI_UndoManagerTargets;
}

void CUI_UndoManagerAddTarget( CUI_UndoManagerTarget *target )
{
    BOOL flag = NO;
    NSMutableArray *targets = CUI_UndoManagerTargetsArray();
    for ( CUI_UndoManagerTarget *t in targets ) {
        if ( [t callback] == [target callback] ) {
            flag = YES;
            break;
        }
    }
    if ( !flag ) [targets addObject:target];
}


// Class
Class UndoManagerClass( void )
{ return [NSUndoManager class]; }

// Registering
void UndoManagerRegisterUndo( NSUndoManager *ref, CUI_UndoManagerTargetCallbackType fnAddress, CFTypeRef object )
{
    CUI_UndoManagerTarget *target = [[CUI_UndoManagerTarget alloc] initWithCallback:fnAddress];
    CUI_UndoManagerAddTarget( target );
    [ref registerUndoWithTarget:target selector:@selector(undoAction:) object:(__bridge id)object];
}

void UndoManagerPrepareWithInvocation( NSUndoManager *ref, CUI_UndoManagerTargetCallbackType fnAddress, CFTypeRef object )
{
    CUI_UndoManagerTarget *target = [[CUI_UndoManagerTarget alloc] initWithCallback:fnAddress];
    CUI_UndoManagerAddTarget( target );
    [[ref prepareWithInvocationTarget:target] undoAction:(__bridge id)object];
}

// Ability
BOOL UndoManagerCanUndo( NSUndoManager *ref )
{ return [ref canUndo]; }

BOOL UndoManagerCanRedo( NSUndoManager *ref )
{ return [ref canRedo]; }

// Perform
void UndoManagerUndo( NSUndoManager *ref )
{ [ref undo]; }

void UndoManagerUndoNestedGroup( NSUndoManager *ref )
{ [ref undoNestedGroup]; }

void UndoManagerRedo( NSUndoManager *ref )
{ [ref redo]; }

// Limiting
NSUInteger UndoManagerLevelsOfUndo( NSUndoManager *ref )
{ return [ref levelsOfUndo]; }

void UndoManagerSetLevelsOfUndo( NSUndoManager *ref, NSUInteger levels )
{ [ref setLevelsOfUndo:levels]; }

// Groups
void UndoManagerBeginUndoGrouping( NSUndoManager *ref )
{ [ref beginUndoGrouping]; }

void UndoManagerEndUndoGrouping( NSUndoManager *ref )
{ [ref endUndoGrouping]; }

BOOL UndoManagerGroupsByEvent( NSUndoManager *ref )
{ return [ref groupsByEvent]; }

void UndoManagerSetGroupsByEvent( NSUndoManager *ref, BOOL flag )
{ [ref setGroupsByEvent:flag]; }

NSInteger UndoManagerGroupingLevel( NSUndoManager *ref )
{ return [ref groupingLevel]; }

// Enable
void UndoManagerDisableUndoRegistration( NSUndoManager *ref )
{ [ref disableUndoRegistration]; }

void UndoManagerEnableUndoRegistration( NSUndoManager *ref )
{ [ref enableUndoRegistration]; }

BOOL UndoManagerIsUndoRegistrationEnabled( NSUndoManager *ref )
{ return [ref isUndoRegistrationEnabled]; }


// Performed
BOOL UndoManagerIsUndoing( NSUndoManager *ref )
{ return [ref isUndoing]; }

BOOL UndoManagerIsRedoing( NSUndoManager *ref )
{ return [ref isRedoing]; }

// Clearing
void UndoManagerRemoveAllActions( NSUndoManager *ref )
{ [ref removeAllActions]; }

// Action name
CFStringRef UndoManagerUndoActionName( NSUndoManager *ref )
{ return (__bridge CFStringRef)[ref undoActionName]; }

CFStringRef UndoManagerRedoActionName( NSUndoManager *ref )
{ return (__bridge CFStringRef)[ref redoActionName]; }

void UndoManagerSetActionName( NSUndoManager *ref, CFStringRef name )
{ [ref setActionName:(__bridge NSString *)name]; }

// Menu item title
CFStringRef UndoManagerUndoMenuItemTitle( NSUndoManager *ref )
{ return (__bridge CFStringRef)[ref undoMenuItemTitle]; }

CFStringRef UndoManagerRedoMenuItemTitle( NSUndoManager *ref )
{ return (__bridge CFStringRef)[ref redoMenuItemTitle]; }

CFStringRef UndoManagerUndoMenuTitleForUndoActionName( NSUndoManager *ref, CFStringRef name )
{ return (__bridge CFStringRef)[ref undoMenuTitleForUndoActionName:(__bridge NSString *)name]; }

CFStringRef UndoManagerRedoMenuTitleForUndoActionName( NSUndoManager *ref, CFStringRef name )
{ return (__bridge CFStringRef)[ref redoMenuTitleForUndoActionName:(__bridge NSString *)name]; }

// Loops
CFArrayRef UndoManagerRunLoopModes( NSUndoManager *ref )
{ return (__bridge CFArrayRef)[ref runLoopModes]; }

// Discardable
void UndoManagerSetActionIsDiscardable( NSUndoManager *ref, BOOL flag )
{ [ref setActionIsDiscardable:flag]; }

BOOL UndoManagerUndoActionIsDiscardable( NSUndoManager *ref )
{ return [ref undoActionIsDiscardable]; }

BOOL UndoManagerRedoActionIsDiscardable( NSUndoManager *ref )
{ return [ref redoActionIsDiscardable]; }

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140400
NSUInteger UndoManagerRedoCount( NSUndoManager *ref )
{ return [ref redoCount]; }

NSUInteger UndoManagerUndoCount( NSUndoManager *ref )
{ return [ref undoCount]; }
#endif // 140400

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
CFTypeRef UndoManagerRedoActionUserInfoValueForKey( NSUndoManager *ref, CFStringRef key )
{ return (__bridge CFTypeRef)[ref redoActionUserInfoValueForKey:(__bridge NSString *)key]; }

void UndoManagerSetActionUserInfoValueForKey( NSUndoManager *ref, CFTypeRef info, CFStringRef key )
{ [ref setActionUserInfoValue:(__bridge id)info forKey:(__bridge NSString *)key]; }

CFTypeRef UndoManagerUndoActionUserInfoValueForKey( NSUndoManager *ref, CFStringRef key )
{ return (__bridge CFTypeRef)[ref undoActionUserInfoValueForKey:(__bridge NSString *)key]; }

#endif // 150000
