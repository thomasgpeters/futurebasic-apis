
#import "FileHandlingUtils.h"
//#import "ArrayIndices.h" //2023-Nov-15 Brian - not referenced in this file

#pragma mark - Utility functions
CFStringRef FH_URLGetPath( CFURLRef url )
{ return (__bridge CFStringRef)[(__bridge NSURL *)url path]; }

Boolean FH_FileExistsAtPath( CFStringRef path ) {
    return [[NSFileManager defaultManager] fileExistsAtPath:(__bridge NSString *)path]; //2023-Dec-22 Brian
}

Boolean FH_LastFileExists( CFURLRef url ) {
    return FH_FileExistsAtPath((__bridge CFStringRef)[(__bridge NSURL *)url path] ); //2023-Dec-22 Brian
}

#pragma mark - URL functions
CFURLRef FH_AppendComponentToURL( CFURLRef baseURL, CFStringRef componentToAppend )
{ return(__bridge CFURLRef)[(__bridge NSURL *)baseURL URLByAppendingPathComponent:(__bridge NSString *)componentToAppend]; }


CFStringRef FH_AppendComponentToString( CFStringRef basePath, CFStringRef componentToAppend )
{ return(__bridge CFStringRef)[(__bridge NSString *)basePath stringByAppendingPathComponent:(__bridge NSString *)componentToAppend]; }


CFURLRef FH_GetBundleResourceDirectoryURL( void )
{ return (__bridge CFURLRef)[[NSBundle mainBundle] resourceURL]; }


#pragma mark - Creator/Type functions
long FH_GetFileType( CFURLRef url, OSType * type )
{
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[(__bridge NSURL *)url path] error:nil];
    *type = [[attributes objectForKey:NSFileHFSTypeCode] intValue]; //2022-Jan-11 Brian
    return 0;
}

void FH_SetTypeCreator( CFURLRef fileURL, OSType type, OSType creator )
{
    NSString *filePath = [(__bridge NSURL *)fileURL path];
    NSNumber *typeNum = [NSNumber numberWithInt:type];
    NSNumber *creatorNum = [NSNumber numberWithInt:creator];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:typeNum forKey:NSFileHFSTypeCode];
    [attributes setObject:creatorNum forKey:NSFileHFSCreatorCode];
    [[NSFileManager defaultManager] setAttributes:attributes ofItemAtPath:filePath error:nil];
}

UInt64 FH_FileLength( NSURL *url )
{
    UInt64 returnLength = 0;
#if !__has_feature(objc_arc)
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
#endif
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingFromURL:url error:NULL];
    if ( fh ) {
        UInt64    offSet = [fh offsetInFile];     // save current offset
        UInt64    length = [fh seekToEndOfFile];
        [fh seekToFileOffset:offSet];             // restore offset in file
                                                  //[fh release];
        returnLength = length;
    }
#if !__has_feature(objc_arc)
    [pool drain];
#endif
    return returnLength;
}


#pragma mark - Read functions
//2023-Apr-26 Brian - older calls deprecated in macOS 10.15
NSData *FH_ReadCopyData( NSUInteger length, UInt64 *offset, NSURL *url ) {
#if !__has_feature(objc_arc)
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
#endif
    NSData *data;
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingFromURL:url error:NULL];
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
    if ( @available(macOS 10.15, *) ) {  //2023-Apr-26 Brian - older call deprecated in macOS 10.15
        [fh seekToOffset:*offset error:NULL];
#if __has_feature(objc_arc)
        data = [fh readDataUpToLength:length error:NULL];
#else
        data = [[fh readDataUpToLength:length error:NULL]retain];
#endif
        [fh getOffset:offset error:NULL];
    } else {
        [fh seekToFileOffset:*offset];
#if __has_feature(objc_arc)
        data = [fh readDataOfLength:length];
#else
        data = [[fh readDataOfLength:length] retain]; // 'retain' required because 'data' in the local pool is drained
#endif
        *offset = [fh offsetInFile];
    }
#else// 101500
    [fh seekToFileOffset:*offset];
#if __has_feature(objc_arc)
    data = [fh readDataOfLength:length];
#else
    data = [[fh readDataOfLength:length] retain]; // 'retain' required because 'data' in the local pool is drained
#endif
    *offset = [fh offsetInFile];
#endif// 101500
#if !__has_feature(objc_arc)
    [pool drain];
#endif
    return data;
}

void FH_PrintFile( CFURLRef url, CFStringRef string )
{ [(__bridge NSString *)string writeToURL:(__bridge NSURL *)url atomically:NO encoding:NSUTF8StringEncoding error:nil]; }


CFStringRef FH_InputFile( CFURLRef url, __attribute__ ((unused)) CFStringRef string )
{ return (__bridge CFStringRef)[NSString stringWithContentsOfURL:(__bridge NSURL *)url encoding:NSUTF8StringEncoding error:nil]; }

