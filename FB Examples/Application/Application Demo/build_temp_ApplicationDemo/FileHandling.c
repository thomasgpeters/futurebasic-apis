
//  FileHandling.c

// prefix header, with public (user-code-reachable) struct and typedef declarations
#import "FileHandlingUtils.h"
#import "Runtime.h" //2023-Feb-07 Brian

#pragma mark - fileopen, fileclose, fileread, filewrite

@interface FileObject : NSObject
@property (nonatomic,strong) NSFileHandle *fh;
@property (nonatomic,strong) NSMutableData *buffer;
@property (nonatomic, strong) NSData *newlineData;
@property (nonatomic, strong) NSData *returnData;
@property (nonatomic,assign) BOOL append;
@property (nonatomic,assign) BOOL eof;
- (id)initWithFileHandle:(NSFileHandle *)fh;
+ (id)fileObjectWithFileHandle:(NSFileHandle *)fh;
- (NSString *)readLineAndReturnError:(NSError**)error;
- (NSString *)readLineAndReturnError:(NSError**)error encoding:(NSStringEncoding)encoding;

@end

static NSMutableDictionary *sFileObjects;

@implementation FileObject

- (id)initWithFileHandle:(NSFileHandle *)fh {
    if ( (self = [super init]) ) {
        self.fh = fh;
        self.buffer = [[NSMutableData alloc] init];
        self.newlineData = [@"\n" dataUsingEncoding:NSUTF8StringEncoding];
        self.returnData = [@"\r" dataUsingEncoding:NSUTF8StringEncoding];
        self.append = NO;
    }
    return self;
}

+ (id)fileObjectWithFileHandle:(NSFileHandle *)fh {
#if __has_feature(objc_arc)
    return [[FileObject alloc] initWithFileHandle:fh];
#else
    return [[[FileObject alloc] initWithFileHandle:fh] autorelease];
#endif
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.fh release];
    [self.buffer release];
    [super dealloc];
}
#endif

- (NSString *)readLineAndReturnError:(NSError **)error {
    while (YES) {
        NSRange newlineRange = [self.buffer rangeOfData:self.newlineData options:0 range:NSMakeRange(0, self.buffer.length)];
        NSRange returnRange = [self.buffer rangeOfData:self.returnData options:0 range:NSMakeRange(0, self.buffer.length)];
        
        if ( newlineRange.location == NSNotFound ) {
            newlineRange = returnRange;
        } else if ( returnRange.location != NSNotFound ) {
            if ( returnRange.location < newlineRange.location ) {
                newlineRange = returnRange;
            }
        }
        
        if (newlineRange.location != NSNotFound) {
            NSData *lineData = [self.buffer subdataWithRange:NSMakeRange(0, newlineRange.location)];
            [self.buffer replaceBytesInRange:NSMakeRange(0, newlineRange.location + newlineRange.length) withBytes:NULL length:0];
            return [[NSString alloc] initWithData:lineData encoding:NSUTF8StringEncoding];
        }
        NSData *chunk;
        
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
        if (@available(macOS 10.15, *)) {
            chunk = [self.fh readDataUpToLength:1024 error:error];
        } else {
            chunk = [self.fh readDataOfLength:1024];
        }
#else
        chunk = [self.fh readDataOfLength:1024];
#endif
        
        if ( chunk.length < 1024 && self.buffer.length == chunk.length ) self.eof = YES;// kludge to determine if we've reached end of file

        if (chunk.length == 0) {
            // end of file
            if (self.buffer.length > 0) {
                NSString *line = [[NSString alloc] initWithData:self.buffer encoding:NSUTF8StringEncoding];
                self.buffer.length = 0;
                return line;
            }
            return nil;
        }
        [self.buffer appendData:chunk];
    }
}

- (NSString *)readLineAndReturnError:(NSError **)error encoding:(NSStringEncoding)encoding {
    while (YES) {
        NSRange newlineRange = [self.buffer rangeOfData:self.newlineData options:0 range:NSMakeRange(0, self.buffer.length)];
        NSRange returnRange = [self.buffer rangeOfData:self.returnData options:0 range:NSMakeRange(0, self.buffer.length)];
        
        if ( newlineRange.location == NSNotFound ) {
            newlineRange = returnRange;
        } else if ( returnRange.location != NSNotFound ) {
            if ( returnRange.location < newlineRange.location ) {
                newlineRange = returnRange;
            }
        }
        
        if (newlineRange.location != NSNotFound) {
            NSData *lineData = [self.buffer subdataWithRange:NSMakeRange(0, newlineRange.location)];
            [self.buffer replaceBytesInRange:NSMakeRange(0, newlineRange.location + newlineRange.length) withBytes:NULL length:0];
            return [[NSString alloc] initWithData:lineData encoding:encoding];
        }
        NSData *chunk;
        
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
        if (@available(macOS 10.15, *)) {
            chunk = [self.fh readDataUpToLength:1024 error:error];
        } else {
            chunk = [self.fh readDataOfLength:1024];
        }
#else
        chunk = [self.fh readDataOfLength:1024];
#endif
        
        if ( chunk.length < 1024 && self.buffer.length == chunk.length ) self.eof = YES;// kludge to determine if we've reached end of file

        if (chunk.length == 0) {
            // end of file
            if (self.buffer.length > 0) {
                NSString *line = [[NSString alloc] initWithData:self.buffer encoding:encoding];
                self.buffer.length = 0;
                return line;
            }
            return nil;
        }
        [self.buffer appendData:chunk];
    }
}
@end

BOOL FileClose( long inFileID, NSError **err )
{
    BOOL result = NO;
    if ( sFileObjects ) {
        NSString *fileID = [NSString stringWithFormat:@"%ld",inFileID];
        FileObject *fileObj = sFileObjects[fileID];
        if ( fileObj ) {

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
            if (@available(macOS 10.15, *)) {
                NSError *error = nil;
                result = [fileObj.fh closeAndReturnError:&error];
                if ( err ) *err = error;
            } else {
                [fileObj.fh closeFile];
                result = YES;
            }
#else
            [fileObj.fh closeFile];
            result = YES;
#endif
            
            [sFileObjects removeObjectForKey:fileID];
            return result;
        }
    }
    
    if ( err ) {
        NSError *error = [NSError errorWithDomain:@"FileNotOpen" code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"A file with ID %ld is not currently open",inFileID]}];
        *err = error;
    }
    return result;
}

BOOL FileOpenAppend( long inFileID, CFURLRef inURL, NSError **err )
{
    if ( !sFileObjects ) sFileObjects = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *fileID = [NSString stringWithFormat:@"%ld",inFileID];
    FileObject *fileObj = sFileObjects[fileID];
    if ( fileObj ) {
        if ( err ) {
            NSError *error = [NSError errorWithDomain:@"AlreadyOpenError" code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"A file with ID %ld is already open",inFileID]}];
            *err = error;
        }
    } else {
        NSURL *url = (__bridge NSURL *)inURL;
        
        // if file doesn't exist, create it
        NSFileManager *fm = [NSFileManager defaultManager];
        if ( ![fm fileExistsAtPath:[url path]] ) {
            if ( ![@"" writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:err] ) {
                return NO;
            }
        }

        NSFileHandle *fh = [NSFileHandle fileHandleForWritingToURL:url error:err];
        if ( fh ) {
            fileObj = [FileObject fileObjectWithFileHandle:fh];
            fileObj.append = YES;
            [sFileObjects setValue:fileObj forKey:fileID];
            return YES;
        }
    }
    return NO;
}

BOOL FileOpenRead( long inFileID, CFURLRef inURL, NSError **err )
{
    if ( !sFileObjects ) sFileObjects = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *fileID = [NSString stringWithFormat:@"%ld",inFileID];
    FileObject *fileObj = sFileObjects[fileID];
    if ( fileObj ) {
        if ( err ) {
            NSError *error = [NSError errorWithDomain:@"AlreadyOpenError" code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"A file with ID %ld is already open",inFileID]}];
            *err = error;
        }
    } else {
        NSURL *url = (__bridge NSURL *)inURL;
        NSFileHandle *fh = [NSFileHandle fileHandleForReadingFromURL:url error:err];
        if ( fh ) {
            fileObj = [FileObject fileObjectWithFileHandle:fh];
            [sFileObjects setValue:fileObj forKey:fileID];
            return YES;
        }
    }
    return NO;
}

BOOL FileOpenReadAppend( long inFileID, CFURLRef inURL, NSError **err )
{
    if ( !sFileObjects ) sFileObjects = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *fileID = [NSString stringWithFormat:@"%ld",inFileID];
    FileObject *fileObj = sFileObjects[fileID];
    if ( fileObj ) {
        if ( err ) {
            NSError *error = [NSError errorWithDomain:@"AlreadyOpenError" code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"A file with ID %ld is already open",inFileID]}];
            *err = error;
        }
    } else {
        NSURL *url = (__bridge NSURL *)inURL;
        NSFileHandle *fh = [NSFileHandle fileHandleForUpdatingURL:url error:err];
        if ( fh ) {
            fileObj = [FileObject fileObjectWithFileHandle:fh];
            fileObj.append = YES;
            [sFileObjects setValue:fileObj forKey:fileID];
            return YES;
        }
    }
    return NO;
}

