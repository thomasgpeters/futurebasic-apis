/*
 FileWrapper.h

 Bernie Wylde
 */


#import "CocoaUI.h"

// Class
Class FileWrapperClass( void );

// Create
NSFileWrapper *FileWrapperWithURL( CFURLRef url, NSFileWrapperReadingOptions options, NSError **err );
NSFileWrapper *FileWrapperDirectoryWithFileWrappers( CFDictionaryRef childrenByPreferredName );
NSFileWrapper *FileWrapperRegularFileWithContents( CFDataRef contents );
NSFileWrapper *FileWrapperSymbolicLinkWithDestinationURL( CFURLRef url );
NSFileWrapper *FileWrapperWithSerializedRepresentation( CFDataRef serializedRepresentation );

// Query
BOOL FileWrapperIsRegularFile( NSFileWrapper *ref );
BOOL FileWrapperIsDirectory( NSFileWrapper *ref );
BOOL FileWrapperIsSymbolicLink( NSFileWrapper *ref );

// Info
CFDictionaryRef FileWrapperFileWrappers( NSFileWrapper *ref );
CFStringRef FileWrapperAddFileWrapper( NSFileWrapper *ref, NSFileWrapper *child );
void FileWrapperRemoveFileWrapper( NSFileWrapper *ref, NSFileWrapper *child );
CFStringRef FileWrapperAddRegularFileWithContents( NSFileWrapper *ref, CFDataRef dta, CFStringRef preferredFilename );
CFStringRef FileWrapperKeyForFileWrapper( NSFileWrapper *ref, NSFileWrapper *child );
CFURLRef FileWrapperSymbolicLinkDestinationURL( NSFileWrapper *ref );

// Update
BOOL FileWrapperMatchesContentsOfURL( NSFileWrapper *ref, CFURLRef url );
BOOL FileWrapperReadFromURL( NSFileWrapper *ref, CFURLRef url, NSFileWrapperReadingOptions options, NSError **err );

// Serialize
CFDataRef FileWrapperSerializedRepresentation( NSFileWrapper *ref );

// Files
CFStringRef FileWrapperFilename( NSFileWrapper *ref );
CFStringRef FileWrapperPreferredFilename( NSFileWrapper *ref );
CFDictionaryRef FileWrapperFileAttributes( NSFileWrapper *ref );
CFDataRef FileWrapperRegularFileContents( NSFileWrapper *ref );

// Write files
BOOL FileWrapperWriteToURL( NSFileWrapper *ref, CFURLRef url, NSFileWrapperWritingOptions options, CFURLRef origContentsURL, NSError **err );

// Icons
NSImage *FileWrapperIcon( NSFileWrapper *ref );


