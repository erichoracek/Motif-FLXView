//
//  ViewController.h
//  Example
//
//  Created by Eric Horacek on 5/18/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTFDynamicThemeApplier;

@interface ViewController : UIViewController

- (instancetype)initWithDynamicThemeApplier:(MTFDynamicThemeApplier *)themeApplier;

@property (readonly, nonatomic, strong) MTFDynamicThemeApplier *themeApplier;

@end
