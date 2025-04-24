/*
 HelpManager.m

 Bernie Wylde
 */

#import "HelpManager.h"

// Class
Class HelpManagerClass( void )
{ return [NSHelpManager class]; }

// - get -
NSHelpManager *HelpManagerShared( void )
{ return [NSHelpManager sharedHelpManager]; }

// - display -
void HelpManagerFindString( CFStringRef string, CFStringRef book )
{ [[NSHelpManager sharedHelpManager] findString:(__bridge NSString *)string inBook:(__bridge NSString *)book]; }

void HelpManagerOpenHelpAnchor( CFStringRef anchor, CFStringRef book )
{ [[NSHelpManager sharedHelpManager] openHelpAnchor:(__bridge NSString *)anchor inBook:(__bridge NSString *)book]; }

// - add help books -
BOOL HelpManagerRegisterBooksInBundle( NSBundle *bundle )
{ return [[NSHelpManager sharedHelpManager] registerBooksInBundle:bundle]; }

// - configure -
void HelpManagerSetContextHelp( CFAttributedStringRef attrString, NSObject *object )
{ [[NSHelpManager sharedHelpManager] setContextHelp:(__bridge NSAttributedString *)attrString forObject:(id)object]; }

void HelpManagerRemoveContextHelp( NSObject *object )
{ [[NSHelpManager sharedHelpManager] removeContextHelpForObject:(id)object]; }

// - display -
CFAttributedStringRef HelpManagerContextHelp( NSObject *object )
{ return (__bridge CFAttributedStringRef)[[NSHelpManager sharedHelpManager] contextHelpForObject:(id)object]; }

BOOL HelpManagerShowContextHelp( NSObject *object, CGPoint locationHint )
{ return [[NSHelpManager sharedHelpManager] showContextHelpForObject:(id)object locationHint:NSPointFromCGPoint(locationHint)]; }

// - properties -
BOOL HelpManagerIsContextHelpModeActive( void )
{ return [NSHelpManager isContextHelpModeActive]; }


#pragma mark - custom
BOOL HelpManagerIndexBookInBundle( NSBundle *bundle )
{
    NSDictionary *dict = [bundle infoDictionary];
    NSString *hbDirName = [dict objectForKey:@"CFBundleHelpBookFolder"];
    if ( hbDirName ) {
        NSURL *url = [[[bundle bundleURL] URLByDeletingLastPathComponent] URLByAppendingPathComponent:hbDirName];
        if ( url ) {
            NSTask *task = [[NSTask alloc] init];
            [task setLaunchPath:@"/usr/bin/hiutil"];
            url = [url URLByAppendingPathComponent:@"helpindex.help"];
            NSArray *args = @[@"-Caf",[url path],@"."];
            [task setArguments:args];
            [task launch];
            return YES;
        }
    }
    return NO;
}
