//
//  DDUndoController.m
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "DDUndoController.h"

@implementation DDUndoController

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChange:) name:DDDocumentWillRearrangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChange:) name:DDDocumentDidRearrangeNotification object:nil];
    stack = [[DDIconUndoStack alloc] init];
}

- (IBAction)undo:(id)sender {
    [stack undo];
    self.canUndo = stack.canUndo;
    self.canRedo = stack.canRedo;
}

- (IBAction)redo:(id)sender {
    [stack redo];
    self.canUndo = stack.canUndo;
    self.canRedo = stack.canRedo;
}

- (void)handleChange:(NSNotification *)note {
    DDIconArrangement * arrangement = [DDIconArrangement currentArrangement];
    [stack pushArrangement:arrangement];
    self.canUndo = stack.canUndo;
    self.canRedo = stack.canRedo;
}

@end
