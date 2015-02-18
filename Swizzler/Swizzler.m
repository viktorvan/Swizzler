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

- (void) swizzle:(SEL)selector class:(Class)originalClass class:(Class)swizzleClass
{
  [self assertSwizzleNotInProgress];
  
  self.original = class_getClassMethod(originalClass, selector);
  self.swizzle = class_getClassMethod(swizzleClass, selector);
  method_exchangeImplementations(self.original, self.swizzle);
}

- (void) deSwizzle
{
  if ([self isSwizzleInProgress]) {
    method_exchangeImplementations(self.original, self.swizzle);
    [self resetMethods];    
  }
}

- (void)assertSwizzleNotInProgress
{
  NSAssert(![self isSwizzleInProgress], @"Cannot swizzle when already swizzled");
}

- (BOOL)isSwizzleInProgress
{
  return self.original && self.swizzle;
}

- (void)resetMethods
{
  self.original = nil;
  self.swizzle = nil;
}

@end
