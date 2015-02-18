//
//  TestClass.m
//  Swizzler
//
//  Created by Viktor Andersson on 18/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass

static BOOL methodCalled = NO;

+ (void) aMethod
{
  methodCalled = YES;
}

+ (BOOL)didCallMethod
{
  return methodCalled;
}

@end
