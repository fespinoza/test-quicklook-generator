#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <Cocoa/Cocoa.h>
#include <QuickLook/QuickLook.h>
#include "QuickLookTestGenerator-Swift.h"

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

/* -----------------------------------------------------------------------------
 Generate a preview for file

 This function's job is to create preview for designated file
 ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
  @autoreleasepool {
    NSSize canvasSize = NSMakeSize(600, 300);

    NSLog(@"Quicklook Init! %@, contentType %@", url, contentTypeUTI);

    HelloWorld *sample = [[HelloWorld alloc] init];

    NSLog(@"Quicklook: %@", [sample sayHello]);

    [NSKeyedUnarchiver setClass:[DocumentData class] forClassName:@"LinkedIdeas.DocumentData"];
    [NSKeyedUnarchiver setClass:[Concept class] forClassName:@"LinkedIdeas.Concept"];
    [NSKeyedUnarchiver setClass:[Link class] forClassName:@"LinkedIdeas.Link"];

    DocumentManager *manager = [[DocumentManager alloc] init];

    manager.url = (__bridge NSURL *)url;
    manager.contentTypeUTI = (__bridge NSString *)contentTypeUTI;




    // Preview will be drawn in a vectorized context
    CGContextRef cgContext = QLPreviewRequestCreateContext(preview, *(CGSize *)&canvasSize, false, NULL);

    NSLog(@"Quick look generator %@", url);

    if(cgContext) {


      NSGraphicsContext* context = [NSGraphicsContext graphicsContextWithGraphicsPort:(void *)cgContext flipped:YES];

      if (context) {

        [NSGraphicsContext saveGraphicsState];
        [NSGraphicsContext setCurrentContext:context];

        // This is where you draw anything

        // - [x] open document
        // - [x] read information
        // - [ ] generate view moodels
        // - [ ] create view and connect data
        // - [ ] render

        [manager processDocumentWithCanvasSize:canvasSize context:context];
        
//
//        [[NSColor redColor] set];
//        NSRectFill(NSMakeRect(0, 0, 600, 300));
//
//        [[NSColor blueColor] set];
//        NSRectFill(NSMakeRect(100, 100, 100, 100));

        [NSGraphicsContext restoreGraphicsState];

      }
      QLPreviewRequestFlushContext(preview, cgContext);
      CFRelease(cgContext);
    }
  }
  return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
  // Implement only if supported
}
