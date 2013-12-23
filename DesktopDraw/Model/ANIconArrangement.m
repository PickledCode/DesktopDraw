//
//  ANIconArrangement.m
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANIconArrangement.h"

static NSString * finderItemIdentifier(FinderItem * item);

@implementation ANIconArrangement

@synthesize locations;

- (id)initWithDesktop:(FinderDesktopObject *)object {
    if ((self = [super init])) {
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        for (FinderItem * item in object.items) {
            dict[finderItemIdentifier(item)] = [NSValue valueWithPoint:item.desktopPosition];
        }
        locations = [dict copy];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        locations = [aDecoder decodeObject];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:locations];
}

- (void)applyToDesktop:(FinderDesktopObject *)object {
    for (FinderItem * item in object.items) {
        item.desktopPosition = [locations[finderItemIdentifier(item)] pointValue];
    }
}

- (BOOL)isEqualToArrangement:(ANIconArrangement *)arr {
    return [locations isEqualToDictionary:arr.locations];
}

@end

static NSString * finderItemIdentifier(FinderItem * item) {
    return [NSString stringWithFormat:@"%@_%@", item.name, item.nameExtension];
}
