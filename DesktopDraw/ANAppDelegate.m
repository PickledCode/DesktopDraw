//
//  ANAppDelegate.m
//  DesktopDraw
//
//  Created by Alex Nichol on 12/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANAppDelegate.h"

@implementation ANAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // do something here to create a new document
    [self newDocument];
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
    [self updateEnabledMenuItems];
}

- (IBAction)undo:(id)sender {
    [currentWC undo:sender];
    [self updateEnabledMenuItems];
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
