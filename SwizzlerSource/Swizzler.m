//
//  Swizzler.m
//  Swizzler
//
//  Created by Viktor Andersson on 13/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#import "Swizzler.h"
#import <objc/runtime.h>
#import "SwizzlerValidator.h"

@interface Swizzler ()

@property (nonatomic) Method targetMethod;
@property (nonatomic) Method swizzleMethod;

@end

@implementation Swizzler

- (instancetype) initWithSelector:(SEL)theSelector class:(Class)theTargetClass class:(Class)theSwizzleClass
{
  return [self initWithSelector:theSelector
                          class:theTargetClass
                          class:theSwizzleClass
                      validator:[[SwizzlerValidator alloc] init]];
}

- (instancetype) initWithSelector:(SEL)theSelector
                            class:(Class)theTargetClass
                            class:(Class)theSwizzleClass
                        validator:(SwizzlerValidator *)aValidator
{
  if (self = [super init]) {
    _selector = theSelector;
    _targetClass = theTargetClass;
    _swizzleClass = theSwizzleClass;
    
    [aValidator validate:self];
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
