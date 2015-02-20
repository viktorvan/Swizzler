//
//  SwizzlerValidator.h
//  Swizzler
//
//  Created by Viktor Andersson on 19/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Swizzler;

/*!
 * @class SwizzlerValidator
 * @brief Can validate the state of a Swizzler instance.
 * @discussion Validates that the classes responds to the selector to be swizzled.
 */
@interface SwizzlerValidator : NSObject

/// Exception name to be used when a class does not respond to the selector to be swizzled.
FOUNDATION_EXPORT NSString *const UndefinedSelectorException;

/*!
 * Validates a Swizzler instance.
 * @param aSwizzler The swizzler to validate.
 */
- (void) validate:(Swizzler *)aSwizzler;

@end
