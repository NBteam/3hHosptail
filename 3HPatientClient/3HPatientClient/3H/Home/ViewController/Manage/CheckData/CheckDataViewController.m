//
//  CheckDataViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "CheckDataViewController.h"
#import "CheckDataTopView.h"
#import "CheckDataAViewController.h"
#import "CheckDataBViewController.h"


@interface CheckDataViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) CheckDataTopView *topView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) CheckDataAViewController *checkDataAVc;

@property (nonatomic, strong) CheckDataBViewController *checkDataBVc;

@end

@implementation CheckDataViewController

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

- (CheckDataTopView *)topView{
    WeakSelf(CheckDataViewController);
    if (!_topView) {
        _topView = [[CheckDataTopView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 44)];
        _topView.backgroundColor = [UIColor colorWithHEX:0xffffff];
        __weak CheckDataTopView *weakTopView = _topView;
        
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

- (CheckDataAViewController *)checkDataAVc{
    if (!_checkDataAVc) {
        _checkDataAVc = [[CheckDataAViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    }
    return _checkDataAVc;
}

- (CheckDataBViewController *)checkDataBVc{
    if (!_checkDataBVc) {
        _checkDataBVc = [[CheckDataBViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    }
    return _checkDataBVc;
}

- (void)customAddChildVc{
    [self addChildViewController:self.checkDataAVc];
    [self addChildViewController:self.checkDataBVc];
    
    
    [self.checkDataAVc willMoveToParentViewController:self];
    self.checkDataAVc.view.height = self.scrollView.contentSize.height;
    self.checkDataAVc.view.left = DeviceSize.width *0;
    self.checkDataAVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.checkDataAVc.view];
    [self.checkDataAVc didMoveToParentViewController:self];
    
    [self.checkDataBVc willMoveToParentViewController:self];
    self.checkDataBVc.view.height = self.scrollView.contentSize.height;
    self.checkDataBVc.view.left = DeviceSize.width *1;
    self.checkDataBVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.checkDataBVc.view];
    [self.checkDataBVc didMoveToParentViewController:self];
    
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
    return @"化验及检查数据";
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
