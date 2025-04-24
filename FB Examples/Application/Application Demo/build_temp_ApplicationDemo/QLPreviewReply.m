/*
 QLPreviewReply.m

 Bernie Wylde
 */

#import "QLPreviewReply.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000

// Create
QLPreviewReply *QLPreviewReplyWithFileURL( CFURLRef url )
{
#if __has_feature(objc_arc)
    return [[QLPreviewReply alloc] initWithFileURL:(__bridge NSURL *)url];
#else
    return [[[QLPreviewReply alloc] initWithFileURL:(__bridge NSURL *)url] autorelease];
#endif
}

QLPreviewReply *QLPreviewReplyForPDFWithPageSize( CGSize defaultPageSize, CUI_QLPreviewReplyForPDFWithPageSizeHandlerType pdfDocumentCreationHandler, void *userData )
{
#if __has_feature(objc_arc)
    return [[QLPreviewReply alloc] initForPDFWithPageSize:defaultPageSize documentCreationBlock:^(QLPreviewReply *reply, NSError **error) {
        return (*pdfDocumentCreationHandler)(reply,error,userData);
    }];
#else
    return [[[QLPreviewReply alloc] initForPDFWithPageSize:defaultPageSize documentCreationBlock:^(QLPreviewReply *reply, NSError **error) {
        return (*pdfDocumentCreationHandler)(reply,error,userData);
    }] autorelease];
#endif
}

QLPreviewReply *QLPreviewReplyWithDataOfContentType( UTType *type, CGSize contentSize, CUI_QLPreviewReplyWithDataOfContentTypeHandlerType dataCreationHandler, void *userData )
{
#if __has_feature(objc_arc)
    return [[QLPreviewReply alloc] initWithDataOfContentType:type contentSize:contentSize dataCreationBlock:^(QLPreviewReply *reply, NSError **error) {
        return (*dataCreationHandler)(reply,error,userData);
    }];
#else
    return [[[QLPreviewReply alloc] initWithDataOfContentType:type contentSize:contentSize dataCreationBlock:^(QLPreviewReply *reply, NSError **error) {
        return (*dataCreationHandler)(reply,error,userData);
    }] autorelease];
#endif
}

QLPreviewReply *QLPreviewReplyWithContextSize( CGSize contextSize, BOOL isBitmap, CUI_QLPreviewReplyWithContextSizeHandlerType contextCreationHandler, void *userData )
{
#if __has_feature(objc_arc)
    return [[QLPreviewReply alloc] initWithContextSize:contextSize isBitmap:isBitmap drawingBlock:^(CGContextRef context, QLPreviewReply *reply, NSError **error) {
        return (*contextCreationHandler)(context,reply,error,userData);
    }];
#else
    return [[[QLPreviewReply alloc] initWithContextSize:contextSize isBitmap:isBitmap drawingBlock:^(CGContextRef context, QLPreviewReply *reply, NSError **error) {
        return (*contextCreationHandler)(context,reply,error,userData);
    }] autorelease];
#endif
}

// Inspect
CFStringRef QLPreviewReplyTitle( QLPreviewReply *ref )
{ return (__bridge CFStringRef)[ref title]; }

void QLPreviewReplySetTitle( QLPreviewReply *ref, CFStringRef title )
{ [ref setTitle:(__bridge NSString *)title]; }

CFDictionaryRef QLPreviewReplyAttachments( QLPreviewReply *ref )
{ return (__bridge CFDictionaryRef)[ref attachments]; }

void QLPreviewReplySetAttachments( QLPreviewReply *ref, CFDictionaryRef attachments )
{ [ref setAttachments:(__bridge NSDictionary *)attachments]; }

NSStringEncoding QLPreviewReplyStringEncoding( QLPreviewReply *ref )
{ return [ref stringEncoding]; }

void QLPreviewReplySetStringEncoding( QLPreviewReply *ref, NSStringEncoding encoding )
{ [ref setStringEncoding:encoding]; }


#pragma mark - QLPreviewReplyAttachment

// Create
QLPreviewReplyAttachment *QLPreviewReplyAttachmentWithData( CFDataRef dta, UTType *type )
{
#if __has_feature(objc_arc)
    return [[QLPreviewReplyAttachment alloc] initWithData:(__bridge NSData *)dta contentType:type];
#else
    return [[[QLPreviewReplyAttachment alloc] initWithData:(__bridge NSData *)dta contentType:type] autorelease];
#endif
}

// Inspect
UTType *QLPreviewReplyAttachmentContentType( QLPreviewReplyAttachment *ref )
{ return [ref contentType]; }

CFDataRef QLPreviewReplyAttachmentData( QLPreviewReplyAttachment *ref )
{ return (__bridge CFDataRef)[ref data]; }

#endif// 120000

