
//#ifndef RUNTIME_H
//#define RUNTIME_H

// Dev flags
#define kNSFBFullStop 1

enum { myCommandOneMegBuffSize = 1048576};   //2023-Aug-11 Brian - most commands won't return 1k, so this should be sufficient size
/* temp_includes.c */
//
// gFBStrStk size increased ( to 127 )to bypass bug that causes crash when memmove() overwrites another var's contents. Brian 20160514
//
extern Str255 gFBStrStk[64];
extern SInt16 gFBStk;
extern Str255 gReturnedString;
extern Str255 gFBTStk[16];
extern SInt8 gFBTStkP;
extern UInt8 gPSDefStrSize;

#if SILENCE_CLANG_WARNINGS
extern int gPSDefTabStops;
#else // SILENCE_CLANG_WARNINGS
extern UInt8 gPSDefTabStops;
#endif // SILENCE_CLANG_WARNINGS

extern Boolean gFBLeadingSpace;
extern UInt16 gFBPrintPos;
extern char gFBUsingSymbols[4];
extern UInt32 gFBNextData;

#if USE_SJLJ_FOR_GOSUB_RETURN // see _useSJLJForGosubReturn in FBtoC source
extern jmp_buf gReturnEnv[1024];
#else
extern UInt16 gReturnLabelNum[1024];
#endif

extern UInt16 gReturnLevel;
extern long gSelectL[10];
extern double gSelectD[10];
extern Str255 gSelectS[10];
extern CFTypeRef gSelectCF[10];

extern OSStatus gFBSysError;
extern volatile Boolean gFBSndBusy; //2023-Dec-22 Brian
extern DynArrayInfo gFBDynArrayInfo[64];
extern void *gFBTempContainer;
extern void *gFBTemp2Container;

extern long   gFBFileError;
extern OSType gFBSaveType;
extern OSType gFBSaveCreator;
extern Str255 gFBLineBuf;
extern UInt32 gFBLineDev;
extern UInt32 gFBLinePos;
extern SInt64 gFBLastFilePos;
extern char gFBFileTabMode;
extern UInt16 gFBTabWidth;

extern FBInfoForOpenFile gFBOpenFiles[kMaxFBFiles + kFBMaxSerialFiles];

extern FBOnXxxxxVector gFBOnErrorVector;
extern CFMutableArrayRef gFBIndex[9 + 1];

extern unsigned char gFBFloatMaxDigits;
extern long gFBWidth;
extern int  gFBRoute;
extern const Boolean gNumberLeadingSpace;

extern Handle gFBBuffer[6];

extern const UInt32 kFBEFFilter;
extern Str1 gFBTEKey;
extern FBOnXxxxxVector gFBOnEditVector;
/* temp_includes.c */
StringPtr PSltrl(char *inCString, char *commentForGenstrings);
StringPtr PSltrr(char *inCString, char *commentForGenstrings);
void DebugPrintStackLevel(void);
void FBKillDynamicArray(const int dynArrayNum);
void FBGrowDynamicArray(const int dynArrayNum, const long index); //2023-Nov-15 Brian
void FBWriteDynamic(int fileRef, int dynArrayNum);
void FBReadDynamic(int fileRef, int dynArrayNum);
void FBSwap(void *p1, void *p2, const int bytes);
StringPtr PScstr(Str255 s);
StringPtr CSpstr(char *s);
void PSinput( StringPtr s );

StringPtr STACK_PUSH( void ); // replacement for STACK_PUSH macro Brian 20160515

StringPtr PSstrcpy(StringPtr dest, ConstStr255Param source);

#if SILENCE_CLANG_WARNINGS
StringPtr PSstrcpyn(StringPtr dest, ConstStr255Param source, const unsigned char destSize);
#else // SILENCE_CLANG_WARNINGS
StringPtr PSstrcpyn(StringPtr dest, ConstStr255Param source, const int destSize);
#endif // SILENCE_CLANG_WARNINGS

