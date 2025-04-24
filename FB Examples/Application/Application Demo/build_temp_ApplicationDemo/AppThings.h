
void FBFullStop( CFStringRef msg, CFStringRef info, Boolean fatal ); //2023-Dec-22 Brian changed to Boolean

void PrintCR( void );
void FBRoute( int where );
void FBPrintString( Str255  s );

///////////////////////////////////////////////////
//             AppleEvents //
///////////////////////////////////////////////////
OSErr FBAEHandleQuit( AppleEvent __attribute__ ((__unused__)) *theAppleEvent, AppleEvent __attribute__ ((__unused__)) *reply, long __attribute__ ((__unused__))  myAEFlags );
void FBInitAEEvents( void );

///////////////////////////////////////////////////
//            HandleEvents emulation             //
///////////////////////////////////////////////////
void FBHandleEvents( void );

///////////////////////////////////////////////////
//          print to window/file                 //
///////////////////////////////////////////////////
void FBAddLeadingSpace( char * sPtr );
void PrintLong( const SInt64 theNumber, NSString *nextArg );
void PrintFloat( const double  d, NSString *nextArg );
void PrintTab( __attribute__ ((unused)) long tabs );
void PrintSpc( long spc, NSString *nextArg );
void PrintContainerWnd( void  **ctnrVarPtr );


long Pos( long device );
void RuntimeErrMsg( StringPtr  msg );
void FBStopMsg( ConstStr255Param msg_p, const int  lineNumber );
void FBShutdown( void *msgPtr, Boolean cfType );
void FBReportRangeError( const int  value, const int  lineNumber, const int  limit, CFStringRef fileName );


