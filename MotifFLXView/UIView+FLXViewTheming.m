//
//  UIView+FLXViewTheming.m
//  MotifFLXView
//
//  Created by Eric Horacek on 5/14/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import Motif;
@import FLXView;

#import "NSValueTransformer+MotifFLXLayoutStrategy.h"
#import "NSValueTransformer+MotifFLXMargins.h"

#import "UIView+FLXViewTheming.h"

@implementation UIView (FLXViewTheming)

+ (void)load {
    [self
        mtf_registerThemeProperty:@"flex"
        requiringValueOfClass:NSNumber.class
        applierBlock:^(NSNumber *value, UIView *view){
            view.flx_flex = value.floatValue;
        }];

    NSString *layoutStrategyPropertyName = @"layoutStrategy";
    void(^layoutStrategyApplierBlock)(FLXLayoutStrategy *, UIView *) = ^(FLXLayoutStrategy *value, UIView *view) {
        NSString *key = NSStringFromSelector(@selector(flx_layoutStrategy));
        [view setValue:value forKey:key];
    };

    [self
        mtf_registerThemeProperty:layoutStrategyPropertyName
        requiringValueOfClass:FLXLayoutStrategy.class
        applierBlock:layoutStrategyApplierBlock];

    [self
        mtf_registerThemeProperty:layoutStrategyPropertyName
        requiringValueOfClass:FLXLayoutStrategy.class
        applierBlock:layoutStrategyApplierBlock];

    [self
        mtf_registerThemeProperty:layoutStrategyPropertyName
        requiringValueOfClass:FLXLayoutStrategy.class
        applierBlock:layoutStrategyApplierBlock];

    [self
        mtf_registerThemeProperty:layoutStrategyPropertyName
        requiringValueOfClass:FLXLayoutStrategy.class
        applierBlock:layoutStrategyApplierBlock];

    NSString *marginsPropertyName = @"margins";
    void(^marginsApplierBlock)(NSValue *, UIView *) = ^(NSValue *value, UIView *view) {
        NSString *key = NSStringFromSelector(@selector(flx_margins));
        [view setValue:value forKey:key];
    };

    [self
        mtf_registerThemeProperty:marginsPropertyName
        requiringValueOfObjCType:@encode(FLXMargins)
        applierBlock:marginsApplierBlock];

    [self
        mtf_registerThemeProperty:marginsPropertyName
        requiringValueOfObjCType:@encode(FLXMargins)
        applierBlock:marginsApplierBlock];

    [self
        mtf_registerThemeProperty:marginsPropertyName
        requiringValueOfObjCType:@encode(FLXMargins)
        applierBlock:marginsApplierBlock];

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

    [self
        mtf_registerThemeProperty:@"selfAlignment"
        forKeyPath:NSStringFromSelector(@selector(flx_selfAlignment))
        withValuesByKeyword:@{
           @"auto": @(FLXSelfAlignmentAuto),
           @"start": @(FLXSelfAlignmentStart),
           @"center": @(FLXSelfAlignmentCenter),
           @"end": @(FLXSelfAlignmentEnd),
           @"stretch": @(FLXSelfAlignmentStretch),
       }];
}

@end
