//
//  NSValueTransformer+MotifFLXLayoutStrategy.m
//  MotifFLXView
//
//  Created by Eric Horacek on 5/19/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import FLXView;
@import Motif;

#import "NSValueTransformer+MotifFLXLayoutStrategy.h"

@implementation NSValueTransformer (MotifFLXLayoutStrategy)

+ (void)load {
    [self
        mtf_registerValueTransformerWithName:MTFFLXLayoutStrategyFromArrayTransformerName
        transformedValueClass:FLXLayoutStrategy.class
        reverseTransformedValueClass:NSArray.class
        returningTransformedValueWithBlock:^(NSArray *values) {
            NSAssert(values.count == 2, @"Layout strategy array must have two values");

            for (id value in values) {
                NSAssert(
                    [value isKindOfClass:NSNumber.class],
                    @"Layout strategy array values must be kind of class NSNumber");
            }

            return [FLXLayoutStrategy fixed:(CGSize){
                .width = [values[0] floatValue],
                .height = [values[1] floatValue]
            }];
        }];

    [self
        mtf_registerValueTransformerWithName:MTFFLXLayoutStrategyFromDictionaryTransformerName
        transformedValueClass:FLXLayoutStrategy.class
        reverseTransformedValueClass:NSDictionary.class
        returningTransformedValueWithBlock:^(NSDictionary *values) {
            for (id value in [values objectEnumerator]) {
                NSAssert(
                    [value isKindOfClass:NSNumber.class],
                    @"Layout strategy dictionary values must be of type NSNumber");
            }

            NSArray *validProperties = @[@"width", @"height"];
            NSMutableSet *passedInvalidPropertyNames = [NSMutableSet setWithArray:values.allKeys];
            [passedInvalidPropertyNames minusSet:[NSSet setWithArray:validProperties]];
            NSAssert(
                passedInvalidPropertyNames.count == 0,
                @"Invalid layout strategy property names: %@",
                passedInvalidPropertyNames);

            return [FLXLayoutStrategy fixed:(CGSize){
                .width = [values[validProperties[0]] floatValue],
                .height = [values[validProperties[1]] floatValue]
            }];
        }];
}

@end

NSString * const MTFFLXLayoutStrategyFromArrayTransformerName = @"MTFFLXLayoutStrategyFromArrayTransformerName";

NSString * const MTFFLXLayoutStrategyFromDictionaryTransformerName = @"MTFFLXLayoutStrategyFromDictionaryTransformerName";
