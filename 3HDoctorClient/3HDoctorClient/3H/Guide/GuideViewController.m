//
//  GuideViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 16/1/25.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"

@interface GuideViewController ()<UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AppDefaultColor;
    [self.view addSubview:self.scrollView];
    [self customView];
    [self.view addSubview:self.pageControl];
    
}


- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(DeviceSize.width * 2, DeviceSize.height);
       // _scrollView.s/Users/Smile_faner/Desktop/3H/3HDoctorClient/3HDoctorClient/3H/Guide/GuideViewController.hcrollEnabled = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
       // _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.width *0.5, self.view.bottom - 20, 0, 0)];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = AppDefaultColor;
        _pageControl.numberOfPages = 2;
    }
    return _pageControl;
}

- (void)customView{
    NSArray *imgs = @[@"3H医生端端-引导页1.jpg",@"3H医生端端-引导页2.jpg"];
    for (int i = 0; i < imgs.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgs[i]]];
        img.frame = CGRectMake(0 + DeviceSize.width * i, 0, DeviceSize.width, DeviceSize.height);
        [self.scrollView addSubview:img];
        
        if (i == 1) {
            
            CGFloat f;
            if (DeviceSize.height <= 568) {
                f = 130;
            }else if(DeviceSize.height >568 && DeviceSize.height <= 667){
                f = 155;
            }else{
                f = 170;
            }
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((DeviceSize.width -90)/2, f, 100, 30);
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
            [btn setTitle:@"立即体检" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = AppDefaultColor;
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 15;
            btn.layer.borderColor = [UIColor colorWithHEX:0xffffff].CGColor;
            btn.layer.borderWidth = 1;
            img.userInteractionEnabled = YES;
            [img addSubview:btn];
        }
    }
}

- (void)btnAction{
    [SGSaveFile saveObjectToSystem:IsFirst forKey:IsFirst];
     [(AppDelegate*)[UIApplication sharedApplication].delegate setWindowRootViewControllerIsLogin];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page  = scrollView.contentOffset.x /scrollView.width+ 0.5;
   
    self.pageControl.currentPage = page;
    
    if (scrollView.contentOffset.x > DeviceSize.width ) {
        NSLog(@"到了");
    }
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
