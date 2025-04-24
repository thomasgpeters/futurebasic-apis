/*
 QLPreviewReply.h

 Bernie Wylde
 */

#import "CocoaUI.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED >= 120000

API_AVAILABLE(macos(12.0))
typedef PDFDocument *(*CUI_QLPreviewReplyForPDFWithPageSizeHandlerType)(QLPreviewReply*,NSError**,void*);
API_AVAILABLE(macos(12.0))
typedef NSData *(*CUI_QLPreviewReplyWithDataOfContentTypeHandlerType)(QLPreviewReply*,NSError**,void*);
API_AVAILABLE(macos(12.0))
typedef BOOL (*CUI_QLPreviewReplyWithContextSizeHandlerType)(CGContextRef,QLPreviewReply*,NSError**,void*);

// Create
API_AVAILABLE(macos(12.0))
QLPreviewReply *QLPreviewReplyWithFileURL( CFURLRef url );
API_AVAILABLE(macos(12.0))
QLPreviewReply *QLPreviewReplyForPDFWithPageSize( CGSize defaultPageSize, CUI_QLPreviewReplyForPDFWithPageSizeHandlerType pdfDocumentCreationHandler, void *userData );
API_AVAILABLE(macos(12.0))
QLPreviewReply *QLPreviewReplyWithDataOfContentType( UTType *type, CGSize contentSize, CUI_QLPreviewReplyWithDataOfContentTypeHandlerType dataCreationHandler, void *userData );
API_AVAILABLE(macos(12.0))
QLPreviewReply *QLPreviewReplyWithContextSize( CGSize contextSize, BOOL isBitmap, CUI_QLPreviewReplyWithContextSizeHandlerType contextCreationHandler, void *userData );

// Inspect
API_AVAILABLE(macos(12.0))
CFStringRef QLPreviewReplyTitle( QLPreviewReply *ref );
API_AVAILABLE(macos(12.0))
void QLPreviewReplySetTitle( QLPreviewReply *ref, CFStringRef title );
API_AVAILABLE(macos(12.0))
CFDictionaryRef QLPreviewReplyAttachments( QLPreviewReply *ref );
API_AVAILABLE(macos(12.0))
void QLPreviewReplySetAttachments( QLPreviewReply *ref, CFDictionaryRef attachments );
API_AVAILABLE(macos(12.0))
NSStringEncoding QLPreviewReplyStringEncoding( QLPreviewReply *ref );
API_AVAILABLE(macos(12.0))
void QLPreviewReplySetStringEncoding( QLPreviewReply *ref, NSStringEncoding encoding );


#pragma mark - QLPreviewReplyAttachment

// Create
API_AVAILABLE(macos(12.0))
QLPreviewReplyAttachment *QLPreviewReplyAttachmentWithData( CFDataRef dta, UTType *type );

// Inspect
API_AVAILABLE(macos(12.0))
UTType *QLPreviewReplyAttachmentContentType( QLPreviewReplyAttachment *ref );
API_AVAILABLE(macos(12.0))
CFDataRef QLPreviewReplyAttachmentData( QLPreviewReplyAttachment *ref );

#endif// 120000

