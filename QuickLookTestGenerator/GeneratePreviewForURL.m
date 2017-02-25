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


//    Document *document = [[Document alloc] init];

    NSLog(@"Quicklook Init! %@", url);

    HelloWorld *sample = [[HelloWorld alloc] init];

    NSLog(@"Quicklook: %@", [sample sayHello]);

//    if(![document readFromURL:(__bridge NSURL *)url ofType:(__bridge NSString *)contentTypeUTI]) {
//      return noErr;
//    }

//    NSLog(@"Quick look generator DOCUMENT %@", document);

    // Preview will be drawn in a vectorized context
    CGContextRef cgContext = QLPreviewRequestCreateContext(preview, *(CGSize *)&canvasSize, false, NULL);

    NSLog(@"Quick look generator %@", url);

    if(cgContext) {


      NSGraphicsContext* context = [NSGraphicsContext graphicsContextWithGraphicsPort:(void *)cgContext flipped:YES];

      if (context) {

        [NSGraphicsContext saveGraphicsState];
        [NSGraphicsContext setCurrentContext:context];

        // This is where you draw anything

        // - open document
        // - read information
        // - generate view moodels
        // - create view and connect data
        // - render

        [[NSColor redColor] set];
        NSRectFill(NSMakeRect(0, 0, 600, 300));

        [[NSColor blueColor] set];
        NSRectFill(NSMakeRect(100, 100, 100, 100));

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
