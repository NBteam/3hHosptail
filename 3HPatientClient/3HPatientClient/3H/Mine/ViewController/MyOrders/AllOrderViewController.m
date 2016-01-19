//
//  AllOrderViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/18.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "AllOrderViewController.h"
#import "AllHeadView.h"
#import "MyOrdersViewController.h"
#import "MyOrdersBViewController.h"

@interface AllOrderViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) AllHeadView *topView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) MyOrdersViewController *myOrdersVc;

@property (nonatomic, strong) MyOrdersBViewController *myOrdersBVc;

@end

@implementation AllOrderViewController

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

- (AllHeadView *)topView{
    WeakSelf(AllOrderViewController);
    if (!_topView) {
        _topView = [[AllHeadView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 44)];
        _topView.backgroundColor = [UIColor colorWithHEX:0xffffff];
        __weak AllHeadView *weakTopView = _topView;
        
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

- (MyOrdersBViewController *)myOrdersBVc{
    if (!_myOrdersBVc) {
        _myOrdersBVc = [[MyOrdersBViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    }
    return _myOrdersBVc;
}

- (MyOrdersViewController *)myOrdersVc{
    if (!_myOrdersVc) {
        _myOrdersVc = [[MyOrdersViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    }
    return _myOrdersVc;
}

- (void)customAddChildVc{
    [self addChildViewController:self.myOrdersVc];
    [self addChildViewController:self.myOrdersBVc];
    
    
    [self.myOrdersVc willMoveToParentViewController:self];
    self.myOrdersVc.view.height = self.scrollView.contentSize.height;
    self.myOrdersVc.view.left = DeviceSize.width *0;
    self.myOrdersVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.myOrdersVc.view];
    [self.myOrdersVc didMoveToParentViewController:self];
    
    [self.myOrdersBVc willMoveToParentViewController:self];
    self.myOrdersBVc.view.height = self.scrollView.contentSize.height;
    self.myOrdersBVc.view.left = DeviceSize.width *1;
    self.myOrdersBVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.myOrdersBVc.view];
    [self.myOrdersBVc didMoveToParentViewController:self];
    
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
    return @"我的订单";
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
