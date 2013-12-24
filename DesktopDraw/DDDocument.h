//
//  DDDocument.h
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DDDrawView.h"

#define DDDocumentWillRearrangeNotification @"DDDocumentWillRearrangeNotification"
#define DDDocumentDidRearrangeNotification @"DDDocumentDidRearrangeNotification"

@interface DDDocument : NSDocument {
    DDIconPath * _loadedPath;
}

@property (nonatomic) IBOutlet DDDrawView * draw;
@property (nonatomic) IBOutlet NSWindow * mainWindow;

- (NSSize)sizeForScreen;
- (IBAction)scaleProperly:(id)sender;
- (IBAction)positionIcons:(id)sender;
- (IBAction)clear:(id)sender;

@end
