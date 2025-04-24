/*
 MDA.h

 Bernie Wylde
 */

#import "CocoaUI.h"

@interface MDAObj : NSObject
@property (nonatomic,retain) NSMutableArray *array;
@property (nonatomic,assign) long dims;

- (void)padArray:(NSMutableArray *)array toIndex:(long)index;
- (void)nullPadArray:(NSMutableArray *)array toIndex:(long)index insert:(BOOL)insert;
- (NSMutableArray *)array:(NSMutableArray *)array subarrayAtIndex:(long)index grow:(BOOL)grow;

// get
//- (id)objectv:(va_list)ap;
- (id)objectv:(long)index args:(va_list)ap;
- (id)object:(int)index, ...;

// add
- (void)addObjectv:(id)obj args:(va_list)ap;
- (void)addObject:(id)obj, ...;

// find
- (long)findObject:(id)obj inRange:(NSRange)range;
- (long)findObject:(id)obj;

// set
- (void)setObjectv:(id)obj args:(va_list)ap;
- (void)setObject:(id)obj, ...;

// insert
- (void)insertObjectv:(id)obj args:(va_list)ap;
- (void)insertObject:(id)obj, ...;

// remove
//- (void)removev:(long)index args:(va_list)ap;
- (void)removev:(long)length index:(long)index args:(va_list)ap;
//- (void)remove:(long)index, ...;
- (void)removeAll;
- (void)compactArray:(NSMutableArray *)array;
- (void)compact;
- (void)removeNullsFromArray:(NSMutableArray *)array;// deprecated
- (void)removeNulls;// deprecated

// sort
- (void)sortArray:(NSMutableArray *)array usingSelector:(NSString *)selector;
- (void)sortUsingSelector:(NSString *)selector;

// query
- (long)countv:(va_list)ap;

// read
- (BOOL)readFromURL:(NSURL *)url;

// write
- (BOOL)writeToURL:(NSURL *)url;

// description
- (long)description:(NSMutableArray *)array indent:(long)indent string:(NSMutableString *)string emptyArrays:(BOOL)emptyArrays nulls:(BOOL)nulls classes:(BOOL)classes;
- (NSString *)descriptionWithEmptyArrays:(BOOL)emptyArrays nulls:(BOOL)nulls classes:(BOOL)classes;
- (NSString *)descriptionWithTag:(long)tag emptyArrays:(BOOL)emptyArrays nulls:(BOOL)nulls classes:(BOOL)classes;
- (NSString *)description;

// text
- (void)textWithArray:(NSMutableArray *)array string:(NSMutableString *)string;
- (NSString *)text;
@end

typedef MDAObj *MDAObjRef;

void MDAAlert_priv( NSString *msg, NSString *info );
void MDADimCountAlert_priv( long tag, long reqCount, long actCount );

NSMutableDictionary *MDADict( void );

MDAObj *MDAWithTag_priv( long tag, BOOL create );
MDAObj *MDAWithTag( long tag );

// set
void MDASet( long tag, MDAObj *ref );

// info
long MDADims( long tag );
CFMutableArrayRef MDAArray( long tag );
Class MDAClass( long tag, long dimCount, long dim1, ... );

// get
id MDAObjectv( MDAObj *mda, long dim1, va_list ap );
//id MDAObjv( long tag, long dim1, va_list ap );
CFTypeRef MDAObject( long tag, long dimCount, long dim1, ... );
long MDAInteger( long tag, long dimCount, long dim1, ... );
double MDADouble( long tag, long dimCount, long dim1, ... );

// Find
long MDAFind( long tag, CFTypeRef obj, CFRange range );

// add
void MDAAddObjectv( MDAObj *mda, id obj, va_list ap );
void MDAAddObject( long tag, CFTypeRef obj, long dimCount, ... );
void MDAAppendArray( long tag, CFArrayRef inArray, long dimCount, ... );

// set
void MDASetObjectv( MDAObj *mda, id obj, va_list ap );
void MDASetObject( long tag, CFTypeRef obj, long dimCount, ... );

// insert
void MDAInsertObjectv( MDAObj *mda, id obj, va_list ap );
void MDAInsertObject( long tag, CFTypeRef obj, long dimCount, ... );

// remove
//void MDARemovev( MDAObj *mda, long index, va_list ap );
void MDARemovev( MDAObj *mda, long length, long index, va_list ap );
//void MDARemove( long tag, long dimCount, long dim1, ... );
void MDARemove( long tag, long length, long dimCount, long dim1, ... );
void MDARemoveNulls( long tag );// deprecated
void MDAClear( long tag );
void MDACompact( long tag );
void MDACopy( long tag1, long tag2 );

// sort
void MDASort( long tag, CFStringRef selector );

// delete
void MDAKill( long tag );

// count
long MDACountv( MDAObj *mda, va_list ap );
long MDACount( long tag, ... );

// read
BOOL MDARead( long tag, CFURLRef url );

// write
BOOL MDAWrite( long tag, CFURLRef url );

// description
CFStringRef MDADescription( long tag, BOOL emptyArrays, BOOL nulls, BOOL classes );

// text
CFStringRef MDAText( long tag );