BOOL FileOpenReadWrite( long inFileID, CFURLRef inURL, NSError **err )
{
    if ( !sFileObjects ) sFileObjects = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *fileID = [NSString stringWithFormat:@"%ld",inFileID];
    FileObject *fileObj = sFileObjects[fileID];
    if ( fileObj ) {
        if ( err ) {
            NSError *error = [NSError errorWithDomain:@"AlreadyOpenError" code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"A file with %ld ID is already open",inFileID]}];
            *err = error;
        }
    } else {
        NSURL *url = (__bridge NSURL *)inURL;
        NSFileHandle *fh = [NSFileHandle fileHandleForUpdatingURL:url error:err];
        if ( fh ) {
            fileObj = [FileObject fileObjectWithFileHandle:fh];
            [sFileObjects setValue:fileObj forKey:fileID];
            return YES;
        }
    }
    return NO;
}

BOOL FileOpenWrite( long inFileID, CFURLRef inURL, NSError **err )
{
    if ( !sFileObjects ) sFileObjects = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *fileID = [NSString stringWithFormat:@"%ld",inFileID];
    FileObject *fileObj = sFileObjects[fileID];
    if ( fileObj ) {
        if ( err ) {
            NSError *error = [NSError errorWithDomain:@"AlreadyOpenError" code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"A file with ID %ld is already open",inFileID]}];
            *err = error;
        }
    } else {
        NSURL *url = (__bridge NSURL *)inURL;
        
        // if file doesn't exist, create it
        NSFileManager *fm = [NSFileManager defaultManager];
        if ( ![fm fileExistsAtPath:[url path]] ) {
            if ( ![@"" writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:err] ) {
                return NO;
            }
        }
        
        NSFileHandle *fh = [NSFileHandle fileHandleForWritingToURL:url error:err];
        if ( fh ) {
            fileObj = [FileObject fileObjectWithFileHandle:fh];
            [sFileObjects setValue:fileObj forKey:fileID];
            return YES;
        }
    }
    return NO;
}

CFStringRef FileRead( long inFileID, NSError **err )
{
    if ( sFileObjects ) {
        NSString *fileID = [NSString stringWithFormat:@"%ld",inFileID];
        FileObject *fileObj = sFileObjects[fileID];
        if ( fileObj ) {
            NSError *error = nil;
            NSData *data;
            
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
            if (@available(macOS 10.15, *)) {
                data = [fileObj.fh readDataToEndOfFileAndReturnError:&error];
            } else {
                data = [fileObj.fh readDataToEndOfFile];
            }
#else
            data = [fileObj.fh readDataToEndOfFile];
#endif
            
            if ( data ) {
                return (__bridge CFStringRef)[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            } else {
                if ( err ) *err = error;
                return nil;
            }
        }
    }
    if ( err ) {
        NSError *error = [NSError errorWithDomain:@"FileNotOpen" code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"A file with ID %ld is not open",inFileID]}];
        *err = error;
    }
    return nil;
}

#if 1 // encoding param
CFStringRef FileReadLine( long inFileID, long encoding, NSError **err )
{
    if ( sFileObjects ) {
        NSString *fileID = [NSString stringWithFormat:@"%ld",inFileID];
        FileObject *fileObj = sFileObjects[fileID];
        if ( fileObj ) {
            if ( encoding == kFBParamMissing ) encoding = NSUTF8StringEncoding;
            NSError *error = nil;
            NSString *string = [fileObj readLineAndReturnError:&error encoding:encoding];
            if ( err ) *err = error;
            return (__bridge CFStringRef)string;
        }
    }
    if ( err ) {
        NSError *error = [NSError errorWithDomain:@"FileNotOpen" code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"A file with ID %ld is not open",inFileID]}];
        *err = error;
    }
    return nil;
}
#else
CFStringRef FileReadLine( long inFileID, NSError **err )
{
    if ( sFileObjects ) {
        NSString *fileID = [NSString stringWithFormat:@"%ld",inFileID];
        FileObject *fileObj = sFileObjects[fileID];
        if ( fileObj ) {
            NSError *error = nil;
            NSString *string = [fileObj readLineAndReturnError:&error];
            if ( err ) *err = error;
            return (__bridge CFStringRef)string;
        }
    }
    if ( err ) {
        NSError *error = [NSError errorWithDomain:@"FileNotOpen" code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"A file with ID %ld is not open",inFileID]}];
        *err = error;
    }
    return nil;
}
#endif

BOOL FileWrite( long inFileID, CFStringRef inString, NSError **err )
{
    if ( sFileObjects ) {
        NSString *fileID = [NSString stringWithFormat:@"%ld",inFileID];
        FileObject *fileObj = sFileObjects[fileID];
        if ( fileObj ) {
            NSString *string = (__bridge NSString *)inString;
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
            if ( data ) {
                
                if ( !fileObj.append ) {
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
                    if (@available(macOS 10.15, *)) {
                        NSError *error = nil;
                        if ( ![fileObj.fh truncateAtOffset:0 error:&error] ) {
                            if ( err ) *err = error;
                            return NO;
                        }
                    } else {
                        [fileObj.fh truncateFileAtOffset:0];
                    }
#else
                    [fileObj.fh truncateFileAtOffset:0];
#endif
                }
                
#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 101500
                if (@available(macOS 10.15, *)) {
                    unsigned long long offsetInFile;
                    NSError *error = nil;
                    if ( [fileObj.fh seekToEndReturningOffset:&offsetInFile error:&error] ) {
                        if ( ![fileObj.fh writeData:data error:&error] ) {
                            if ( err ) *err = error;
                            return NO;
                        }
                        return YES;
                    } else {
                        if ( err ) *err = error;
                        return NO;
                    }
                } else {
                    [fileObj.fh seekToEndOfFile];
                    [fileObj.fh writeData:data];
                    return YES;
                }
#else
                [fileObj.fh seekToEndOfFile];
                [fileObj.fh writeData:data];
                return YES;
#endif
            }
        }
    }
    if ( err ) {
        NSError *error = [NSError errorWithDomain:@"FileNotOpen" code:-999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"A file with ID %ld is not open",inFileID]}];
        *err = error;
    }
    return NO;
}



enum {
    unknownVarType = -1,
    longVarType = 0,
    fixedVarType = 1,
    unsignedLongVarType = 2,
    shortVarType = 3,
    unsignedShortVarType = 4,
    byteVarType = 5,
    unsignedByteVarType = 6,
    booleanVarType = 7,
    UInt64VarType = 8,
    SInt64VarType = 9,
    pointerVarType = 10,
    handleVarType = 11,
    singleVarType = 12,
    doubleVarType = 13,
    ldoubleVarType = 14,
    doubleComplexType = 15,
    constStr255VarType = 16,
    containerVarType = 145,
    voidType = 146,
    pseudoRecordType = 147,
};


#define FBERRORS 13

long                gFBFileError;
OSType                gFBSaveType    = 0;                        // used by FBSetOpenType and other
OSType                gFBSaveCreator = 0;                        // used by FBSetOpenType and other
Str255                gFBLineBuf;
UInt32                gFBLineDev;
UInt32                gFBLinePos;
SInt64              gFBLastFilePos;
char                gFBFileTabMode;
UInt16              gFBTabWidth = 16;

//#if !defined NO_SUFFIX_ON_ARRAY_NAMES || NO_SUFFIX_ON_ARRAY_NAMES == 0
//#error wrong version of FileHandling.c
//#endif

FBInfoForOpenFile gFBOpenFiles[kMaxFBFiles + kFBMaxSerialFiles]; // suffix matches FB's FBInfoForOpenFile      gFBOpenFiles(_kFBMaxDiskFiles + _kFBMaxSerialFiles)

//static OSStatus        FBReadFile_Priv( const int fileID, void *dest, ByteCount numBytesRequested, ByteCount *numBytesRead );
static OSStatus      FBReadFile_Priv( const int fileID, void *dest, UInt64 numBytesRequested, UInt64 * numBytesRead ); //2023-Apr-26 Brian
static ssize_t       FBXSerialRead_Priv( const int serialPortID ); //2022-Jan-11 Brian
static void          FBCloseOneFile_priv( int fileID );

////////////////////////////////////
#pragma mark - Error handling
////////////////////////////////////

long FBerror( void )
{ return gFBFileError; }

//void FBFileErrorAlert( int fileID, OSStatus err )
void FBFileErrorAlert( long fileID, long err )// 20201221 bw
{
    if ( err ) {
        NSError *error   = [NSError errorWithDomain:NSOSStatusErrorDomain code:err userInfo:nil];
        NSString *string = [NSString stringWithFormat:@"The program returned a file error.\nFile ref:%ld\n%@", fileID, [error description]];
        FBFullStop( (__bridge CFStringRef)string, CFSTR(""), false );
    }
}

// value may be: FBFileErrorAlert (the default), a user-function (from 'on error fn MyErrHandler'), or NULL (from 'on error end').

FBOnXxxxxVector gFBOnErrorVector = &FBFileErrorAlert; // [fn name marks line to be removed by C runtime stripping] FBFileErrorAlert()



