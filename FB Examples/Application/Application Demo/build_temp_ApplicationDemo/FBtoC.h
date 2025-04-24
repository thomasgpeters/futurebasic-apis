/*
 Prefix header for the translated product of FBtoC
 */
//#ifndef FBTOC_H
//#define FBTOC_H

#define SILENCE_CLANG_WARNINGS 0 // silence clang warnings for -Weverything compiler option 20250304 bw


typedef id genericObjectType;// 20180516 bw - to avoid clash with user variable name 'id' - used by FB translator in fast enumeration 'for' loops

    // see AssertMacros.h      To activate, put in CFLAGS: -DDEBUG=1
#ifdef DEBUG
#define DEBUG_ASSERT_COMPONENT_NAME_STRING "FBtoC" 
#endif

#define TO_STACK gFBStrStk[gFBStk]
#define USE_SJLJ_FOR_GOSUB_RETURN 1
#if USE_SJLJ_FOR_GOSUB_RETURN // see _useSJLJForGosubReturn in FBtoC source
#define GOSUB if ( !setjmp( gReturnEnv[++gReturnLevel] ) ) goto
#define RETURN_FROM_GOSUB longjmp( gReturnEnv[gReturnLevel--], 1 ) 
#endif

#define NO_SUFFIX_ON_ARRAY_NAMES 1 // matching _noSuffixOnArrayNames in FBtoC source

#import <strings.h>  //2022-Dec-11 Brian - has bzero() declaration
#import "MacTypes.h" //2022-Dec-11 Brian
#import <termios.h>
#import <unistd.h>
#import <util.h>
#import <CoreFoundation/CFURL.h> //2022-Dec-11 Brian - FBInfoForOpenFile struct uses a CFURLRef which needs a declaration.

    ////////////////////////////////////////////////////////////
    // public (user-and runtime-code-reachable) declarations: //
    //         struct, typedef, enum, #define                 //
    ////////////////////////////////////////////////////////////

typedef struct termios termios; // so we don't need to preface termios vars with 'struct'

    // resurrect some things inconveniently missing from 64-bit Carbon
typedef unsigned char *                 StringPtr;
static inline void BlockZero( void *destPtr, Size byteCount ) { if ( byteCount > 0 ) bzero( destPtr, byteCount ); }
static inline void BlockMoveData( const void *srcPtr, void *destPtr, Size byteCount ) { if ( byteCount > 0 ) memmove( destPtr, srcPtr, byteCount ); }
static inline void BlockMove( const void *srcPtr, void *destPtr, Size byteCount ) { if ( byteCount > 0 ) memmove( destPtr, srcPtr, byteCount ); }

    // custom-sized strings [those already in MacTypes.h are commented out]
typedef unsigned char Str1[2];
typedef unsigned char Str3[4];
typedef unsigned char Str5[6];
typedef unsigned char Str7[8];
typedef unsigned char Str9[10];
typedef unsigned char Str11[12];
typedef unsigned char Str13[14];

#if SILENCE_CLANG_WARNINGS == 0
#if DECARBONATE
typedef unsigned char Str15[16];
#endif
#endif // SILENCE_CLANG_WARNINGS

typedef unsigned char Str17[18];
typedef unsigned char Str19[20];
typedef unsigned char Str21[22];
typedef unsigned char Str23[24];
typedef unsigned char Str25[26];

#if SILENCE_CLANG_WARNINGS == 0
#if DECARBONATE
typedef unsigned char Str27[28];
#endif
#endif // SILENCE_CLANG_WARNINGS

typedef unsigned char Str29[30];

#if SILENCE_CLANG_WARNINGS == 0
#if DECARBONATE
typedef unsigned char Str31[32];
#endif
#endif // SILENCE_CLANG_WARNINGS

typedef unsigned char Str33[34];
typedef unsigned char Str35[36];
typedef unsigned char Str37[38];
typedef unsigned char Str39[40];
typedef unsigned char Str41[42];
typedef unsigned char Str43[44];
typedef unsigned char Str45[46];
typedef unsigned char Str47[48];
typedef unsigned char Str49[50];
typedef unsigned char Str51[52];
typedef unsigned char Str53[54];
typedef unsigned char Str55[56];
typedef unsigned char Str57[58];
typedef unsigned char Str59[60];
typedef unsigned char Str61[62];

#if SILENCE_CLANG_WARNINGS == 0
#if DECARBONATE
typedef unsigned char Str63[64];
#endif
#endif // SILENCE_CLANG_WARNINGS

