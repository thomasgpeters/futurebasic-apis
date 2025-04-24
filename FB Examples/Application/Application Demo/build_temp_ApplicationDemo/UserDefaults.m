/*
 UserDefaults.m

 Bernie Wylde
 */

#import "UserDefaults.h"

#pragma mark - private
//NSDictionary *UserDefaultsProcessDictionary( NSDictionary *inDict )
//{
//    NSMutableDictionary *dict = [inDict mutableCopy];
//    NSArray *keys = [dict allKeys];
//    for ( NSString *key in keys ) {
//        id obj = [dict objectForKey:key];
//        if ( [obj isKindOfClass:[NSColor class]] ) {
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
//            [dict setObject:data forKey:key];
//        } else if ( [obj isKindOfClass:[NSFont class]] ) {
//            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
//            [dict setObject:data forKey:key];
//        } else if ( [obj isKindOfClass:[NSDictionary class]] ) {
//            NSDictionary *newDict = UserDefaultsProcessDictionary( obj );
//            [dict setObject:newDict forKey:key];
//        }
//    }
//    return (NSDictionary *)dict;
//}

void CUI_UserDefaultsAddValueToDictionary( NSView *view, NSMutableDictionary *dict )
{
    NSInteger tag = [view tag];
    
    if ( tag > 0 ) {
        // button
        if ( [(NSObject *)view class] == [NSButton class] ) {
            NSButton *btn = (NSButton *)view;
            NSString *key = [NSString stringWithFormat:@"Button%ldState",(long)[btn tag]];
            [dict setObject:@([btn state]) forKey:key];
            return;
        }
        
        // colorwell
        if ( [(NSObject *)view class] == [NSColorWell class] ) {
            NSColorWell *well = (NSColorWell *)view;
            NSString *key = [NSString stringWithFormat:@"ColorWell%ldColor",(long)[well tag]];
            [dict setObject:[NSArchiver archivedDataWithRootObject:[well color]] forKey:key];
            return;
        }
        
        // combobox
        if ( [(NSObject *)view class] == [NSComboBox class] ) {
            NSComboBox *box = (NSComboBox *)view;
            NSString *key = [NSString stringWithFormat:@"ComboBox%ldStringValue",(long)[box tag]];
            [dict setObject:[box stringValue] forKey:key];
            key = [NSString stringWithFormat:@"ComboBox%ldObjectValues",(long)[box tag]];
            [dict setObject:[box objectValues] forKey:key];
            return;
        }
        
        // datepicker
        if ( [(NSObject *)view class] == [NSDatePicker class] ) {
            NSDatePicker *picker = (NSDatePicker *)view;
            NSString *key = [NSString stringWithFormat:@"DatePicker%ldDateValue",(long)[picker tag]];
            [dict setObject:[picker dateValue] forKey:key];
            return;
        }
        
        // popupbutton
        if ( [view class] == [NSPopUpButton class] ) {
            NSPopUpButton *btn = (NSPopUpButton *)view;
            NSString *key = [NSString stringWithFormat:@"PopUpButton%ldTitleOfSelectedItem",(long)[btn tag]];
            NSString *title = [btn titleOfSelectedItem];
            if ( title ) [dict setObject:title forKey:key];
            return;
        }
        
        // searchfield
        if ( [view class] == [NSSearchField class] ) {
            NSSearchField *fld = (NSSearchField *)view;
            NSString *key = [NSString stringWithFormat:@"SearchField%ldStringValue",(long)[fld tag]];
            [dict setObject:[fld stringValue] forKey:key];
            return;
        }
        
        // segmentedcontrol
        if ( [view class] == [NSSegmentedControl class] ) {
            NSSegmentedControl *c = (NSSegmentedControl *)view;
            NSString *key = [NSString stringWithFormat:@"SegmentedControl%ldSelectedSegment",(long)[c tag]];
            [dict setObject:@([c selectedSegment]) forKey:key];
            return;
        }
        
        // slider
        if ( [view class] == [NSSlider class] ) {
            NSSlider *slider = (NSSlider *)view;
            NSString *key = [NSString stringWithFormat:@"Slider%ldDoubleValue",(long)[slider tag]];
            [dict setObject:@([slider doubleValue]) forKey:key];
            return;
        }
        
        // stepper
        if ( [view class] == [NSStepper class]) {
            NSStepper *stepper = (NSStepper *)view;
            NSString *key = [NSString stringWithFormat:@"Stepper%ldDoubleValue",(long)[stepper tag]];
            [dict setObject:@([stepper doubleValue]) forKey:key];
            return;
        }
        
        // textfield
        if ( [view class] == [NSTextField class] ) {
            NSTextField *fld = (NSTextField *)view;
            NSString *key = [NSString stringWithFormat:@"TextField%ldStringValue",(long)[fld tag]];
            [dict setObject:[fld stringValue] forKey:key];
            return;
        }
        
        // tokenfield
        if ( [view class] == [NSTokenField class] ) {
            NSTokenField *fld = (NSTokenField *)view;
            NSString *key = [NSString stringWithFormat:@"TokenField%ldStringValue",(long)[fld tag]];
            [dict setObject:[fld stringValue] forKey:key];
            return;
        }
        
    } else {
        
        // tabview - store tabview item views
        if ( [view class] == [NSTabView class] ) {
            NSTabView *tab = (NSTabView *)view;
            NSArray *items = [tab tabViewItems];
            for ( NSTabViewItem *item in items ) {
                NSView *itemView = [item view];
                CUI_UserDefaultsAddSubviewValuesToDictionary( itemView, dict );
            }
            return;
        }
        
    }
}