// on error fn 20201221 bw
//CUI_OnErrorFunctionType CUI_OnErrorFunction( void )
//{ return sCUI_OnErrorFunction; }
//
//void CUI_SetOnErrorFunction( CUI_OnErrorFunctionType onErrorFn )
//{ sCUI_OnErrorFunction = onErrorFn; }
//
//void CallUserDefinedOnErrorFunction( long fileID, long errCode )
//{
//    CUI_OnErrorFunctionType onErrorFn = CUI_OnErrorFunction();
//    if ( onErrorFn ) {
//        (*onErrorFn)( fileID, errCode );
//    }
//}



//void FBCheckFileError( int fileID, OSStatus err )
void FBCheckFileError( long fileID, long err )// 20201221 bw
{
    /*
     all opens, reads, writes   call though here at exit
     
     if ( err == noErr ) do nothing
     if ( gFBOnErrorVector is 0 ) do nothing  else call the vector - the vector points to either the default FBFileErrorAlert() or the user vector from their ON ERROR fn xxxxx ( if provided ).
     */
    if ( err ) {
        gFBFileError = err;
        if ( gFBOnErrorVector ) (*gFBOnErrorVector)( fileID, err );
        
        //CallUserDefinedOnErrorFunction( fileID, err )
        
    }
}

#pragma mark - opens
CFStringRef FBUnixFunction( CFStringRef inCommand ) {
    NSString *s = @"";  //2023-Aug-11 Brian - use empty string and not "nil" or "NULL"
    const char *command = [(__bridge NSString *)inCommand UTF8String]; //2023-Aug-09 Brian - convert CFString to the CString popen needs
    void *pipe          = popen( (char*)command, "r" );
    void *buffer        = malloc( myCommandOneMegBuffSize );
    NSUInteger nChars   = fread( buffer, 1, myCommandOneMegBuffSize, pipe );
    pclose( pipe );      //2023-Sep-12 Brian
    
#if __has_feature(objc_arc)
    if ( nChars ) s = [[NSString alloc]initWithBytes:buffer length:nChars encoding:NSUTF8StringEncoding];
#else
    if ( nChars ) s = [[[NSString alloc]initWithBytes:buffer length:nChars encoding:NSUTF8StringEncoding]autorelease];
#endif
    
    free( buffer );
    return (__bridge CFStringRef)s;
}

// //2023-Aug-14 Brian - reinstate open "unix" for FB 7.0.23 to give FBers time to update their code to the new 'unix' function
void FBOpenUNIX( unsigned fileID, Str255 command )
{
    /*
     Open "UNIX", fileID, command
     */
    gFBStk--;       // restore missing stack pointer decrement. Brian 20160516
    OSStatus err = noErr;
    
    if ( fileID > 0 && fileID < kMaxFBFiles ) {
        if ( gFBOpenFiles[fileID].isOpen == false ) {
            PScstr( command );
            gFBOpenFiles[fileID].pipeUNIX = popen( (char*)command, "r" );
            gFBOpenFiles[fileID].isOpen = true;
        } else {
            CFStringRef s1 = (__bridge CFStringRef)NSLocalizedStringFromTable(@"Error in Open 'UNIX' for file#",@"Runtime",@"FBOpenUNIX");
            CFStringRef e1 = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%d"), s1, fileID );
            CFStringRef e2 = (__bridge CFStringRef)NSLocalizedStringFromTable(@"FileID already in use",@"Runtime",@"FBOpenUNIX");
            FBFullStop( e1, e2, false );
            CFRelease(e1);
        }
    } else {
        CFStringRef s1 = (__bridge CFStringRef)NSLocalizedStringFromTable(@"FileID not in range ",@"Runtime",@"FBOpenUNIX");
        CFStringRef s2 = (__bridge CFStringRef)NSLocalizedStringFromTable(@" for FileID: ",@"Runtime",@"FBOpenUNIX");
        CFStringRef e1 = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%d%@%d"), s1, (int)err, s2, fileID );
        
        CFStringRef s3 = (__bridge CFStringRef)NSLocalizedStringFromTable( @"FileID must be in range 1 to ", @"Runtime", @"FBOpenUNIX" );
        CFStringRef e2 = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%d"),s3,kMaxFBFiles - 1 );
        
        FBFullStop( e1, e2, false );
        CFRelease(e1);
        CFRelease(e2);
    }
}
//void FBOpenUNIX( unsigned fileID, Str255 command )
/* //2023-Aug-11 Brian - commented out in favor of new 'unix' function. This was the support for the open "unix" statement.
 void FBOpenUNIX( unsigned fileID, CFStringRef inCommand, CFMutableStringRef outString ) {  //2023-Aug-09 Brian - change to accept CFStringRef
 
 //Open "UNIX", fileID, command
 
 //2023-Aug-09 Brian - no need for stack pointer since pascal string is no longer used
 //gFBStk--;       // restore missing stack pointer decrement. Brian 20160516
 OSStatus err = noErr;
 enum { myReply16kBuffSize = 16384}; //2023-Aug-09 Brian - could let the FBer enter a buffer size but this size seems safe.
 if ( fileID > 0 && fileID < kMaxFBFiles ) {
 if ( gFBOpenFiles[fileID].isOpen == false ) {
 //PScstr( command ); //2023-Aug-09 Brian
 const char *command = [(__bridge NSString *)inCommand UTF8String]; //2023-Aug-09 Brian - convert CFString to the CString popen needs
 gFBOpenFiles[fileID].pipeUNIX = popen( (char*)command, "r" );
 gFBOpenFiles[fileID].isOpen = true;
 void *buffer = malloc( myReply16kBuffSize );
 NSUInteger nChars = fread( buffer, 1, myReply16kBuffSize, gFBOpenFiles[fileID].pipeUNIX );
 FBClose( fileID );   //2023-Aug-09 Brian - does plose() and also zeros out gFBOpenFiles of fileID
 NSString *s = [[[NSString alloc]initWithBytes:buffer length:nChars encoding:NSUTF8StringEncoding]autorelease];
 free( buffer );
 CFStringReplaceAll(outString, (__bridge CFStringRef)s );
 } else {
 CFStringRef s1 = (__bridge CFStringRef)NSLocalizedStringFromTable(@"Error in Open 'UNIX' for file#",@"Runtime",@"FBOpenUNIX");
 CFStringRef e1 = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%d"), s1, fileID );
 CFStringRef e2 = (__bridge CFStringRef)NSLocalizedStringFromTable(@"FileID already in use",@"Runtime",@"FBOpenUNIX");
 FBFullStop( e1, e2, false );
 CFRelease(e1);
 }
 } else {
 CFStringRef s1 = (__bridge CFStringRef)NSLocalizedStringFromTable(@"FileID not in range ",@"Runtime",@"FBOpenUNIX");
 CFStringRef s2 = (__bridge CFStringRef)NSLocalizedStringFromTable(@" for FileID: ",@"Runtime",@"FBOpenUNIX");
 CFStringRef e1 = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%d%@%d"), s1, (int)err, s2, fileID );
 
 CFStringRef s3 = (__bridge CFStringRef)NSLocalizedStringFromTable( @"FileID must be in range 1 to ", @"Runtime", @"FBOpenUNIX" );
 CFStringRef e2 = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%d"),s3,kMaxFBFiles - 1 );
 
 FBFullStop( e1, e2, false );
 CFRelease(e1);
 CFRelease(e2);
 }
 }
 */
void FBOpenOutput( const int fileID, void *filePathType, void *ptrToURL )
{
    /*
     Works for data fork only
     Bad fileID gives no errors, just does nothing harmlessly.
     Other errors give no message, but plough on regardless
     
     Only CFURLRef syntax allowed: open "O", fileID, [@]url
     */
    CFURLRef        url = nil;
    OSStatus        err = noErr;
    int             myFD;
    char            fm = 'O';
    //NSError         *fhError = nil;
    
    if ( fileID > 0 && fileID < kMaxFBFiles ) {
        switch ( (long)filePathType ) {
            case 0:// CFURLRef
                url = (CFURLRef)ptrToURL;
                if ( FH_FileExistsAtPath( FH_URLGetPath( url ) ) == NO ) {
                    if ( FH_BuildEmptyFile( url ) == NO ) {   //  YES create worked, NO it failed
                        err = ENOENT; //2 - no such file or directory;
                    }
                }
                break;
            case 2:                                                                // ptr to CFURLRef
                memmove( &url, ptrToURL, sizeof(CFURLRef));
                if ( FH_FileExistsAtPath( FH_URLGetPath( url ) ) == NO ) {
                    if ( FH_BuildEmptyFile( url ) == NO ) {   //  YES create worked, NO it failed
                        err = ENOENT; //2 - no such file or directory;
                    }
                }
                break;
                
            default: // only CFURLRef allowed. FSRef, FSSpec fails because this file is for 64-bit runtime. Brian 20170113
                err = ENOENT; //2 - no such file or directory;
                break;
        }
        __Require_noErr( err, Bail );// 20170926 bw
        
        err = FH_IsFileAvailable( url, &fm, &myFD, fileID );
        
        __Require_noErr( err, Bail );// 20170926 bw
        
        FH_SetTypeCreator( url, gFBSaveType, gFBSaveCreator );
        
        // Stash for future use
        gFBOpenFiles[fileID].isOpen            = true;
        gFBOpenFiles[fileID].url            = (__bridge CFURLRef)[(__bridge NSURL *)url copy];   // make a copy so it is retained.
        
#if !__has_feature(objc_arc)
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
#endif
        NSFileHandle *fh = [NSFileHandle fileHandleForUpdatingURL:(__bridge NSURL *)url error:NULL];
        gFBOpenFiles[fileID].savedOffset    = FH_TruncateFileAtOffset( fh, 0 );
#if !__has_feature(objc_arc)
        [pool drain];
#endif
        gFBOpenFiles[fileID].recordSize        = 256;     // default until fn OpenOutputSubStatement enhanced
        gFBOpenFiles[fileID].linePos           = 0;       // 20080131
        gFBOpenFiles[fileID].fileDescriptor = myFD;
        gFBOpenFiles[fileID].fileOpenMode   = 'O';
    } else {
        CFStringRef s1 = (__bridge CFStringRef)NSLocalizedStringFromTable( @"Error in FBOpenOutput for file# ", @"Runtime", @"FBOpenOutput" );
        CFStringRef e1 = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%d"),s1,fileID );
        CFStringRef s2 = (__bridge CFStringRef)NSLocalizedStringFromTable( @"FileID must be in range 1 to ", @"Runtime", @"FBOpenOutput" );
        CFStringRef e2 = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%d"),s2,kMaxFBFiles - 1 );
        FBFullStop( e1, e2, false );
        CFRelease(e1);
        CFRelease(e2);
    }
Bail:
    FBCheckFileError( fileID, err );
}

