//
//  ANIconUndoStack.m
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANIconUndoStack.h"

@implementation ANIconUndoStack

- (id)init {
    if ((self = [super init])) {
        undoStack = [NSMutableArray array];
        redoStack = [NSMutableArray array];
    }
    return self;
}

- (ANIconArrangement *)currentArrangement {
    return undoStack.lastObject;
}

- (void)pushArrangement:(ANIconArrangement *)arr {
    [redoStack removeAllObjects];
    if ([self.currentArrangement isEqualToArrangement:arr]) return;
    [undoStack addObject:arr];
}

- (BOOL)canUndo {
    return undoStack.count > 1;
}

- (BOOL)canRedo {
    return redoStack.count > 0;
}

- (void)undo {
    NSAssert(self.canUndo, @"Cannot undo!");
    [redoStack addObject:undoStack.lastObject];
    [undoStack removeLastObject];
    
    FinderApplication * app = [SBApplication applicationWithBundleIdentifier:@"com.apple.Finder"];
    [undoStack.lastObject applyToDesktop:app.desktop];
    
    while (undoStack.count > kMaximumStackSize) {
        [undoStack removeObjectAtIndex:0];
    }
}

- (void)redo {
    NSAssert(self.canRedo, @"Cannot redo!");
    [undoStack addObject:redoStack.lastObject];
    [redoStack removeLastObject];
    
    FinderApplication * app = [SBApplication applicationWithBundleIdentifier:@"com.apple.Finder"];
    [undoStack.lastObject applyToDesktop:app.desktop];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        undoStack = [[aDecoder decodeObject] mutableCopy];
        redoStack = [[aDecoder decodeObject] mutableCopy];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:undoStack];
    [aCoder encodeObject:redoStack];
}

@end
