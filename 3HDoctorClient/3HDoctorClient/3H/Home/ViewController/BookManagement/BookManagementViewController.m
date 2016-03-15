//
//  BookManagementViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BookManagementViewController.h"
#import "BookManagementTopView.h"
//挂号预约
#import "BookIsRegisteredViewController.h"
//电话预约
#import "BookIsPhoneViewController.h"
@interface BookManagementViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) BookManagementTopView *topView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) BookIsRegisteredViewController *registerVc;

@property (nonatomic, strong) BookIsPhoneViewController *phoneVc;

@end

@implementation BookManagementViewController

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

- (BookManagementTopView *)topView{
    WeakSelf(BookManagementViewController);
    if (!_topView) {
        _topView = [[BookManagementTopView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 44)];
        _topView.backgroundColor = [UIColor colorWithHEX:0xffffff];
        __weak BookManagementTopView *weakTopView = _topView;
        
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

- (BookIsRegisteredViewController *)registerVc{
    if (!_registerVc) {
        WeakSelf(BookManagementViewController);
        _registerVc = [[BookIsRegisteredViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        [_registerVc setReloadBlock:^(NSString *numString) {
            if (![numString isEqualToString:@"0"]) {
                weakSelf.topView.labGuaHao.hidden = NO;
                weakSelf.topView.labGuaHao.text = [NSString stringWithFormat:@"%@",numString];
            }else{
                weakSelf.topView.labGuaHao.hidden = YES;
            }
        }];
    }
    return _registerVc;
}

- (BookIsPhoneViewController *)phoneVc{
    if (!_phoneVc) {
        WeakSelf(BookManagementViewController);
        _phoneVc = [[BookIsPhoneViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        [_phoneVc setReloadBlock:^(NSString *numString) {
            if (![numString isEqualToString:@"0"]) {
                weakSelf.topView.labDianHua.hidden = NO;
                weakSelf.topView.labDianHua.text = [NSString stringWithFormat:@"%@",numString];
            }else{
                weakSelf.topView.labDianHua.hidden = YES;
            }
        }];
    }
    return _phoneVc;
}

- (void)customAddChildVc{
    [self addChildViewController:self.registerVc];
    [self addChildViewController:self.phoneVc];
    
    
    [self.registerVc willMoveToParentViewController:self];
    self.registerVc.view.height = self.scrollView.contentSize.height;
    self.registerVc.view.left = DeviceSize.width *0;
    self.registerVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.registerVc.view];
    [self.registerVc didMoveToParentViewController:self];
    
    [self.phoneVc willMoveToParentViewController:self];
    self.phoneVc.view.height = self.scrollView.contentSize.height;
    self.phoneVc.view.left = DeviceSize.width *1;
     self.phoneVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.phoneVc.view];
    [self.phoneVc didMoveToParentViewController:self];
    
    if (self.isPhone) {
        [self.topView topButtonMenuSelectForIndex:1];
        [self.scrollView setContentOffset:CGPointMake(DeviceSize.width *1, 0) animated:YES];
    }
    
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
    return @"预约管理";
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