void FBOpenRandom( const int fileID, void *filePathType, void *ptrToURL, SInt64 recLen, Boolean isOpenR )
{
    /*
     1) Open "R",2,@fs,reclen  or    Open "R",#2,@fs,reclen  or     Open "R",varName,@fs,reclen formats only
     Open "N" formats added rp:20091006
     
     Brian 20091201 -  bug #407 If the user data file does not exist and the user specified the FSSpec or CFURLRef version, the file is created.
     */
    
    OSStatus        err = fnOpnErr;
    CFURLRef        url;
    int             fd;
    char            fm;
    
    if ( fileID > 0 && fileID < kMaxFBFiles ) {
        
        if ( (long)filePathType == 0 ) {
            url = (CFURLRef)ptrToURL;
        } else {
            memmove( &url, ptrToURL, sizeof(CFURLRef) );
        }
        
        if ( FH_FileExistsAtPath( FH_URLGetPath( url ) ) == NO ) FH_BuildEmptyFile( url );
        
        if ( isOpenR ) fm = 'R'; else fm = 'N';
        
        err = FH_IsFileAvailable( url, &fm, &fd, fileID );
        if( err == noErr || err == EACCES ) {
            gFBOpenFiles[fileID].isOpen         = true;
            gFBOpenFiles[fileID].url            = (__bridge CFURLRef)[(__bridge NSURL *)url copy];   // make a copy so it is retained.
            gFBOpenFiles[fileID].savedOffset    = 0;
            gFBOpenFiles[fileID].recordSize     = recLen;
            gFBOpenFiles[fileID].linePos        = 0;  //20080131
            gFBOpenFiles[fileID].fileDescriptor = fd;
            gFBOpenFiles[fileID].fileOpenMode   = fm;
        }
    }
    // Bail: // commented out 20221020 bw
    FBCheckFileError( fileID, err );
}


void FBOpenAppend( const int fileID, void *filePathType, void *ptrToURL, SInt64 recLen )
{
    /*
     1) Open "A",2,@url
     2) Assumes data fork (i.e.  "I") and does not accept "ID" or "IR" for data/resource fork
     
     Only supports this syntax: open "A", fileID, [@]url
     */
    
    CFURLRef url;
    
    switch ( (long)filePathType ) {
        case 0:     // CFURLRef
            url = (CFURLRef)ptrToURL;
            if ( FH_FileExistsAtPath( FH_URLGetPath( url ) ) == NO ) { // if file does not exist, create it.
                FBOpenOutput( fileID, filePathType, (void *)url );
#if 1 // CFFILE_OPEN
                FBClose( fileID, NULL );
#else // CFFILE_OPEN
                FBClose( fileID );
#endif // CFFILE_OPEN
            }
            break;
        case 2:
        {                                                            // ptr to CFURLRef
            memmove( &url, ptrToURL, sizeof(CFURLRef) );
            if ( FH_FileExistsAtPath( FH_URLGetPath( url ) ) == NO ) { // if file does not exist, create it.
                FBOpenOutput( fileID, filePathType, &url );
#if 1 // CFFILE_OPEN
                FBClose( fileID, NULL );
#else // CFFILE_OPEN
                FBClose( fileID );
#endif // CFFILE_OPEN

            }
            break;
        }
        default: {
            CFStringRef s1 = (__bridge CFStringRef)NSLocalizedStringFromTable( @"Error in FBOpenAppend for file# ", @"Runtime", @"FBOpenAppend" );
            CFStringRef e1 = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%d"),s1,fileID );
            CFStringRef s2 = (__bridge CFStringRef)NSLocalizedStringFromTable( @"Only CFURLRefs can be used in FB OPEN statement", @"Runtime", @"FBOpenAppend" );
            CFStringRef e2 = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%d"),s2,kMaxFBFiles - 1 );
            FBFullStop( e1, e2, false );
            CFRelease(e1);
            CFRelease(e2);
        }
            break;
    }
    
    FBOpenRandom( fileID, filePathType, ptrToURL, recLen, true );
    OSStatus err = FH_SetFilePointerToEndOfFile( (__bridge NSURL *)gFBOpenFiles[fileID].url,  &(gFBOpenFiles[fileID].savedOffset) );
    FBCheckFileError( fileID, err );
}


void FBOpenInput( const int fileID, void *filePathType, void *ptrToURL, SInt64 recLen, __attribute__ ((unused)) Boolean isResourceOpen  )
{
    CFURLRef        url;
    OSStatus        err = noErr;
    int             myFD;
    char            fm = 'I';
    
    if ( fileID > 0 && fileID < kMaxFBFiles ) {
        switch ( (long)filePathType ) {
            case 2:                                                                // ptr to CFURLRef
                memmove( &url, ptrToURL, sizeof(CFURLRef) );
                break;
            case 0:     // CFURLRef
            default:
                url = (CFURLRef)ptrToURL;
                break;
        }
        //int openType = O_RDONLY ; // open with Read privilege
        //int myFD = TryUnixOpen( fileID, url, openType, &err );
                
        err = FH_IsFileAvailable( url, &fm, &myFD, fileID );
        if ( myFD < 0 ) err = EACCES;  // invalid fd is file not found. Brian 20180617
        
        //        require_noerr( err, Bail );
        __Require_noErr( err, Bail );// 20170926 bw
        
        gFBOpenFiles[fileID].isOpen         = true;
        gFBOpenFiles[fileID].url            = (__bridge CFURLRef)[(__bridge NSURL *)url copy];   // make a copy so it is retained.
        gFBOpenFiles[fileID].savedOffset    = 0;
        gFBOpenFiles[fileID].recordSize     = recLen;
        gFBOpenFiles[fileID].linePos        = 0;
        gFBOpenFiles[fileID].fileDescriptor = myFD;
        gFBOpenFiles[fileID].fileOpenMode   = 'I';
        
    } else {
        CFStringRef s1 = (__bridge CFStringRef)NSLocalizedStringFromTable( @"Error in FBOpenInput for file# ", @"Runtime", @"FBOpenInput" );
        CFStringRef e1 = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%d"),s1,fileID );
        CFStringRef s2 = (__bridge CFStringRef)NSLocalizedStringFromTable( @"FileID must be in range 1 to ", @"Runtime", @"FBOpenInput" );
        CFStringRef e2 = CFStringCreateWithFormat( kCFAllocatorDefault, NULL, CFSTR("%@%d"),s2,kMaxFBFiles - 1 );
        FBFullStop( e1, e2, false );
        CFRelease(e1);
        CFRelease(e2);
    }
Bail:
    FBCheckFileError( fileID, err );
}

#pragma mark - close
static void FBCloseOneFile_priv( int fileID )
{
    if ( gFBOpenFiles[fileID].pipeUNIX ) {           // UNIX
        pclose( gFBOpenFiles[fileID].pipeUNIX );
    } else if ( gFBOpenFiles[fileID].savedOffset ) {    // file
        //int lockError = 0;
        gFBLinePos = 0;
        //lockError = flock( gFBOpenFiles[fileID].fileDescriptor, LOCK_UN );   //    unlock file
        close( gFBOpenFiles[fileID].fileDescriptor );
        CFRelease( gFBOpenFiles[fileID].url );          // url retained when file was opened
        //[gFBOpenFiles[fileID].fh release];
    } else if ( gFBOpenFiles[fileID].fileDescriptor ) { // serial
        gFBLinePos = 0;
        close( gFBOpenFiles[fileID].fileDescriptor );
        free( gFBOpenFiles[fileID].buff );
    	//Brian 2024-Dec-18 CFMutableArrays created in FBInitSerialPorts() from OSX SerialIO.incl
        // When user's code issues an FB 'close' for the serial port, deallocate arrays and nil out pointer.
        // an FB "close all" works okay for the first close but subsequent closes would fail with nil
        // pointers for each of these CFMuatableArrays.
        if ( gFBSerialName != nil && gFBSerialInName != nil && gFBSerialOutName != nil ) {
            CFRelease( gFBSerialName );     gFBSerialName    = nil;
            CFRelease( gFBSerialInName );   gFBSerialInName  = nil;
            CFRelease( gFBSerialOutName );  gFBSerialOutName = nil;
        }
    }
    BlockZero( &gFBOpenFiles[fileID], sizeof( FBInfoForOpenFile ) );
}

