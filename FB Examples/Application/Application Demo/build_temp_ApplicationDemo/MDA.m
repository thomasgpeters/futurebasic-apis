/*
 MDA.m

 Bernie Wylde
 */

#import "MDA.h"

static NSMutableDictionary *sMDA_dict;

@implementation MDAObj
#if !__has_feature(objc_arc)
- (void)dealloc {
    [self.array release];
    [super dealloc];
}
#endif

- (void)padArray:(NSMutableArray *)array toIndex:(long)index {
    long count = [array count];
    while ( index >= count ) {
        [array addObject:[NSMutableArray arrayWithCapacity:0]];
        count++;
    }
}

- (void)nullPadArray:(NSMutableArray *)array toIndex:(long)index insert:(BOOL)insert {
    long count = [array count];
    if ( insert ) {
        while ( index > count ) {
            [array addObject:[NSNull null]];
            count++;
        }
    } else {
        while ( index >= count ) {
            [array addObject:[NSNull null]];
            count++;
        }
    }
}

- (NSMutableArray *)array:(NSMutableArray *)array subarrayAtIndex:(long)index grow:(BOOL)grow {
    NSMutableArray *subarray = nil;
    long count = [array count];
    if ( grow ) {
        if ( index >= count ) {
            [self padArray:array toIndex:index];
        }
        subarray = [array objectAtIndex:index];
    } else {
        if ( index < count ) {
            subarray = [array objectAtIndex:index];
        }
    }
    return subarray;
}

// get
//- (id)objectv:(va_list)ap {
//    id obj = nil;
//    NSMutableArray *array = self.array;
//    long count = [self.array count];
//    long arg = va_arg(ap,long);
//    if ( self.dims == 1 ) {
//        if ( arg < count ) {
//            obj = [array objectAtIndex:arg];
//        }
//    } else {
//        array = [self array:array subarrayAtIndex:arg grow:NO];
//        if ( array ) {
//            count = [array count];
//            for ( long d = 1; d < self.dims; d++ ) {
//                long arg = va_arg(ap,long);
//                if ( d == self.dims - 1 ) {
//                    if ( arg < count ) {
//                        obj = [array objectAtIndex:arg];
//                    }
//                } else {
//                    array = [self array:array subarrayAtIndex:arg grow:NO];
//                    if ( array == nil ) break;
//                }
//            }
//        }
//    }
//    return obj;
//}

- (id)objectv:(long)index args:(va_list)ap {
    id obj = nil;
    NSMutableArray *array = self.array;
    long arg0 = index;
    long count = [array count];
    if ( self.dims == 1 ) {
        if ( arg0 < 0 ) arg0 = count + arg0; // last obj is -1, penultimate obj is -2, etc. // 20250124
        if ( arg0 >= 0 && arg0 < count ) {
            obj = [array objectAtIndex:arg0];
        }
    } else {
        array = [self array:array subarrayAtIndex:arg0 grow:NO];
        if ( array ) {
            for ( long d = 1; d < self.dims; d++ ) {
                long arg = va_arg(ap,long);
                if ( d == self.dims - 1 ) {
                    count = [array count];
                    if ( arg < 0 ) arg = count + arg; // last obj is -1, penultimate obj is -2, etc. // 20250124
                    if ( arg >= 0 && arg < count ) {
                        obj = [array objectAtIndex:arg];
                    }
                } else {
                    array = [self array:array subarrayAtIndex:arg grow:NO];
                    if ( array == nil ) break;
                }
            }
        }
    }
    if ( [obj isEqualTo:[NSNull null]] ) obj = nil;
    return obj;
}

- (id)object:(int)index, ... {
    va_list ap;
    va_start(ap,index);
    id obj = [self objectv:index args:ap];
    va_end(ap);
    return obj;
}

// add
- (void)addObjectv:(id)obj args:(va_list)ap {
    NSMutableArray *array = self.array;
    if ( self.dims == 1 ) {
        [array addObject:obj];
    } else {
        for ( long d = 0; d < self.dims; d++ ) {
            long arg = va_arg(ap,long);
            if ( d == self.dims - 1 ) {
                [array addObject:obj];
            } else {
                array = [self array:array subarrayAtIndex:arg grow:YES];
            }
        }
    }
}