void CUI_UserDefaultsAddSubviewValuesToDictionary( NSView *superview, NSMutableDictionary *dict )
{
    NSArray *subviews = [superview subviews];
    for ( NSView *obj in subviews ) {
        if ( [obj respondsToSelector:@selector(tag)] ) {
            CUI_UserDefaultsAddValueToDictionary( obj, dict );
        }
        CUI_UserDefaultsAddSubviewValuesToDictionary( obj, dict );
    }
}

void CUI_UserDefaultsStoreWindowViewValues( NSWindow *w, NSString *key )
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    CUI_UserDefaultsAddSubviewValuesToDictionary( [w contentView], dict );
    if ( !key ) key = [w title];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:key];
}



void CUI_UserDefaultsRestoreValueFromDictionary( NSView *view, NSDictionary *dict )
{
    NSInteger tag = [view tag];
    if ( tag > 0 ) {
        // button
        if ( [view class] == [NSButton class] ) {
            NSButton *btn = (NSButton *)view;
            NSString *key = [NSString stringWithFormat:@"Button%ldState",(long)[btn tag]];
            NSNumber *number = [dict objectForKey:key];
            if ( number ) [btn setState:[number integerValue]];
            return;
        }
        
        // colorwell
        if ( [view class] == [NSColorWell class] ) {
            NSColorWell *well = (NSColorWell *)view;
            NSString *key = [NSString stringWithFormat:@"ColorWell%ldColor",(long)[well tag]];
            NSData *data = [dict objectForKey:key];
            if ( data ) {
                NSColor *col = [NSUnarchiver unarchiveObjectWithData:data];
                if ( col ) [well setColor:col];
            }
            return;
        }
        
        // combobox
        if ( [view class] == [NSComboBox class] ) {
            NSComboBox *box = (NSComboBox *)view;
            NSString *key = [NSString stringWithFormat:@"ComboBox%ldStringValue",(long)[box tag]];
            NSString *string = [dict objectForKey:key];
            if ( string ) [box setStringValue:string];
            key = [NSString stringWithFormat:@"ComboBox%ldObjectValues",(long)[box tag]];
            NSArray *array = [dict objectForKey:key];
            [box removeAllItems];
            if ( key ) [box addItemsWithObjectValues:array];
            return;
        }
        
        // datepicker
        if ( [view class] == [NSDatePicker class] ) {
            NSDatePicker *picker = (NSDatePicker *)view;
            NSString *key = [NSString stringWithFormat:@"DatePicker%ldDateValue",(long)[picker tag]];
            NSDate *date = [dict objectForKey:key];
            if ( date ) [picker setDateValue:date];
            return;
        }
        
        // popupbutton
        if ( [view class] == [NSPopUpButton class] ) {
            NSPopUpButton *btn = (NSPopUpButton *)view;
            NSString *key = [NSString stringWithFormat:@"PopUpButton%ldTitleOfSelectedItem",(long)[btn tag]];
            NSString *string = [dict objectForKey:key];
            if ( string ) [btn selectItemWithTitle:string];
            return;
        }
        
        // searchfield
        if ( [view class] == [NSSearchField class] ) {
            NSSearchField *fld = (NSSearchField *)view;
            NSString *key = [NSString stringWithFormat:@"SearchField%ldStringValue",(long)[fld tag]];
            NSString *string = [dict objectForKey:key];
            if ( string ) [fld setStringValue:string];
            return;
        }
        
        // segmentedcontrol
        if ( [view class] == [NSSegmentedControl class] ) {
            NSSegmentedControl *c = (NSSegmentedControl *)view;
            NSString *key = [NSString stringWithFormat:@"SegmentedControl%ldSelectedSegment",(long)[c tag]];
            NSNumber *number = [dict objectForKey:key];
            if ( number ) [c setSelectedSegment:[number integerValue]];
            return;
        }
        
        // slider
        if ( [view class] == [NSSlider class] ) {
            NSSlider *slider = (NSSlider *)view;
            NSString *key = [NSString stringWithFormat:@"Slider%ldDoubleValue",(long)[slider tag]];
            NSNumber *number = [dict objectForKey:key];
            if ( number ) [slider setDoubleValue:[number doubleValue]];
            return;
        }
        
        // stepper
        if ( [view class] == [NSStepper class] ) {
            NSStepper *stepper = (NSStepper *)view;
            NSString *key = [NSString stringWithFormat:@"Stepper%ldDoubleValue",(long)[stepper tag]];
            NSNumber *number = [dict objectForKey:key];
            if ( number ) [stepper setDoubleValue:[number doubleValue]];
            return;
        }
        
        // textfield
        if ( [view class] == [NSTextField class] ) {
            NSTextField *fld = (NSTextField *)view;
            NSString *key = [NSString stringWithFormat:@"TextField%ldStringValue",(long)[fld tag]];
            NSString *string = [dict objectForKey:key];
            if ( string ) [fld setStringValue:string];
            return;
        }
        
        // tokenfield
        if ( [view class] == [NSTokenField class] ) {
            NSTokenField *fld = (NSTokenField *)view;
            NSString *key = [NSString stringWithFormat:@"TokenField%ldStringValue",(long)[fld tag]];
            NSString *string = [dict objectForKey:key];
            if ( string ) [fld setStringValue:string];
            return;
        }
        
    } else {
        
        // tabview - restore tabview item views
        if ( [view class] == [NSTabView class] ) {
            NSTabView *tab = (NSTabView *)view;
            NSArray *items = [tab tabViewItems];
            for ( NSTabViewItem *item in items ) {
                NSView *itemView = [item view];
                CUI_UserDefaultsRestoreSubviewValuesFromDictionary( itemView, dict );
            }
            return;
        }
        
    }
}

