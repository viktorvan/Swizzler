//
//  Swizzler.h
//  Swizzler
//
//  Created by Viktor Andersson on 13/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Swizzler : NSObject

- (void) swizzle:(SEL)selector class:(Class)originalClass class:(Class)swizzleClass;
- (void) deSwizzle;

@end
