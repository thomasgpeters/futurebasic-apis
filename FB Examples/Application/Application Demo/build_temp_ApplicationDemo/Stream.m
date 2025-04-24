/*
 Stream.m

 Bernie Wylde
 */

#import "Stream.h"

#pragma mark - Stream
// Delegate
@implementation CUI_StreamDelegate

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    (*self.callback)( aStream, eventCode, self.userData );
}

@end

//CUI_StreamDelegate *sCUI_StreamDelegate;

// Class
Class StreamClass( void )
{ return [NSStream class]; }

// Configure
CFTypeRef StreamPropertyForKey( NSStream *ref, CFStringRef key )
{ return (__bridge CFTypeRef)[ref propertyForKey:(__bridge NSString *)key]; }

void StreamSetPropertyForKey( NSStream *ref, CFTypeRef property, CFStringRef key )
{ [ref setProperty:(__bridge id)property forKey:(__bridge NSString *)key]; }

void StreamSetDelegateCallback( NSStream *ref, CUI_StreamDelegateCallbackType callback, void *userData )
{
    CUI_StreamDelegate *delegate = [[CUI_StreamDelegate alloc] init];
    [delegate setCallback:callback];
    [delegate setUserData:userData];
    [ref setDelegate:delegate];
    
//    sCUI_StreamDelegate = [[CUI_StreamDelegate alloc] init];
//    [sCUI_StreamDelegate setCallback:callback];
//    [sCUI_StreamDelegate setUserData:userData];
//    [ref setDelegate:sCUI_StreamDelegate];
}

// Using
void StreamOpen( NSStream *ref )
{ [ref open]; }

void StreamClose( NSStream *ref )
{ [ref close]; }

// Run loops
void StreamScheduleInRunLoop( NSStream *ref, NSRunLoop *runLoop, CFStringRef runLoopMode )
{ [ref scheduleInRunLoop:runLoop forMode:(__bridge NSString *)runLoopMode]; }

void StreamRemoveFromRunLoop( NSStream *ref, NSRunLoop *runLoop, CFStringRef runLoopMode )
{ [ref removeFromRunLoop:runLoop forMode:(__bridge NSString *)runLoopMode]; }

// Info
NSStreamStatus StreamStatus( NSStream *ref )
{ return [ref streamStatus]; }

NSError *StreamError( NSStream *ref )
{ return [ref streamError]; }

// Type methods
void StreamGetBoundStreams( NSUInteger bufferSize, NSInputStream **inputStream, NSOutputStream **outputStream )
{ [NSStream getBoundStreamsWithBufferSize:bufferSize inputStream:inputStream outputStream:outputStream]; }

void StreamGetStreamsToHostWithName( CFStringRef hostname, NSInteger port, NSInputStream **inputStream, NSOutputStream **outputStream )
{ [NSStream getStreamsToHostWithName:(__bridge NSString *)hostname port:port inputStream:inputStream outputStream:outputStream]; }


#pragma mark - InputStream
// Create
NSInputStream *InputStreamWithData( CFDataRef dta )
{ return [NSInputStream inputStreamWithData:(__bridge NSData *)dta]; }

NSInputStream *InputStreamWithURL( CFURLRef url )
{ return [NSInputStream inputStreamWithURL:(__bridge NSURL *)url]; }

// Using
NSInteger InputStreamRead( NSInputStream *ref, void *buffer, NSUInteger maxLength )
{ return [ref read:buffer maxLength:maxLength]; }

BOOL InputStreamGetBuffer( NSInputStream *ref, void *buffer, NSUInteger *length )
{ return [ref getBuffer:buffer length:length]; }

BOOL InputStreamHasBytesAvailable( NSInputStream *ref )
{ return [ref hasBytesAvailable]; }


#pragma mark - OutputStream
// Create
NSOutputStream *OutputStreamToMemory( void )
{ return [NSOutputStream outputStreamToMemory]; }

NSOutputStream *OutputStreamToBuffer( void *buffer, NSUInteger capacity )
{ return [NSOutputStream outputStreamToBuffer:buffer capacity:capacity]; }

NSOutputStream *OutputStreamWithURL( CFURLRef url, BOOL append )
{ return [NSOutputStream outputStreamWithURL:(__bridge NSURL *)url append:append]; }

// Using
BOOL OutputStreamHasSpaceAvailable( NSOutputStream *ref )
{ return [ref hasSpaceAvailable]; }

NSInteger OutputStreamWrite( NSOutputStream *ref, void *buffer, NSUInteger maxLength )
{ return [ref write:buffer maxLength:maxLength]; }

