//
//  ANIconUndoStack.h
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDIconArrangement.h"

#define kMaximumStackSize 100

@interface DDIconUndoStack : NSObject <NSCoding> {
    NSMutableArray * undoStack;
    NSMutableArray * redoStack;
}

@property (readonly) DDIconArrangement * currentArrangement;

- (void)pushArrangement:(DDIconArrangement *)arr;

- (BOOL)canUndo;
- (BOOL)canRedo;
- (void)undo;
- (void)redo;

@end
