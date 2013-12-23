//
//  ANIconArrangement.h
//  DesktopDraw
//
//  Created by Alex Nichol on 12/23/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Finder.h"

/**
 * A snapshot of the desktop icon arrangement.
 */
@interface ANIconArrangement : NSObject {
    NSDictionary * locations;
}

@property (readonly) NSDictionary * locations;

- (id)initWithDesktop:(FinderDesktopObject *)object;
- (void)applyToDesktop:(FinderDesktopObject *)object;

- (BOOL)isEqualToArrangement:(ANIconArrangement *)arr;

@end