void CUI_UserDefaultsRestoreSubviewValuesFromDictionary( NSView *superview, NSDictionary *dict )
{
    NSArray *subviews = [superview subviews];
    for ( NSView *obj in subviews ) {
        if ( [obj respondsToSelector:@selector(tag)] ) {
            CUI_UserDefaultsRestoreValueFromDictionary( obj, dict );
        }
        CUI_UserDefaultsRestoreSubviewValuesFromDictionary( obj, dict );
    }
}

void CUI_UserDefaultsRestoreWindowViewValues( NSWindow *w, NSString *key )
{
    if ( !key ) key = [w title];
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if ( dict ) CUI_UserDefaultsRestoreSubviewValuesFromDictionary( [w contentView], dict );
}

void CUI_UserDefaultsRemoveWindowViewValues( NSWindow *w, NSString *key )
{
    if ( !key ) key = [w title];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:key];
}


#pragma mark - public
// Class
Class UserDefaultsClass( void )
{ return [NSUserDefaults class]; }

// Get values
CFTypeRef UserDefaultsObject( CFStringRef key )
{ return (__bridge CFTypeRef)[[NSUserDefaults standardUserDefaults] objectForKey:(__bridge NSString *)key]; }

BOOL UserDefaultsBool( CFStringRef key )
{ return [[NSUserDefaults standardUserDefaults] boolForKey:(__bridge NSString *)key]; }

