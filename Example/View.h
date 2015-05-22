//
//  View.h
//  MotifFLXView
//
//  Created by Eric Horacek on 5/18/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import FLXView;

NS_ASSUME_NONNULL_BEGIN

@class MTFThemeClass;

@interface View : FLXView

@property (readwrite, nonatomic, strong, nullable) MTFThemeClass *childClass;

@property (readwrite, nonatomic, assign) NSUInteger numberOfChildren;

@end

NS_ASSUME_NONNULL_END