StringPtr PSstrcat( StringPtr dest, ConstStr255Param appendStr);

#if SILENCE_CLANG_WARNINGS
StringPtr PSstrcatn(StringPtr dest, ConstStr255Param source, const unsigned char destSize);
#else // SILENCE_CLANG_WARNINGS
StringPtr PSstrcatn(StringPtr dest, ConstStr255Param source, const int destSize);
#endif // SILENCE_CLANG_WARNINGS

void PSdeftab(const int tabstops);
void FBDefUsing(const SInt32 formatchars);
StringPtr PSusing(Str255 format, const double n);

CFStringRef CFUsing( CFStringRef format, double n );

StringPtr PSleft(ConstStr255Param s, SInt16 n);
StringPtr PSright(ConstStr255Param s, SInt16 n);
StringPtr PSmid(ConstStr255Param s, SInt16 p, SInt16 n);
StringPtr PSucase(ConstStr255Param s);
StringPtr PSstring(SInt16 n, UInt8 theChar);
StringPtr PSstringstr(SInt16 n, ConstStr255Param s);
StringPtr PSstrampersand(Handle h, int index);
StringPtr PSstrhash(const int resID, const int index);
StringPtr PSpstr(StringPtr p);
CFStringRef DateFormatCreateStringWithAbsoluteTime( CFStringRef formatStr, CFAbsoluteTime at );
StringPtr PSdatePStime( ConstStr255Param s );

CFStringRef DateCFString( CFStringRef formatStr );
CFStringRef TimeCFString( CFStringRef formatStr );

SInt64 InString( NSInteger startPos,  CFStringRef strToSearch, CFStringRef strToSearchFor, NSInteger searchOptions );

CFStringRef RightString( CFStringRef inString, CFIndex howManyChars );
CFStringRef LeftString( CFStringRef inString, CFIndex toIndex );
CFStringRef MidString( CFStringRef inString, CFIndex startPos, CFIndex howManyChars );

CFStringRef HexString( long num );
CFStringRef BinString( long theBytes );
CFStringRef OctString( long theBytes );

CFStringRef SpaceCFString( long length );
CFStringRef LcaseCFString( CFStringRef string );
CFStringRef UcaseCFString( CFStringRef string );

CFStringRef MKIString( UInt32 n );
NSInteger LenCF( CFTypeRef obj );


// === 20250318 bw ===
enum {
    kLenDefault,
    kLenUnicode
};
NSInteger FB_Len( CFTypeRef obj, NSUInteger option );
// === 20240318 bw ===


void MidStatementCFString( CFMutableStringRef inString, NSInteger startPos, NSInteger numChars, CFStringRef inReplaceString );

//unichar UCC_Function( CFStringRef inString, NSUInteger index ); // 20240729 bw
UInt32 UCC_Function( CFStringRef inString, NSUInteger charIndex ); // 20250315 bw

//CFStringRef UCS_Function( unichar chr ); // 20240729 bw
CFStringRef UCS_Function( UInt64 codePoint ); // 20250315 bw
CFStringRef UCS_Function2( UInt64 codePoint, ... ); // 20250319 bw

SInt16 STRLeadingSpace(void);
void PSdefstr(const UInt8 length);

CFStringRef CopyDblToString( const double user_supplied_number );
CFStringRef FBStr( const double user_supplied_number );// 20231222 bw
StringPtr PSstr(const double n );// maxDigits second param 20210125 bw