long UserDefaultsInteger( CFStringRef key )
{ return [[NSUserDefaults standardUserDefaults] integerForKey:(__bridge NSString *)key]; }

double UserDefaultsDouble( CFStringRef key )
{ return [[NSUserDefaults standardUserDefaults] doubleForKey:(__bridge NSString *)key]; }

float UserDefaultsFloat( CFStringRef key )
{ return [[NSUserDefaults standardUserDefaults] floatForKey:(__bridge NSString *)key]; }

CFURLRef UserDefaultsURL( CFStringRef key )
{ return (__bridge CFURLRef)[[NSUserDefaults standardUserDefaults] URLForKey:(__bridge NSString *)key]; }

CFArrayRef UserDefaultsArray( CFStringRef key )
{ return (__bridge CFArrayRef)[[NSUserDefaults standardUserDefaults] arrayForKey:(__bridge NSString *)key]; }

CFDictionaryRef UserDefaultsDictionary( CFStringRef key )
{ return (__bridge CFDictionaryRef)[[NSUserDefaults standardUserDefaults] dictionaryForKey:(__bridge NSString *)key]; }

CFStringRef UserDefaultsString( CFStringRef key )
{ return (__bridge CFStringRef)[[NSUserDefaults standardUserDefaults] stringForKey:(__bridge NSString *)key]; }

CFArrayRef UserDefaultsStringArray( CFStringRef key )
{ return (__bridge CFArrayRef)[[NSUserDefaults standardUserDefaults] stringArrayForKey:(__bridge NSString *)key]; }

CFDataRef UserDefaultsData( CFStringRef key )
{ return (__bridge CFDataRef)[[NSUserDefaults standardUserDefaults] dataForKey:(__bridge NSString *)key]; }

CFDictionaryRef UserDefaultsDictionaryRepresentation( void )
{ return (__bridge CFDictionaryRef)[[NSUserDefaults standardUserDefaults] dictionaryRepresentation]; }

// Set values
void UserDefaultsSetObject( CFStringRef key, CFTypeRef obj )
{ [[NSUserDefaults standardUserDefaults] setObject:(__bridge id)obj forKey:(__bridge NSString *)key]; }

void UserDefaultsSetBool( CFStringRef key, BOOL value )
{ [[NSUserDefaults standardUserDefaults] setBool:value forKey:(__bridge NSString *)key]; }

void UserDefaultsSetInteger( CFStringRef key, long value )
{ [[NSUserDefaults standardUserDefaults] setInteger:value forKey:(__bridge NSString *)key]; }

void UserDefaultsSetDouble( CFStringRef key, double value )
{ [[NSUserDefaults standardUserDefaults] setDouble:value forKey:(__bridge NSString *)key]; }

