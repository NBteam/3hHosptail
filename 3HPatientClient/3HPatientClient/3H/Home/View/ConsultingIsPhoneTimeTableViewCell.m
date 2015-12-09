//
//  ConsultingIsPhoneTimeTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingIsPhoneTimeTableViewCell.h"

@implementation ConsultingIsPhoneTimeTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.scrollView];
    [self.contentView addSubview:self.btnLeft];
    [self.contentView addSubview:self.btnRight];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9.5, 32/2, 32/2)];
        _imgLogo.image = [UIImage imageNamed:@"首页-我要预约-预约挂号-2_预约时间"];
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 10, 0, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"请选择预约时间";
        [_labTitle sizeToFit];
        _labTitle.top = 10;
    }
    return _labTitle;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.labLine.bottom, DeviceSize.width, 180)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(DeviceSize.width * 2, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIButton *)btnLeft{
    if (!_btnLeft) {
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeft.frame = CGRectMake(50, 0, 50, 50);
        [_btnLeft setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_左"] forState:UIControlStateNormal];
        [_btnLeft addTarget:self action:@selector(btnLeftAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLeft;
}

- (void)btnLeftAction{
    
}

- (UIButton *)btnRight{
    if (!_btnRight) {
        _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = CGRectMake(DeviceSize.width -100, 0, 50, 50);
        [_btnRight setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_右"] forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(btnRightAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}

- (void)btnRightAction{
    
}

- (void)customScrollViews{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width*10, 50)];
    view.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
    [self.scrollView addSubview:view];
    UILabel *labLines = [[UILabel alloc] initWithFrame:CGRectMake(0, 50-0.5, view.width, 0.5)];
    labLines.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    for (int i = 0; i<10; i++) {
        
    }
}

//赋值
- (void)confingWithModel:(NSInteger )dic{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