- (void)addObject:(id)obj, ... {
    va_list ap;
    va_start(ap,obj);
    [self addObjectv:obj args:ap];
    va_end(ap);
}

// set
- (void)setObjectv:(id)obj args:(va_list)ap {
    if ( !obj ) obj = [NSNull null];
    NSMutableArray *array = self.array;
    for ( long d = 0; d < self.dims; d++ ) {
        long arg = va_arg(ap,long);
        if ( self.dims == 1 ) {
            [self nullPadArray:array toIndex:arg insert:NO];
            [array replaceObjectAtIndex:arg withObject:obj];
        } else {
            if ( d == self.dims - 1 ) {
                [self nullPadArray:array toIndex:arg insert:NO];
                [array replaceObjectAtIndex:arg withObject:obj];
            } else {
                array = [self array:array subarrayAtIndex:arg grow:YES];
            }
        }
    }
}

- (void)setObject:(id)obj, ... {
    va_list ap;
    va_start(ap,obj);
    [self setObjectv:obj args:ap];
    va_end(ap);
}

// insert
- (void)insertObjectv:(id)obj args:(va_list)ap {
    NSMutableArray *array = self.array;
    for ( long d = 0; d < self.dims; d++ ) {
        long arg = va_arg(ap,long);
        if ( self.dims == 1 ) {
            [self nullPadArray:array toIndex:arg insert:YES];
            [array insertObject:obj atIndex:arg];
        } else {
            if ( d == self.dims - 1 ) {
                [self nullPadArray:array toIndex:arg insert:YES];
                [array insertObject:obj atIndex:arg];
            } else {
                array = [self array:array subarrayAtIndex:arg grow:YES];
            }
        }
    }
}

- (void)insertObject:(id)obj, ... {
    va_list ap;
    va_start(ap,obj);
    [self insertObjectv:obj args:ap];
    va_end(ap);
}

// find
- (NSUInteger)indexOfObject:(id)obj inArray:(NSMutableArray *)array {
    
    // .....
    
    return NSNotFound;
}

- (long)findObject:(id)obj inRange:(NSRange)range {
    long index = NSNotFound;
    NSMutableArray *array = self.array;
    if ( self.dims == 1 ) {
        NSUInteger count = [array count];
        if ( range.location < count ) {
            if ( range.location + range.length > count ) range.length = count - range.location;
            index = [array indexOfObject:obj inRange:range];
        }
    } else {
        // .....
    }
    return index;
}

- (long)findObject:(id)obj {
    long index = NSNotFound;
    NSMutableArray *array = self.array;
    if ( self.dims == 1 ) {
        index = [array indexOfObject:obj];
    } else {
        // .....
    }
    return index;
}

// remove
- (void)removev:(long)length index:(long)index args:(va_list)ap {
    NSMutableArray *array = self.array;
    long arg0 = index;
    long count = [array count];
    if ( self.dims == 1 ) {
        if ( arg0 < count ) {
            if ( length > 1 ) {
                if ( (arg0 + length) > count ) length = count - arg0;
                [array removeObjectsInRange:NSMakeRange(arg0,length)];
            } else {
                [array removeObjectAtIndex:arg0];
            }
        }
    } else {
        array = [self array:array subarrayAtIndex:arg0 grow:NO];
        if ( array ) {
            for ( long d = 1; d < self.dims; d++ ) {
                long arg = va_arg(ap,long);
                count = [array count];
                if ( d == self.dims - 1 ) {
                    if ( arg < count ) {
                        if ( length > 1 ) {
                            if ( (arg + length) > count ) length = count - arg;
                            [array removeObjectsInRange:NSMakeRange(arg,length)];
                        } else {
                            [array removeObjectAtIndex:arg];
                        }
                        //[array removeObjectAtIndex:arg];
                    }
                } else {
                    array = [self array:array subarrayAtIndex:arg grow:NO];
                    if ( array == nil ) break;
                }
            }
        }
    }
}

