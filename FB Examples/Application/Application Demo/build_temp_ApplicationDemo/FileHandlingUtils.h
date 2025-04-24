
#import "FBtoC.h"
#import "Runtime.h"

Boolean FH_FileExistsAtPath( CFStringRef path ) ; //2023-Dec-22 Brian change to Boolean
Boolean FH_LastFileExists( CFURLRef url ) ; //2023-Dec-22 Brian
CFURLRef FH_AppendComponentToURL( CFURLRef baseURL, CFStringRef componentToAppend ) ;
CFStringRef FH_AppendComponentToString( CFStringRef basePath, CFStringRef componentToAppend ) ;
CFURLRef FH_GetBundleResourceDirectoryURL( void );
CFURLRef FH_GetSysDirAndPathURL( UInt32 whichDirectory, UInt32 whichDomain, CFStringRef whichAppendComponent ) ;
long FH_GetFileType( CFURLRef url, OSType * type ) ;
void FH_SetTypeCreator( CFURLRef fileURL, OSType type, OSType creator ) ;
UInt64 FH_FileLength( NSURL *url ) ;
//UInt64 FH_CurrentOffsetInFile( CFURLRef url );
OSStatus FH_SetFilePointerToEndOfFile( NSURL *url, UInt64 *filePos );  //2023-Apr-26 Brian

//NSData *FH_ReadCopyData( NSUInteger length, SInt64 *offset, NSURL *url ); //2023-Apr-26 Brian
NSData *FH_ReadCopyData( NSUInteger length, UInt64 *offset, NSURL *url );
void FH_PrintFile( CFURLRef url, CFStringRef string ) ;
CFStringRef FH_InputFile( CFURLRef url, CFStringRef string ) ;
//OSStatus FH_ReadChar( SInt64 * offset, UInt8 *value, NSURL *url ); //2023-Apr-26 Brian
OSStatus FH_ReadChar( UInt64 * offset, UInt8 *value, NSURL *url );

//void FH_ReadFile( void *p, SInt64 length, SInt64 *offset, NSURL *url ); //2023-Apr-26 Brian
void FH_ReadFile( void *p, SInt64 length, UInt64 *offset, NSURL *url );
OSStatus FH_CheckFileLockStatus( int fd, int inStatusType, int *outFileLockStat );

UInt64 FH_WriteData( CFDataRef inData, UInt64 inOffset, NSURL *url );
UInt64 FH_WriteFile( void *p, UInt64 length, UInt64 offset, NSURL *url );

UInt64 FH_WriteChar( CFURLRef url, char theChar, SInt64 offset );
BOOL FH_BuildEmptyFile( CFURLRef url );
long FH_TrashObject( CFStringRef sourceObj ) ;
CFStringRef FH_URLGetPath( CFURLRef url );
UInt64 FH_TruncateFileAtOffset( NSFileHandle *fh, UInt64 inOffset );
OSStatus FH_IsFileAvailable( CFURLRef url, char *modeRequested, int *fd, int fileID );

