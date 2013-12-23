//
//  ANDrawView.m
//  DesktopDraw
//
//  Created by Alex Nichol on 12/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANDrawView.h"

@implementation ANDrawView

@synthesize path;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        path = [[ANIconPath alloc] init];
    }
    return self;
}

- (id)initWithFrame:(NSRect)frameRect {
    if ((self = [super initWithFrame:frameRect])) {
        path = [[ANIconPath alloc] init];
    }
    return self;
}

- (void)clearPath {
    path = [[ANIconPath alloc] init];
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