StringPtr PShex( long n );
StringPtr PSoct( long n );
StringPtr PSbin( long n );
StringPtr PSuns( const SInt32 n );
StringPtr PSmki(UInt32 n);
SInt8 FBPopCmpStr(Str255 s1, Str255 s2);
int CviCF( CFStringRef s );// 20210129 bw
int FBcvi(ConstStr255Param s);
UInt8 PSlen(ConstStr255Param s);
UInt8 PSasc(ConstStr255Param s);
UInt8 PSinstr(int startPos, Str255 haystack, Str255 needle);
SInt64 PSvalint(Str255 s);
double PSval(Str255 s);
NSInteger FBIntVal( id obj );// 20220627 bw
double FBDblVal( id obj );// 20220627 bw
long MidStmt(void *strvPtr, long position, long length, Str255 s_p);
double frac(const double x);
double sgn(const double value);
SInt32 sgni(const SInt32 value);
SInt32 maybe(void);

long rnd( long minMax, long max );

int FBmax(const SInt32 n1, const SInt32 n2);
void FBDelay(const Duration t);
NSInteger FBSystemFunction( const SInt32 expr ); //2023-Jul-18 Brian
SInt32 OSVersion( void );
void OSGetMajorMinor( NSInteger *maj, NSInteger *min );   //2020-Dec-26 Brian

void FBRunPath( CFStringRef path );
void FBRunURL( CFURLRef url );
void FBRunPathURL( CFTypeRef obj );
void FBPstrDollarStatement(void *address, void *s);

////////////////////////////////////////////////////////
//   Container declares from Container.c              //
////////////////////////////////////////////////////////
StringPtr GetCtnrString(void **srcCtnrVar, StringPtr s, short lstring);
StringPtr CatCtnrString(void **srcCtnrVar, StringPtr sPtr, long lstring);
void FBCtnrCopy(void **srcCtnrVar, void **destCtnrVar);
void * FBCtnrCopy3( void **destCtnrVar, void **srcCtnrVar );

void *CtnrStoreString(void **ctnrVarPtr, Str255 inPStr);
void CtnrFree(void * ptr);

long Asc_ctnr( void **ctnrVarPtr);
void PrintContainer( Handle *ctnrVarPtr );
void FBClearTempContainer(void);
void FBClearTemp2Container(void);

void *AddStringToCtnr(void **ctnrVarPtr, Str255 inPStr);
void *AddCtnrs( void **ctnrV1Ptr, void **ctnrV2Ptr);

SInt64 FBCompareHandles( void **ctnr1, void **ctnr2 );
SInt64 FBCompareContainers( void **ctnr1, void **ctnr2 );
Boolean FBCmpCtnr(void **ctnr1, void **ctnr2);
void *UCase_Ctnr(void **ctnrVarPtr);
void * FBNewContainer(SInt64 length);
SInt64 CtnrRequestedSize(void * ptr);
void *Left_Ctnr( void **ctnrVarPtr, SInt64 length);
SInt64 Len_Ctnr( void **ctnrPtr);
void *Mid_Ctnr( void **ctnrVarPtr, SInt64 startPos, SInt64 length);
void *Right_Ctnr( void **ctnrVarPtr, SInt64 length);
void *StringNum_Ctnr(SInt64 length, long c);
void *StringStr_Ctnr(SInt64 length, Str255 inPStr);
void MidStmt_Ctnr(void **ctnrVarPtr, SInt64 position_L, SInt64 length, Str255 inputPStr);
void MidStmt_Ctnr_Ctnr( void **ctnrVarPtr, SInt64 position_L, SInt64 length, void **srcCtnrVar );
SInt64 Instr_Ctnr(long position_L, void **BigctnrVarPtr, void **SearchctnrVarPtr);
SInt64 Instr_Ctnr_PStr(long position_L, void **BigctnrVarPtr, Str255 inputPStr);
////////////////////////////////////////////////////////
//   End of container declares from Container.c       //
////////////////////////////////////////////////////////

long FBerror(void);

