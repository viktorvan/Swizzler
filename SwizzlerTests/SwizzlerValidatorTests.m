//
//  SwizzlerValidatorTests.m
//  Swizzler
//
//  Created by Viktor Andersson on 19/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#import <XCTest/XCTest.h>
#import "SwizzlerValidator.h"
#import "Swizzler.h"
#import "TestClass.h"

@interface SwizzlerValidatorTests : XCTestCase

@end

@implementation SwizzlerValidatorTests {
  id targetClass;
  id swizzleClass;
  SEL notDefinedInTargetClass;
  SEL notDefinedInSwizzleClass;
  SwizzlerValidator *validator;
}

#pragma mark Swizzle Selector
+ (void)notInTargetClass
{
}

#pragma mark Tests

- (void)setUp
{
  [super setUp];
  targetClass = [TestClass class];
  swizzleClass = [self class];
  notDefinedInTargetClass = @selector(notInTargetClass);
  notDefinedInSwizzleClass = @selector(aMethod);
  validator = [[SwizzlerValidator alloc] init];
}

- (void)testRaisesExceptionIfTargetClassNotRespondsToSelector
{
  NSException *ex;
  @try {
    [validator validate:[self swizzlerWithSelector:notDefinedInTargetClass]];
  }
  @catch (NSException *exception) {
    ex = exception;
  }
  
  expect(ex.name).to.equal(UndefinedSelectorException);
}

- (void)testRaisesExceptionIfSwizzleClassNotRespondsToSelector
{
  NSException *ex;
  @try {
    [validator validate:[self swizzlerWithSelector:notDefinedInSwizzleClass]];
  }
  @catch (NSException *exception) {
    ex = exception;
  }
  
  NSString *expected = [NSString stringWithFormat:@"%@", [[self class] description]];
  expect(ex.reason).to.contain(expected);
}

- (void)testExceptionReasonContainsSelectorName
{
  NSException *ex;
  @try {
    [validator validate:[self swizzlerWithSelector:notDefinedInTargetClass]];
  }
  @catch (NSException *exception) {
    ex = exception;
  }
  
  expect(ex.reason).to.contain(NSStringFromSelector(notDefinedInTargetClass));
}

- (void)testExceptionReasonContainsTargetClassName
{
  NSException *ex;
  @try {
    [validator validate:[self swizzlerWithSelector:notDefinedInTargetClass]];
  }
  @catch (NSException *exception) {
    ex = exception;
  }
  
  expect(ex.reason).to.contain([targetClass description]);
}

- (void)testExceptionReasonContainsSwizzleClassName
{
  NSException *ex;
  @try {
    [validator validate:[self swizzlerWithSelector:notDefinedInSwizzleClass]];
  }
  @catch (NSException *exception) {
    ex = exception;
  }
  
  expect(ex.reason).to.contain([swizzleClass description]);
}

- (Swizzler *)swizzlerWithSelector:(SEL)theSelector
{
  return [[Swizzler alloc] initWithSelector:theSelector
                                      class:targetClass
                                      class:swizzleClass];
}

@end