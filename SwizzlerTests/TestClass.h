//
//  TestClass.h
//  Swizzler
//
//  Created by Viktor Andersson on 18/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestProtocol.h"

@interface TestClass : NSObject

+ (void) resetNumMethodCalls;
+ (BOOL) didCallMethod;
+ (int) numCallsToMethod;
+ (void) aMethod;

@end
