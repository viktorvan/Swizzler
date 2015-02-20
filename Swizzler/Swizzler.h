//
//  Swizzler.h
//  Swizzler
//
//  Created by Viktor Andersson on 13/02/15.
//  Copyright (c) 2015 Viktor Andersson. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SwizzlerValidator;

/*! @typedef ActionBlock
 * @brief An action.
 */
typedef void (^ActionBlock)(void);

/*!
 * @class Swizzler
 * @brief Swizzles class methods.
 */
@interface Swizzler : NSObject

@property (nonatomic, readonly) SEL selector;
@property (strong, nonatomic, readonly) id targetClass;
@property (strong, nonatomic, readonly) id swizzleClass;

- (instancetype) init __attribute__((unavailable("init not available")));

/*!
 * @brief Initializes a Swizzler with the following parameters.
 * @param theSelector Selector to swizzle.
 * @param theTargetClass The class on which the selector should be replaced.
 * @param theSwizzleClass The class with the method that will be replacing the target class method.
 */
- (instancetype) initWithSelector:(SEL)theSelector
                            class:(Class)theTargetClass
                            class:(Class)theSwizzleClass;

/*!
 * @brief Initializes a Swizzler with the following parameters.
 * @param theSelector Selector to swizzle.
 * @param theTargetClass The class on which the selector should be replaced.
 * @param theSwizzleClass The class with the method that will be replacing the target class method.
 * @param aValidator A validator for the Swizzler.
 */
- (instancetype) initWithSelector:(SEL)theSelector
                            class:(Class)theTargetClass
                            class:(Class)theSwizzleClass
                        validator:(SwizzlerValidator *)aValidator;

/*!
 * @discussion The ActionBlock anAction will be called while the Swizzlers methods are swizzled. 
 * When the block returns the methods will be deSwizzled.
 * @param anAction An ActionBlock that will be called while the methods are swizzled.
 * @code [swizzler doWhileSwizzled: ^{
   // Do something useful while the methods are swizzled.
 }];
 */
- (void) doWhileSwizzled:(ActionBlock) anAction;

/*! @discussion De-swizzle the methods. After sending this message to the Swizzler the methods will be returned to
 * their original unswizzled state.
 */
- (void) deSwizzle;

@end
