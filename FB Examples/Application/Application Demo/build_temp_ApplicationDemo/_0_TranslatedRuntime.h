#import <AppKit/AppKit.h>
#import "FBtoC.h"
#import "Runtime.h"
#import "AppThings.h"

///////////////////////////////////////////////////
//  prototypes + translated #defines and records //
///////////////////////////////////////////////////
 
#if MAC_OS_X_VERSION_10_4 >= MAC_OS_X_VERSION_MAX_ALLOWED
typedef UInt32 URefCon;
typedef SInt32 SRefCon;
#endif
long  FBInstallAEHandler( AEEventClass aeClass, AEEventID aeType, void* aeProc, SRefCon x, Boolean y ) 
;


typedef struct  __attribute__ ((__packed__)) 	CFSTRRec
{
  CFStringRef         cfStr;
  Str255              s;
} CFSTRRec;
long  FBPStr2CStr( void* strPtr ) 
;
long  FBCStr2PStr( void* strPtr ) 
;
extern SInt8             gFBUpperChar[256]; 
extern SInt8             gFBLowerChar[256]; 
long  InitFBGlobals( void ) 
;


typedef Handle 		THPrint;
 
#import <malloc/malloc.h>
#import <sys/ioctl.h>
#import <sys/fcntl.h>
#import <stdio.h>
extern CFBundleRef       gSysBundle; 
CFBundleRef  CreateBundleForFramework( Str255 framework_p ) 
;
void*  GetMachFunctionFromBundle( void* bndl, Str255 name_p ) 
;
void  DynamicClear( UInt8 dynArrayNum ) 
;
long  DynamicNextElement( UInt8 array ) 
;
long  DynamicRemoveItems( SInt32 dynArrayNum, long first, long howMany, void* savePtr ) 
;
long  DynamicInsertItems( SInt32 dynArrayNum, long where, long howMany, void* fillPtr ) 
;


typedef double 		FB_double;
  enum { dispatchPriorityDefault = 0 }; 
/// THIS NEEDS TO BE REMOVED ONCE THE .c and .m runtime is updated. Used in routeToBuffer  Brian 20190917

//////def _DEFINEDINCRUNTIME ///////

  enum { dispatchPriorityBackground = -32768 }; 
  enum { dispatchPriorityHigh = 2 }; 
  enum { dispatchPriorityLow = -2 }; 
void  BlockFill( void* address, unsigned long bytes, long byteVal ) 
;
void  LongBlockFill( void* address, unsigned long bytes, long byteVal ) 
;
void  TRUNCATE( void* StrPtr ) 
;
long  roundUp( double f ) 
;
long  roundDown( double f ) 
;
void  LCASE( void* sPtr ) 
;


typedef void* 		va_List;
 
#define va_List va_list
#define va_Start( ap, lastArg ) va_start( ap, lastArg )
#define va_Copy( ap2, ap1 ) va_copy( ap2, ap1 )
#define va_End( ap ) va_end( ap )
#define va_ArgInt32( ap ) va_arg( ap, int )
#define va_ArgInt64( ap ) va_arg( ap, SInt64 )
#define va_ArgLong( ap ) va_arg( ap, long )
#define va_ArgDouble( ap ) va_arg( ap, double )
#define va_ArgObj( ap ) va_arg( ap, CFTypeRef )
 
#define nsUserName()(__bridge CFStringRef)NSUserName()
#define nsFullUserName()(__bridge CFStringRef)NSFullUserName()
#define nsHomeDirectory()(__bridge CFStringRef)NSHomeDirectory()
#define nsHomeDirectoryForUser( userName )(__bridge CFStringRef)NSHomeDirectoryForUser((__bridge NSString *)userName )
#define nsTemporaryDirectory()(__bridge CFStringRef)NSTemporaryDirectory()
#define nsOpenStepRootDirectory()(__bridge CFStringRef)NSOpenStepRootDirectory()
 






#define nsDecimalString( dcm, locale )(__bridge CFStringRef)NSDecimalString( dcm,(NSLocale *)locale )	
NSDecimal NSDecimalWithString( CFStringRef string );
CFCharacterSetRef  CharacterSetPuntuationSet( void ) 
;
CFMutableCharacterSetRef  MutableCharacterSetPuntuationSet( void ) 
;
 
#define nsFileTypeForHFSTypeCode( hfsFileTypeCode )(__bridge CFStringRef)NSFileTypeForHFSTypeCode( hfsFileTypeCode )
#define nsHFSTypeCodeFromFileType( fileTypeString ) NSHFSTypeCodeFromFileType((__bridge NSString *)fileTypeString )
CFStringRef nsHFSTypeOfFileAtURL( CFURLRef url );
CFStringRef  StringWithPascalString( Str255 s_p ) 
;
StringPtr StringPascalString( CFStringRef string ) 
;
 

#import "QLFilePreviewRequest.h"
 
#import "QLPreviewingController.h"
 
#import "QLPreviewItem.h"
 
#import "QLPreviewPanel.h"
 
#import "QLPreviewProvider.h"
 
#import "QLPreviewReply.h"
 
#import "QLPreviewView.h"
 











#define kIOSerialBSDServiceValue @"IOSerialBSDClient"
#define kIOSerialBSDTypeKey @"IOSerialBSDClientType"
#define kIOSerialBSDAllTypes @"IOSerialStream"
#define kIOSerialBSDModemType @"IOModemSerialStream"
#define kIOSerialBSDRS232Type @"IORS232SerialStream"
#define kIOTTYDeviceKey @"IOTTYDevice"
#define kIOCalloutDeviceKey @"IOCalloutDevice"
  enum { MACHPORTNULL = 0 }; 
  enum { KERNSUCCESS = 0 }; 
  enum { KERNFAILURE = 5 }; 
 
CFMutableDictionaryRef ioServiceMatching( CFStringRef name );
long  FBXInitBSDSystemFramework( void ) 
;
long  e_xit( SInt32 status ) 
;
extern UInt16            gFBSerialPortCount; 
extern CFMutableArrayRef gFBSerialName; 
extern CFMutableArrayRef gFBSerialInName; 
extern CFMutableArrayRef gFBSerialOutName; 
extern Boolean           gOSXSerialInited; 
long  FBXSerialGetSerialIterator( io_iterator_t * matchingServices ) 
;
long  FBXSerialGetCountAndNames( io_iterator_t serialPortIterator ) 
;
long  FBXSerialSetBaud( termios * options, long speed ) 
;
long  FBXOpenSerialPort( CFStringRef path, long speed, long parity, long stopBits, long charSize, termios * origOptions ) 
;
long  FBXHandShake( SInt16 fileDescriptor, long controlMode ) 
;
long  FBInitSerialPorts( void ) 
;
long  FBSerialOpen( long fileRef, long baudRate, long parity, long stopBits, long charSize, long buffSize ) 
;
long  FBHandShake( long fileRef, long flags ) 
;
long  TermGetStatus( long fileRef ) 
;


