//
//  RecommendScrollViewLoop.m
//  NR
//
//  Created by 范英强 on 15/8/17.
//  Copyright (c) 2015年 范英强. All rights reserved.
//

#import "RecommendScrollViewLoop.h"
#import "NSTimer+Addition.h"

@interface RecommendScrollViewLoop () <UIScrollViewDelegate>


@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong) NSTimer *animationTimer;
@property (nonatomic , assign) NSTimeInterval animationDuration;



@end
@implementation RecommendScrollViewLoop

- (void)setTotalPagesCount:(NSInteger (^)(void))totalPagesCount
{
    _totalPageCount = totalPagesCount();
    if (_totalPageCount > 0) {
        [self configContentViews];
        [self creatPointViewNum:_totalPageCount];
        [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
    }
}

- (void)creatPointViewNum:(NSInteger)num{
    if (num >0) {
        CGFloat f = num *6 +(num -1)*15;
        NSLog(@"%f",f);
        for (int i = 0; i<num; i++) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((DeviceSize.width -f)/2+21*i, 0, 6, 6)];
            img.image = [UIImage imageNamed:@"ic_dot_on"];
            img.tag = 100 +i;
            if (i != 0) {
                img.image = [UIImage imageNamed:@"ic_dot_off"];
            }
            [self.pointView addSubview:img];
        }
    }
}
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
        self.pointView = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollView.height -6 -15, DeviceSize.width, 6)];
        self.pointView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.pointView];
    }
    return self;
}

#pragma mark -
#pragma mark - 有函数

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (self.fetchContentViewAtIndex) {
        [self.contentViews addObject:self.fetchContentViewAtIndex(previousPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(_currentPageIndex)];
        [self.contentViews addObject:self.fetchContentViewAtIndex(rearPageIndex)];
    }
    
    if (self.GetViewIndexBlock) {
        self.GetViewIndexBlock(_currentPageIndex);
    }
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
//        NSLog(@"next，当前页:%li",self.currentPageIndex);
        [self configContentViews];
        [self changePointView];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        NSLog(@"previous，当s前页:%li",self.currentPageIndex);
        [self configContentViews];
        [self changePointView];
    }
}

- (void)changePointView{
    for (UIImageView *img in self.pointView.subviews) {
        if (img.tag == self.currentPageIndex +100) {
            img.image = [UIImage imageNamed:@"ic_dot_on"];
        }else{
            img.image = [UIImage imageNamed:@"ic_dot_off"];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
    //NSLog(@"方响应事件法%f",self.scrollView.contentOffset.x);
   // NSLog(@"好好看俺%f",CGRectGetWidth(self.scrollView.frame));
    [self.scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
}

- (void)recommendScrollViewPauseTimer{
    [self.animationTimer pauseTimer];
}

- (void)recommendScrollViewResumeTimerAfterTimeInterval:(NSTimeInterval)interval{
    [self.animationTimer resumeTimerAfterTimeInterval:interval];
}
@end
