//
//  ANAppDelegate.m
//  DesktopDraw
//
//  Created by Alex Nichol on 12/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAppDelegate.h"

@implementation ANAppDelegate

+ (NSString *)savePathName {
    NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support"];
    path = [path stringByAppendingPathComponent:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    path = [path stringByAppendingPathComponent:@"undostack.dat"];
    return path;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // do something here to create a new document
    [self newDocument];
    [self updateEnabledMenuItems];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

- (void)updateEnabledMenuItems {
    if (currentWC.undoStack.canRedo) {
        [redoItem setAction:@selector(redo:)];
    } else {
        [redoItem setAction:nil];
    }
    if (currentWC.undoStack.canUndo) {
        [undoItem setAction:@selector(undo:)];
    } else {
        [undoItem setAction:nil];
    }
}

- (IBAction)redo:(id)sender {
    [currentWC redo:sender];
    [self drawWCChangedStack:currentWC];
}

- (IBAction)undo:(id)sender {
    [currentWC undo:sender];
    [self drawWCChangedStack:currentWC];
}

- (void)newDocument {
    ANDrawWC * draw = [[ANDrawWC alloc] init];
    [draw showWindow:nil];
    currentWC = draw;
    draw.delegate = self;
}

#pragma mark - Draw Delegate -

- (void)drawWCFocused:(id)sender {
    currentWC = sender;
}

- (void)drawWCChangedStack:(id)sender {
    if (sender == currentWC) [self updateEnabledMenuItems];
}

@end
