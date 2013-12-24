//
//  ANDrawView.m
//  DesktopDraw
//
//  Created by Alex Nichol on 12/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "DDDrawView.h"

@implementation DDDrawView

@synthesize path;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        path = [[DDIconPath alloc] init];
    }
    return self;
}

- (id)initWithFrame:(NSRect)frameRect {
    if ((self = [super initWithFrame:frameRect])) {
        path = [[DDIconPath alloc] init];
    }
    return self;
}

- (void)updatePath:(DDIconPath *)aPath {
    path = aPath;
    [self setNeedsDisplay:YES];
}

- (void)clearPath {
    path = [[DDIconPath alloc] init];
    [self setNeedsDisplay:YES];
}

- (CGPoint)convertPointToRelativeCoords:(NSPoint)point {
    return CGPointMake(point.x / self.frame.size.width,
                       point.y / self.frame.size.height);
}

- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	[[NSColor whiteColor] set];
    NSRectFill(self.bounds);
    
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextBeginPath(context);
    [path addToContext:context size:NSSizeToCGSize(self.frame.size)];
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
    CGContextSetLineWidth(context, 5);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextStrokePath(context);
}

#pragma mark - Mouse Events -

- (void)mouseDragged:(NSEvent *)theEvent {
    NSPoint point = [theEvent locationInWindow];
    point = [self.window.contentView convertPoint:point toView:self];
    [path addPoint:[self convertPointToRelativeCoords:point]];
    [self setNeedsDisplay:YES];
}

- (void)mouseDown:(NSEvent *)theEvent {
    NSPoint point = [theEvent locationInWindow];
    point = [self.window.contentView convertPoint:point toView:self];
    [path moveToPoint:[self convertPointToRelativeCoords:point]];
}

@end
