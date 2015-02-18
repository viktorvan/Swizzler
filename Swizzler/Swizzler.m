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

@property (nonatomic) SEL selector;
@property (nonatomic) Class targetClass;
@property (nonatomic) Class swizzleClass;

@property (nonatomic) Method targetMethod;
@property (nonatomic) Method swizzleMethod;

@end

@implementation Swizzler

- (instancetype) initWithSelector:(SEL)theSelector
                            class:(Class)theTargetClass
                            class:(Class)theSwizzleClass
{
  if (self = [super init]) {
    self.selector = theSelector;
    self.targetClass = theTargetClass;
    self.swizzleClass = theSwizzleClass;
  }
  
  return self;
}

- (void) doWhileSwizzled:(ActionBlock)anAction
{
  [self swizzle];
  @try {
    anAction();
  }
  @finally {
    [self deSwizzle];
  }
}

- (void) swizzle
{
  [self assertSwizzleNotInProgress];
  
  self.targetMethod = class_getClassMethod(self.targetClass, self.selector);
  self.swizzleMethod = class_getClassMethod(self.swizzleClass, self.selector);
  method_exchangeImplementations(self.targetMethod, self.swizzleMethod);
}

- (void) deSwizzle
{
  if ([self isSwizzleInProgress]) {
    method_exchangeImplementations(self.targetMethod, self.swizzleMethod);
    [self resetMethods];    
  }
}

- (void)assertSwizzleNotInProgress
{
  NSAssert(![self isSwizzleInProgress], @"Cannot swizzle when already swizzled");
}

- (BOOL)isSwizzleInProgress
{
  return self.targetMethod && self.swizzleMethod;
}

- (void)resetMethods
{
  self.targetMethod = nil;
  self.swizzleMethod = nil;
}

@end
