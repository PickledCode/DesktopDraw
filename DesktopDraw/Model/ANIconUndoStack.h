//
//  ANIconUndoStack.h
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANIconArrangement.h"

#define kMaximumStackSize 100

@interface ANIconUndoStack : NSObject <NSCoding> {
    NSMutableArray * undoStack;
    NSMutableArray * redoStack;
}

@property (readonly) ANIconArrangement * currentArrangement;

- (void)pushArrangement:(ANIconArrangement *)arr;

- (BOOL)canUndo;
- (BOOL)canRedo;
- (void)undo;
- (void)redo;

@end
