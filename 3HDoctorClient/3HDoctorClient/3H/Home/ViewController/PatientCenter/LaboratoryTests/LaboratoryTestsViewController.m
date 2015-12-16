//
//  LaboratoryTestsViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "LaboratoryTestsViewController.h"
#import "LaboratoryTestsTopView.h"
//化验
#import "LaboratoryViewController.h"
//检查
#import "CheckViewController.h"
#import "LaboratoryTestsAddViewController.h"

@interface LaboratoryTestsViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) LaboratoryTestsTopView *topView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) LaboratoryViewController *laboratoryVc;

@property (nonatomic, strong) CheckViewController *checkVc;

@end

@implementation LaboratoryTestsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(addAction) andTarget:self andImageName:@"首页-患者中心_添加"];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.scrollView];
    self.VcIndex = 0;
    [self customAddChildVc];
}

- (void)addAction{
    if (self.VcIndex == 0) {
        [self.laboratoryVc addPushVc];
    }else{
        [self.checkVc addPushVc];
    }
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI

- (LaboratoryTestsTopView *)topView{
    WeakSelf(LaboratoryTestsViewController);
    if (!_topView) {
        _topView = [[LaboratoryTestsTopView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 44)array:@[@"化验",@"检查"]];
        _topView.backgroundColor = [UIColor colorWithHEX:0xffffff];
        __weak LaboratoryTestsTopView *weakTopView = _topView;
        
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

- (LaboratoryViewController *)laboratoryVc{
    if (!_laboratoryVc) {
        _laboratoryVc = [[LaboratoryViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        _laboratoryVc.mid = self.mid;
    }
    return _laboratoryVc;
}

- (CheckViewController *)checkVc{
    if (!_checkVc) {
        _checkVc = [[CheckViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        _checkVc.mid = self.mid;
    }
    return _checkVc;
}

- (void)customAddChildVc{
    [self addChildViewController:self.laboratoryVc];
    [self addChildViewController:self.checkVc];
    
    
    [self.laboratoryVc willMoveToParentViewController:self];
    self.laboratoryVc.view.height = self.scrollView.contentSize.height;
    self.laboratoryVc.view.left = DeviceSize.width *0;
    self.laboratoryVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.laboratoryVc.view];
    [self.laboratoryVc didMoveToParentViewController:self];
    
    [self.checkVc willMoveToParentViewController:self];
    self.checkVc.view.height = self.scrollView.contentSize.height;
    self.checkVc.view.left = DeviceSize.width *1;
    self.checkVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.checkVc.view];
    [self.checkVc didMoveToParentViewController:self];
    
}

#pragma mark scollview手滑动停止
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger pageIndex = scrollView.contentOffset.x / DeviceSize.width;
    
    self.VcIndex = pageIndex;
    [self.topView topButtonMenuSelectForIndex:pageIndex];
    
}
#pragma mark scrollview改变contentOffset停止
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;{
    
    NSInteger pageIndex = scrollView.contentOffset.x / DeviceSize.width;
    self.VcIndex = pageIndex;
    [self.topView topButtonMenuSelectForIndex:pageIndex];
}

- (NSString *)title{
    return @"化验及检查";
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
