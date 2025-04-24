/*
 FileWrapper.m

 Bernie Wylde
 */

#import "FileWrapper.h"

// Class
Class FileWrapperClass( void )
{ return [NSFileWrapper class]; }

// Create
NSFileWrapper *FileWrapperWithURL( CFURLRef url, NSFileWrapperReadingOptions options, NSError **err )
{
#if __has_feature(objc_arc)
    return [[NSFileWrapper alloc] initWithURL:(__bridge NSURL *)url options:options error:err];
#else
    return [[[NSFileWrapper alloc] initWithURL:(__bridge NSURL *)url options:options error:err] autorelease];
#endif
}

NSFileWrapper *FileWrapperDirectoryWithFileWrappers( CFDictionaryRef childrenByPreferredName )
{
#if __has_feature(objc_arc)
    return [[NSFileWrapper alloc] initDirectoryWithFileWrappers:(__bridge NSDictionary *)childrenByPreferredName];
#else
    return [[[NSFileWrapper alloc] initDirectoryWithFileWrappers:(__bridge NSDictionary *)childrenByPreferredName] autorelease];
#endif
}

NSFileWrapper *FileWrapperRegularFileWithContents( CFDataRef contents )
{
#if __has_feature(objc_arc)
    return [[NSFileWrapper alloc] initRegularFileWithContents:(__bridge NSData *)contents];
#else
    return [[[NSFileWrapper alloc] initRegularFileWithContents:(__bridge NSData *)contents] autorelease];
#endif
}

NSFileWrapper *FileWrapperSymbolicLinkWithDestinationURL( CFURLRef url )
{
#if __has_feature(objc_arc)
    return [[NSFileWrapper alloc] initSymbolicLinkWithDestinationURL:(__bridge NSURL *)url];
#else
    return [[[NSFileWrapper alloc] initSymbolicLinkWithDestinationURL:(__bridge NSURL *)url] autorelease];
#endif
}

NSFileWrapper *FileWrapperWithSerializedRepresentation( CFDataRef serializedRepresentation )
{
#if __has_feature(objc_arc)
    return [[NSFileWrapper alloc] initWithSerializedRepresentation:(__bridge NSData *)serializedRepresentation];
#else
    return [[[NSFileWrapper alloc] initWithSerializedRepresentation:(__bridge NSData *)serializedRepresentation] autorelease];
#endif
}

// Query
BOOL FileWrapperIsRegularFile( NSFileWrapper *ref )
{ return [ref isRegularFile]; }

BOOL FileWrapperIsDirectory( NSFileWrapper *ref )
{ return [ref isDirectory]; }

BOOL FileWrapperIsSymbolicLink( NSFileWrapper *ref )
{ return [ref isSymbolicLink]; }

// Info
CFDictionaryRef FileWrapperFileWrappers( NSFileWrapper *ref )
{ return (__bridge CFDictionaryRef)[ref fileWrappers]; }

CFStringRef FileWrapperAddFileWrapper( NSFileWrapper *ref, NSFileWrapper *child )
{ return (__bridge CFStringRef)[ref addFileWrapper:child]; }

void FileWrapperRemoveFileWrapper( NSFileWrapper *ref, NSFileWrapper *child )
{ [ref removeFileWrapper:child]; }

CFStringRef FileWrapperAddRegularFileWithContents( NSFileWrapper *ref, CFDataRef dta, CFStringRef preferredFilename )
{ return (__bridge CFStringRef)[ref addRegularFileWithContents:(__bridge NSData *)dta preferredFilename:(__bridge NSString *)preferredFilename]; }

CFStringRef FileWrapperKeyForFileWrapper( NSFileWrapper *ref, NSFileWrapper *child )
{ return (__bridge CFStringRef)[ref keyForFileWrapper:child]; }

CFURLRef FileWrapperSymbolicLinkDestinationURL( NSFileWrapper *ref )
{ return (__bridge CFURLRef)[ref symbolicLinkDestinationURL]; }

// Update
BOOL FileWrapperMatchesContentsOfURL( NSFileWrapper *ref, CFURLRef url )
{ return [ref matchesContentsOfURL:(__bridge NSURL *)url]; }

BOOL FileWrapperReadFromURL( NSFileWrapper *ref, CFURLRef url, NSFileWrapperReadingOptions options, NSError **err )
{ return [ref readFromURL:(__bridge NSURL *)url options:options error:err]; }

// Serialize
CFDataRef FileWrapperSerializedRepresentation( NSFileWrapper *ref )
{ return (__bridge CFDataRef)[ref serializedRepresentation]; }

// Files
CFStringRef FileWrapperFilename( NSFileWrapper *ref )
{ return (__bridge CFStringRef)[ref filename]; }

CFStringRef FileWrapperPreferredFilename( NSFileWrapper *ref )
{ return (__bridge CFStringRef)[ref preferredFilename]; }

CFDictionaryRef FileWrapperFileAttributes( NSFileWrapper *ref )
{ return (__bridge CFDictionaryRef)[ref fileAttributes]; }

CFDataRef FileWrapperRegularFileContents( NSFileWrapper *ref )
{ return (__bridge CFDataRef)[ref regularFileContents]; }

// Write files
BOOL FileWrapperWriteToURL( NSFileWrapper *ref, CFURLRef url, NSFileWrapperWritingOptions options, CFURLRef origContentsURL, NSError **err )
{ return [ref writeToURL:(__bridge NSURL *)url options:options originalContentsURL:(__bridge NSURL *)origContentsURL error:err]; }

// Icons
NSImage *FileWrapperIcon( NSFileWrapper *ref )
{ return [ref icon]; }


