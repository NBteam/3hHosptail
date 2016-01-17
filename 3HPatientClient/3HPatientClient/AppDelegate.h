//
//  AppDelegate.h
//  3HPatientClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)setWindowRootViewControllerIsTabBar;
- (void)setWindowRootViewControllerIsLogin;
#pragma mark -----支付宝支付-----
-(void)sendPay_demoName:(NSString *)name price:(NSString *)price desc:(NSString *)desc order_sn:(NSString *)order_sn;

@end

