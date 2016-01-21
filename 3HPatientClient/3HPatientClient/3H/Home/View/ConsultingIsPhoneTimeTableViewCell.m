//
//  ConsultingIsPhoneTimeTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingIsPhoneTimeTableViewCell.h"
#import "AppointTimeModel.h"

@implementation ConsultingIsPhoneTimeTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.viewBack];
    [self.viewBack addSubview:self.btnLeft];
    [self.viewBack addSubview:self.btnRight];
    [self.viewBack addSubview:self.labTime];
    [self.viewBack addSubview:self.labLine];
    [self.viewBack addSubview:self.scrollView];
    [self customScrollViewsArray:nil];
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
    NSInteger  index = (self.scrollView.contentOffset.x - self.viewBack.width)/(self.viewBack.width);
    if (index >= 0) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x -self.viewBack.width, 0) animated:YES];
        
        AppointTimeModel * model = self.dataArray[index];
        self.labTime.text = model.date;
    }
    
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
- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc]initWithFrame:CGRectMake(0, self.btnLeft.bottom-1, self.viewBack.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}
- (void)btnRightAction{
     NSInteger  index = (self.scrollView.contentOffset.x +self.viewBack.width)/(self.viewBack.width);
    if (index < self.dataArray.count) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x +self.viewBack.width, 0) animated:YES];
       
        AppointTimeModel * model = self.dataArray[index];
        self.labTime.text = model.date;
    }
    
}

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(self.btnLeft.right, 0, self.btnRight.left -self.btnLeft.right, 35)];
        _labTime.textColor = AppDefaultColor;
        _labTime.font = [UIFont systemFontOfSize:15];
        _labTime.textAlignment = NSTextAlignmentCenter;
//        _labTime.text = @"2016年09月09日";
    }
    return _labTime;
}

- (void)customScrollViewsArray:(NSMutableArray *)array{
    if (array.count != 0) {
        AppointTimeModel * model = array[0];
        self.labTime.text = model.date;
    }
    for (int j = 0; j <array.count; j++) {
        AppointTimeModel * model = array[j];
        for (int i = 0 ; i<model.times.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(j*self.viewBack.width +(i%3)*self.viewBack.width/3, (i/3)*45, self.viewBack.width/3, 45);
            btn.backgroundColor = [UIColor colorWithHEX:0xffffff];
            btn.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
            [btn setTitleColor:[UIColor colorWithHEX:0x999999] forState:UIControlStateNormal];
            btn.layer.borderWidth = 0.25;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = j * 1000 + i + 100;
            if ([model.times[i][@"is_empty"] doubleValue] == 0) {
                btn.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
                btn.layer.borderColor = AppDefaultColor.CGColor;
                [btn setTitleColor:[UIColor colorWithHEX:0x999999] forState:UIControlStateNormal];
            }
            [btn setTitle:model.times[i][@"start_time"] forState:UIControlStateNormal];
//            [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
            [self.scrollView addSubview:btn];
        }
    }
    self.scrollView.contentSize = CGSizeMake(self.viewBack.width *array.count, self.scrollView.height);
}
- (void)btnClick:(UIButton *)button{
    AppointTimeModel * model = self.dataArray[(button.tag-100)/1000];
    if ([[NSString stringWithFormat:@"%@",model.times[(button.tag-100)%1000][@"is_empty"]] isEqualToString:@"1"]) {
        for (UIView * view in self.scrollView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton * btn = (UIButton *)view;
                btn.backgroundColor = [UIColor whiteColor];
                btn.selected = NO;
                [btn setTitleColor:[UIColor colorWithHEX:0x999999] forState:UIControlStateNormal];
            }
        }
        for (int i = 0; i < self.dataArray.count; i++) {
            AppointTimeModel * model1 = self.dataArray[i];
            for (int j = 0 ; j < model1.times.count; j++) {
                if ([[NSString stringWithFormat:@"%@",model.times[j][@"is_empty"]] isEqualToString:@"0"]) {
                    UIButton * btnN = (UIButton *)[self.scrollView viewWithTag:i*1000+j+100];
                    btnN.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
                    [btnN setTitleColor:[UIColor colorWithHEX:0x999999] forState:UIControlStateNormal];
                }
            }
        }
        button.backgroundColor = AppDefaultColor;
        button.selected = YES;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (self.btnBlock) {
            self.btnBlock(model.times[(button.tag-100)%1000]);
        }
    }else{
        if (self.isEmptyBlock) {
            self.isEmptyBlock();
        }
    }
    
}
//赋值
- (void)confingWithModel:(NSMutableArray *)array{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    [self customScrollViewsArray:array];
}


@end
