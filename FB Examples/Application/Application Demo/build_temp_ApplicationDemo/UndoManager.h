/*
 UndoManager.h

 Bernie Wylde
 */

#import "CocoaUI.h"

typedef void (*CUI_UndoManagerTargetCallbackType)(CFTypeRef);

@interface CUI_UndoManagerTarget : NSObject
- (id)initWithCallback:(CUI_UndoManagerTargetCallbackType)cb;
@property (nonatomic,assign) CUI_UndoManagerTargetCallbackType callback;
@end

// private
NSMutableArray *CUI_UndoManagerTargetsArray( void );
void CUI_UndoManagerAddTarget( CUI_UndoManagerTarget *target );

// Class
Class UndoManagerClass( void );

// Registering
void UndoManagerRegisterUndo( NSUndoManager *ref, CUI_UndoManagerTargetCallbackType fnAddress, CFTypeRef object );
void UndoManagerPrepareWithInvocation( NSUndoManager *ref, CUI_UndoManagerTargetCallbackType fnAddress, CFTypeRef object );

// Ability
BOOL UndoManagerCanUndo( NSUndoManager *ref );
BOOL UndoManagerCanRedo( NSUndoManager *ref );

// Perform
void UndoManagerUndo( NSUndoManager *ref );
void UndoManagerUndoNestedGroup( NSUndoManager *ref );
void UndoManagerRedo( NSUndoManager *ref );

// Limiting
NSUInteger UndoManagerLevelsOfUndo( NSUndoManager *ref );
void UndoManagerSetLevelsOfUndo( NSUndoManager *ref, NSUInteger levels );

// Groups
void UndoManagerBeginUndoGrouping( NSUndoManager *ref );
void UndoManagerEndUndoGrouping( NSUndoManager *ref );
BOOL UndoManagerGroupsByEvent( NSUndoManager *ref );
void UndoManagerSetGroupsByEvent( NSUndoManager *ref, BOOL flag );
NSInteger UndoManagerGroupingLevel( NSUndoManager *ref );

// Enable
void UndoManagerDisableUndoRegistration( NSUndoManager *ref );
void UndoManagerEnableUndoRegistration( NSUndoManager *ref );
BOOL UndoManagerIsUndoRegistrationEnabled( NSUndoManager *ref );

// Performed
BOOL UndoManagerIsUndoing( NSUndoManager *ref );
BOOL UndoManagerIsRedoing( NSUndoManager *ref );

// Clearing
void UndoManagerRemoveAllActions( NSUndoManager *ref );

// Action name
CFStringRef UndoManagerUndoActionName( NSUndoManager *ref );
CFStringRef UndoManagerRedoActionName( NSUndoManager *ref );
void UndoManagerSetActionName( NSUndoManager *ref, CFStringRef name );

// Menu item title
CFStringRef UndoManagerUndoMenuItemTitle( NSUndoManager *ref );
CFStringRef UndoManagerRedoMenuItemTitle( NSUndoManager *ref );
CFStringRef UndoManagerUndoMenuTitleForUndoActionName( NSUndoManager *ref, CFStringRef name );
CFStringRef UndoManagerRedoMenuTitleForUndoActionName( NSUndoManager *ref, CFStringRef name );

// Loops
CFArrayRef UndoManagerRunLoopModes( NSUndoManager *ref );

// Discardable
void UndoManagerSetActionIsDiscardable( NSUndoManager *ref, BOOL flag );
BOOL UndoManagerUndoActionIsDiscardable( NSUndoManager *ref );
BOOL UndoManagerRedoActionIsDiscardable( NSUndoManager *ref );

// Instance properties
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 140400
API_AVAILABLE(macos(14.4))
NSUInteger UndoManagerRedoCount( NSUndoManager *ref );
API_AVAILABLE(macos(14.4))
NSUInteger UndoManagerUndoCount( NSUndoManager *ref );
#endif // 140400

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 150000
API_AVAILABLE(macos(15.0))
CFTypeRef UndoManagerRedoActionUserInfoValueForKey( NSUndoManager *ref, CFStringRef key );
API_AVAILABLE(macos(15.0))
void UndoManagerSetActionUserInfoValueForKey( NSUndoManager *ref, CFTypeRef info, CFStringRef key );
API_AVAILABLE(macos(15.0))
CFTypeRef UndoManagerUndoActionUserInfoValueForKey( NSUndoManager *ref, CFStringRef key );
#endif // 150000

