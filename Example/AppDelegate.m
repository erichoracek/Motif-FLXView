//
//  AppDelegate.m
//  Example
//
//  Created by Eric Horacek on 5/18/15.
//  Copyright (c) 2015 Eric Horacek. All rights reserved.
//

@import Motif;

#import "ViewController.h"
#import "ThemeSymbols.h"

#import "AppDelegate.h"

@implementation AppDelegate

#pragma mark - AppDelegate <UIApplicationDelegate>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];

    MTFDynamicThemeApplier *themeApplier = [self createDynamicThemeApplier];
    ViewController *viewController = [[ViewController alloc] initWithDynamicThemeApplier:themeApplier];

    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark - AppDelegate

- (MTFDynamicThemeApplier *)createDynamicThemeApplier {
    NSError *error;
    MTFTheme *theme = [MTFTheme themeFromJSONThemeNamed:ThemeName error:&error];
    NSAssert(error == nil, @"Error loading theme %@", error);

    MTFLiveReloadThemeApplier *themeApplier = [[MTFLiveReloadThemeApplier alloc]
        initWithTheme:theme
        sourceFile:__FILE__];

    return themeApplier;
}

@end
