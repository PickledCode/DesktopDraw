//
//  DDDocument.m
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "DDDocument.h"

@implementation DDDocument

- (id)init {
    self = [super init];
    if (self) {
        [self clear:nil];
    }
    return self;
}

- (NSString *)windowNibName {
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"DDDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController {
    [super windowControllerDidLoadNib:aController];
    NSRect frame = aController.window.frame;
    frame.size = [self sizeForScreen];
    [self.mainWindow setFrame:frame display:YES animate:NO];
    if (_loadedPath) [self.draw updatePath:_loadedPath];
}

+ (BOOL)autosavesInPlace {
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    return [NSKeyedArchiver archivedDataWithRootObject:self.draw.path];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    _loadedPath = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (self.draw) [self.draw updatePath:_loadedPath];
    return YES;
}

- (NSSize)sizeForScreen {
    NSScreen * screen = self.mainWindow.screen;
    NSSize size = screen.frame.size;
    NSRect drawFrame = self.draw.frame;
    // inspect the ratio of drawFrame and see which dimension we need to change
    if (drawFrame.size.width / drawFrame.size.height < size.width / size.height) {
        // it is not wide enough
        drawFrame.size.width = drawFrame.size.height * size.width / size.height;
    } else {
        // it may not be tall enough
        drawFrame.size.height = drawFrame.size.width * size.height / size.width;
    }
    NSRect windowFrame = self.mainWindow.frame;
    CGFloat addWidth = drawFrame.size.width - self.draw.frame.size.width;
    CGFloat addHeight = drawFrame.size.height - self.draw.frame.size.height;
    windowFrame.size.width += addWidth;
    windowFrame.size.height += addHeight;
    return windowFrame.size;
}

#pragma mark - Actions -

- (IBAction)scaleProperly:(id)sender {
    NSRect frame = self.mainWindow.frame;
    frame.size = [self sizeForScreen];
    [self.mainWindow setFrame:frame display:YES animate:YES];
}

- (IBAction)positionIcons:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:DDDocumentWillRearrangeNotification object:self];
    [self.draw.path applyToDesktop:self.mainWindow.screen];
    [[NSNotificationCenter defaultCenter] postNotificationName:DDDocumentDidRearrangeNotification object:self];
}

- (IBAction)clear:(id)sender {
    [self.draw clearPath];
}

@end
