//
//  AddPatientsViewController.m
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AddPatientsViewController.h"
#import "LaboratoryTestsTopView.h"
#import "PhoneViewController.h"
#import "CodeViewController.h"

@interface AddPatientsViewController ()
@property (nonatomic, strong) LaboratoryTestsTopView *topView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) PhoneViewController * PhoneVc;
@property (nonatomic, strong) CodeViewController * CodeVc;
@end

@implementation AddPatientsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.scrollView];
    [self customAddChildVc];
    // Do any additional setup after loading the view.
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI

- (LaboratoryTestsTopView *)topView{
    WeakSelf(AddPatientsViewController);
    if (!_topView) {
        _topView = [[LaboratoryTestsTopView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 44) array:@[@"手机号码",@"扫一扫"]];
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

- (PhoneViewController *)PhoneVc{
    if (!_PhoneVc) {
        _PhoneVc = [[PhoneViewController alloc] init];
    }
    return _PhoneVc;
}

- (CodeViewController *)CodeVc{
    if (!_CodeVc) {
        _CodeVc = [[CodeViewController alloc] init];
    }
    return _CodeVc;
}

- (void)customAddChildVc{
    [self addChildViewController:self.PhoneVc];
    [self addChildViewController:self.CodeVc];
    
    
    [self.PhoneVc willMoveToParentViewController:self];
    self.PhoneVc.view.height = self.scrollView.contentSize.height;
    self.PhoneVc.view.left = DeviceSize.width *0;
    self.PhoneVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.PhoneVc.view];
    [self.PhoneVc didMoveToParentViewController:self];
    
    [self.CodeVc willMoveToParentViewController:self];
    self.CodeVc.view.height = self.scrollView.contentSize.height;
    self.CodeVc.view.left = DeviceSize.width *1;
    self.CodeVc.view.height = DeviceSize.height -self.frameTopHeight -self.topView.height;
    [self.scrollView addSubview:self.CodeVc.view];
    [self.CodeVc didMoveToParentViewController:self];
    
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
    return @"添加患者";
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
