//
//  TestClass.m
//  Swizzler
//
//  Created by Viktor Andersson on 18/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass

static int numMethodCalls = 0;

+ (void) aMethod
{
  ++numMethodCalls;
}

+ (BOOL)didCallMethod
{
  return numMethodCalls > 0;
}

+ (int)numCallsToMethod
{
  return numMethodCalls;
}

+ (void)resetNumMethodCalls
{
  numMethodCalls = 0;
}

@end