OSStatus FH_ReadChar( UInt64 * offset, UInt8 *value, NSURL *url ){
    OSStatus err = 0;
    NSData *data = FH_ReadCopyData( sizeof(char), offset, url );
    if( data != nil ) {
        [data getBytes:value length:[data length]];
#if !__has_feature(objc_arc)
        [data release];
#endif
    } else {
        *value = '\0';
        //err = ioErr;
    }
    return err;     // always returns zero for now. Just testing. Brian 20171130
}

void FH_ReadFile( void *p, SInt64 length, UInt64 *offset, NSURL *url )
{
    NSData *data = FH_ReadCopyData( length, offset, url ); // allow for file already being read and this is a subsequent read.
    if ( data != nil ) {
        [data getBytes:p length: [data length]];
#if !__has_feature(objc_arc)
        [data release];
#endif
    }
}

OSStatus FH_CheckFileLockStatus( int fd, int inStatusType, int *outFileLockStat )
{
    OSStatus err = noErr;
    struct flock fileLockRec = { 0, 0, 0, 0, 0 };
    
    fileLockRec.l_type = inStatusType;
    err = fcntl( fd, F_GETLK, &fileLockRec );
    if ( err >= 0 ) {
        *outFileLockStat = (int)fileLockRec.l_type;     // if no lock found to prevent a F_WRLCK( or F_RDLCK ), the lock type is set to F_UNLCK.
    } else {
        err = errno;
    }
    return err;
}

// 'Updateable' means available for reading and writing
// 'Writable'   means available only for writing.
OSStatus FH_IsFileAvailable( CFURLRef url, char *modeRequested, int *fd, __attribute__ ((unused)) int fileID )
{
    OSStatus err  = noErr;
    int openFileMode, localFD, fileLockStat = 0;
    
    const char *pathName = [[(__bridge NSURL *)url path] UTF8String];

    // Does another process have this file open?  Note: the answer should be to try it with the unix 'open' below.
    // Instead this code creates a file handle which leaves open a crash possibility should Apple change their reaction.
    // Creating this file handle runs the risk the OS will deallocate and fail to do its own close of the file descriptor
    // because this code already does it. Since FH_IsFileAvailable() is called only on FB OPENs, there is no risk of exhausting file descriptors.
    // This is the error message the system generates because our 'close' usurped its close:
    // "BUG in libdispatch client: kevent[EVFILT_MACHPORT] monitored resource vanished before the source cancel handler was invoked"
    //
#if !__has_feature(objc_arc)
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
#endif
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingFromURL:(__bridge NSURL *)url error:NULL];
    localFD = [fh fileDescriptor];  // file handle creation does not install a lock on the file
    err = FH_CheckFileLockStatus( localFD, F_WRLCK, &fileLockStat );
    close( localFD );

    switch ( *modeRequested ) {
        case 'N': openFileMode = O_RDWR   | O_SHLOCK   | O_NONBLOCK;
            if ( err == noErr ) {
                switch ( fileLockStat ) {
                    case F_RDLCK:                            // at least one process has a shared lock
                        *modeRequested = 'I';                // need to do an open "I" since other process has a shared lock
                        err = EACCES;                        // tell caller write permission denied
                        openFileMode = O_RDONLY   | O_SHLOCK   | O_NONBLOCK;
                    case F_UNLCK:                            // means file is unlocked and available.
                        localFD = open(pathName, openFileMode);
                        *fd = localFD;
                        //gFBOpenFiles[fileID].fh = [[NSFileHandle alloc]initWithFileDescriptor:localFD closeOnDealloc:YES];
                        break;
                    case F_WRLCK:                            // one process has an exclusive or write lock
                        err = EAGAIN;                        // resource temporarily not available
                        break;
                    default:
                        break;
                }
            }
            break;
        case 'I': openFileMode = O_RDONLY | O_SHLOCK   | O_NONBLOCK;
            if ( err == noErr ) {
                switch ( fileLockStat ) {
                    case F_RDLCK:                            // at least one process has a shared lock
                        //err = EACCES;                        // tell caller write permission denied
                                                             // 'break' intentionally omitted
                    case F_UNLCK:                            // means file is unlocked and available.
                        localFD = open(pathName, openFileMode);
                        *fd = localFD;
                        //gFBOpenFiles[fileID].fh = [[NSFileHandle alloc]initWithFileDescriptor:localFD closeOnDealloc:YES];
                        break;
                    case F_WRLCK:                            // one process has an exclusive or write lock
                        err = EAGAIN;                        // resource temporarily not available
                        break;
                    default:
                        break;
                }
            }

            break;
        case 'O':
        case 'A':
        case 'R': openFileMode = O_RDWR   | O_EXLOCK   | O_NONBLOCK;   // modes 'O','A','R' are all exclusive
            if ( err == noErr ) {
                switch ( fileLockStat ) {
                    case F_RDLCK:                            // at least one process has a shared lock
                    case F_WRLCK:                            // one process has an exclusive or write lock
                        err = EAGAIN;                        // resource temporarily not available
                        break;
                    case F_UNLCK:                            // means file is unlocked and available.
                        localFD = open(pathName, openFileMode);
                        *fd = localFD;
                        //gFBOpenFiles[fileID].fh = [[NSFileHandle alloc]initWithFileDescriptor:localFD closeOnDealloc:YES];
                        break;
                    default:
                        break;
                }
            }
            break;
        default:
            err = 999; // invalid modeRequested
            break;
            
    }
