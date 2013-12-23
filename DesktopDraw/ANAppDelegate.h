//
//  ANAppDelegate.h
//  DesktopDraw
//
//  Created by Alex Nichol on 12/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANDrawWC.h"

@interface ANAppDelegate : NSObject <NSApplicationDelegate, ANDrawWCDelegate> {
    ANDrawWC * currentWC;
    IBOutlet NSMenuItem * redoItem;
    IBOutlet NSMenuItem * undoItem;
}

+ (NSString *)savePathName;

- (void)updateEnabledMenuItems;

- (IBAction)redo:(id)sender;
- (IBAction)undo:(id)sender;

- (void)newDocument;

@end