void UserDefaultsSetFloat( CFStringRef key, float value )
{ [[NSUserDefaults standardUserDefaults] setFloat:value forKey:(__bridge NSString *)key]; }

void UserDefaultsSetURL( CFStringRef key, CFURLRef value )
{ [[NSUserDefaults standardUserDefaults] setURL:(__bridge NSURL *)value forKey:(__bridge NSString *)key]; }

// Remove
void UserDefaultsRemoveObject( CFStringRef key )
{ [[NSUserDefaults standardUserDefaults] removeObjectForKey:(__bridge NSString *)key]; }

void UserDefaultsRemoveAll( void )
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [ud dictionaryRepresentation];
    for (id key in dict) {
        [ud removeObjectForKey:key];
    }
}

// Suites
void UserDefaultsAddSuiteNamed( CFStringRef name )
{ [[NSUserDefaults standardUserDefaults] addSuiteNamed:(__bridge NSString *)name]; }

void UserDefaultsRemoveSuiteNamed( CFStringRef name )
{ [[NSUserDefaults standardUserDefaults] removeSuiteNamed:(__bridge NSString *)name]; }

// Register
void UserDefaultsRegisterDefaults( CFDictionaryRef defaults )
{
    NSMutableDictionary *dict = [(__bridge NSDictionary *)defaults mutableCopy];
    NSArray *keys = [dict allKeys];
    for ( NSString *key in keys ) {
        NSObject *obj = [dict objectForKey:key];
        if ( [obj isKindOfClass:[NSColor class]] ) {
            NSData *data;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400// 20211228
            if (@available(macOS 10.14, *)) {
                data = [NSKeyedArchiver archivedDataWithRootObject:obj requiringSecureCoding:NO error:nil];
            } else {
                data = [NSKeyedArchiver archivedDataWithRootObject:obj];
            }
#else
            data = [NSKeyedArchiver archivedDataWithRootObject:obj];
#endif// 101400
            [dict setObject:data forKey:key];
        } else if ( [obj isKindOfClass:[NSFont class]] ) {// this should be NSFontDescriptor !!!
            NSFont *font = (NSFont *)obj;
            NSData *data;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400// 20211228
            if (@available(macOS 10.14, *)) {// 20211228
                data = [NSKeyedArchiver archivedDataWithRootObject:[font fontDescriptor] requiringSecureCoding:NO error:nil];
            } else {
                data = [NSKeyedArchiver archivedDataWithRootObject:[font fontDescriptor]];
            }
#else
            data = [NSKeyedArchiver archivedDataWithRootObject:[font fontDescriptor]];
#endif// 101400
            [dict setObject:data forKey:key];
        }
        
//        else if ( [obj isKindOfClass:[MDAObj class]] ) {
//            
//            NSData *data;
//#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400
//            if (@available(macOS 10.14, *)) {
//                data = [NSKeyedArchiver archivedDataWithRootObject:obj requiringSecureCoding:NO error:nil];
//            } else {
//                data = [NSKeyedArchiver archivedDataWithRootObject:obj];
//            }
//#else
//            data = [NSKeyedArchiver archivedDataWithRootObject:obj];
//#endif// 101400
//            [dict setObject:data forKey:key];
//
//        }
        
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:dict];
}

// Persistent domains
CFDictionaryRef UserDefaultsPersistentDomainForName( CFStringRef name )
{ return (__bridge CFDictionaryRef)[[NSUserDefaults standardUserDefaults] persistentDomainForName:(__bridge NSString *)name]; }

void UserDefaultsSetPersistentDomainForName( CFDictionaryRef domain, CFStringRef name )
{ [[NSUserDefaults standardUserDefaults] setPersistentDomain:(__bridge NSDictionary *)domain forName:(__bridge NSString *)name]; }

void UserDefaultsRemovePersistentDomainForName( CFStringRef name )
{ [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:(__bridge NSString *)name]; }

