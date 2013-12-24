//
//  ANIconPath.h
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Finder.h"
#import "DDIconArrangement.h"

#define kANIconPathBuffer 128

/**
 * Stores an array of lines.
 */
@interface DDIconPath : NSObject <NSCoding> {
    CGPoint * lines; // relative to the desktop, 0.0-1.0
    CGPoint currentPoint;
    
    NSInteger pointCount, pointAlloc;
    CGFloat length;
}

/**
 * Move to a point in relative coordinates.
 */
- (void)moveToPoint:(CGPoint)point;

/**
 * Add a point to the path in relative coordinates
 */
- (void)addPoint:(CGPoint)point;

/**
 * Used to stroke in the context
 */
- (void)addToContext:(CGContextRef)context size:(CGSize)scale;

/**
 * Apply the path to the desktop icons.
 */
- (void)applyToDesktop:(NSScreen *)theScreen;

/**
 * Iterate the segments in order to find the point after a certain
 * length along the path.
 */
- (void)iterateSegments:(void (^)(int pIndex, CGFloat distance, CGFloat endDistance, BOOL * done))callback;

@end
