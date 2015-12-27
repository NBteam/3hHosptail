//
//  ShoppingCartTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/27.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"

@implementation ShoppingCartTableViewCell

- (void)customView{
    [self.contentView addSubview:self.btnSelect];
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.viewBack];
    [self.viewBack addSubview:self.btnReduct];
    [self.viewBack addSubview:self.btnAdd];
    [self.viewBack addSubview:self.labNum];
    [self.contentView addSubview:self.labPrice];
}

- (UIButton *)btnSelect{
    if (!_btnSelect) {
        _btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSelect.frame = CGRectMake(0, (90 -35)/2, 35, 35);
        [_btnSelect setImage:[UIImage imageNamed:@"3H-注册_选框"] forState:UIControlStateNormal];
        [_btnSelect setImage:[UIImage imageNamed:@"3H-注册_全选"] forState:UIControlStateSelected];
        _btnSelect.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnSelect addTarget:self action:@selector(btnSelectClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSelect;
}

- (void)btnSelectClick{
    if (self.btnSelect.selected) {
        self.btnSelect.selected = NO;
    }else{
        self.btnSelect.selected = YES;
    }
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(self.btnSelect.right, 10, 80, 70)];
        _imgLogo.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _imgLogo.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _imgLogo.layer.borderWidth = 0.5;
        
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.imgLogo.top, DeviceSize.width -self.imgLogo.right -20, 0)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.numberOfLines = 2;
    }
    return _labTitle;
}

- (UILabel *)labPrice{
    if (!_labPrice) {
        _labPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.imgLogo.bottom -15, self.viewBack.left -self.imgLogo.right -20, 15)];
        _labPrice.textColor = AppDefaultColor;
        _labPrice.font = [UIFont systemFontOfSize:15];
    }
    return _labPrice;
}




- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(DeviceSize.width -90 -10, (90 -30 -10), 90, 30)];
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
        _labNum.text = @"99";
        _labNum.textAlignment = NSTextAlignmentCenter;
    }
    return _labNum;
}

- (void)btnReductAction{
    NSInteger num = [self.labNum.text integerValue];
    if (num >1) {
        num --;
        self.labNum.text = [NSString stringWithFormat:@"%li",num];
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
        self.labNum.text = [NSString stringWithFormat:@"%li",num];
    }
}

- (void)confingWithModel{
    self.labTitle.text = @"首页-健康商城-商品详情_数量首页-健康商城-商品详情_数量首页-健康商城-商品详情_数量";
    [self.labTitle sizeToFit];
    self.labTitle.top = self.imgLogo.top;
    self.labTitle.width = DeviceSize.width -self.imgLogo.right -20;
    self.labPrice.text = @"100元";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
