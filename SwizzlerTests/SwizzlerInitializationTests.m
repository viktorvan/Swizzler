//
//  SwizzlerInitializationTests.m
//  Swizzler
//
//  Created by Viktor Andersson on 19/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import <XCTest/XCTest.h>
#import "Swizzler.h"
#import "TestClass.h"

@interface SwizzlerInitializationTests : XCTestCase

@end

@implementation SwizzlerInitializationTests

+ (void)notInTargetClass
{
}

- (void)testRaisesExceptionIfTargetClassNotRespondsToSelector
{
  NSException *ex;
  @try {
    Swizzler *notUsed = [[Swizzler alloc] initWithSelector:@selector(notInTargetClass)
                                                     class:[TestClass class]
                                                     class:[self class]];
    #pragma unused(notUsed)
  }
  @catch (NSException *exception) {
    ex = exception;
  }
  
  expect(ex.name).to.equal(@"UndefinedSelectorException");
  expect(ex.reason).to.contain([[TestClass class] description]);
}

- (void)testRaisesExceptionIfSwizzleClassNotRespondsToSelector
{
  NSException *ex;
  @try {
    Swizzler *notUsed = [[Swizzler alloc] initWithSelector:@selector(aMethod)
                                                     class:[TestClass class]
                                                     class:[self class]];
    #pragma unused(notUsed)
  }
  @catch (NSException *exception) {
    ex = exception;
  }
  
  expect(ex.name).to.equal(@"UndefinedSelectorException");
  NSString *expected = [NSString stringWithFormat:@"%@", [[self class] description]];
  expect(ex.reason).to.contain(expected);
}

@end