void FBFileErrorAlert(long fileID, long err);
void FBCheckFileError(long fileID, long err);
CFStringRef FBUnixFunction( CFStringRef cmd );
void FBOpenUNIX(unsigned fileID, Str255 command); //2023-Aug-14 Brian - reinstate open "unix" for FB 7.0.23 to give FBers time to update their code to the new 'unix' function
void FBOpenOutput(const int fileID, void *fileNamePtr, void *fs);
void FBOpenRandom(const int fileID, void *fileNamePtr, void *fs, SInt64 recLen, Boolean exclusive);
void FBOpenAppend(const int fileID, void *fileNamePtr, void *fs, SInt64 recLen);
void FBOpenInput(const int fileID, void *fileNamePtr, void *fs, SInt64 recLen, Boolean isResourceOpen);
#if 1 // CFFILE_OPEN
BOOL FBClose( long inFileID, NSError **err );
BOOL FBeof( long fileID );
#else // CFFILE_OPEN
void FBClose(int fileID);
Boolean FBeof(int fileID); //2024-Feb-16 Brian
#endif // CFFILE_OPEN

SInt64 FBlof(int fileID, SInt64 recLen);

void FBAppend(const int fileID);
void FBRecord(const int fileID, SInt64 recNum, SInt64 posInRec);
SInt64 CurrentOffset( int fileID );
SInt64 FBrec(int fileID);
SInt64 FBloc(int fileID);
void FBLineInputHash(int fileID, StringPtr s);
//ByteCount FBReadFile(const int fileID, void *dest, Boolean isInputHashString, ByteCount numBytesRequested);
UInt64 FBReadFile( const int fileID, void * dest, Boolean isInputHashString, UInt64 numBytesRequested ); //2023-Apr-26 Brian

StringPtr FBInkeyFromFile(const int fileID);
short FBReadSwapShort(const unsigned fileID);
long FBReadSwapLong(const unsigned fileID);
int  FBReadSwapInt(const unsigned fileID); //2024-Jul-31 Brian
float FBReadSwapSingle(const unsigned fileID);
double FBReadSwapDouble(const unsigned fileID);

void FBParseInput(const short varType, void *vPtr);
void FBToCInputFile(const int fileID, void *target, short varType);
void FBReadString( int fileID, void *dest, UInt64 numBytesRequested );

#if 1 // CFFILE_OPEN
BOOL FBWriteFile(const int fileID, void *src, SInt64 numBytes, NSError **err );
#else
void FBWriteFile(const int fileID, void *src, SInt64 numBytes);
#endif

void FBWriteString( const int fileID, char * src, ByteCount varLength );
void FBWriteSwapShort(short s, const unsigned fileID);
void FBWriteSwapLong( long aLongVar, const unsigned fileID );
void FBWriteSwapSingle(float f, const unsigned fileID);
void FBWriteSwapDouble(double d, const unsigned fileID);
void FBWriteSwapInt( int anIntVar, const unsigned fileID ); //2024-Jul-31 Brian
void FBFilePrintChar(char theChar);
SInt64 FBFileGetPos(void);// moved to AppThings.h 20230616 bw
void FBFilePrintTab(void);
void FBFilePrintCR(void);
void FBFilePrintString(Str255 s_p);
void FBSetOpenType(Str15 opentype_p);
#if 1 // RENAME_KILL_SYNTAX
BOOL FBRename( CFURLRef oldURL, CFURLRef newURL, NSError **err );
BOOL FBKill( CFURLRef url, NSError **err );
#else // RENAME_KILL_SYNTAX
void FBRename(CFURLRef oldName, CFURLRef newName );
void FBKill( CFURLRef fileName );
#endif // RENAME_KILL_SYNTAX

void CopyNameFromCFURLRef(CFURLRef url, CFStringRef *string);
void GetNameAsPascalStringFromCFURLRef(CFURLRef url, Str255 *name);

