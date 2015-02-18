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

+ (void)aMethod
{
  calledSwizzleMethod = YES;
}

- (void)setUp
{
  [super setUp];
  swizzler = [[Swizzler alloc] init];
  calledSwizzleMethod = NO;
}

- (void)tearDown

{
  [super tearDown];
  [swizzler deSwizzle];
  [TestClass resetNumMethodCalls];
}

#pragma mark Tests

- (void)testInvokingOriginalMethodAfterSwizzlingShouldInvokeSwizzleMethod
{
  expect(calledSwizzleMethod).to.beFalsy();
  
  [self performSwizzling];
  
  [TestClass aMethod];
  
  expect(calledSwizzleMethod).to.beTruthy();
}

- (void)testInvokingOriginalMethodAfterSwizzlingShouldNotInvokeOriginalMethod
{
  expect([TestClass didCallMethod]).to.beFalsy();
  
  [self performSwizzling];
  
  [TestClass aMethod];
  
  expect([TestClass didCallMethod]).to.beFalsy();
}

- (void)testCannotSwizzleIfAlreadySwizzled
{
  [self performSwizzling];
  expect(^{
    [self performSwizzling];
  }).to.raise(@"NSInternalInconsistencyException");
}

- (void)testDeSwizzlingShouldAlwaysLeaveClassInDeSwizzledState {
  expect([TestClass didCallMethod]).to.beFalsy();
  [self performSwizzling];
  [swizzler deSwizzle];
  
  [TestClass aMethod];
  
  expect([TestClass numCallsToMethod]).to.equal(1);
  
  [swizzler deSwizzle];
  
  [TestClass aMethod];
  
  expect([TestClass numCallsToMethod]).to.equal(2);
}

- (void)testInvokingOriginalMethodAfterDeSwizzlingShouldInvokeOriginalMethod
{
  expect([TestClass didCallMethod]).to.beFalsy();
  
  [self performSwizzling];
  [swizzler deSwizzle];
  
  [TestClass aMethod];
  
  expect([TestClass didCallMethod]).to.beTruthy();
}

#pragma mark Private methods

- (void)performSwizzling
{
  [swizzler swizzleMethod:@selector(aMethod) class:[TestClass class] class:[self class]];
}

@end
