/*
 Stream.h

 Bernie Wylde
 */


#import "CocoaUI.h"

#pragma mark - Stream
// Delegate
typedef void (*CUI_StreamDelegateCallbackType)(NSStream*,NSStreamEvent,void*);

@interface CUI_StreamDelegate : NSObject <NSStreamDelegate>
@property (nonatomic,assign) CUI_StreamDelegateCallbackType callback;
@property (nonatomic,assign) void *userData;
@end

// Class
Class StreamClass( void );

// Configure
CFTypeRef StreamPropertyForKey( NSStream *ref, CFStringRef key );
void StreamSetPropertyForKey( NSStream *ref, CFTypeRef property, CFStringRef key );
void StreamSetDelegateCallback( NSStream *ref, CUI_StreamDelegateCallbackType callback, void *userData );

// Using
void StreamOpen( NSStream *ref );
void StreamClose( NSStream *ref );

// Run loops
void StreamScheduleInRunLoop( NSStream *ref, NSRunLoop *runLoop, CFStringRef runLoopMode );
void StreamRemoveFromRunLoop( NSStream *ref, NSRunLoop *runLoop, CFStringRef runLoopMode );

// Info
NSStreamStatus StreamStatus( NSStream *ref );
NSError *StreamError( NSStream *ref );

// Type methods
void StreamGetBoundStreams( NSUInteger bufferSize, NSInputStream **inputStream, NSOutputStream **outputStream );
void StreamGetStreamsToHostWithName( CFStringRef hostname, NSInteger port, NSInputStream **inputStream, NSOutputStream **outputStream );


#pragma mark - InputStream
// Create
NSInputStream *InputStreamWithData( CFDataRef dta );
NSInputStream *InputStreamWithURL( CFURLRef url );

// Using
NSInteger InputStreamRead( NSInputStream *ref, void *buffer, NSUInteger maxLength );
BOOL InputStreamGetBuffer( NSInputStream *ref, void *buffer, NSUInteger *length );
BOOL InputStreamHasBytesAvailable( NSInputStream *ref );


#pragma mark - OutputStream
// Create
NSOutputStream *OutputStreamToMemory( void );
NSOutputStream *OutputStreamToBuffer( void *buffer, NSUInteger capacity );
NSOutputStream *OutputStreamWithURL( CFURLRef url, BOOL append );

// Using
BOOL OutputStreamHasSpaceAvailable( NSOutputStream *ref );
NSInteger OutputStreamWrite( NSOutputStream *ref, void *buffer, NSUInteger maxLength );
