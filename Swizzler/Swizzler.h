//
//  Swizzler.h
//  Swizzler
//
//  Created by Viktor Andersson on 13/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Swizzler : NSObject

- (void) swizzleMethod:(SEL)selector class:(Class)originalClass class:(Class)swizzleClass;

@end