#if 1 // CFFILE_OPEN

BOOL FBClose( long inFileID, NSError **err )
{
    if ( inFileID == 0 ) {          // close all
        BOOL flag = NO;
        if ( sFileObjects ) {
            NSArray *keys = [sFileObjects allKeys];
            for ( NSString *key in keys ) {
                FileObject *fileObj = sFileObjects[key];
                if ( fileObj ) {
                    if ( FileClose( inFileID, err ) ) {
                        flag = YES;// at least one file was closed
                    }
                }
            }
        }
        
        for ( inFileID = 1; inFileID < (kMaxFBFiles + kFBMaxSerialFiles); inFileID++ ) {
            FBCloseOneFile_priv ( inFileID );
        }
        
        return flag;
    } else {
        if ( FileClose( inFileID, err ) ) return YES;
        
        if ( inFileID >= -kFBMaxSerialFiles && inFileID < kMaxFBFiles ) {
            if ( inFileID < 0 ) inFileID = kMaxFBFiles - inFileID;
            FBCloseOneFile_priv( inFileID );
        }
    }
    
    return NO;
}

BOOL FBeof( long inFileID )
{
    BOOL result = YES;
    
    if ( sFileObjects ) {
        NSString *fileID = [NSString stringWithFormat:@"%ld",inFileID];
        FileObject *fileObj = sFileObjects[fileID];
        if ( fileObj ) {
            return fileObj.eof;
        }
    }
    
    if ( inFileID > 0 && inFileID < kMaxFBFiles && gFBOpenFiles[inFileID].isOpen ) {
        if ( gFBOpenFiles[inFileID].pipeUNIX ) {   // UNIX
            result = gFBOpenFiles[inFileID].eof;
        } else {                            // file
            if ( (UInt64)CurrentOffset( inFileID ) < FH_FileLength( (__bridge NSURL *)gFBOpenFiles[inFileID].url ) ) result = NO;
        }
    }
    return result;
}

#else // CFFILE_OPEN

void FBClose( int fileID )
{
    /*
     close fileID
     */
    if ( fileID == 0 ) {          // close all
        for ( fileID = 1; fileID < (kMaxFBFiles + kFBMaxSerialFiles); fileID++ ) {
            FBCloseOneFile_priv ( fileID );
        }
    } else if ( fileID >= -kFBMaxSerialFiles && fileID < kMaxFBFiles ) {
        if ( fileID < 0 ) fileID = kMaxFBFiles - fileID;
        FBCloseOneFile_priv( fileID );
    }
}

Boolean FBeof( int fileID ) //2024-Feb-16 Brian - make return value a Boolean instead of long.
{
    Boolean result = true; //2023-Dec-22 Brian
    
    if ( fileID > 0 && fileID < kMaxFBFiles && gFBOpenFiles[fileID].isOpen ) {
        if ( gFBOpenFiles[fileID].pipeUNIX ) {   // UNIX
            result = gFBOpenFiles[fileID].eof;
        } else    {                            // file
            if ( (UInt64)CurrentOffset( fileID ) < FH_FileLength( (__bridge NSURL *)gFBOpenFiles[fileID].url ) ) result = false;
        }
    }
    return result;
}

#endif // CFFILE_OPEN

#pragma mark - Enquiries / commands

SInt64 FBlof( int fileID, SInt64 recLen ) {
    SInt64 size = 0;
    int serialPortID;
    
    if ( fileID > 0 && fileID < kMaxFBFiles ) {
        //if ( noErr != FSGetForkSize( gFBOpenFiles[fileID].fileDescriptor, &size ) ) { size = 0; }
        //size = FH_FileLength( gFBOpenFiles[fileID].fileDescriptor );
        size = FH_FileLength( (__bridge NSURL *)gFBOpenFiles[fileID].url );
        
    } else if ( fileID < 0 && fileID >= -kFBMaxSerialFiles ) { // serial
        serialPortID = kMaxFBFiles - fileID;
        FBXSerialRead_Priv( serialPortID ); // grab any chars pending
        size = gFBOpenFiles[serialPortID].bytesInBuff;
    }
    return size/recLen;
}

void FBAppend( const int fileID )
{
    // FB 'append' statement
    OSStatus err = noErr;
    if ( gFBOpenFiles[fileID].fileOpenMode != 'I' )
        err = FH_SetFilePointerToEndOfFile( (__bridge NSURL *)gFBOpenFiles[fileID].url, &(gFBOpenFiles[fileID].savedOffset) );
    else
        err = wrPermErr;
    
    FBCheckFileError( fileID, err );
}

void FBRecord( const int fileID, SInt64 recNum, SInt64 posInRec )
{
    /*
     Record [#]fileID, recordNum [,positionInRecord]
     */
    OSStatus err  = noErr;
    NSError  *fhError = nil;
    if ( fileID > 0 && fileID < kMaxFBFiles ) {
        // calculate new file position and store in global record
        gFBOpenFiles[fileID].savedOffset = recNum * gFBOpenFiles[fileID].recordSize + posInRec;
#if !__has_feature(objc_arc)
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
#endif
        NSFileHandle *fh = [NSFileHandle fileHandleForReadingFromURL:(__bridge NSURL *)gFBOpenFiles[fileID].url error:&fhError];
        [fh seekToFileOffset:gFBOpenFiles[fileID].savedOffset];
#if !__has_feature(objc_arc)
        [pool drain];
#endif
    }
    
    // File is not extended automatically by Record. User will have to check file length before using Record
    
    FBCheckFileError( fileID, err );
}

SInt64 CurrentOffset( int fileID )
{
    SInt64 position = 0;
    if ( fileID > 0 && fileID < kMaxFBFiles && gFBOpenFiles[fileID].isOpen ) {
        position = gFBOpenFiles[fileID].savedOffset;
    }
    return position;
}

// returns current offset in file divided by the record size used in the FB Open statement
SInt64 FBrec( int fileID )// FB 'rec' statement
{ return CurrentOffset( fileID )/gFBOpenFiles[fileID].recordSize; }

SInt64 FBloc( int fileID )// FB 'loc' function
{ return CurrentOffset( fileID ) % gFBOpenFiles[fileID].recordSize; }


#pragma mark - Read
void FBLineInputHash( int fileID, StringPtr s )
{
    /*
     line input #fileID, stringVar$
     */
    long            len;
    signed char        theChar;
    Boolean            eol;
    OSStatus        err = noErr;
    
    *(char*)s = 0; // null string if error
    
    if ( fileID < 0 )  { // serial
        do {
            ByteCount bytesRead = FBReadFile( fileID, &theChar, false, 1 ); //2022-Jan-10 Brian
            if ( bytesRead == 0 ) break;
            if ( theChar != 13  ) {
                s[0]++;
                s[s[0]] = theChar;
            }
        }
        while ( theChar != 13 && s[0] < 255 );
    } else {
        if ( fileID > 0 && fileID < kMaxFBFiles ) { // UNIX or file
            if (gFBOpenFiles[fileID].pipeUNIX) { // UNIX
                eol = false;
                len = 0;
                do {
                    theChar = fgetc( gFBOpenFiles[fileID].pipeUNIX );
                    switch ( theChar ) {
                        case 10:
                        case 13:
                            eol = true;
                            break;
                        case EOF:
                            eol = true;
                            gFBOpenFiles[fileID].eof = true; //2023-Dec-22 Brian
                            break;
                        default:
                            len++;
                            s[len] = theChar;
                    }
                }
                while ( eol == false && len < 255 );
                s[0] = len;
            } else {                                    // file
                if ( gFBOpenFiles[fileID].url ) {
                    
                    unsigned char    ch;
                    UInt64    count = 0;
                    UInt64 fileSize = FH_FileLength( (__bridge NSURL *)gFBOpenFiles[fileID].url ); //2024-Feb-16 Brian
                    do {
                        //err = FSReadFork( gFBOpenFiles[fileID].savedOffset, fsAtMark + pleaseCacheMask, 0, 1, &ch, NULL );  // 0,1 means start at position zero and read 1 byte
                        
                        err =  FH_ReadChar( &gFBOpenFiles[fileID].savedOffset, &ch, (__bridge NSURL *)gFBOpenFiles[fileID].url ); //
                        if ( err ) break;
                        count++;
                        *(char*)(s + count) = ch;
                        //#define LINE_INPUT_TERMINATED_BY_LINEFEED 1
                        //#if LINE_INPUT_TERMINATED_BY_LINEFEED
                    } while ( count < 255 && ch != 13 && ch != 10 && count < fileSize); //2024-Feb-16 Brian
                    
                    if ( !err && (ch == 13 || ch == 10) ) { count--; } // strip <cr> or <lf>
                    //#else
                    //} while ( count < 255 && ch != 13 );
                    //if ( !err && ch == 13 ) { count--; }            // strip <cr>
                    //#endif
                    *(char*)s = count;                                // length byte
                    if ( count && (err == eofErr) ) err = noErr;    // if we read any char at all, don't signal eof error
                } else {
                    err = fnOpnErr; //  file not open
                }
            }
        }
    }
    FBCheckFileError( fileID, err );
}