- (void)removeAll {
    [self.array removeAllObjects];
}

- (void)compactArray:(NSMutableArray *)array {
    [array removeObject:[NSNull null]];
    long count = [array count];
    for ( long index = 0; index < count; index++ ) {
        id obj = [array objectAtIndex:index];
        if ( [obj isKindOfClass:[NSMutableArray class]] ) {
            [self compactArray:obj];
        }
    }
}

- (void)compact {
    [self compactArray:self.array];
}

- (void)removeNullsFromArray:(NSMutableArray *)array { // deprecated
    [array removeObject:[NSNull null]];
    long count = [array count];
    for ( long index = 0; index < count; index++ ) {
        id obj = [array objectAtIndex:index];
        if ( [obj isKindOfClass:[NSMutableArray class]] ) {
            [self removeNullsFromArray:obj];
        }
    }
}

- (void)removeNulls {// deprecated
    [self removeNullsFromArray:self.array];
}

- (void)sortArray:(NSMutableArray *)array usingSelector:(NSString *)selector {
    if ( !selector ) selector = @"compare:";
    SEL sel = NSSelectorFromString(selector);
    if ( ![array respondsToSelector:sel] ) {
        sel = @selector(compare:);
    }
    [self compactArray:array];
    if ( self.dims == 1 ) {
        [array sortUsingSelector:sel];
    } else {
        long count = [array count];
        for ( long index = 0; index < count; index++ ) {
            id obj = [array objectAtIndex:index];
            if ( [obj isKindOfClass:[NSMutableArray class]] ) {
                [self sortArray:obj usingSelector:selector];
            } else {
                [array sortUsingSelector:sel];
            }
        }
    }
}

- (void)sortUsingSelector:(NSString *)selector {
    [self sortArray:self.array usingSelector:selector];
}

// query
- (long)countv:(va_list)ap {
NSMutableArray *array = self.array;
    if ( self.dims == 1 ) {
       return [array count];
    } else {
        for ( long d = 0; d < (self.dims - 1); d++ ) {
            long arg = va_arg(ap,long);
            array = [self array:array subarrayAtIndex:arg grow:NO];
        }
          return [array count];
    }
    return 0;
}

// read
- (BOOL)readFromURL:(NSURL *)url {
    self.array = [NSKeyedUnarchiver unarchiveObjectWithFile:[url path]];
    self.dims = [[self.array objectAtIndex:0] integerValue];
    [self.array removeObjectAtIndex:0];
    return ( self.array != nil );
}

// write
- (BOOL)writeToURL:(NSURL *)url {
    [self.array insertObject:@(self.dims) atIndex:0];
    BOOL flag = [NSKeyedArchiver archiveRootObject:self.array toFile:[url path]];
    [self.array removeObjectAtIndex:0];
    return flag;
}

// description
- (long)description:(NSMutableArray *)array indent:(long)indent string:(NSMutableString *)string emptyArrays:(BOOL)emptyArrays nulls:(BOOL)nulls classes:(BOOL)classes {
    indent++;
    NSString *indentSpaces = [@"" stringByPaddingToLength:indent*5 withString:@" " startingAtIndex:0];
    NSInteger count = [array count];
    for ( NSInteger index = 0; index < count; index++ ) {
        id obj = [array objectAtIndex:index];
        if ( [obj isKindOfClass:[NSMutableArray class]] ) {
            if ( [obj count] == 0 ) {
                if ( emptyArrays ) {
                    [string appendFormat:@"%@%lu: <empty>\r",indentSpaces,(unsigned long)index];
                }
            } else {
                [string appendFormat:@"%@%lu: \r",indentSpaces,(unsigned long)index];
                indent = [self description:obj indent:indent string:string emptyArrays:emptyArrays nulls:nulls classes:classes];
            }
        } else {
            if ( !( nulls == NO && [obj isEqualTo:[NSNull null]] ) ) {
                [string appendFormat:@"%@%lu: %@",indentSpaces,(unsigned long)index,obj];
            }
            
            if ( classes ) {
                NSString *className = NSStringFromClass([obj class]);
//                if ( [obj isKindOfClass:[NSNumber class]] ) {
//                    className = @"Number";
//                } else if ( [obj isKindOfClass:[NSString class]] ) {
//                    className = @"String";
//                } else if ( [obj isKindOfClass:[NSArray class]] ) {
//                    className = @"Array";
//                } else if ( [obj isKindOfClass:[NSDictionary class]] ) {
//                    className = @"Dictionary";
//                } else if ( [obj isKindOfClass:[NSColor class]] ) {
//                    className = @"Color";
//                } else if ( [obj isKindOfClass:[NSDate class]] ) {
//                    className = @"Date";
//                } else if ( [obj isKindOfClass:[NSFont class]] ) {
//                    className = @"Font";
//                } else if ( [obj isKindOfClass:[NSURL class]] ) {
//                    className = @"URL";
//                }
                [string appendFormat:@"          %@",className];
            }
            
            [string appendString:@"\r"];
        }
    }
    indent--;
    return indent;
}

