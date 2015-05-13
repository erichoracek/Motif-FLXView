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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self == nil) return nil;

    NSMutableArray *childViews = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < 10; index++) {
        [childViews addObject:[[UIView alloc] init]];
    }
    _childViews = [childViews copy];

    for (UIView *childView in self.childViews) {
        [self addSubview:childView];
    }

    return self;
}

@synthesize childClass = _childClass;

- (void)setChildClass:(MTFThemeClass * __nullable)childClass {
    _childClass = childClass;
    
    for (UIView *childView in self.childViews) {
        [childClass applyToObject:childView];
    }
}

@end

NS_ASSUME_NONNULL_END