#if !__has_feature(objc_arc)
    [pool drain];
#endif
    return err;
}

#pragma mark - Write functions

//2023-Apr-26 Brian - older calls deprecated in macOS 10.15
UInt64 FH_WriteData( CFDataRef inData, UInt64 inOffset, NSURL *url )
{
#if !__has_feature(objc_arc)
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
#endif
    NSFileHandle *fh = [NSFileHandle fileHandleForWritingToURL:url error:NULL];
    UInt64 outOffset;
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
    if ( @available(macOS 10.15, *) ) {  //2023-Apr-26 Brian - older call deprecated in macOS 10.15
        [fh seekToOffset:inOffset error:NULL];
        [fh writeData:(__bridge NSData *)inData];
        [fh getOffset:&outOffset error:NULL];
    } else {
        [fh seekToFileOffset:inOffset];
        [fh writeData:(__bridge NSData *)inData];
        outOffset = [fh offsetInFile];
    }
#else// 101500
    [fh seekToFileOffset:inOffset];
    [fh writeData:(__bridge NSData *)inData];
    outOffset = [fh offsetInFile];
#endif// 101500
#if !__has_feature(objc_arc)
    [pool drain];
#endif
    return outOffset;
}

UInt64 FH_WriteFile( void *p, UInt64 length, UInt64 offset, NSURL *url )
{ return FH_WriteData( (__bridge CFDataRef)[NSData dataWithBytes:p length:length], offset, url ); }


UInt64 FH_WriteChar( CFURLRef url, char theChar, SInt64 offset )
{ return FH_WriteData( (__bridge CFDataRef)[NSData dataWithBytes:&theChar length:sizeof(theChar)], offset, (__bridge NSURL *)url ); }


BOOL FH_BuildEmptyFile( CFURLRef url )
{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm createFileAtPath: (__bridge NSString *)FH_URLGetPath( url ) contents:nil attributes:nil];
}

long FH_TrashObject( CFStringRef sourceObj )
{
    OSErr err = noErr;
    if ( sourceObj ) {
        //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
        NSString *src = [(__bridge NSString *)sourceObj stringByDeletingLastPathComponent];
        NSString *file = [(__bridge NSString *)sourceObj lastPathComponent];
        [[NSWorkspace sharedWorkspace] performFileOperation:NSWorkspaceRecycleOperation source:src destination:@"" files:[NSArray arrayWithObject:file] tag:nil];
        NSSound *systemSound = [[NSSound alloc] initWithContentsOfFile:@"/System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/dock/drag to trash.aif" byReference:YES];
        if(systemSound) {
            [systemSound play];
#if !__has_feature(objc_arc)
            [systemSound release];
#endif
        }
        //[pool drain];
    } else {
        err = 999;
    }
    return err;
}

OSStatus FH_SetFilePointerToEndOfFile( NSURL *url, UInt64 *filePos )
{
    OSStatus err = noErr;
    UInt64 length = FH_FileLength( url );
#if !__has_feature(objc_arc)
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
#endif
    NSFileHandle *fh = [NSFileHandle fileHandleForReadingFromURL:url error:NULL];
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
    if ( @available(macOS 10.15, *) ) {  //2023-Apr-26 Brian - older call deprecated in macOS 10.15
        [fh seekToOffset:length error:NULL];
    } else {
        @try {
            [fh seekToFileOffset: length];
        } @catch (NSException *theException) {
            if (theException.name == NSFileHandleOperationException) {
                err = fnOpnErr;
            }
        }
    }
#else// 101500
    @try {
        [fh seekToFileOffset: length];
    } @catch (NSException *theException) {
        if (theException.name == NSFileHandleOperationException) {
            err = fnOpnErr;
        }
    }
#endif// 101500
    //@finally {
    
    //}
#if !__has_feature(objc_arc)
    [pool drain];
#endif
    *filePos = length;
    return err;
}


UInt64 FH_TruncateFileAtOffset( NSFileHandle *fh, UInt64 inOffset ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
    if ( @available(macOS 10.15, *) ) {  //2023-Apr-26 Brian - older call deprecated in macOS 10.15
        [fh seekToOffset:inOffset error:NULL];
        [fh truncateAtOffset:inOffset error:nil];// 20230926 bw
    } else {
        [fh seekToFileOffset:inOffset];
        [fh truncateFileAtOffset: inOffset];
    }
#else// 101500
    [fh seekToFileOffset:inOffset];
    [fh truncateFileAtOffset: inOffset];
#endif// 101500
    return inOffset;
}

