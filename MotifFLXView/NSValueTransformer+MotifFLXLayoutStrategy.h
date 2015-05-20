//
//  NSValueTransformer+MotifFLXLayoutStrategy.h
//  MotifFLXView
//
//  Created by Eric Horacek on 5/19/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import Foundation;

@interface NSValueTransformer (MotifFLXLayoutStrategy)

@end

/**
 The name of the value transformer responsible for transforming an NSArray to
 a NSValue wrapping a FLXPadding struct.
 */
extern NSString * const MTFFLXLayoutStrategyFromArrayTransformerName;

/**
 The name of the value transformer responsible for transforming an NSDictionary
 to a NSValue wrapping a FLXPadding struct.
 */
extern NSString * const MTFFLXLayoutStrategyFromDictionaryTransformerName;
