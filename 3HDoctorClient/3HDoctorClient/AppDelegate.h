//
//  AppDelegate.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)setWindowRootViewControllerIsGuide;

- (void)setWindowRootViewControllerIsTabBar;

- (void)setWindowRootViewControllerIsLogin;

@end

