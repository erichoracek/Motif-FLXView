//
//  ViewController.m
//  Example
//
//  Created by Eric Horacek on 5/18/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import MotifFLXView;

#import "View.h"
#import "ThemeSymbols.h"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Lifecycle

- (instancetype)initWithDynamicThemeApplier:(MTFDynamicThemeApplier *)themeApplier {
    NSParameterAssert(themeApplier != nil);

    self = [super initWithNibName:nil bundle:nil];
    if (self == nil) return nil;

    _themeApplier = themeApplier;

    return self;
}

#pragma mark - UIViewController

- (void)loadView {
    self.view = [[View alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.themeApplier applyClassWithName:ThemeClassNames.Container toObject:self.view];
}

@end