- (NSString *)descriptionWithEmptyArrays:(BOOL)emptyArrays nulls:(BOOL)nulls classes:(BOOL)classes {
#if __has_feature(objc_arc)
    NSMutableString *string = [[NSMutableString alloc] initWithString:@"\r"];
#else
    NSMutableString *string = [[[NSMutableString alloc] initWithString:@"\r"] autorelease];
#endif
    [self description:self.array indent:0 string:string emptyArrays:emptyArrays nulls:nulls classes:classes];
    return string;
}

- (NSString *)descriptionWithTag:(long)tag emptyArrays:(BOOL)emptyArrays nulls:(BOOL)nulls classes:(BOOL)classes {
#if __has_feature(objc_arc)
    NSMutableString *string = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"< mda %ld >\r",tag]];
#else
    NSMutableString *string = [[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"< mda %ld >\r",tag]] autorelease];
#endif
    [self description:self.array indent:-1 string:string emptyArrays:emptyArrays nulls:nulls classes:classes];
    return string;
}

- (NSString *)description {
    return [self descriptionWithEmptyArrays:YES nulls:YES classes:NO];
}

- (void)textWithArray:(NSMutableArray *)array string:(NSMutableString *)string {
    NSInteger count = [array count];
    for ( NSInteger index = 0; index < count; index++ ) {
        id obj = [array objectAtIndex:index];
        if ( [obj isKindOfClass:[NSMutableArray class]] ) {
            if ( [obj count] > 0 ) {
                [self textWithArray:obj string:string];
                [string appendString:@"\n"];
            }
        } else {
            if ( self.dims > 1 ) {
                [string appendFormat:@"%@\t",obj];
            } else {
                [string appendFormat:@"%@\n",obj];
            }
        }
    }
}

- (NSString *)text {
    NSMutableString *string = [NSMutableString stringWithCapacity:0];
    [self textWithArray:self.array string:string];
    if ( [string hasSuffix:@"\t"] ) [string deleteCharactersInRange:NSMakeRange([string length]-1,1)];
    return string;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.array forKey:@"array"];
    [encoder encodeInteger:self.dims forKey:@"dims"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.array = [decoder decodeObjectForKey:@"array"];
        self.dims = [decoder decodeIntegerForKey:@"dims"];
    }
    return self;
}
@end

void MDAAlert_priv( NSString *msg, NSString *info )
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:msg];
    [alert setInformativeText:info];
    [alert addButtonWithTitle:@"Stop"];
    [alert addButtonWithTitle:@"Continue"];
    NSModalResponse response = [alert runModal];
    if ( response == NSAlertFirstButtonReturn ) [NSApp terminate:nil];
#if !__has_feature(objc_arc)
    [alert release];
#endif
}

void MDADimCountAlert_priv( long tag, long reqCount, long actCount )
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"mda array dim count error."];
    NSString *info = [NSString stringWithFormat:@"%ld dims specified for mda array '%ld'. Should be %ld.",actCount,tag,reqCount];
    [alert setInformativeText:info];
    [alert addButtonWithTitle:@"Stop"];
    [alert addButtonWithTitle:@"Continue"];
    NSModalResponse response = [alert runModal];
    if ( response == NSAlertFirstButtonReturn ) [NSApp terminate:nil];