static OSStatus FBReadFile_Priv( const int fileID, void *dest, UInt64 numBytesRequested, UInt64 * numBytesRead ) //2023-Apr-26 Brian
{
    OSStatus        err = noErr;
    int                serialPortID;
    
    *numBytesRead = 0; // default if error
    if ( fileID > 0 && fileID < kMaxFBFiles )  {   // disk file
        if ( gFBOpenFiles[fileID].isOpen ) {
            FH_ReadFile( dest, numBytesRequested, &(gFBOpenFiles[fileID].savedOffset),(__bridge NSURL *)gFBOpenFiles[fileID].url );
            *numBytesRead = numBytesRequested;
        } else {
            err = fnOpnErr; }
    }
    
    else if ( fileID < 0 && fileID >= -kFBMaxSerialFiles ) {   // serial
        serialPortID = kMaxFBFiles - fileID;
        if ( gFBOpenFiles[serialPortID].isOpen ) {
            FBXSerialRead_Priv( serialPortID );
            if ( gFBOpenFiles[serialPortID].bytesInBuff >= numBytesRequested ) {
                memmove( dest, gFBOpenFiles[serialPortID].buff, numBytesRequested ); // copy from serial buffer to dest
                
                gFBOpenFiles[serialPortID].bytesInBuff -= numBytesRequested;
                memmove( gFBOpenFiles[serialPortID].buff, gFBOpenFiles[serialPortID].buff + numBytesRequested, gFBOpenFiles[serialPortID].bytesInBuff ); // 'left-justify' buffer contents
                
                *numBytesRead = numBytesRequested;
            } else {
                err = eofErr;  // asked for too many
            }
        } else {
            err = fnOpnErr;
        }
    }
    return err;
}

UInt64 FBReadFile( const int fileID, void * dest, Boolean isInputHashString, UInt64 numBytesRequested ) //2023-Apr-26 Brian
{
    UInt64 numBytesRead; //2023-Apr-26 Brian
    
    if ( isInputHashString && (numBytesRequested == 0) ) numBytesRequested = 1; // read #serialPort, s$; 0   behaves like  inkey$( serialPort )
    OSStatus err = FBReadFile_Priv( fileID, dest, numBytesRequested, &numBytesRead );
    if ( isInputHashString == false ) FBCheckFileError( fileID, err );
    return numBytesRead;
}

StringPtr FBInkeyFromFile( const int fileID )
{
    // inkey$() return 1 character on success, null string if failure; failure is silent
    UInt64 numBytesRead; //2023-Apr-26 Brian
    
    FBReadFile_Priv( fileID, &gReturnedString[1], 1, &numBytesRead );
    gReturnedString[0] = numBytesRead;
    return gReturnedString;
}

/*
 read# numeric var    big-endian on disk
 */
short FBReadSwapShort( const unsigned fileID )
{
    short myShort;
    FBReadFile( fileID, &myShort, false, 2 );
    return CFSwapInt16BigToHost( myShort );
}


/*
 In 64-bit enviroments a type 'long' is 8 bytes and not 4.
 This code hard codes the types size as '4' which corresponds to a 'long' in a 32-bit environment.
 Assuming a 64-bit environment and I'm removing the CFSwapInt32 call.
 Also changing the '4' hardcode to sizeof( int ). Note: type 'int' is 4 bytes in a 64-bit environment
 
 */
int FBReadSwapInt( const unsigned fileID ) { //2024-Jul-31 Brian
    //int FBReadSwapLong( const unsigned fileID ) {
    int myFourByteInt = 0;
    FBReadFile( fileID, &myFourByteInt, false, sizeof( int ) );
    return myFourByteInt; //2024-Jul-31 Brian
    //return CFSwapInt32BigToHost( myFourByteInt ); //2024-Jul-31 Brian //2022-Jan-10 Brian
}

long FBReadSwapLong( const unsigned fileID ) { //2023-Nov-15 Brian
    //int FBReadSwapLong( const unsigned fileID ) {
    long myEightByteInt;
    FBReadFile( fileID, &myEightByteInt, false, sizeof( long ) );
    return myEightByteInt;
    //return CFSwapInt32BigToHost( myLongVar ); //2022-Jan-10 Brian
}

float FBReadSwapSingle( const unsigned fileID )
{
    CFSwappedFloat32 myFloatSingle;
    FBReadFile( fileID, &myFloatSingle, false, sizeof( myFloatSingle ) );
    return CFConvertFloatSwappedToHost( myFloatSingle );
}

double FBReadSwapDouble( const unsigned fileID )
{
    CFSwappedFloat64 myDouble;
    FBReadFile( fileID, &myDouble, false, sizeof( myDouble ) );
    return CFConvertDoubleSwappedToHost( myDouble );
}


static SInt64 FBStringToSInt64( ConstStr255Param s )
{ return (SInt64)PSval( PSstrcpy( STACK_PUSH(), s ) ); }


void FBParseInput( const short  varType, void * vPtr )
{
    void *            textPtr = &gFBLineBuf;
    UInt32            linePos = gFBLinePos; //2022-Jan-10 Brian
    Str255            parsedStr;
    
    PSstrcpy( parsedStr, "\p" );
    while ( (-(linePos <= *(unsigned char*)(textPtr) ) & ( ((-(*(unsigned char*)(textPtr + linePos) == (unsigned char)' ' ) | ( -(*(unsigned char*)(textPtr + linePos) == 9 ) ) )) ) ) )
    {
        linePos++;
    }
    if ( -(*(unsigned char*)(textPtr + linePos) == PSasc( PSstrcpy( STACK_PUSH(), "\p\"" ) ) ) )
    {
        linePos++;
        while ( (-(linePos <= *(unsigned char*)(textPtr) ) & ( -(*(unsigned char*)(textPtr + linePos) != PSasc( PSstrcpy( STACK_PUSH(), "\p\"" ) ) ) ) ) )
        {
            PSstrcpy( TO_STACK, parsedStr );
            PSstrcat( TO_STACK, PSstring( 1, *(unsigned char*)(textPtr + linePos) ));
            PSstrcpy( parsedStr, TO_STACK );
            linePos++;
        }
        if ( (-(linePos <= *(unsigned char*)(textPtr) ) & ( -(*(unsigned char*)(textPtr + linePos) == PSasc( PSstrcpy( STACK_PUSH(), "\p\"" ) ) ) ) ) )
        {
            linePos++;
        }
    } else {
        while ( (-(linePos <= *(unsigned char*)(textPtr) ) & ( (-(*(unsigned char*)(textPtr + linePos) != (unsigned char)',' ) & ( -(*(unsigned char*)(textPtr + linePos) != 9 ) ) ) ) ) )
        {
            PSstrcpy( TO_STACK, parsedStr );
            PSstrcat( TO_STACK, PSstring( 1, *(unsigned char*)(textPtr + linePos)  ));
            PSstrcpy( parsedStr, TO_STACK );
            linePos++;
        }
    }
    while ( (-(linePos <= *(unsigned char*)(textPtr) ) & ( ((-(*(unsigned char*)(textPtr + linePos) == (unsigned char)' ' ) | ( (-(*(unsigned char*)(textPtr + linePos) == 9 ) | ( -(*(unsigned char*)(textPtr + linePos) == 13 ) ) ) ) )) ) ) )
    {
        linePos++;
    }
    if ( (-(linePos <= *(unsigned char*)(textPtr) ) & ( -(*(unsigned char*)(textPtr + linePos) == (unsigned char)',' ) ) ) ) {
        linePos++;
    }
    
    // varTypes coded in InitCTypetable ( an abbreviated version in this file too )
    switch( varType ) {
        case longVarType:
        case fixedVarType:
        case unsignedLongVarType:
            *(SInt32*)vPtr = (SInt32)FBStringToSInt64( parsedStr );
            break;
        case shortVarType:
        case unsignedShortVarType:
            *(SInt16*)vPtr = (SInt16)FBStringToSInt64( parsedStr );
            break;
        case byteVarType:
        case unsignedByteVarType:
        case booleanVarType:
            *(SInt8*)vPtr = (SInt8)FBStringToSInt64( parsedStr );
            break;
        case UInt64VarType:
        case SInt64VarType:
            *(SInt64*)vPtr = FBStringToSInt64( parsedStr );
            break;
        case singleVarType:  // floats/singles
            *(float*)vPtr = PSval( PSstrcpy( STACK_PUSH(), parsedStr ) );
            break;
        case doubleVarType:
            *(double*)vPtr = PSval( PSstrcpy( STACK_PUSH(), parsedStr ) );
            break;
        case ldoubleVarType:
            *(long double*)vPtr = PSval( PSstrcpy( STACK_PUSH(), parsedStr ) );
            break;
        case containerVarType:
            CtnrStoreString( (void **)vPtr, parsedStr );
            break;
        default:
            if ( varType >= 17 && varType <= 144 ) { // _str1VarType to _str255VarType
                PSstrcpy( (StringPtr)vPtr, parsedStr );
            }
            break;
    }
    gFBLinePos = linePos;
}


