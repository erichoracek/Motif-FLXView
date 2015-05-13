//
//  UIView+Theming.m
//  MotifFLXView
//
//  Created by Eric Horacek on 5/18/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import Motif;

#import "UIView+Theming.h"

@implementation UIView (Theming)

+ (void)load {
    [self
        mtf_registerThemeProperty:@"backgroundColor"
        valueTransformerName:MTFColorFromStringTransformerName
        applierBlock:^(UIColor *color, UIView *view){
            view.backgroundColor = color;
        }];
}

@end
