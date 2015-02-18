//
//  Swizzler.m
//  Swizzler
//
//  Created by Viktor Andersson on 13/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#import "Swizzler.h"
#import <objc/runtime.h>

@interface Swizzler ()

@property (nonatomic) Method original;
@property (nonatomic) Method swizzle;

@end

@implementation Swizzler

- (void) swizzleMethod:(SEL)selector class:(Class)originalClass class:(Class)swizzleClass
{
  self.original = class_getClassMethod(originalClass, selector);
  self.swizzle = class_getClassMethod(swizzleClass, selector);
  method_exchangeImplementations(self.original, self.swizzle);
}

- (void) deSwizzle
{
  method_exchangeImplementations(self.original, self.swizzle);
}

@end
