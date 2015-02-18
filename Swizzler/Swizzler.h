//
//  Swizzler.h
//  Swizzler
//
//  Created by Viktor Andersson on 13/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ActionBlock)(void);

@interface Swizzler : NSObject

- (instancetype) init __attribute__((unavailable("init not available")));
- (instancetype) initWithSelector:(SEL)theSelector
                            class:(Class)theTargetClass
                            class:(Class)theSwizzleClass;

- (void) doWhileSwizzled:(ActionBlock) anAction;

@end
