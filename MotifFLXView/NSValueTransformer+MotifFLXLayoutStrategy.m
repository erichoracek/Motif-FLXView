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

NS_ASSUME_NONNULL_BEGIN

@implementation NSValueTransformer (MotifFLXLayoutStrategy)

+ (void)load {
    [self
        mtf_registerValueTransformerWithName:MTFFLXLayoutStrategyFromNumberTransformerName
        transformedValueClass:FLXLayoutStrategy.class
        reverseTransformedValueClass:NSNumber.class
        returningTransformedValueWithBlock:^(NSNumber *value) {
            return [self layoutStrategyForValues:@[value, value]];
        }];

    [self
        mtf_registerValueTransformerWithName:MTFFLXLayoutStrategyFromStringTransformerName
        transformedValueClass:FLXLayoutStrategy.class
        reverseTransformedValueClass:NSString.class
        returningTransformedValueWithBlock:^(NSString *value) {
            if ([value isEqual:@"sizeToFit"]) {
                return [FLXLayoutStrategy sizeToFit];
            }

            return [self layoutStrategyForValues:@[value, value]];
        }];

    [self
        mtf_registerValueTransformerWithName:MTFFLXLayoutStrategyFromArrayTransformerName
        transformedValueClass:FLXLayoutStrategy.class
        reverseTransformedValueClass:NSArray.class
        returningTransformedValueWithBlock:^(NSArray *values) {
            NSAssert(values.count == 2, @"Layout strategy array must have two values");

            return [self layoutStrategyForValues:@[values[0], values[1]]];
        }];

    [self
        mtf_registerValueTransformerWithName:MTFFLXLayoutStrategyFromDictionaryTransformerName
        transformedValueClass:FLXLayoutStrategy.class
        reverseTransformedValueClass:NSDictionary.class
        returningTransformedValueWithBlock:^(NSDictionary *values) {
            NSArray *validProperties = @[@"width", @"height"];
            NSMutableSet *passedInvalidPropertyNames = [NSMutableSet setWithArray:values.allKeys];
            [passedInvalidPropertyNames minusSet:[NSSet setWithArray:validProperties]];
            NSAssert(
                passedInvalidPropertyNames.count == 0,
                @"Invalid layout strategy property names: %@",
                passedInvalidPropertyNames);

            return [self layoutStrategyForValues:@[
                values[validProperties[0]] ?: @0,
                values[validProperties[1]] ?: @0
            ]];
        }];
}

+ (FLXLayoutStrategy *)layoutStrategyForValues:(NSArray *)values {
    return [FLXLayoutStrategy relative:^CGSize(CGSize containerSize) {
        return (CGSize){
            .width = [self layoutStrategyComponentForValue:values[0] containerSize:containerSize],
            .height = [self layoutStrategyComponentForValue:values[1] containerSize:containerSize]
        };
    }];
}

+ (CGFloat)layoutStrategyComponentForValue:(id)value containerSize:(CGSize)containerSize {
    if ([value isKindOfClass:NSNumber.class]) {
        return [(NSNumber *)value floatValue];
    }

    if ([value isKindOfClass:NSString.class]) {
        NSExpression *expression = [NSExpression expressionWithFormat:(NSString *)value];

        NSDictionary *object = @{
            @"containerWidth": @(containerSize.width),
            @"containerHeight": @(containerSize.height)
        };

        return [[expression
            expressionValueWithObject:object context:nil]
            floatValue];
    }

    return 0.0f;
}

@end

NSString * const MTFFLXLayoutStrategyFromNumberTransformerName = @"MTFFLXLayoutStrategyFromNumberTransformerName";

NSString * const MTFFLXLayoutStrategyFromStringTransformerName = @"MTFFLXLayoutStrategyFromStringTransformerName";

NSString * const MTFFLXLayoutStrategyFromArrayTransformerName = @"MTFFLXLayoutStrategyFromArrayTransformerName";

NSString * const MTFFLXLayoutStrategyFromDictionaryTransformerName = @"MTFFLXLayoutStrategyFromDictionaryTransformerName";

NS_ASSUME_NONNULL_END