void FBToCInputFile( const int fileID, void *target, short varType )
{
    UInt32 lastDevice;
    lastDevice = gFBLineDev;
    gFBLineDev = fileID;
    
    if ( fileID ) {
        if ( lastDevice != gFBLineDev || gFBLinePos == 0 || gFBLinePos > gFBLineBuf[0] ) {
            gFBLinePos = 1;
            FBLineInputHash( fileID, (StringPtr)&gFBLineBuf );
        }
    }
    FBParseInput( varType, target );
}

static ssize_t FBXSerialRead_Priv( const int serialPortID )
{
    // regarding 'read': the returned count of bytes read is mostly ignored by callers. Changing bytesRead var to same type required by 'read' //2022-Jan-11 Brian
    ssize_t bytesRead = read( gFBOpenFiles[serialPortID].fileDescriptor, gFBOpenFiles[serialPortID].buff + gFBOpenFiles[serialPortID].bytesInBuff, gFBOpenFiles[serialPortID].buffSize - gFBOpenFiles[serialPortID].bytesInBuff );
    gFBOpenFiles[serialPortID].bytesInBuff += bytesRead;
    return bytesRead;
}



void FBReadString( int fileID, void *dest, UInt64 numBytesRequested ) //2023-Apr-26 Brian
{
    // read #fileID, s; numBytes
    OSStatus    err;
    UInt64    numBytesRead; //2023-Apr-26 Brian
    
    *(char*)dest = 0;
    if ( (numBytesRequested == 0) && (FBlof( fileID, 1 ) > 0) ) numBytesRequested = 1; // read #fileID, s; 0  used to poll serial port
    
    if ( numBytesRequested ) {
        err = FBReadFile_Priv( fileID, dest + 1, numBytesRequested, &numBytesRead );
        *(char*)dest= numBytesRead; // set caller's pascal length byte
        FBCheckFileError( fileID, err );
    }
}



////////////////////////////////////
#pragma mark - Output
////////////////////////////////////
#if 1 // CFFILE_OPEN

BOOL FBWriteFile( const int fileID, void *src, SInt64 numBytes, NSError **err ) __attribute__ ((noinline));
BOOL FBWriteFile( const int fileID, void *src, SInt64 numBytes, NSError **err )
{
    if ( numBytes == kFBParamMissing ) {
        return FileWrite( fileID, (CFStringRef)src, err );
    } else {
        // write file[#] deviceID, address&, numBytes&
        OSStatus err = noErr;
        
        if ( fileID > 0 && fileID < kMaxFBFiles ) { // disk file
            if ( gFBOpenFiles[fileID].isOpen && gFBOpenFiles[fileID].fileOpenMode != 'I' ) {
                gFBOpenFiles[fileID].savedOffset = FH_WriteFile( src , numBytes, gFBOpenFiles[fileID].savedOffset,(__bridge NSURL *)gFBOpenFiles[fileID].url );
            } else {
                err = wrPermErr;
            }
        } else if ( fileID < 0 && fileID >= -kFBMaxSerialFiles ) { // serial
            SInt64 bytesSent;
            
            int serialPortID = kMaxFBFiles - fileID;
            if ( gFBOpenFiles[serialPortID].isOpen ) {
                bytesSent = (SInt64)write( gFBOpenFiles[serialPortID].fileDescriptor, src, numBytes );  // 'man 2 write' for documentation
                if ( bytesSent != numBytes ) err = writErr;
                //free( p );
            } else {
                err = fnOpnErr;
            }
        }
        FBCheckFileError( fileID, err );
    }
    return NO;
}

void FBWriteString( const int fileID, char * src, ByteCount varLength ) __attribute__ ((noinline));
void FBWriteString( const int fileID, char * src, ByteCount varLength )
{
    /*
     write# stringVar[;length]
     */
    int         writeBytes = (int)varLength; //2022-Jan-10 Brian - safe because varLength can't be more than 255 for a pascal sting.
    int      lengthOfPstr = *(unsigned char*)src;  // picks off the leading length byte of the pascal string - Brian 20170113
    char     temp[256];
    OSStatus err = noErr;
    
    if ( gFBOpenFiles[fileID].isOpen && gFBOpenFiles[fileID].fileOpenMode != 'I' ) {
        if ( writeBytes > lengthOfPstr ) writeBytes = lengthOfPstr;
        FBWriteFile( fileID, src + 1, writeBytes, NULL );   // write the string sent
        
        // if necessary, pad the string to the length specified in the WRITE# statement. e.g. WRITE #1, stringVar;3   <<<<<== the '3' is passed to this function in varLength
        // e.g. if the string length provided in the WRITE# statement is longer than the string's actual length, this code pads to the string length provided.
        // So, if the string has 1 character in it ( s = "X" ) and WRITE# specifies more than one ( WRITE #1, string;3 ), it will be padded with 2 characters ( 2 + 1 = 3 )
        
        // Two rules cover the behavior:
        // (1) when the programmer-supplied varLength on the WRITE# statement is LESS than the string length, the string is truncated to the varLength.
        // (2) when the programmer-supplied varLength on the WRITE# statement is GREATER than the string length, the string is padded to the varLength with spaces.
        
        
        writeBytes = (int) varLength - lengthOfPstr; //2022-Jan-10 Brian - safe - see similar case on writeBytes above
        if ( writeBytes > 0 ) {
            if ( writeBytes > 255 ) writeBytes = 255;
            //CFMutableStringRef mutStr = CFStringCreateMutable(kCFAllocatorDefault, 0);
            for ( int i = 0; i < writeBytes; i++ ) {
                temp[i] = ' ';
                //CFStringAppend(mutStr, CFSTR(" ") );
            }
            //s = CFStringCreateWithBytes( NULL, &temp[0], writeBytes, kCFStringEncodingMacRoman, false );
            FBWriteFile( fileID, &temp[0], writeBytes, NULL );
        }
    } else {
        err = wrPermErr ;
    }
    FBCheckFileError( fileID, err );
}

#else // CFFILE_OPEN

void FBWriteFile( const int fileID, void * src, SInt64 numBytes ) __attribute__ ((noinline));
void FBWriteFile( const int fileID, void * src, SInt64 numBytes )
{
    // write file[#] deviceID, address&, numBytes&
    OSStatus err = noErr;
    
    if ( fileID > 0 && fileID < kMaxFBFiles ) { // disk file
        if ( gFBOpenFiles[fileID].isOpen && gFBOpenFiles[fileID].fileOpenMode != 'I' ) {
            gFBOpenFiles[fileID].savedOffset = FH_WriteFile( src , numBytes, gFBOpenFiles[fileID].savedOffset,(__bridge NSURL *)gFBOpenFiles[fileID].url );
        } else {
            err = wrPermErr;
        }
    } else if ( fileID < 0 && fileID >= -kFBMaxSerialFiles ) { // serial
        SInt64 bytesSent;
        
        int serialPortID = kMaxFBFiles - fileID;
        if ( gFBOpenFiles[serialPortID].isOpen ) {
            bytesSent = (SInt64)write( gFBOpenFiles[serialPortID].fileDescriptor, src, numBytes );  // 'man 2 write' for documentation
            if ( bytesSent != numBytes ) err = writErr;
            //free( p );
        } else {
            err = fnOpnErr;
        }
    }
    FBCheckFileError( fileID, err );
}

void FBWriteString( const int fileID, char * src, ByteCount varLength ) __attribute__ ((noinline));
void FBWriteString( const int fileID, char * src, ByteCount varLength )
{
    /*
     write# stringVar[;length]
     */
    int         writeBytes = (int)varLength; //2022-Jan-10 Brian - safe because varLength can't be more than 255 for a pascal sting.
    int      lengthOfPstr = *(unsigned char*)src;  // picks off the leading length byte of the pascal string - Brian 20170113
    char     temp[256];
    OSStatus err = noErr;
    
    if ( gFBOpenFiles[fileID].isOpen && gFBOpenFiles[fileID].fileOpenMode != 'I' ) {
        if ( writeBytes > lengthOfPstr ) writeBytes = lengthOfPstr;
        FBWriteFile( fileID, src + 1, writeBytes );   // write the string sent
        
        // if necessary, pad the string to the length specified in the WRITE# statement. e.g. WRITE #1, stringVar;3   <<<<<== the '3' is passed to this function in varLength
        // e.g. if the string length provided in the WRITE# statement is longer than the string's actual length, this code pads to the string length provided.
        // So, if the string has 1 character in it ( s = "X" ) and WRITE# specifies more than one ( WRITE #1, string;3 ), it will be padded with 2 characters ( 2 + 1 = 3 )
        
        // Two rules cover the behavior:
        // (1) when the programmer-supplied varLength on the WRITE# statement is LESS than the string length, the string is truncated to the varLength.
        // (2) when the programmer-supplied varLength on the WRITE# statement is GREATER than the string length, the string is padded to the varLength with spaces.
        
        
        writeBytes = (int) varLength - lengthOfPstr; //2022-Jan-10 Brian - safe - see similar case on writeBytes above
        if ( writeBytes > 0 ) {
            if ( writeBytes > 255 ) writeBytes = 255;
            //CFMutableStringRef mutStr = CFStringCreateMutable(kCFAllocatorDefault, 0);
            for ( int i = 0; i < writeBytes; i++ ) {
                temp[i] = ' ';
                //CFStringAppend(mutStr, CFSTR(" ") );
            }
            //s = CFStringCreateWithBytes( NULL, &temp[0], writeBytes, kCFStringEncodingMacRoman, false );
            FBWriteFile( fileID, &temp[0], writeBytes );
        }
    } else {
        err = wrPermErr ;
    }
    FBCheckFileError( fileID, err );
}

