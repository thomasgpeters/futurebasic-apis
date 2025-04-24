/*
 ColorList.m

 Bernie Wylde
 */

#import "ColorList.h"

// Class
Class ColorListClass( void )
{ return [NSColorList class]; }

// Init
NSColorList *ColorListWithName( CFStringRef name )
{
#if __has_feature(objc_arc)
    return [[NSColorList alloc] initWithName:(__bridge NSString *)name];
#else
    return [[[NSColorList alloc] initWithName:(__bridge NSString *)name] autorelease];
#endif
}

NSColorList *ColorListFromFileAtURL( CFStringRef name, CFURLRef url )
{
#if __has_feature(objc_arc)
    return [[NSColorList alloc] initWithName:(__bridge NSString *)name fromFile:[(__bridge NSURL *)url path]];
#else
    return [[[NSColorList alloc] initWithName:(__bridge NSString *)name fromFile:[(__bridge NSURL *)url path]] autorelease];
#endif
}

// Lists
CFArrayRef ColorListAvailableColorLists( void )
{ return (__bridge CFArrayRef)[NSColorList availableColorLists]; }

NSColorList *ColorListNamed( CFStringRef name )
{ return [NSColorList colorListNamed:(__bridge NSString *)name]; }

// Properties
CFStringRef ColorListName( NSColorList *ref )
{ return (__bridge CFStringRef)[ref name]; }

BOOL ColorListIsEditable( NSColorList *ref )
{ return [ref isEditable]; }

// Managing colors
CFArrayRef ColorListAllKeys( NSColorList *ref )
{ return (__bridge CFArrayRef)[ref allKeys]; }

NSColor *ColorListColorWithKey( NSColorList *ref, CFStringRef key )
{ return [ref colorWithKey:(__bridge NSString *)key]; }

void ColorListInsertColor( NSColorList *ref, NSColor *col, CFStringRef key, NSUInteger index )
{ [ref insertColor:col key:(__bridge NSString *)key atIndex:index]; }

void ColorListRemoveColorWithKey( NSColorList *ref, CFStringRef key )
{ [ref removeColorWithKey:(__bridge NSString *)key]; }

void ColorListSetColor( NSColorList *ref, NSColor *col, CFStringRef key )
{ [ref setColor:col forKey:(__bridge NSString *)key]; }

// Write and remove ColorList files
void ColorListRemoveFile( NSColorList *ref )
{ [ref removeFile]; }

BOOL ColorListWriteToURL( NSColorList *ref, CFURLRef url, NSError **err )
{ return [ref writeToURL:(__bridge NSURL *)url error:err]; }


// Custom
NSColorList *ColorListByAddingColor( NSColorList *ref, NSColor *col, CFStringRef key )
{
    if ( [ref isEditable] ) {
        [ref setColor:col forKey:(__bridge NSString *)key];
        return ref;
    } else {
#if __has_feature(objc_arc)
        NSColorList *cl2 = [[NSColorList alloc] initWithName:[ref name]];
#else
        NSColorList *cl2 = [[[NSColorList alloc] initWithName:[ref name]] autorelease];
#endif
        NSArray *keys = [ref allKeys];
        for ( NSString *key1 in keys ) {
            NSColor *col1 = [ref colorWithKey:key1];
            [cl2 setColor:col1 forKey:key1];
        }
        [cl2 setColor:col forKey:(__bridge NSString *)key];
        return cl2;
    }
}

NSColorList *ColorListByAddingColorList( NSColorList *cl1, NSColorList *cl2 )
{
    NSArray *keys2 = [cl2 allKeys];
    
    if ( [cl1 isEditable] ) {
        for ( NSString *key2 in keys2 ) {
            NSColor *col2 = [cl2 colorWithKey:key2];
            [cl1 setColor:col2 forKey:key2];
        }
        return cl1;
    } else {
#if __has_feature(objc_arc)
        NSColorList *cl3 = [[NSColorList alloc] initWithName:[cl1 name]];
#else
        NSColorList *cl3 = [[[NSColorList alloc] initWithName:[cl1 name]] autorelease];
#endif
        NSArray *keys1 = [cl1 allKeys];
        for ( NSString *key1 in keys1 ) {
            NSColor *col1 = [cl1 colorWithKey:key1];
            [cl3 setColor:col1 forKey:key1];
        }
        for ( NSString *key2 in keys2 ) {
            NSColor *col2 = [cl2 colorWithKey:key2];
            [cl3 setColor:col2 forKey:key2];
        }
        return cl3;
    }
}

