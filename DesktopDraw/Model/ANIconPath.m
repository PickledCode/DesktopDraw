//
//  ANIconPath.m
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANIconPath.h"

static CGPoint distanceAlong(CGPoint s, CGPoint e, CGFloat d);

@interface ANIconPath (Private)

- (void)putIcon:(FinderItem *)item atPoint:(CGPoint)p onScreen:(NSScreen *)s;

@end

@implementation ANIconPath

- (id)init {
    if ((self = [super init])) {
        pointAlloc = kANIconPathBuffer;
        lines = (CGPoint *)malloc(sizeof(CGPoint) * pointAlloc);
        application = [SBApplication applicationWithBundleIdentifier:@"com.apple.Finder"];
    }
    return self;
}

- (void)moveToPoint:(CGPoint)point {
    currentPoint = point;
}

- (void)addPoint:(CGPoint)point {
    // add a line
    if (pointCount + 2 > pointAlloc) {
        pointAlloc += kANIconPathBuffer;
        lines = (CGPoint *)realloc(lines, sizeof(CGPoint) * pointAlloc);
    }
    lines[pointCount++] = currentPoint;
    lines[pointCount++] = point;
    
    length += sqrt(pow(point.x - currentPoint.x, 2) + pow(point.y - currentPoint.y, 2));
    
    currentPoint = point;
}

- (void)addToContext:(CGContextRef)context size:(CGSize)scale {
    for (int i = 0; i < pointCount - 1; i += 2) {
        CGContextMoveToPoint(context, lines[i].x * scale.width, lines[i].y * scale.height);
        CGContextAddLineToPoint(context, lines[i + 1].x * scale.width, lines[i + 1].y * scale.height);
    }
}

- (void)applyToDesktop:(NSScreen *)theScreen {
    SBElementArray * items = application.desktop.items;
    // we have `items.count`, and we have a total length of `length`
    // now, we iterate along the path
    CGFloat separator = length / (CGFloat)(items.count + 1);
    __block CGFloat nextSpot = separator;
    __block NSInteger currentIndex = 0;
    [self iterateSegments:^(int pIndex, CGFloat distance, CGFloat endDistance, BOOL * done) {
        // fill in all icons that appear on this line
        while (endDistance > nextSpot) {
            CGPoint start = lines[pIndex];
            CGPoint end = lines[pIndex + 1];
            // apply a point along this segment
            CGPoint thePoint = distanceAlong(start, end, nextSpot - distance);
            [self putIcon:items[currentIndex] atPoint:thePoint onScreen:theScreen];
            nextSpot += separator;
            currentIndex++;
            if (currentIndex == items.count) {
                *done = YES;
                return;
            }
        }
    }];
}

- (void)iterateSegments:(void (^)(int pIndex, CGFloat distance, CGFloat endDistance, BOOL * done))callback {
    CGFloat distance = 0;
    BOOL stop = NO;
    for (int i = 0; i < pointCount - 1; i += 2) {
        CGPoint start = lines[i];
        CGPoint end = lines[i + 1];
        CGFloat endDistance = distance + sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2));
        callback(i, distance, endDistance, &stop);
        if (stop) return;
        distance = endDistance;
    }
}

- (ANIconArrangement *)currentArrangement {
    return [[ANIconArrangement alloc] initWithDesktop:application.desktop];
}

#pragma mark - Private -

- (void)putIcon:(FinderItem *)item atPoint:(CGPoint)p onScreen:(NSScreen *)s {
    CGFloat x = (p.x * s.frame.size.width) + s.frame.origin.x;
    CGFloat y = ((1.0 - p.y) * s.frame.size.height) + s.frame.origin.y;
    item.desktopPosition = NSMakePoint(x, y);
}

@end

static CGPoint distanceAlong(CGPoint s, CGPoint e, CGFloat d) {
    // go d units along the line from s to e
    CGFloat totalLength = sqrt(pow(e.x - s.x, 2) + pow(e.y - s.y, 2));
    CGFloat percentage = d / totalLength;
    return CGPointMake(s.x + (e.x - s.x) * percentage,
                       s.y + (e.y - s.y) * percentage);
}
