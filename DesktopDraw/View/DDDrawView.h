//
//  ANDrawView.h
//  DesktopDraw
//
//  Created by Alex Nichol on 12/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DDIconPath.h"

@interface DDDrawView : NSView {
    DDIconPath * path;
}

@property (readonly) DDIconPath * path;

- (void)updatePath:(DDIconPath *)aPath;
- (void)clearPath;
- (CGPoint)convertPointToRelativeCoords:(NSPoint)point;

@end
