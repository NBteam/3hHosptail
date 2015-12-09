//
//  HomeSlidingTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "HomeSlidingTableViewCell.h"

@implementation HomeSlidingTableViewCell

- (void)customView{
    [self.contentView addSubview:self.scrollView];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 215)];
        _scrollView.delegate = self;
//        _scrollView.contentSize = CGSizeMake(DeviceSize.width * 2, DeviceSize.height - self.frameTopHeight -self.topView.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (void)confingWithModel:(NSString *)model{
    for (int i = 0; i<10; i++) {
        HomeSlidingCustomView *customView = [[HomeSlidingCustomView alloc] initWithFrame:CGRectMake(10 +150*i, 10, 140, 195)];
        [customView confingWithModel:@""];
        // 单击的 Recognizer
        UITapGestureRecognizer* singleRecognizer;
        singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewSingleTap:)];
        //点击的次数
        singleRecognizer.numberOfTapsRequired = 1; // 单击
        //点击的手指数
        singleRecognizer.numberOfTouchesRequired = 1;
        //给view添加一个手势监测；
        [customView addGestureRecognizer:singleRecognizer];
        customView.tag = 500 +i;
        [self.scrollView addSubview:customView];
    }
    self.scrollView.contentSize = CGSizeMake(150 *10 +10, 0);
}

- (void)titleViewSingleTap:(UITapGestureRecognizer *)recognizer{
    if (self.slidingBlock) {
        self.slidingBlock(recognizer.view.tag);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
