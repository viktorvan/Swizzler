[![Build Status](https://travis-ci.org/viktorvan/Swizzler.svg?branch=master)](https://travis-ci.org/viktorvan/Swizzler)

Swizzler is an iOS and Mac OS X tool used to replace (i.e. 'swizzle') the implementation of a class method. Example uses can be during test-driven development when you need to verify that a class method is being called. Or when the behaviour of a class method needs to be stubbed in a test.

Swizzling can be useful for example, when it is not possible to use dependency injection (e.g. property- or constructor injection) to inject the dependency with the class method in question.

## Prerequisites
* [Git](http://git-scm.com/)
* [CocoaPods](http://cocoapods.org)

## Installation

* `git clone <repository-url>` this repository
* Run `pod install` to update the CocoaPods.
* Open Swizzler.xcworkspace and build the project.
* Add the Swizzler source files folder `SwizzlerSource` to your project.

## Usage
Use the following import:

    #import "Swizzler.h"

Create a swizzler for the target class and selector you want to replace. You will also need to provide a 'swizzle' class with the replacement class method you want to be called instead of the original target class method.

    Swizzler *swizzler = [[Swizzler alloc] initWithSelector:@selector(theSelectorToSwizzle)
                                                      class:[ClassToBeSwizzled class]
                                                      class:[ClassWithReplacementMethod class]];

You can now use the swizzler to swizzle the method implementations and execute a block of code:

    [swizzler doWhileSwizzled:^{
      /* Do stuff while the methods are swizzled. */
    }];

After the execution the Swizzler will automatically de-swizzle the methods back to their original implementations.