//
//  DDUndoController.h
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDIconUndoStack.h"
#import "DDDocument.h"

@interface DDUndoController : NSObject {
    DDIconUndoStack * stack;
}

@property (readwrite) BOOL canUndo;
@property (readwrite) BOOL canRedo;

- (IBAction)undo:(id)sender;
- (IBAction)redo:(id)sender;

- (void)handleChange:(NSNotification *)note;

@end
