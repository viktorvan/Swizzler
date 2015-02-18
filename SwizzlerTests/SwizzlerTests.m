//
//  SwizzlerTests.m
//  Swizzler
//
//  Created by Viktor Andersson on 13/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
#import <XCTest/XCTest.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "TestClass.h"
#import "Swizzler.h"

@interface SwizzlerTests : XCTestCase

@end

static BOOL calledSwizzleMethod;

@implementation SwizzlerTests {
  Swizzler *swizzler;
}

- (void)setUp
{
  swizzler = [[Swizzler alloc] init];
  calledSwizzleMethod = NO;
}

- (void)testInvokingOriginalMethodAfterSwizzlingShouldExecuteSwizzleMethod {
  expect(calledSwizzleMethod).to.beFalsy();
  
  [swizzler swizzleMethod:@selector(aMethod) class:[TestClass class] class:[self class]];
  
  [TestClass aMethod];
  
  expect(calledSwizzleMethod).to.beTruthy();
}

+ (void)aMethod
{
  calledSwizzleMethod = YES;
}

@end
