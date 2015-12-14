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
    [self.contentView addSubview:self.viewBack];
    [self.viewBack addSubview:self.btnLeft];
    [self.viewBack addSubview:self.btnRight];
    [self.viewBack addSubview:self.labTime];
    [self.viewBack addSubview:self.scrollView];
    [self customScrollViews];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 32/2, 32/2)];
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
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.btnLeft.bottom -0.5, self.viewBack.width, 180)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.viewBack.width * 3, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom +10, DeviceSize.width -20, 180 +35)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewBack.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _viewBack.layer.borderWidth = 0.5;
    }
    return _viewBack;
}


- (UIButton *)btnLeft{
    if (!_btnLeft) {
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeft.frame = CGRectMake(0, 0, 45, 35);
        [_btnLeft setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_左"] forState:UIControlStateNormal];
        [_btnLeft addTarget:self action:@selector(btnLeftAction) forControlEvents:UIControlEventTouchUpInside];
        _btnLeft.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
        _btnLeft.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _btnLeft.layer.borderWidth = 0.5;
    }
    return _btnLeft;
}

- (void)btnLeftAction{
     [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x -self.viewBack.width, 0) animated:YES];
}

- (UIButton *)btnRight{
    if (!_btnRight) {
        _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = CGRectMake(self.viewBack.width -45, 0, 45, 35);
        [_btnRight setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_右"] forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(btnRightAction) forControlEvents:UIControlEventTouchUpInside];
        _btnRight.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
        _btnRight.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _btnRight.layer.borderWidth = 0.5;
    }
    return _btnRight;
}

- (void)btnRightAction{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x +self.viewBack.width, 0) animated:YES];
}

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(self.btnLeft.right, 0, self.btnRight.left -self.btnLeft.right, 35)];
        _labTime.textColor = AppDefaultColor;
        _labTime.font = [UIFont systemFontOfSize:15];
        _labTime.textAlignment = NSTextAlignmentCenter;
        _labTime.text = @"2016年09月09日";
    }
    return _labTime;
}

- (void)customScrollViews{
    NSArray *arr = @[@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00"];
    
    for (int j = 0; j <3; j++) {
        for (int i = 0 ; i<arr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(j*self.viewBack.width +(i%3)*self.viewBack.width/3, (i/3)*45, self.viewBack.width/3, 45);
            btn.backgroundColor = [UIColor colorWithHEX:0xffffff];
            btn.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
            [btn setTitleColor:[UIColor colorWithHEX:0x999999] forState:UIControlStateNormal];
            btn.layer.borderWidth = 0.25;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            
            
            if (i ==5) {
                btn.backgroundColor = AppDefaultColor;
                btn.layer.borderColor = AppDefaultColor.CGColor;
                [btn setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
            }
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [self.scrollView addSubview:btn];
        }
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