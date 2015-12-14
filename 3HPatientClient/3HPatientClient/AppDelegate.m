//
//  AppDelegate.m
//  3HPatientClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "AppDelegate.h"

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
//友盟
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setUM];
    [self.window makeKeyAndVisible];
    [self setAppStyle];
    [self setWindowRootViewControllerIsLogin];
    
    return YES;
}

- (void)setUM{
    
    [UMSocialData setAppKey:@"566e3e94e0f55ac832003f56"];
    
    [UMSocialWechatHandler setWXAppId:@"wx0863c23f9e3f8d86" appSecret:@"a26911a258571173a188ff6a78cabb4e" url:nil];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2661693258"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"1105007970" appKey:@"fGnXA1STNeUt3Se5" url:@"http://www.umeng.com/social"];
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [UMSocialSnsService handleOpenURL:url];
}


- (void)setWindowRootViewControllerIsTabBar{
    [self restoreRootViewController:[[BaseTabBarController alloc] init]];
}

- (void)setWindowRootViewControllerIsLogin{
    [self restoreRootViewController:[[BaseNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]]];
}

/**
 *  切换根视图
 *
 *  @param rootViewController 新根视图
 */
- (void)restoreRootViewController:(UIViewController *)rootViewController{
    typedef void (^Animation)(void);
    UIWindow* window = self.window;
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{ BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    [UIView transitionWithView:window duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:animation completion:nil];
}

- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
    }
    return _window;
}

- (void)setAppStyle
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18]}];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHEX:0x333333]];
    
    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithHEX:0x20c6c6]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       AppDefaultColor, NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateSelected];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
