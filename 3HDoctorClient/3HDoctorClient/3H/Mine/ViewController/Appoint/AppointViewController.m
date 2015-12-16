//
//  AppointViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AppointViewController.h"
#import "AppointTopView.h"
//门诊预约
#import "OutpatientAppointViewController.h"
//电话预约
#import "PhoneAppointViewController.h"
@interface AppointViewController ()
<UIScrollViewDelegate>

@property (nonatomic, strong) AppointTopView *topView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) OutpatientAppointViewController *outpatientAppointVc;

@property (nonatomic, strong) PhoneAppointViewController *phoneAppointVc;
@end

@implementation AppointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.scrollView];
    [self customAddChildVc];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI

- (AppointTopView *)topView{
    WeakSelf(AppointViewController);
    if (!_topView) {
        _topView = [[AppointTopView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 44)];
        _topView.backgroundColor = [UIColor colorWithHEX:0xffffff];
        __weak AppointTopView *weakTopView = _topView;
        
        [weakTopView setBtnClickBlock:^(NSInteger index) {
            [weakTopView topButtonMenuSelectForIndex:index];
            
            [weakSelf.scrollView setContentOffset:CGPointMake(DeviceSize.width *index, 0) animated:YES];
        }];
        //  默认选中第一个
        [weakTopView topButtonMenuSelectForIndex:0];
    }
    return _topView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topView.bottom, DeviceSize.width, DeviceSize.height - self.frameTopHeight - self.topView.height)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(DeviceSize.width * 2, DeviceSize.height - self.frameTopHeight -self.topView.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (OutpatientAppointViewController *)outpatientAppointVc{
    if (!_outpatientAppointVc) {
        _outpatientAppointVc = [[OutpatientAppointViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    }
    return _outpatientAppointVc;
}

- (PhoneAppointViewController *)phoneAppointVc{
    if (!_phoneAppointVc) {
        _phoneAppointVc = [[PhoneAppointViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    }
    return _phoneAppointVc;
}

- (void)customAddChildVc{
    [self addChildViewController:self.outpatientAppointVc];
    [self addChildViewController:self.phoneAppointVc];
    
    
    [self.outpatientAppointVc willMoveToParentViewController:self];
    self.outpatientAppointVc.view.height = self.scrollView.contentSize.height;
    self.outpatientAppointVc.view.left = DeviceSize.width *0;
    self.outpatientAppointVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.outpatientAppointVc.view];
    [self.outpatientAppointVc didMoveToParentViewController:self];
    
    [self.phoneAppointVc willMoveToParentViewController:self];
    self.phoneAppointVc.view.height = self.scrollView.contentSize.height;
    self.phoneAppointVc.view.left = DeviceSize.width *1;
    self.phoneAppointVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.phoneAppointVc.view];
    [self.phoneAppointVc didMoveToParentViewController:self];
    
}


#pragma mark scollview手滑动停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger pageIndex = scrollView.contentOffset.x / DeviceSize.width;
    [self.topView topButtonMenuSelectForIndex:pageIndex];
    
}
#pragma mark scrollview改变contentOffset停止
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;{
    
    NSInteger pageIndex = scrollView.contentOffset.x / DeviceSize.width;
    [self.topView topButtonMenuSelectForIndex:pageIndex];
}

- (NSString *)title{
    return @"预约设置";
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
