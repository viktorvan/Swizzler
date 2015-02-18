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
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import <XCTest/XCTest.h>
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
  swizzler = [[Swizzler alloc] initWithSelector:@selector(aMethod)
                                          class:[TestClass class]
                                          class:[self class]];
  calledSwizzleMethod = NO;
}

- (void)tearDown

{
  [super tearDown];
  [swizzler deSwizzle];
  [TestClass resetNumMethodCalls];
}

#pragma mark Tests

- (void)testUsesSwizzledMethodWhileSwizzled
{
  expect(calledSwizzleMethod).to.beFalsy();
  
  [swizzler doWhileSwizzled:^{
    [TestClass aMethod];
  }];
  
  expect(calledSwizzleMethod).to.beTruthy();
}

- (void)testDoesNotUseOriginalMethodWhileSwizzled
{
  expect([TestClass didCallMethod]).to.beFalsy();
  
  [swizzler doWhileSwizzled:^{
    [TestClass aMethod];
  }];
  
  expect([TestClass didCallMethod]).to.beFalsy();
}

- (void)testUsesOriginalMethodAfterDoWhileSwizzled {
  [swizzler doWhileSwizzled:^{ /* do nothing */ }];

  expect([TestClass didCallMethod]).to.beFalsy();
  [TestClass aMethod];
  expect([TestClass didCallMethod]).to.beTruthy();
}

- (void)testCannotSwizzleIfAlreadySwizzled
{
  [swizzler doWhileSwizzled:^{
    expect(^{
      [swizzler doWhileSwizzled:^{ /* do nothing */ }];
    }).to.raise(@"NSInternalInconsistencyException");
  }];
}

- (void)testShouldDeSwizzleIfExceptionIsThrownByActionBlock {
  @try {
    [swizzler doWhileSwizzled:^{
      [[NSException exceptionWithName:@"TestException" reason:@"Test" userInfo:nil] raise];
    }];
  }
  @catch (NSException *exception) {
    /* We are expecting a TestException here, otherwise we raise the exception again. */
    if (![exception.name isEqualToString:@"TestException"]) {
      [exception raise];
    }
  }
  
  expect([TestClass didCallMethod]).to.beFalsy();
  [TestClass aMethod];
  expect([TestClass didCallMethod]).to.beTruthy();
}

@end
