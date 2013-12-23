//
//  ANDrawWC.m
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDrawWC.h"

@interface ANDrawWC ()

@end

@implementation ANDrawWC

@synthesize undoStack;

- (id)init {
    if ((self = [super initWithWindowNibName:@"ANDrawWC"])) {
        undoStack = [[ANIconUndoStack alloc] init];
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    // resize the window accordingly
    [self scaleProperly:nil];
    self.window.delegate = self;
}

- (void)windowDidBecomeKey:(NSNotification *)notification {
    [self.delegate drawWCFocused:self];
}

#pragma mark - Actions -

- (IBAction)scaleProperly:(id)sender {
    // get the scale of the current NSScreen
    NSScreen * screen = self.window.screen;
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
    NSRect windowFrame = self.window.frame;
    CGFloat addWidth = drawFrame.size.width - self.draw.frame.size.width;
    CGFloat addHeight = drawFrame.size.height - self.draw.frame.size.height;
    windowFrame.size.width += addWidth;
    windowFrame.size.height += addHeight;
    [self.window setFrame:windowFrame display:YES animate:YES];
}

- (IBAction)positionIcons:(id)sender {
    ANIconArrangement * arr = [self.draw.path currentArrangement];
    [undoStack pushArrangement:arr];
    [self.draw.path applyToDesktop:self.window.screen];
    [undoStack pushArrangement:[self.draw.path currentArrangement]];
    [self.delegate drawWCChangedStack:self];
}

- (IBAction)clear:(id)sender {
    [self.draw clearPath];
}

#pragma mark - Undo & Redo -

- (IBAction)undo:(id)sender {
    // shift in the undo manager
    [undoStack undo];
}

- (IBAction)redo:(id)sender {
    // shift in the undo manager
    [undoStack redo];
}

@end