#if !__has_feature(objc_arc)
    [alert release];
#endif
}

NSMutableDictionary *MDADict( void )
{
    if ( !sMDA_dict ) sMDA_dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    return sMDA_dict;
}

MDAObj *MDAWithTag_priv( long tag, BOOL create )
{
    if ( tag < 0 ) {// 20230726
        MDAAlert_priv( @"Bad tag value.", @"mda array tag values cannot be negative." );
        return nil;
    }
    
    if ( !sMDA_dict ) sMDA_dict = [[NSMutableDictionary alloc] initWithCapacity:0];

    NSString *key = [NSString stringWithFormat:@"%ld",tag];
    MDAObj *mda = [sMDA_dict valueForKey:key];
    if ( !mda ) {
        if ( create ) {
            mda = [[MDAObj alloc] init];
            [mda setArray:[[NSMutableArray alloc] initWithCapacity:0]];// 20230614
            [mda setDims:0];
            [sMDA_dict setValue:mda forKey:key];
        } else {
            //MDAAlert_priv( @"Array does not exist.", [NSString stringWithFormat:@"mda array %ld does not exist.",tag] );
        }
    }
    return mda;
}

// info
MDAObj *MDAWithTag( long tag )
{ return MDAWithTag_priv( tag, NO ); }

long MDADims( long tag )
{
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) return [mda dims];
    return 0;
}

CFMutableArrayRef MDAArray( long tag )
{
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) return (__bridge CFMutableArrayRef)[mda array];
    return nil;
}

Class MDAClass( long tag, long dimCount, long dim1, ... )
{
    id obj = nil;
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) {
        if ( mda.dims == dimCount ) {
            va_list ap;
            va_start(ap,dim1);
            obj = MDAObjectv( mda, dim1, ap );
            va_end(ap);
        } else {
            // error - wrong dim count
            MDADimCountAlert_priv( tag, mda.dims, dimCount );
        }
    }
    if ( obj ) return [obj class];
    return nil;
}


void MDASet( long tag, MDAObj *ref )
{
    NSMutableDictionary *mdaDict = MDADict();
    [mdaDict setValue:ref forKey:[NSString stringWithFormat:@"%ld",tag]];
}

// Get
id MDAObjectv( MDAObj *mda, long dim1, va_list ap )
{ return [mda objectv:dim1 args:ap]; }

//id MDAObjv( long tag, long dim1, va_list ap )
//{
//    MDAObj *mda = MDAWithTag_priv( tag, NO );
//    if ( mda ) {
//        return [mda objectv:tag args:ap];
//    }
//    return nil;
//}

CFTypeRef MDAObject( long tag, long dimCount, long dim1, ... )
{
    id obj = nil;
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) {
        if ( mda.dims == dimCount ) {
            va_list ap;
            va_start(ap,dim1);
            obj = MDAObjectv( mda, dim1, ap );
            va_end(ap);
        } else {
            // error - wrong dim count
            MDADimCountAlert_priv( tag, mda.dims, dimCount );
        }
    }
    return (__bridge CFTypeRef)obj;
}

//CFTypeRef MDAObject( long tag, long dimCount, long dim1, ... )
//{
//    id obj = nil;
//    MDAObj *mda = MDAWithTag_priv( tag, NO );
//    if ( mda ) {
//        if ( mda.dims >= dimCount ) {
//            va_list ap;
//            va_start(ap,dim1);
//            obj = MDAObjectv( mda, dim1, ap );
//            va_end(ap);
//        } else {
//            // error - wrong dim count
//            MDADimCountAlert_priv( tag, mda.dims, dimCount );
//        }
//    }
//    return obj;
//}