// Volatile domains
CFArrayRef UserDefaultsVolatileDomainNames( void )
{ return (__bridge CFArrayRef)[[NSUserDefaults standardUserDefaults] volatileDomainNames]; }

CFDictionaryRef UserDefaultsVolatileDomainForName( CFStringRef name )
{ return (__bridge CFDictionaryRef)[[NSUserDefaults standardUserDefaults] volatileDomainForName:(__bridge NSString *)name]; }

void UserDefaultsSetVolatileDomainForName( CFDictionaryRef domain, CFStringRef name )
{ [[NSUserDefaults standardUserDefaults] setVolatileDomain:(__bridge NSDictionary *)domain forName:(__bridge NSString *)name]; }

void UserDefaultsRemoveVolatileDomainForName( CFStringRef name )
{ [[NSUserDefaults standardUserDefaults] removeVolatileDomainForName:(__bridge NSString *)name]; }

// Managed environment keys
BOOL UserDefaultsObjectIsForcedForKey( CFStringRef key )
{ return [[NSUserDefaults standardUserDefaults] objectIsForcedForKey:(__bridge NSString *)key]; }

BOOL UserDefaultsObjectIsForcedForKeyInDomain( CFStringRef key, CFStringRef domain )
{ return [[NSUserDefaults standardUserDefaults] objectIsForcedForKey:(__bridge NSString *)key inDomain:(__bridge NSString *)domain]; }

// Legacy
BOOL UserDefaultsSynchronize( void )
{ return [[NSUserDefaults standardUserDefaults] synchronize]; }


#pragma mark - Convenience

void UserDefaultsSetValuesInDictionary( CFDictionaryRef inDict )
{
    NSDictionary *dict = (__bridge NSDictionary *)inDict;
    NSArray *keys = [dict allKeys];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    for ( NSString *key in keys ) {
        [ud setObject:dict[key] forKey:key];
    }
}


// Rect
CGRect UserDefaultsRect( CFStringRef key )
{
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:(__bridge NSString *)key];
    if ( string ) return NSRectToCGRect( NSRectFromString(string) );
    return CGRectZero;
}

void UserDefaultsSetRect( CFStringRef key, CGRect r )
{ [[NSUserDefaults standardUserDefaults] setObject:NSStringFromRect(NSRectFromCGRect(r)) forKey:(__bridge NSString *)key]; }

// Color
NSColor *UserDefaultsColor( CFStringRef key )
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:(__bridge NSString *)key];
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400// 20211228
    if (@available(macOS 10.14, *)) {
        if ( data ) return [NSKeyedUnarchiver unarchivedObjectOfClass:[NSColor class] fromData:data error:nil];
    } else {
        if ( data ) return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
#else
    if ( data ) return [NSKeyedUnarchiver unarchiveObjectWithData:data];
#endif// 101400
    return nil;
}

void UserDefaultsSetColor( CFStringRef key, NSColor *col )
{
    if ( col ) {
        NSData *data;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400// 20211228
        if (@available(macOS 10.14, *)) {
            data = [NSKeyedArchiver archivedDataWithRootObject:col requiringSecureCoding:NO error:nil];
        } else {
            data = [NSKeyedArchiver archivedDataWithRootObject:col];
        }
#else
        data = [NSKeyedArchiver archivedDataWithRootObject:col];
#endif// 101400
        if ( data ) [[NSUserDefaults standardUserDefaults] setObject:data forKey:(__bridge NSString *)key];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:col forKey:(__bridge NSString *)key];
    }
}

// Font
CFTypeRef UserDefaultsFont( CFStringRef key )
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:(__bridge NSString *)key];
    if ( data ) {
        NSFontDescriptor *fd;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400// 20211228
        if (@available(macOS 10.14, *)) {
            fd = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSFontDescriptor class] fromData:data error:nil];
        } else {
            fd = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
#else
        fd = [NSKeyedUnarchiver unarchiveObjectWithData:data];
#endif// 101400
        if ( fd ) return (__bridge CFTypeRef)[NSFont fontWithDescriptor:fd size:0];
    }
    return nil;
}

