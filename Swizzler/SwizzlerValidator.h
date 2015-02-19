//
//  SwizzlerValidator.h
//  Swizzler
//
//  Created by Viktor Andersson on 19/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Swizzler;


@interface SwizzlerValidator : NSObject

FOUNDATION_EXPORT NSString *const UndefinedSelectorException;

- (void) validate:(Swizzler *)aSwizzler;

@end
