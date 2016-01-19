//
//  ShopDetailNumTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShopDetailNumTableViewCell.h"

@implementation ShopDetailNumTableViewCell


- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.viewBack];
    [self.viewBack addSubview:self.btnReduct];
    [self.viewBack addSubview:self.labNum];
    [self.viewBack addSubview:self.btnAdd];
}
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 0, 0)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"数量";
        [_labTitle sizeToFit];
        _labTitle.top = (45 -_labTitle.height)/2;
    }
    return _labTitle;
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(self.labTitle.right +10, 7.5, 90, 30)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewBack.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _viewBack.layer.borderWidth = 0.5;
        _viewBack.layer.masksToBounds = YES;
        _viewBack.layer.cornerRadius = 3;
    }
    return _viewBack;
}

- (UIButton *)btnReduct{
    if (!_btnReduct) {
        _btnReduct = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnReduct.frame = CGRectMake(0, 0, 30, 30);
        _btnReduct.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _btnReduct.layer.borderWidth = 0.5;
        [_btnReduct setImage:[UIImage imageNamed:@"首页-健康商城-商品详情_数量-"] forState:UIControlStateNormal];
        [_btnReduct addTarget:self action:@selector(btnReductAction) forControlEvents:UIControlEventTouchUpInside];
        _btnReduct.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
    }
    return _btnReduct;
}

- (UILabel *)labNum{
    if (!_labNum) {
        _labNum = [[UILabel alloc] initWithFrame:CGRectMake(self.btnReduct.right, 0, 30, 30)];
        _labNum.textColor = [UIColor colorWithHEX:0x333333];
        _labNum.font = [UIFont systemFontOfSize:15];
        _labNum.text = @"1";
        _labNum.textAlignment = NSTextAlignmentCenter;
    }
    return _labNum;
}

- (void)btnReductAction{
    NSInteger num = [self.labNum.text integerValue];
    if (num >1) {
        num --;
        self.labNum.text = [NSString stringWithFormat:@"%li",(long)num];
        if (self.changeIndex) {
            self.changeIndex(self.labNum.text);
        }
    }
    
}

- (UIButton *)btnAdd{
    if (!_btnAdd) {
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAdd.frame = CGRectMake(self.labNum.right, 0, 30, 30);
        _btnAdd.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _btnAdd.layer.borderWidth = 0.5;
        [_btnAdd addTarget:self action:@selector(btnAddAction) forControlEvents:UIControlEventTouchUpInside];
        [_btnAdd setImage:[UIImage imageNamed:@"首页-健康商城-商品详情_数量+"] forState:UIControlStateNormal];
        _btnAdd.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
    }
    return _btnAdd;
}

- (void)btnAddAction{
    NSInteger num = [self.labNum.text integerValue];
    if (num <99) {
        num ++;
        self.labNum.text = [NSString stringWithFormat:@"%li",(long)num];
        if (self.changeIndex) {
            self.changeIndex(self.labNum.text);
        }
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
