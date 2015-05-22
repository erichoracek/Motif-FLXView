//
//  View.m
//  MotifFLXView
//
//  Created by Eric Horacek on 5/18/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import Motif;

#import "View.h"

NS_ASSUME_NONNULL_BEGIN

@interface View ()

@property (readonly, nonatomic, strong) NSArray *childViews;

@end

@implementation View

@synthesize childClass = _childClass;

- (void)setChildClass:(MTFThemeClass * __nullable)childClass {
    BOOL shouldAnimate = _childClass != nil;

    _childClass = childClass;

    for (UIView *childView in self.childViews) {
        [childClass applyToObject:childView];
    }

    if (shouldAnimate) {
        [UIView animateWithDuration:0.3 animations:^{
            [self layoutIfNeeded];
        }];
    }
}

- (void)setNumberOfChildren:(NSUInteger)numberOfChildren {
    if (_numberOfChildren == numberOfChildren) {
        return;
    }

    _numberOfChildren = numberOfChildren;

    for (UIView *view in self.childViews) {
        [view removeFromSuperview];
    }

    NSMutableArray *childViews = [NSMutableArray array];
    for (NSUInteger index = 0; index < numberOfChildren; index++) {
        UIView *view = [[UIView alloc] init];
        [childViews addObject:view];
    }
    _childViews = [childViews copy];

    for (UIView *childView in self.childViews) {
        [self addSubview:childView];

        [self.childClass applyToObject:childView];
    }
}

@end

NS_ASSUME_NONNULL_END