CFMutableArrayRef CFIndexGetArrayRef(CFIndex indexID);
CFIndex CFIndexGetCount(CFIndex indexID);
void CFIndexSet(CFIndex indexID, CFIndex element, Str255 pStr);
void FBIndexSet(CFIndex element, CFIndex indexID, Str255 pStr);
StringPtr CFIndexGet(CFIndex indexID, CFIndex element);
StringPtr FBIndexGet(CFIndex element, CFIndex indexID);
void CFIndexInsert(CFIndex indexID, CFIndex element, Str255 pStr);
void FBIndexI(CFIndex element, CFIndex indexID, Str255 pStr);
void CFIndexDelete(CFIndex indexID, CFIndex element);
void FBIndexD(CFIndex element, CFIndex indexID);
CFIndex CFIndexFind(CFIndex indexID, CFIndex startElement, Str255 pStr);
CFIndex FBIndexF(Str255 pStr, CFIndex startElement, CFIndex indexID);
void CFIndexClear(CFIndex indexID);
CFComparisonResult CFIndexCompareFunction(const void *val1, const void *val2, void *context);
void CFIndexSort(CFIndex indexID);
void CFIndexAppend(CFIndex indexID, Str255 pStr);
Boolean CFIndexWrite(CFIndex indexID, CFURLRef url);
Boolean CFIndexWriteAll(CFURLRef url);
Boolean CFIndexRead(CFIndex indexID, CFURLRef url);
Boolean CFIndexReadAll(CFURLRef url);

CFIndex FBMem(long expr);

void FBAddCharacterToBuffer(short c);
void FBAddStringToBuffer(Str255 string_p);
void FBCheckForPageFeed(long isCr);
void FBText(long font, long size, long style, long xMode);

void FBLineInput(Str255 prompt_p, void *vPtr);
void FBToCInput(Str255 prompt, void *target, short varType);

NSMutableArray *DispatchGroups( void );
void DispatchGroupAdd( void );
void DispatchGroupRemove( void );
dispatch_group_t DispatchGroupCurrent( void );

#pragma mark - fileopen, fileclose, fileread
BOOL FileClose( long inFileID, NSError **err );
BOOL FileOpenAppend( long inFileID, CFURLRef inURL, NSError **err );
BOOL FileOpenRead( long inFileID, CFURLRef url, NSError **err );
BOOL FileOpenReadAppend( long inFileID, CFURLRef inURL, NSError **err );
BOOL FileOpenReadWrite( long inFileID, CFURLRef url, NSError **err );
BOOL FileOpenWrite( long inFileID, CFURLRef url, NSError **err );
CFStringRef FileRead( long inFileID, NSError **err );

#if 1 // encoding param
CFStringRef FileReadLine( long inFileID, long encoding, NSError **err );
#else
CFStringRef FileReadLine( long inFileID, NSError **err );
#endif

BOOL FileWrite( long inFileID, CFStringRef inString, NSError **err );

#pragma mark - concat functions
id FBConcatString( id obj,va_list ap );
id FBConcatAttributedString( id obj, va_list ap );
id FBConcatArray( id obj, va_list ap );
id FBConcatDictionary( id obj, va_list ap );
id FBConcatSet( id obj, va_list ap );
id FBConcatOrderedSet( id obj, va_list ap );
id FBConcatCountedSet( id obj, va_list ap );
id FBConcatIndexSet( id obj, va_list ap );
id FBConcatNumber( id obj, va_list ap );
CFTypeRef FBConcat( CFTypeRef inObj, ... );
CFTypeRef FBConcatJoin( CFTypeRef inObj, ... );

#pragma mark - C string functions
//2024-Oct-1 Brian
void FBConcatCStr( char *returnedVar, const char *s1,  ...);
void FBAppendCStr( size_t maxDestSize, char *dest, const char *src ); //2024-Oct-10 Brian

#pragma mark - shortcut array and dict setters
// 20241008 bw
CFTypeRef FBShortcutArrayGetter( CFArrayRef inArray, NSInteger index );
void FBShortcutArraySetter( CFMutableArrayRef inArray, NSInteger index, CFTypeRef inObj );

//#endif /* RUNTIME_H */
