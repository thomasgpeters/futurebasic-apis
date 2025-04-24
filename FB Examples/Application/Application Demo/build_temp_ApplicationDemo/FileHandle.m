/*
 FileHandle.m

 Bernie Wylde
 */

#import "FileHandle.h"

// Class
Class FileHandleClass( void )
{ return [NSFileHandle class]; }

// - get -
NSFileHandle *FileHandleForReadingFromURL( CFURLRef url, NSError **err )
{ return [NSFileHandle fileHandleForReadingFromURL:(__bridge NSURL *)url error:err]; }

NSFileHandle *FileHandleForWritingToURL( CFURLRef url, NSError **err )
{ return [NSFileHandle fileHandleForWritingToURL:(__bridge NSURL *)url error:err]; }

NSFileHandle *FileHandleForUpdatingURL( CFURLRef url, NSError **err )
{ return [NSFileHandle fileHandleForUpdatingURL:(__bridge NSURL *)url error:err]; }

NSFileHandle *FileHandleWithStandardError( void )
{ return [NSFileHandle fileHandleWithStandardError]; }

NSFileHandle *FileHandleWithStandardInput( void )
{ return [NSFileHandle fileHandleWithStandardInput]; }

NSFileHandle *FileHandleWithStandardOutput( void )
{ return [NSFileHandle fileHandleWithStandardOutput]; }

NSFileHandle *FileHandleWithNullDevice( void )
{ return [NSFileHandle fileHandleWithNullDevice]; }

// - create -
NSFileHandle *FileHandleWithFileDescriptor( int fd )
{
#if __has_feature(objc_arc)
    return [[NSFileHandle alloc] initWithFileDescriptor:fd];
#else
    return [[[NSFileHandle alloc] initWithFileDescriptor:fd] autorelease];
#endif
}

NSFileHandle *FileHandleWithFileDescriptorCloseOnDealloc( int fd, BOOL flag )
{
#if __has_feature(objc_arc)
    return [[NSFileHandle alloc] initWithFileDescriptor:fd closeOnDealloc:flag];
#else
    return [[[NSFileHandle alloc] initWithFileDescriptor:fd closeOnDealloc:flag] autorelease];
#endif
}

// - file descriptor -
int FileHandleFileDescriptor( NSFileHandle *ref )
{ return [ref fileDescriptor]; }

// - reading -
CFDataRef FileHandleAvailableData( NSFileHandle *ref )
{ return (__bridge CFDataRef)[ref availableData]; }

CFDataRef FileHandleReadDataToEndOfFile( NSFileHandle *ref, NSError **err )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
    if (@available(macOS 10.15, *)) {
        return (__bridge CFDataRef)[ref readDataToEndOfFileAndReturnError:err];
    } else {
        return (__bridge CFDataRef)[ref readDataToEndOfFile];
    }
#else
    return (__bridge CFDataRef)[ref readDataToEndOfFile];
#endif
}

CFDataRef FileHandleReadDataOfLength( NSFileHandle *ref, NSUInteger length )
{ return (__bridge CFDataRef)[ref readDataOfLength:length]; }

// - writing -
BOOL FileHandleWriteData( NSFileHandle *ref, CFDataRef dta, NSError **err )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
    if (@available(macOS 10.15, *)) {
        return [ref writeData:(__bridge NSData *)dta error:err];
    } else {
        [ref writeData:(__bridge NSData *)dta];
    }
#else
    [ref writeData:(__bridge NSData *)dta];
#endif
    return YES;
}

// - reading/writing using blocks
void FileHandleSetReadabilityHandler( NSFileHandle *ref, CUI_FileHandleReadWriteHandlerType handlerFn )
{
    [ref setReadabilityHandler:^(NSFileHandle *fileHandle) {
        if ( handlerFn ) (*handlerFn)(fileHandle);
    }];
}

void FileHandleSetWriteabilityHandler( NSFileHandle *ref, CUI_FileHandleReadWriteHandlerType handlerFn )
{
    [ref setWriteabilityHandler:^(NSFileHandle *fileHandle) {
        if ( handlerFn ) (*handlerFn)(fileHandle);
    }];
}

// - communicating asynchronously -
void FileHandleAcceptConnectionInBackgroundAndNotify( NSFileHandle *ref )
{ [ref acceptConnectionInBackgroundAndNotify]; }

