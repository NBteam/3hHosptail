//
//  ADView.m
//  UITableView_Cell定制
//
//  Created by LZXuan on 14-12-18.
//  Copyright (c) 2014年 LZXuan. All rights reserved.
//

#import "ADView.h"
#import "UIImageView+WebCache.h"
#import "ShopPicModel.h"
#define kScreenSize [UIScreen mainScreen].bounds.size
@implementation ADView
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSArray *_imagesArr;
    NSTimer *_timer;//定时器
}
- (void)dealloc{
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (id)initWithFrame:(CGRect)frame imagesArr:(NSArray*)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        _imagesArr = arr;
        //_isSelected = NO;
        if (_imagesArr.count!=0) {
//            [self creatTimer];
//            [self creatView];
        }
    }
    return self;
}

- (void)creatView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 160*DeviceSize.width/375)];
    for (int i = 0; i < _imagesArr.count+2; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width*i, 0, kScreenSize.width, 160*DeviceSize.width/375)];
        imageView.userInteractionEnabled = YES;
        if (i==0) {
            ShopPicModel * model = _imagesArr[_imagesArr.count-1];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@""]];
        }else if(i==_imagesArr.count+1) {
            ShopPicModel * model = _imagesArr[0];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@""]];
        }else {
            ShopPicModel * model = _imagesArr[i-1];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@""]];
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
            [imageView addGestureRecognizer:singleTap];
        }
        [_scrollView addSubview:imageView];
    }
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    //下面设置滚动视图
    _scrollView.contentSize = CGSizeMake((_imagesArr.count+2)*kScreenSize.width,208*DeviceSize.width/720);
    _scrollView.contentOffset = CGPointMake(kScreenSize.width, 0);
    _scrollView.showsVerticalScrollIndicator = NO;
    //按页
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    [self addSubview:_scrollView];
    //页码器
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width-100, -200, 100, 30)];
    
    _pageControl.numberOfPages = _imagesArr.count;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    [_pageControl addTarget:self action:@selector(pageClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
}

//点击事件
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    if (self.ADBlock) {
        //调用block
        self.ADBlock(_scrollView.contentOffset.x/kScreenSize.width);
    }else {
        NSLog(@"没有传入block");
    }
}

- (void)pageClick:(UIPageControl *)page {
    //修改滚动视图的偏移量
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width*page.currentPage+kScreenSize.width, 0) animated:YES];
}
//减速停止的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //修改页码
    CGPoint offset = _scrollView.contentOffset;
    if (offset.x/_scrollView.bounds.size.width==_imagesArr.count+1){
        offset.x = kScreenSize.width;
        _scrollView.contentOffset = offset;
        _pageControl.currentPage = 0;
    }else if (offset.x/_scrollView.bounds.size.width==0) {
        offset.x = _imagesArr.count*kScreenSize.width;
        _scrollView.contentOffset = offset;
        _pageControl.currentPage = _imagesArr.count-1;
    }else {
        _pageControl.currentPage = offset.x/_scrollView.bounds.size.width-1;
    }
}
- (void)creatTimer {
    //实例化 一个定时器对象
    /*
     参数:
     1.时间间隔 单位 s
     2.目标对象地址 (任意的对象地址)
     3.selector: 就是第二个参数的行为 选择器
     4.一般nil
     5.是否重复 YES 重复操作
     下面的方法 一旦调用创建成功 那么定时器就会立即启动
     每隔0.5s 定时器 会让 self 执行调用 timerClick
     
     */
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
//    [self stopTimer];
}
- (void)stopTimer{
    [_timer setFireDate:[NSDate distantFuture]];
    CGFloat point = _scrollView.contentOffset.x/_scrollView.bounds.size.width;
    [_scrollView setContentOffset:CGPointMake(point*_scrollView.bounds.size.width, 0) animated:YES];
}
- (void)startTimer{
    [_timer setFireDate:[NSDate distantPast]];
    CGFloat point = _scrollView.contentOffset.x/_scrollView.bounds.size.width;
    [_scrollView setContentOffset:CGPointMake(point*_scrollView.bounds.size.width, 0) animated:YES];
}
- (void)timerClick {
//    NSLog(@"timer");
//    CGFloat point = _scrollView.contentOffset.x+_scrollView.bounds.size.width;
    CGFloat point = (_scrollView.contentOffset.x/_scrollView.bounds.size.width+1)*_scrollView.bounds.size.width;
    [_scrollView setContentOffset:CGPointMake(point, 0) animated:YES];
    CGPoint offset = _scrollView.contentOffset;
    if (point/_scrollView.bounds.size.width==_imagesArr.count+1){
        offset.x = 0;
        _scrollView.contentOffset = offset;
        _pageControl.currentPage = 0;
    }else {
        int offSize=_scrollView.contentOffset.x/_scrollView.bounds.size.width;
        if (offSize==_imagesArr.count) {
            _scrollView.contentOffset =CGPointMake(0, 0);
            CGFloat poi = (_scrollView.contentOffset.x/_scrollView.bounds.size.width+1)*_scrollView.bounds.size.width;
            [_scrollView setContentOffset:CGPointMake(poi, 0) animated:YES];
        }
        _pageControl.currentPage = offset.x/_scrollView.bounds.size.width;
    }
}
- (void)configWithArray:(NSArray *)array{
    _imagesArr = array;
    if (_imagesArr.count!=0) {
        [self creatTimer];
        [self creatView];
    }
}

@end
