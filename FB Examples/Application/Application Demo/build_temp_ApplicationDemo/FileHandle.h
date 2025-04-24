/*
 FileHandle.h

 Bernie Wylde
 */


#import "CocoaUI.h"

typedef void (*CUI_FileHandleReadWriteHandlerType)(NSFileHandle *);

// Class
Class FileHandleClass( void );

// - get -
NSFileHandle *FileHandleForReadingFromURL( CFURLRef url, NSError **err );
NSFileHandle *FileHandleForWritingToURL( CFURLRef url, NSError **err );
NSFileHandle *FileHandleForUpdatingURL( CFURLRef url, NSError **err );
NSFileHandle *FileHandleWithStandardError( void );
NSFileHandle *FileHandleWithStandardInput( void );
NSFileHandle *FileHandleWithStandardOutput( void );
NSFileHandle *FileHandleWithNullDevice( void );

// - create -
NSFileHandle *FileHandleWithFileDescriptor( int fd );
NSFileHandle *FileHandleWithFileDescriptorCloseOnDealloc( int fd, BOOL flag );

// - file descriptor -
int FileHandleFileDescriptor( NSFileHandle *ref );

// - reading -
CFDataRef FileHandleAvailableData( NSFileHandle *ref );
CFDataRef FileHandleReadDataToEndOfFile( NSFileHandle *ref, NSError **err );
CFDataRef FileHandleReadDataOfLength( NSFileHandle *ref, NSUInteger length );

// - writing -
BOOL FileHandleWriteData( NSFileHandle *ref, CFDataRef dta, NSError **err );

// - reading/writing using blocks
void FileHandleSetReadabilityHandler( NSFileHandle *ref, CUI_FileHandleReadWriteHandlerType handlerFn );
void FileHandleSetWriteabilityHandler( NSFileHandle *ref, CUI_FileHandleReadWriteHandlerType handlerFn );

// - communicating asynchronously -
void FileHandleAcceptConnectionInBackgroundAndNotify( NSFileHandle *ref );
void FileHandleAcceptConnectionInBackgroundAndNotifyForModes( NSFileHandle *ref, CFArrayRef modes );
void FileHandleReadInBackgroundAndNotify( NSFileHandle *ref );
void FileHandleReadInBackgroundAndNotifyForModes( NSFileHandle *ref, CFArrayRef modes );
void FileHandleReadToEndOfFileInBackgroundAndNotify( NSFileHandle *ref );
void FileHandleReadToEndOfFileInBackgroundAndNotifyForModes( NSFileHandle *ref, CFArrayRef modes );
void FileHandleWaitForDataInBackgroundAndNotify( NSFileHandle *ref );
void FileHandleWaitForDataInBackgroundAndNotifyForModes( NSFileHandle *ref, CFArrayRef modes );

// - seeking within a file -
unsigned long long FileHandleOffsetInFile( NSFileHandle *ref );
BOOL FileHandleSeekToEnd( NSFileHandle *ref, unsigned long long *offset, NSError **err );
BOOL FileHandleSeekToOffset( NSFileHandle *ref, unsigned long long offset, NSError **err );

// Operating on a file
BOOL FileHandleClose( NSFileHandle *ref, NSError **err );
BOOL FileHandleSynchronize( NSFileHandle *ref, NSError **err );
BOOL FileHandleTruncateAtOffset( NSFileHandle *ref, unsigned long long offset, NSError **err );

// Instance methods
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
API_AVAILABLE(macos(10.15))
BOOL FileHandleGetOffset( NSFileHandle *ref, unsigned long long *offset, NSError **err );
API_AVAILABLE(macos(10.15))
CFDataRef FileHandleReadDataUpToLength( NSFileHandle *ref, NSUInteger length, NSError **err );
#endif// 101500


#pragma mark - pipe
// - init -
NSPipe *PipeInit( void );

// - file handles -
NSFileHandle *PipeFileHandleForReading( NSPipe *ref );
NSFileHandle *PipeFileHandleForWriting( NSPipe *ref );