long MDAInteger( long tag, long dimCount, long dim1, ... )
{
    long value = 0;
    id obj = nil;
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) {
        if ( mda.dims == dimCount ) {
            va_list ap;
            va_start(ap,dim1);
            obj = MDAObjectv( mda, dim1, ap );
            va_end(ap);
            if ( obj ) {
                if ( [obj respondsToSelector:@selector(integerValue)] ) {
                    value = [obj integerValue];
                }
            }
        } else {
            // error - wrong dim count
            MDADimCountAlert_priv( tag, mda.dims, dimCount );
        }
    }
    return value;
}

double MDADouble( long tag, long dimCount, long dim1, ... )
{
    double value = 0.0;
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) {
        if ( mda.dims == dimCount ) {
            va_list ap;
            va_start(ap,dim1);
            id obj = MDAObjectv( mda, dim1, ap );
            va_end(ap);
            if ( obj ) {
                if ( [obj respondsToSelector:@selector(doubleValue)] ) {
                    value = [obj doubleValue];
                }
            }
        } else {
            // error - wrong dim count
            MDADimCountAlert_priv( tag, mda.dims, dimCount );
        }
    }
    return value;
}

// Find
long MDAFind( long tag, CFTypeRef obj, CFRange range )
{
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) {
        if ( range.length == -1 ) {
            return [mda findObject:(__bridge id)obj];
        } else {
            return [mda findObject:(__bridge id)obj inRange:NSRangeFromCFRange(range)];
        }
    }
    return NSNotFound;
}


// Add
void MDAAddObjectv( MDAObj *mda, id obj, va_list ap )
{ [mda addObjectv:obj args:ap]; }

void MDAAddObject( long tag, CFTypeRef obj, long dimCount, ... )
{
    MDAObj *mda = MDAWithTag_priv( tag, YES );
    if ( mda ) {
        if ( mda.dims == 0 ) mda.dims = dimCount;
        if ( dimCount == mda.dims || dimCount == (mda.dims - 1) ) {
            va_list ap;
            va_start(ap,dimCount);
            MDAAddObjectv( mda, (__bridge id)obj, ap );
            va_end(ap);
        } else {
            // error - wrong dim count
            MDADimCountAlert_priv( tag, mda.dims, dimCount );
        }
    }
}

void MDAAppendArray( long tag, CFArrayRef inArray, long dimCount, ... )
{
    MDAObj *mda = MDAWithTag_priv( tag, YES );
    if ( mda ) {
        if ( mda.dims == 0 ) mda.dims = dimCount;
        if ( dimCount == mda.dims || dimCount == (mda.dims - 1) ) {
            NSArray *array = (__bridge NSArray *)inArray;
            va_list ap;
            va_start(ap,dimCount);
            for ( id obj in array ) {
                MDAAddObjectv( mda, obj, ap );
            }
            va_end(ap);
        } else {
            // error - wrong dim count
            MDADimCountAlert_priv( tag, mda.dims, dimCount );
        }
    }
}

// Set
void MDASetObjectv( MDAObj *mda, id obj, va_list ap )
{ [mda setObjectv:obj args:ap]; }

void MDASetObject( long tag, CFTypeRef obj, long dimCount, ... )
{
    MDAObj *mda = MDAWithTag_priv( tag, YES );
    if ( mda ) {
        if ( mda.dims == 0 ) mda.dims = dimCount;
        if ( mda.dims == dimCount ) {
            va_list ap;
            va_start(ap,dimCount);
            MDASetObjectv( mda, (__bridge id)obj, ap );
            va_end(ap);
        } else {
            // error - wrong dim count
            MDADimCountAlert_priv( tag, mda.dims, dimCount );
        }
    }
}

// insert
void MDAInsertObjectv( MDAObj *mda, id obj, va_list ap )
{ [mda insertObjectv:obj args:ap]; }

void MDAInsertObject( long tag, CFTypeRef obj, long dimCount, ... )
{
    MDAObj *mda = MDAWithTag_priv( tag, YES );
    if ( mda ) {
        if ( mda.dims == 0 ) mda.dims = dimCount;
        if ( mda.dims == dimCount ) {
            va_list ap;
            va_start(ap,dimCount);
            MDAInsertObjectv( mda, (__bridge id)obj, ap );
            va_end(ap);
        } else {
            // error - wrong dim count
            MDADimCountAlert_priv( tag, mda.dims, dimCount );
        }
    }
}

