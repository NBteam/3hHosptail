//
//  MyAppointmentViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MyAppointmentViewController.h"
#import "MyAppointmentTableViewCell.h"
#import "MyAppointmentTopView.h"
//挂号
#import "MyAppointRegisteredViewController.h"
//住院预约
#import "MyAppointHospitalViewController.h"
//电话
#import "MyAppointPhoneViewController.h"

@interface MyAppointmentViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) MyAppointmentTopView *topView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) MyAppointRegisteredViewController *myAppointRegisteredVc;

@property (nonatomic, strong) MyAppointHospitalViewController *myAppointHospitalVc;

@property (nonatomic, strong) MyAppointPhoneViewController *myAppointPhoneVc;

@end

@implementation MyAppointmentViewController

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

- (MyAppointmentTopView *)topView{
    WeakSelf(MyAppointmentViewController);
    if (!_topView) {
        _topView = [[MyAppointmentTopView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 44)];
        _topView.backgroundColor = [UIColor colorWithHEX:0xffffff];
        __weak MyAppointmentTopView *weakTopView = _topView;
        
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
        _scrollView.contentSize = CGSizeMake(DeviceSize.width * 3, DeviceSize.height - self.frameTopHeight -self.topView.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (MyAppointRegisteredViewController *)myAppointRegisteredVc{
    if (!_myAppointRegisteredVc) {
        _myAppointRegisteredVc = [[MyAppointRegisteredViewController alloc] init];
    }
    return _myAppointRegisteredVc;
}

- (MyAppointHospitalViewController *)myAppointHospitalVc{
    if (!_myAppointHospitalVc) {
        _myAppointHospitalVc = [[MyAppointHospitalViewController alloc] init];
    }
    return _myAppointHospitalVc;
}

- (MyAppointPhoneViewController *)myAppointPhoneVc{
    if (!_myAppointPhoneVc) {
        _myAppointPhoneVc = [[MyAppointPhoneViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    }
    return _myAppointPhoneVc;
}

- (void)customAddChildVc{
    
    [self addChildViewController:self.myAppointRegisteredVc];
    [self addChildViewController:self.myAppointHospitalVc];
    [self addChildViewController:self.myAppointPhoneVc];
    
    
    [self.myAppointRegisteredVc willMoveToParentViewController:self];
    self.myAppointRegisteredVc.view.height = self.scrollView.contentSize.height;
    self.myAppointRegisteredVc.view.left = DeviceSize.width *0;
    self.myAppointRegisteredVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.myAppointRegisteredVc.view];
    [self.myAppointRegisteredVc didMoveToParentViewController:self];
    
    [self.myAppointHospitalVc willMoveToParentViewController:self];
    self.myAppointHospitalVc.view.height = self.scrollView.contentSize.height;
    self.myAppointHospitalVc.view.left = DeviceSize.width *1;
    self.myAppointHospitalVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.myAppointHospitalVc.view];
    [self.myAppointHospitalVc didMoveToParentViewController:self];
    
    [self.myAppointPhoneVc willMoveToParentViewController:self];
    self.myAppointPhoneVc.view.height = self.scrollView.contentSize.height;
    self.myAppointPhoneVc.view.left = DeviceSize.width *2;
    self.myAppointPhoneVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.myAppointPhoneVc.view];
    [self.myAppointPhoneVc didMoveToParentViewController:self];
    
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
    return @"我的预约";
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
