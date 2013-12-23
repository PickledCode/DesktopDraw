//
//  ANDrawWC.h
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANDrawView.h"
#import "ANIconUndoStack.h"

@protocol ANDrawWCDelegate

- (void)drawWCFocused:(id)sender;
- (void)drawWCChangedStack:(id)sender;

@end

@interface ANDrawWC : NSWindowController <NSWindowDelegate> {
    ANIconUndoStack * undoStack;
}

@property (nonatomic) IBOutlet ANDrawView * draw;
@property (readonly) ANIconUndoStack * undoStack;
@property (nonatomic, weak) id<ANDrawWCDelegate> delegate;

- (id)initWithUndoStack:(ANIconUndoStack *)aStack;

- (IBAction)scaleProperly:(id)sender;
- (IBAction)positionIcons:(id)sender;
- (IBAction)clear:(id)sender;
- (IBAction)undo:(id)sender;
- (IBAction)redo:(id)sender;

@end
