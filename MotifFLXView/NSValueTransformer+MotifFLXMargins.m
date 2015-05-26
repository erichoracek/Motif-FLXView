//
//  NSValueTransformer+MotifFLXMargins.m
//  MotifFLXView
//
//  Created by Eric Horacek on 5/19/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import FLXView;
@import Motif;

#import "NSValueTransformer+MotifFLXMargins.h"

@implementation NSValueTransformer (MotifFLXMargins)

+ (void)load {
    [self
        mtf_registerValueTransformerWithName:MTFFLXMarginsFromNumberTransformerName
        transformedValueObjCType:@encode(FLXMargins)
        reverseTransformedValueClass:NSNumber.class
        returningTransformedValueWithBlock:^(NSNumber *value) {
            FLXMargins margins = {
                .top = value.floatValue,
                .left = value.floatValue,
                .bottom = value.floatValue,
                .right = value.floatValue,
            };

            return [NSValue value:&margins withObjCType:@encode(FLXMargins)];
        }];

    [self
        mtf_registerValueTransformerWithName:MTFFLXMarginsFromArrayTransformerName
        transformedValueObjCType:@encode(FLXMargins)
        reverseTransformedValueClass:NSArray.class
        returningTransformedValueWithBlock:^(NSArray *values) {
            NSAssert(values.count <= 4, @"Margins array must have at most four values");
            NSAssert(values.count > 1, @"Margins array must have more than one value");

            for (id value in values) {
                NSAssert(
                    [value isKindOfClass:NSNumber.class],
                    @"Margins array values must be kind of class NSNumber");
            }

            FLXMargins margins;
            if (values.count == 2) {
                margins = (FLXMargins){
                    .top = [values[0] floatValue],
                    .right = [values[1] floatValue],
                    .bottom = [values[0] floatValue],
                    .left = [values[1] floatValue],
                };
            } else {
                margins = (FLXMargins){
                    .top = [values[0] floatValue],
                    .right = [values[1] floatValue],
                    .bottom = [values[2] floatValue],
                    .left = (values.count == 4) ? [values[3] floatValue] : 0.0f,
                };
            }

            return [NSValue value:&margins withObjCType:@encode(FLXMargins)];
        }];

    [self
        mtf_registerValueTransformerWithName:MTFFLXMarginsFromDictionaryTransformerName
        transformedValueObjCType:@encode(FLXMargins)
        reverseTransformedValueClass:NSDictionary.class
        returningTransformedValueWithBlock:^(NSDictionary *values) {
            for (id value in [values objectEnumerator]) {
                NSAssert(
                    [value isKindOfClass:NSNumber.class],
                    @"Margins dictionary values must be kind of class NSNumber");
            }

            NSArray *validProperties = @[@"top", @"right", @"bottom", @"left"];

            // Ensure that the passed properties have valid keys
            NSMutableSet *passedInvalidPropertyNames = [NSMutableSet setWithArray:values.allKeys];
            [passedInvalidPropertyNames minusSet:[NSSet setWithArray:validProperties]];
            NSAssert(
                passedInvalidPropertyNames.count == 0,
                @"Invalid margin property names: %@",
                passedInvalidPropertyNames);

            FLXMargins margins = {
                .top = [values[validProperties[0]] floatValue],
                .right = [values[validProperties[1]] floatValue],
                .bottom = [values[validProperties[2]] floatValue],
                .left = [values[validProperties[3]] floatValue],
            };

            return [NSValue value:&margins withObjCType:@encode(FLXMargins)];
        }];
}

@end

NSString * const MTFFLXMarginsFromNumberTransformerName = @"MTFFLXMarginsFromNumberTransformerName";

NSString * const MTFFLXMarginsFromArrayTransformerName = @"MTFFLXMarginsFromArrayTransformerName";

NSString * const MTFFLXMarginsFromDictionaryTransformerName = @"MTFFLXMarginsFromDictionaryTransformerName";
