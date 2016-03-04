//
//  hopDetailBuyDescTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShopDetailBuyDescTableViewCell.h"
#import "CartListModel.h"
@implementation ShopDetailBuyDescTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labNumName];
    [self.contentView addSubview:self.viewBack];
    [self.viewBack addSubview:self.btnReduct];
    [self.viewBack addSubview:self.btnAdd];
    [self.viewBack addSubview:self.labNum];
    [self.contentView addSubview:self.labPrice];
    [self.contentView addSubview:self.labCode];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 130, 110)];
        _imgLogo.backgroundColor = [UIColor grayColor];
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 10, DeviceSize.width -self.imgLogo.right -20, 0)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.numberOfLines = 2;
    }
    return _labTitle;
}

- (UILabel *)labNumName{
    if (!_labNumName) {
        _labNumName = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.imgLogo.bottom -30, 0, 30)];
        _labNumName.textColor = [UIColor colorWithHEX:0x333333];
        _labNumName.font = [UIFont systemFontOfSize:15];
        _labNumName.text = @"数量";
        CGSize size = [_labNumName.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, 15)];
        _labNumName.width = size.width;
    }
    return _labNumName;
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(self.labNumName.right +10, self.imgLogo.bottom -30, 90, 30)];
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
        if (self.changeInfoBlock) {
            self.changeInfoBlock(0,num);
        }
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
        if (self.changeInfoBlock) {
            self.changeInfoBlock(1,num);
        }
        self.labNum.text = [NSString stringWithFormat:@"%li",num];
    }
}

- (UILabel *)labPrice{
    if (!_labPrice) {
        _labPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.viewBack.top -5 -13, self.labTitle.width, 13)];
        _labPrice.textColor = [UIColor colorWithHEX:0x999999];
        _labPrice.font = [UIFont systemFontOfSize:13];
    }
    return _labPrice;
}

- (UILabel *)labCode{
    if (!_labCode) {
        _labCode = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.labPrice.top -5 -13, self.labTitle.width, 13)];
        _labCode.textColor = [UIColor colorWithHEX:0x999999];
        _labCode.font = [UIFont systemFontOfSize:13];
    }
    return _labCode;
}

//赋值
- (void)confingWithModel:(id)model{
    if ([model isKindOfClass:[ShopInfoModel class]]) {
        ShopInfoModel * item = (ShopInfoModel *)model;
        self.labTitle.text = item.name;
        [self.labTitle sizeToFit];
        self.labNum.text = item.indexStr;
        [self.imgLogo sd_setImageWithURL:SD_IMG(item.thumb)];
        self.labCode.text = [ NSString stringWithFormat:@"编号:%@",item.cusid];
        self.labPrice.text = [NSString stringWithFormat:@"价格:%@",item.price];
    }else{
        CartListModel * item = (CartListModel *)model;
        self.labTitle.text = item.goods_name;
        [self.labTitle sizeToFit];
        self.labNum.text = item.qty;
        [self.imgLogo sd_setImageWithURL:SD_IMG(item.thumb)];
        self.labCode.text = [ NSString stringWithFormat:@"编号:%@",item.goods_id];
        self.labPrice.text = [NSString stringWithFormat:@"价格:%@",item.price];
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