void UserDefaultsSetFont( CFStringRef key, CFTypeRef inFont )
{
    NSFont *font = (__bridge NSFont *)inFont;
    if ( font ) {
        NSData *data;
    #if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101400// 20211228
        if (@available(macOS 10.14, *)) {// 20211228
            data = [NSKeyedArchiver archivedDataWithRootObject:[font fontDescriptor] requiringSecureCoding:NO error:nil];
        } else {
            data = [NSKeyedArchiver archivedDataWithRootObject:[font fontDescriptor]];
        }
    #else
        data = [NSKeyedArchiver archivedDataWithRootObject:[font fontDescriptor]];
    #endif// 101400
        if ( data ) [[NSUserDefaults standardUserDefaults] setObject:data forKey:(__bridge NSString *)key];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:(__bridge id)font forKey:(__bridge NSString *)key];
    }
}

// URL (stored as bookmark data)
CFURLRef UserDefaultsBookmarkURL( CFStringRef key )
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:(__bridge NSString *)key];
    if ( data ) return (__bridge CFURLRef)[NSURL URLByResolvingBookmarkData:data options:0 relativeToURL:nil bookmarkDataIsStale:nil error:nil];
    return nil;
}

void UserDefaultsSetBookmarkURL( CFStringRef key, CFURLRef url )
{
    if ( url ) {
        NSData *data = [(__bridge NSURL *)url bookmarkDataWithOptions:NSURLBookmarkCreationMinimalBookmark includingResourceValuesForKeys:nil relativeToURL:nil error:nil];
        if ( data ) [[NSUserDefaults standardUserDefaults] setObject:data forKey:(__bridge NSString *)key];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:(__bridge id)url forKey:(__bridge NSString *)key];
    }
}


// Window view values
void UserDefaultsStoreWindowViewValues( NSInteger wndTag, CFStringRef key )
{
    NSWindow *w = WindowWithTag( wndTag );
    if ( w ) CUI_UserDefaultsStoreWindowViewValues( w, (__bridge NSString *)key );
}

void UserDefaultsRestoreWindowViewValues( NSInteger wndTag, CFStringRef key )
{
    NSWindow *w = WindowWithTag( wndTag );
    if ( w ) CUI_UserDefaultsRestoreWindowViewValues( w, (__bridge NSString *)key );
}

void UserDefaultsRemoveWindowViewValues( NSInteger wndTag, CFStringRef key )
{
    NSWindow *w = WindowWithTag( wndTag );
    if ( w ) CUI_UserDefaultsRemoveWindowViewValues( w, (__bridge NSString *)key );
}


#pragma mark - Custom
// Dictation edit menu item
void UserDefaultsDictationMenuItemSetDisabled( BOOL flag )
{ [[NSUserDefaults standardUserDefaults] setBool:flag forKey:@"NSDisabledDictationMenuItem"]; }

// Character palette edit menu item
void UserDefaultsCharacterPaletteMenuItemSetDisabled( BOOL flag )
{ [[NSUserDefaults standardUserDefaults] setBool:flag forKey:@"NSDisabledCharacterPaletteMenuItem"]; }


// MDA
void UserDefaultsSetMDA( long tag )
{
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) {
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:mda];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:encodedObject forKey:[NSString stringWithFormat:@"mda-%ld",tag]];
    }
}

void UserDefaultsGetMDA( long tag )
{
    NSString *key = [NSString stringWithFormat:@"mda-%ld",tag];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [ud objectForKey:key];
    if ( encodedObject ) {
        MDAObj *mda = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        NSMutableDictionary *mdaDict = MDADict();
        [mdaDict setValue:mda forKey:[NSString stringWithFormat:@"%ld",tag]];
    }
}

void UserDefaultsRemoveMDA( long tag )
{ [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"mda-%ld",tag]]; }