// remove
void MDARemovev( MDAObj *mda, long length, long index, va_list ap )
{ [mda removev:length index:index args:ap]; }

void MDARemove( long tag, long length, long dimCount, long dim1, ... )
{
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) {
        if ( mda.dims == 0 ) mda.dims = dimCount;
        if ( mda.dims == dimCount ) {
            va_list ap;
            va_start(ap,dim1);
            MDARemovev( mda, length, dim1, ap );
            va_end(ap);
        } else {
            // error - wrong dim count
            MDADimCountAlert_priv( tag, mda.dims, dimCount );
        }
    }
}

void MDARemoveNulls( long tag )// deprecated
{
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    [mda removeNulls];
}

void MDAClear( long tag )
{
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) [mda removeAll];
}

void MDACompact( long tag )
{
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    [mda compact];
}

void MDACopy( long tag1, long tag2 )
{
    MDAObj *mda2 = MDAWithTag_priv( tag2, NO );
    if ( mda2 ) {
        MDAObj *mda1 = MDAWithTag_priv( tag1, NO );
        if ( mda1 ) MDAKill( tag1 );
        mda1 = MDAWithTag_priv( tag1, YES );
        mda1.dims = mda2.dims;
        mda1.array = [[NSMutableArray alloc] initWithArray:mda2.array];
    }
}

// swap
//void MDASwapv( MDAObj *mda1, long dimCount1, va_list ap )
//{
//    id obj1 = [mda1 objectv:ap];
//    if ( obj1 ) {
//        long tag2 = va_arg(ap,long);
//        MDAObj *mda2 = MDAWithTag_priv( tag2, NO );
//        if ( mda2 ) {
//            
//        }
//    }
//}
//
//void MDASwap( long tag1, long dimCount1, ... )
//{
//    // mda1
//    MDAObj *mda1 = MDAWithTag_priv( tag1, NO );
//    if ( mda1 ) {
//        if ( mda1.dims == 0 ) mda1.dims = dimCount1;
//        if ( mda1.dims == dimCount1 ) {
//            va_list ap;
//            va_start(ap,dimCount1);
//            MDASwapv( mda1, dimCount1, ap );
//            va_end(ap);
//        } else {
//            // error - wrong dim count
//            MDADimCountAlert_priv( tag1, mda1.dims, dimCount1 );
//        }
//    }
//}

// sort
void MDASort( long tag, CFStringRef selector )
{
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) [mda sortUsingSelector:(__bridge NSString *)selector];
}

// delete
void MDAKill( long tag )
{ [sMDA_dict removeObjectForKey:[NSString stringWithFormat:@"%ld",tag]]; }

// count
long MDACountv( MDAObj *mda, va_list ap )
{ return [mda countv:ap]; }

long MDACount( long tag, ... )
{
    long count = 0;
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) {
        va_list ap;
        va_start(ap,tag);
        count = MDACountv( mda, ap );
        va_end(ap);
    }
    return count;
}

// read
BOOL MDARead( long tag, CFURLRef url )
{
    MDAObj *mda = MDAWithTag_priv( tag, YES );
    if ( mda ) return [mda readFromURL:(__bridge NSURL *)url];
    return NO;
}

// write
BOOL MDAWrite( long tag, CFURLRef url )
{
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) return [mda writeToURL:(__bridge NSURL *)url];
    return NO;
}

// description
CFStringRef MDADescription( long tag, BOOL emptyArrays, BOOL nulls, BOOL classes )
{
    CFStringRef description = nil;
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) description = (__bridge CFStringRef)[mda descriptionWithTag:tag emptyArrays:emptyArrays nulls:nulls classes:classes];
    return description;
}


// text
CFStringRef MDAText( long tag )
{
    NSString *string = nil;
    MDAObj *mda = MDAWithTag_priv( tag, NO );
    if ( mda ) string = [mda text];
    return (__bridge CFStringRef)string;
}

