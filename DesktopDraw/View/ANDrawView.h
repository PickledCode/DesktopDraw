//
//  ANDrawView.h
//  DesktopDraw
//
//  Created by Alex Nichol on 12/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ANIconPath.h"

@interface ANDrawView : NSView {
    ANIconPath * path;
}

@property (readonly) ANIconPath * path;

- (void)clearPath;
- (CGPoint)convertPointToRelativeCoords:(NSPoint)point;

@end