typedef unsigned char Str65[66];
typedef unsigned char Str67[68];
typedef unsigned char Str69[70];
typedef unsigned char Str71[72];
typedef unsigned char Str73[74];
typedef unsigned char Str75[76];
typedef unsigned char Str77[78];
typedef unsigned char Str79[80];
typedef unsigned char Str81[82];
typedef unsigned char Str83[84];
typedef unsigned char Str85[86];
typedef unsigned char Str87[88];
typedef unsigned char Str89[90];
typedef unsigned char Str91[92];
typedef unsigned char Str93[94];
typedef unsigned char Str95[96];
typedef unsigned char Str97[98];
typedef unsigned char Str99[100];
typedef unsigned char Str101[102];
typedef unsigned char Str103[104];
typedef unsigned char Str105[106];
typedef unsigned char Str107[108];
typedef unsigned char Str109[110];
typedef unsigned char Str111[112];
typedef unsigned char Str113[114];
typedef unsigned char Str115[116];
typedef unsigned char Str117[118];
typedef unsigned char Str119[120];
typedef unsigned char Str121[122];
typedef unsigned char Str123[124];
typedef unsigned char Str125[126];
typedef unsigned char Str127[128];
typedef unsigned char Str129[130];
typedef unsigned char Str131[132];
typedef unsigned char Str133[134];
typedef unsigned char Str135[136];
typedef unsigned char Str137[138];
typedef unsigned char Str139[140];
typedef unsigned char Str141[142];
typedef unsigned char Str143[144];
typedef unsigned char Str145[146];
typedef unsigned char Str147[148];
typedef unsigned char Str149[150];
typedef unsigned char Str151[152];
typedef unsigned char Str153[154];
typedef unsigned char Str155[156];
typedef unsigned char Str157[158];
typedef unsigned char Str159[160];
typedef unsigned char Str161[162];
typedef unsigned char Str163[164];
typedef unsigned char Str165[166];
typedef unsigned char Str167[168];
typedef unsigned char Str169[170];
typedef unsigned char Str171[172];
typedef unsigned char Str173[174];
typedef unsigned char Str175[176];
typedef unsigned char Str177[178];
typedef unsigned char Str179[180];
typedef unsigned char Str181[182];
typedef unsigned char Str183[184];
typedef unsigned char Str185[186];
typedef unsigned char Str187[188];
typedef unsigned char Str189[190];
typedef unsigned char Str191[192];
typedef unsigned char Str193[194];
typedef unsigned char Str195[196];
typedef unsigned char Str197[198];
typedef unsigned char Str199[200];
typedef unsigned char Str201[202];
typedef unsigned char Str203[204];
typedef unsigned char Str205[206];
typedef unsigned char Str207[208];
typedef unsigned char Str209[210];
typedef unsigned char Str211[212];
typedef unsigned char Str213[214];
typedef unsigned char Str215[216];
typedef unsigned char Str217[218];
typedef unsigned char Str219[220];
typedef unsigned char Str221[222];
typedef unsigned char Str223[224];
typedef unsigned char Str225[226];
typedef unsigned char Str227[228];
typedef unsigned char Str229[230];
typedef unsigned char Str231[232];
typedef unsigned char Str233[234];
typedef unsigned char Str235[236];
typedef unsigned char Str237[238];
typedef unsigned char Str239[240];
typedef unsigned char Str241[242];
typedef unsigned char Str243[244];
typedef unsigned char Str245[246];
typedef unsigned char Str247[248];
typedef unsigned char Str249[250];
typedef unsigned char Str251[252];
typedef unsigned char Str253[254];

#if SILENCE_CLANG_WARNINGS == 0
#if DECARBONATE
typedef unsigned char Str255[256];
#endif
#endif // SILENCE_CLANG_WARNINGS

// dynamic array support
#define kMaxNumDynArrays 64  // Limits the maximum number of user-defined dynamic arrays within the user's application. //2022-Jan-10 Brian
typedef struct DynArrayInfo {
    long    elemSize; //2023-Nov-15 Brian    int elemSize;
    long	maxIndex;
    long	lastElem; // for autoXRefCurr emulation
    void *	base;
} DynArrayInfo;

// system function expressions
enum {
    //kFBAplVol		= 1,
    //kFBAplRes		= 4,
    //kFBMemAvail		= 5,
    kFBScrnWidth	= 6,
    kFBScrnHeight	= 7,
    kFBSysVers		= 8,
    kFBAplActive	= 9//,
//    kFBMaxColors	= 10,
//    kFBCrntDepth	= 11,
//    kFBMachType		= 13,
//    kFBCPUSpeed		= 15,
//    kFBClockSpeed	= 16,
//    kFBLastCursType	= 17,
//    kFBAplVRefNum	= 18,
//    kFBAplParID		= 19
};

typedef void (*FBOnXxxxxVector)(long,long);

typedef struct FBAppEventInfo { // cocoaui 20170704 bw
    long appEventKind;
    long appEventID;
} FBAppEventInfo;


#ifndef kFBParamMissing
#define kFBParamMissing -1999999999
#endif

enum {
    kMaxFBFiles = 256,
    kFBMaxSerialFiles = 12
};

//See also OSX SerialIO.incl, where this declaration is shadowed
//typedef struct  __attribute__ ((__packed__))  FBInfoForOpenFile {
typedef struct FBInfoForOpenFile { // 20250406 bw
    // all: open "UNIX", disk files, serial
    Boolean			isOpen;
    Boolean		    eof; //2023-Dec-22 Brian
        // open "UNIX" only
    FILE *			pipeUNIX;       // see FBOpenUNIX()
                                    // disk files only
    UInt64			savedOffset;    // was: SInt16 forkRefNum; Brian 20170114 was SInt64 2023-Apr-26 Brian
    CFURLRef        url;            // was: FSRef  fileRef;    Brian 20170114
    UInt64			recordSize, linePos; //2023-Apr-26 Brian
        // serial only  see FBSerialOpen (in OSX SerialIO.incl)
        //struct termios	originalOptions; removed rp 20080209
    void            *buff;
    ByteCount		buffSize, bytesInBuff;
    SInt16          fileDescriptor;
    char            fileOpenMode;
    void            *fh;
} FBInfoForOpenFile;


typedef struct  __attribute__ ((__packed__))     ldesRec {// see case kControlListBoxProc in FBAppearanceButton()
    short		versionNumber;
    short		numberOfRows;
    short		numberOfColumns;
    short		cellHeight;
    short		cellWidth;
    Boolean		hasVertScroll;
    char		filler1;
    Boolean		hasHorizScroll;
    char		filler2;
    short		LDEFresID;
    Boolean		hasSizeBox;
    char		reserved;
} ldesRec;

// prototypes for data read/restore (see EmitFBData() in FBtoC source)
StringPtr FBReadData(void); //2023-Jul-19 Brian - add 'void' to silence the compiler warning
void FBRestore( short n );

//#endif  // FBTOC_H 
