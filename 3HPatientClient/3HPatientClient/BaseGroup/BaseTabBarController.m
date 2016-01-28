//
//  BaseTabBarController.m
//  OC_Project
//
//  Created by 范英强 on 15/11/28.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "HealthViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"
@interface BaseTabBarController ()


@property (nonatomic, retain) UIView *tabBarBackView;
@property (nonatomic, strong) BaseNavigationController *naMessage;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadViewController];
}

- (void)loadViewController{
    
    HomeViewController *homeVc = [[HomeViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    homeVc.title = @"首页";
    BaseNavigationController *naHome = [[BaseNavigationController alloc] initWithRootViewController:homeVc];
    naHome.tabBarItem.image = [[UIImage imageNamed:@"3H-首页_首页-未点击"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    naHome.tabBarItem.selectedImage = [[UIImage imageNamed:@"3H-首页_首页-点击"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    HealthViewController *healthVc = [[HealthViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    healthVc.title = @"健康";
    BaseNavigationController *naHealth = [[BaseNavigationController alloc] initWithRootViewController:healthVc];
    naHealth.tabBarItem.image = [[UIImage imageNamed:@"3H-首页_健康-未点击"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    naHealth.tabBarItem.selectedImage = [[UIImage imageNamed:@"3H-首页_健康-点击"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    MessageViewController *messageVc = [[MessageViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    messageVc.title = @"消息";
    self.naMessage = [[BaseNavigationController alloc] initWithRootViewController:messageVc];
    self.naMessage.tabBarItem.image = [[UIImage imageNamed:@"3H-首页_消息-未点击"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.naMessage.tabBarItem.selectedImage = [[UIImage imageNamed:@"3H-首页_消息-点击"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MineViewController *mineVc = [[MineViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    mineVc.title = @"我的";
    BaseNavigationController *naMine = [[BaseNavigationController alloc] initWithRootViewController:mineVc];
    naMine.tabBarItem.image = [[UIImage imageNamed:@"3H-首页_我的-未点击"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    naMine.tabBarItem.selectedImage = [[UIImage imageNamed:@"3H-首页_我的-点击"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    [self.tabBar insertSubview:self.tabBarBackView atIndex:0];
    self.tabBar.opaque = YES;
    self.viewControllers = @[naHome,naHealth,self.naMessage,naMine];
    [self loadData];
}


- (void)loadData{
    WeakSelf(BaseTabBarController);
    [[THNetWorkManager shareNetWork] getMsgNumandCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        NSLog(@"---%@",response.dataDic);
        if (response.responseCode == 1) {
            if([response.dataDic[@"msg_num"] integerValue] != 0){
                weakSelf.naMessage.tabBarItem.badgeValue = [NSString stringWithFormat:@"%@",response.dataDic[@"msg_num"]];
            }
            
        
            
        }else{
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        
    } ];
}

- (UIView *)tabBarBackView{
    if (!_tabBarBackView) {
        _tabBarBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 49)];
        _tabBarBackView.backgroundColor = [UIColor whiteColor];
    }
    return _tabBarBackView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
