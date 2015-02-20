//
//  SwizzlerValidator.m
//  Swizzler
//
//  Created by Viktor Andersson on 19/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#import "SwizzlerValidator.h"
#import "Swizzler.h"

NSString *const UndefinedSelectorException = @"UndefinedSelectorException";

@interface SwizzlerValidator ()

@property (strong, nonatomic) Swizzler *itsSwizzler;

@end

@implementation SwizzlerValidator

- (void) validate:(Swizzler *)aSwizzler
{
  self.itsSwizzler = aSwizzler;
  [self validateThatTargetAndSwizzleClassRespondsToSelector];
}

- (void) validateThatTargetAndSwizzleClassRespondsToSelector
{
  [self validateClass:self.itsSwizzler.targetClass];
  [self validateClass:self.itsSwizzler.swizzleClass];
}

- (void) validateClass:(id)aClass
{
  if (![aClass respondsToSelector:self.itsSwizzler.selector]) {
    [self raiseUndefinedSelectorException:aClass];
  }
}

- (void) raiseUndefinedSelectorException:(id)aClass
{
  [[NSException exceptionWithName:UndefinedSelectorException
                           reason:[NSString stringWithFormat:@"%@ does not respond to %@",
                                   [aClass description],
                                   NSStringFromSelector(self.itsSwizzler.selector)]
                         userInfo:nil] raise];
}


@end