void FileHandleAcceptConnectionInBackgroundAndNotifyForModes( NSFileHandle *ref, CFArrayRef modes )
{ [ref acceptConnectionInBackgroundAndNotifyForModes:(__bridge NSArray *)modes]; }

void FileHandleReadInBackgroundAndNotify( NSFileHandle *ref )
{ [ref readInBackgroundAndNotify]; }

void FileHandleReadInBackgroundAndNotifyForModes( NSFileHandle *ref, CFArrayRef modes )
{ [ref readInBackgroundAndNotifyForModes:(__bridge NSArray *)modes]; }

void FileHandleReadToEndOfFileInBackgroundAndNotify( NSFileHandle *ref )
{ [ref readToEndOfFileInBackgroundAndNotify]; }

void FileHandleReadToEndOfFileInBackgroundAndNotifyForModes( NSFileHandle *ref, CFArrayRef modes )
{ [ref readToEndOfFileInBackgroundAndNotifyForModes:(__bridge NSArray *)modes]; }

void FileHandleWaitForDataInBackgroundAndNotify( NSFileHandle *ref )
{ [ref waitForDataInBackgroundAndNotify]; }

void FileHandleWaitForDataInBackgroundAndNotifyForModes( NSFileHandle *ref, CFArrayRef modes )
{ [ref waitForDataInBackgroundAndNotifyForModes:(__bridge NSArray *)modes]; }

// - seeking within a file -
unsigned long long FileHandleOffsetInFile( NSFileHandle *ref )
{ return [ref offsetInFile]; }

BOOL FileHandleSeekToEnd( NSFileHandle *ref, unsigned long long *offset, NSError **err )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
    if (@available(macOS 10.15, *)) {
        return (BOOL)[ref seekToEndReturningOffset:offset error:err];
    } else {
        unsigned long long off = [ref seekToEndOfFile];
        if ( offset ) *offset = off;
    }
#else
    unsigned long long off = [ref seekToEndOfFile];
    if ( offset ) *offset = off;
#endif

    return YES;
}

BOOL FileHandleSeekToOffset( NSFileHandle *ref, unsigned long long offset, NSError **err )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
    if (@available(macOS 10.15, *)) {
        return [ref seekToOffset:offset error:err];
    } else {
        [ref seekToFileOffset:offset];
    }
#else
    [ref seekToFileOffset:offset];
#endif
    return YES;
}

// - operating on a file -
BOOL FileHandleClose( NSFileHandle *ref, NSError **err )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
    if (@available(macOS 10.15, *)) {
        return [ref closeAndReturnError:err];
    } else {
        [ref closeFile];
    }
#else
    [ref closeFile];
#endif

    return YES;
}

BOOL FileHandleSynchronize( NSFileHandle *ref, NSError **err )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
    if (@available(macOS 10.15, *)) {
        return [ref synchronizeAndReturnError:err];
    } else {
        [ref synchronizeFile];
    }
#else
    [ref synchronizeFile];
#endif

    return YES;
}

BOOL FileHandleTruncateAtOffset( NSFileHandle *ref, unsigned long long offset, NSError **err )
{
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
    if (@available(macOS 10.15, *)) {
        return [ref truncateAtOffset:offset error:err];
    } else {
        [ref truncateFileAtOffset:offset];
    }
#else
    [ref truncateFileAtOffset:offset];
#endif

    return YES;
}

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
BOOL FileHandleGetOffset( NSFileHandle *ref, unsigned long long *offset, NSError **err )
{ return [ref getOffset:offset error:err]; }

CFDataRef FileHandleReadDataUpToLength( NSFileHandle *ref, NSUInteger length, NSError **err )
{ return (__bridge CFDataRef)[ref readDataUpToLength:length error:err]; }
#endif// 101500


#pragma mark - pipe
// - init -
NSPipe *PipeInit( void )
{ return [NSPipe pipe]; }

// - file handles -
NSFileHandle *PipeFileHandleForReading( NSPipe *ref )
{ return [ref fileHandleForReading]; }

NSFileHandle *PipeFileHandleForWriting( NSPipe *ref )
{ return [ref fileHandleForWriting]; }