#endif // CFFILE_OPEN




/*
 write# numeric var    big-endian on disk
 */
#if 1 // CFFILE_OPEN

void FBWriteSwapShort( short myShort, const unsigned fileID )
{
    myShort = CFSwapInt16HostToBig( myShort );
    FBWriteFile( fileID, &myShort, 2, NULL );
}

void FBWriteSwapLong( long aLongVar, const unsigned fileID ) //2024-Jul-31 Brian
{
    //aLongVar = CFSwapInt32HostToBig( aLongVar );
    FBWriteFile( fileID, &aLongVar,  sizeof(long), NULL );  //2023-Feb-01 Brian //2022-Jan-10 Brian
    //FBWriteFile( fileID, &anIntVar, sizeof(UInt32) );
}

void FBWriteSwapInt( int anIntVar, const unsigned fileID ) //2024-Jul-31 Brian
{
    //anIntVar = CFSwapInt16BigToHost( anIntVar );
    FBWriteFile( fileID, &anIntVar,  sizeof(anIntVar), NULL );  //2024-Jul-31 Brian //2023-Feb-01 Brian //2022-Jan-10 Brian
    //FBWriteFile( fileID, &anIntVar, sizeof(UInt32) );
}

void FBWriteSwapSingle( float f, const unsigned fileID )
{
    CFSwappedFloat32 mySwappedFloat = CFConvertFloatHostToSwapped( f );
    FBWriteFile( fileID, &mySwappedFloat, sizeof( mySwappedFloat ), NULL );
}

void FBWriteSwapDouble( double d, const unsigned fileID )
{
    CFSwappedFloat64 mySwappedDouble = CFConvertDoubleHostToSwapped( d );
    FBWriteFile( fileID, &mySwappedDouble, sizeof( mySwappedDouble ), NULL );
}

void FBFilePrintChar( char  theChar )
{
    if ( theChar == 13) {
        gFBOpenFiles[gFBRoute].linePos = 0;
    } else {
        gFBOpenFiles[gFBRoute].linePos++;
    }
    gFBLastFilePos = gFBOpenFiles[gFBRoute].linePos;
    FBWriteFile( gFBRoute, &theChar, 1, NULL );
}

#else // CFFILE_OPEN

void FBWriteSwapShort( short myShort, const unsigned fileID )
{
    myShort = CFSwapInt16HostToBig( myShort );
    FBWriteFile( fileID, &myShort, 2 );
}

void FBWriteSwapLong( int aLongVar, const unsigned fileID )
{
    //aLongVar = CFSwapInt32HostToBig( aLongVar );
    //CFSwapInt32BigToHost
    FBWriteFile( fileID, &aLongVar,  sizeof(aLongVar) );  //2023-Feb-01 Brian //2022-Jan-10 Brian
    //FBWriteFile( fileID, &anIntVar, sizeof(UInt32) );
}

void FBWriteSwapSingle( float f, const unsigned fileID )
{
    CFSwappedFloat32 mySwappedFloat = CFConvertFloatHostToSwapped( f );
    FBWriteFile( fileID, &mySwappedFloat, sizeof( mySwappedFloat ) );
}

void FBWriteSwapDouble( double d, const unsigned fileID )
{
    CFSwappedFloat64 mySwappedDouble = CFConvertDoubleHostToSwapped( d );
    FBWriteFile( fileID, &mySwappedDouble, sizeof( mySwappedDouble ) );
}

void FBFilePrintChar( char  theChar )
{
    if ( theChar == 13) {
        gFBOpenFiles[gFBRoute].linePos = 0;
    } else {
        gFBOpenFiles[gFBRoute].linePos++;
    }
    gFBLastFilePos = gFBOpenFiles[gFBRoute].linePos;
    FBWriteFile( gFBRoute, &theChar, 1 );
}

#endif // CFFILE_OPEN

SInt64 FBFileGetPos( void )
{ return gFBLastFilePos; }


void FBFilePrintTab( void )
{
    int             spaceCount;
    int             i;
    
    if ( gFBFileTabMode ) {
        FBFilePrintChar( gFBFileTabMode );
    } else {
        spaceCount = gFBTabWidth - (gFBOpenFiles[gFBRoute].linePos % gFBTabWidth);
        if ( spaceCount < 100 ) {
            for ( i = 0; i < spaceCount; i++ ) { FBFilePrintChar( 32 ); }
        }
    }
}


void FBFilePrintCR( void )
{ FBFilePrintChar( 13 ); }

#if 1 // CFFILE_OPEN

void FBFilePrintString( Str255  s_p )
{
    Str255 s;  PSstrcpy( s, s_p );
    gFBStk -= 1;
    gFBOpenFiles[gFBRoute].linePos += s[0];
    gFBLastFilePos = gFBOpenFiles[gFBRoute].linePos;
    FBWriteFile( gFBRoute, (void*)&s + 1, s[0], NULL );
}

#else // CFFILE_OPEN

void FBFilePrintString( Str255  s_p )
{
    Str255 s;  PSstrcpy( s, s_p );
    gFBStk -= 1;
    gFBOpenFiles[gFBRoute].linePos += s[0];
    gFBLastFilePos = gFBOpenFiles[gFBRoute].linePos;
    FBWriteFile( gFBRoute, (void*)&s + 1, s[0] );
}

#endif // CFFILE_OPEN



////////////////////////////////////
#pragma mark - Misc stuff
////////////////////////////////////

void FBSetOpenType( Str15  opentype_p )
{
    Str255 opentype;  PSstrcpy( opentype, opentype_p );
    gFBStk -= 1;
    UInt8             j;
    if ( opentype[0] == 0 ) {  // 20170611 bw
        gFBSaveType = 0;
        gFBSaveCreator = 0;
    } else {     // bail remainder of function if opentype[0] == 0    Brian 20170611
        if ( opentype[0] >= 4 ) {
            gFBSaveType = 0;
            j = 1;
            do {
                gFBSaveType = gFBSaveType << 8;
                gFBSaveType += opentype[j];
                j++;
            }
            while ( j <= 4 );
        }
        if ( opentype[0] >= 8 ) {
            gFBSaveCreator = 0;
            j = 5;
            do {
                gFBSaveCreator = gFBSaveCreator << 8;
                gFBSaveCreator += opentype[j];
                j++;
            }
            while ( j <= 8 );
        }
    }
}

#if 1 // RENAME_KILL_SYNTAX

BOOL FBRename( CFURLRef oldURL, CFURLRef newURL, NSError **err )
{
    NSError *error = nil;
    BOOL result =  [[NSFileManager defaultManager] moveItemAtURL:(__bridge NSURL * )oldURL
                                            toURL:(__bridge NSURL * )newURL
                                            error:&error];
    if ( err ) *err = error;
    return result;
}

BOOL FBKill( CFURLRef url, NSError **err )
{
    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager] removeItemAtURL:(__bridge NSURL *)url error:&error];
    if ( err ) *err = error;
    return result;
}

#else // RENAME_KILL_SYNTAX

void FBRename( CFURLRef oldName, CFURLRef newName  )
{
    [[NSFileManager defaultManager] moveItemAtURL:(__bridge NSURL * )oldName
                                            toURL:(__bridge NSURL * )newName
                                            error: nil];
}

void FBKill( CFURLRef fileName )
{ [[NSFileManager defaultManager] removeItemAtURL:(__bridge NSURL *)fileName error:nil]; }

#endif // RENAME_KILL_SYNTAX



//////////////////////////////////////////
#pragma mark - CFURLRef helpers
//////////////////////////////////////////

void CopyNameFromCFURLRef( CFURLRef url, CFStringRef * string )
{ *string = (__bridge CFStringRef)[[(__bridge NSURL *)url lastPathComponent]copy]; }

void GetNameAsPascalStringFromCFURLRef( CFURLRef url, Str255 *name )
{
    CFStringRef string;
    
    CopyNameFromCFURLRef( url, &string );
    CFStringGetPascalString( string, *name, 256, kCFStringEncodingMacRoman );
    CFRelease( string );
    //if ( CFURLGetFSRef( url, &ref ) ) GetNameAsPascalStringFromFSRef( &ref, name );
}

