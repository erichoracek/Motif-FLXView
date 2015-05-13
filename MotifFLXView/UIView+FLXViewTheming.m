//
//  UIView+FLXViewTheming.m
//  MotifFLXView
//
//  Created by Eric Horacek on 5/14/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import Motif;
@import FLXView;

#import "NSObject+SetValueFromKeyword.h"
#import "NSValueTransformer+MotifFLXView.h"

#import "UIView+FLXViewTheming.h"

@implementation UIView (FLXViewTheming)

+ (void)load {
    [self
        mtf_registerThemeProperty:@"flex"
        requiringValueOfClass:NSNumber.class
        applierBlock:^(NSNumber *value, UIView *view){
            view.flx_flex = value.floatValue;
        }];

    [self
        mtf_registerThemeProperty:@"layoutStrategy"
        requiringValueOfClass:NSString.class
        applierBlock:^(NSString *value, UIView *view){
            if ([value isEqualToString:@"sizeToFit"]) {
                view.flx_layoutStrategy = [FLXLayoutStrategy sizeToFit];
            } else {
                NSAssert(NO, @"Invalid layout strategy value %@", value);
            }
        }];

    [self
        mtf_registerThemeProperty:@"layoutStrategy"
        requiringValueOfClass:NSNumber.class
        applierBlock:^(NSNumber *value, UIView *view){
            view.flx_layoutStrategy = [FLXLayoutStrategy fixed:(CGSize){
                .width = value.floatValue,
                .height = value.floatValue
            }];
        }];

    [self
        mtf_registerThemeProperty:@"layoutStrategy"
        requiringValueOfClass:NSArray.class
        applierBlock:^(NSArray *values, UIView *view){
            NSAssert(values.count == 2, @"Must have two array entires.");

            for (id value in values) {
                NSAssert(
                    [value isKindOfClass:NSNumber.class],
                    @"Margins array values must be of type NSNumber");
            }

            view.flx_layoutStrategy = [FLXLayoutStrategy fixed:(CGSize){
                .width = [values[0] floatValue],
                .height = [values[1] floatValue]
            }];
        }];

    [self
        mtf_registerThemeProperty:@"layoutStrategy"
        requiringValueOfClass:NSDictionary.class
        applierBlock:^(NSDictionary *values, UIView *view){
            NSAssert(values.count == 2, @"Must have two array entires.");

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

            view.flx_layoutStrategy = [FLXLayoutStrategy fixed:(CGSize){
                .width = [values[validProperties[0]] floatValue],
                .height = [values[validProperties[1]] floatValue]
            }];
        }];

    [self
        mtf_registerThemeProperty:@"selfAlignment"
        forKey:NSStringFromSelector(@selector(flx_selfAlignment))
        withValuesByKeyword:@{
           @"auto": @(FLXSelfAlignmentAuto),
           @"start": @(FLXSelfAlignmentStart),
           @"center": @(FLXSelfAlignmentCenter),
           @"end": @(FLXSelfAlignmentEnd),
           @"stretch": @(FLXSelfAlignmentStretch),
       }];

    [self
        mtf_registerThemeProperty:@"margins"
        requiringValueOfClass:NSNumber.class
        applierBlock:^(NSNumber *marginValue, UIView *view){
            view.flx_margins = (FLXMargins){
                .top = marginValue.floatValue,
                .left = marginValue.floatValue,
                .bottom = marginValue.floatValue,
                .right = marginValue.floatValue,
            };
        }];

    [self
        mtf_registerThemeProperty:@"margins"
        valueTransformerName:MTFFLXMarginsFromDictionaryTransformerName
        applierBlock:^(NSValue *value, UIView *view){
            [view
                setValue:value
                forKey:NSStringFromSelector(@selector(flx_margins))];
        }];

    [self
        mtf_registerThemeProperty:@"margins"
        valueTransformerName:MTFFLXMarginsFromArrayTransformerName
        applierBlock:^(NSValue *value, UIView *view){
            [view
                setValue:value
                forKey:NSStringFromSelector(@selector(flx_margins))];
        }];

    [self
        mtf_registerThemeProperty:@"marginTop"
        requiringValueOfClass:NSNumber.class
        applierBlock:^(NSNumber *value, UIView *view){
            FLXMargins margins = view.flx_margins;
            margins.top = value.floatValue;
            view.flx_margins = margins;
        }];

    [self
        mtf_registerThemeProperty:@"marginRight"
        requiringValueOfClass:NSNumber.class
        applierBlock:^(NSNumber *value, UIView *view){
            FLXMargins margins = view.flx_margins;
            margins.right = value.floatValue;
            view.flx_margins = margins;
        }];

    [self
        mtf_registerThemeProperty:@"marginBottom"
        requiringValueOfClass:NSNumber.class
        applierBlock:^(NSNumber *value, UIView *view){
            FLXMargins margins = view.flx_margins;
            margins.bottom = value.floatValue;
            view.flx_margins = margins;
        }];

    [self
        mtf_registerThemeProperty:@"marginLeft"
        requiringValueOfClass:NSNumber.class
        applierBlock:^(NSNumber *value, UIView *view){
            FLXMargins margin = view.flx_margins;
            margin.left = value.floatValue;
            view.flx_margins = margin;
        }];
}

@end
