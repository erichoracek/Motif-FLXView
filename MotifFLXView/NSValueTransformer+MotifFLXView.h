//
//  NSValueTransformer+MotifFLXView.h
//  MotifFLXView
//
//  Created by Eric Horacek on 5/15/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSValueTransformer (MotifFLXView)

@end

/**
 The name of the value transformer responsible for transforming an NSArray to
 a NSValue wrapping a FLXMargins struct.
 */
extern NSString * const MTFFLXMarginsFromArrayTransformerName;

/**
 The name of the value transformer responsible for transforming an NSDictionary
 to a NSValue wrapping a FLXMargins struct.
 */
extern NSString * const MTFFLXMarginsFromDictionaryTransformerName;

/**
 The name of the value transformer responsible for transforming an NSArray to
 a NSValue wrapping a FLXPadding struct.
 */
extern NSString * const MTFFLXPaddingFromArrayTransformerName;

/**
 The name of the value transformer responsible for transforming an NSDictionary
 to a NSValue wrapping a FLXPadding struct.
 */
extern NSString * const MTFFLXPaddingFromDictionaryTransformerName;
