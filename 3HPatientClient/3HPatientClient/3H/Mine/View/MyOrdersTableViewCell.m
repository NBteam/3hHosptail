//
//  MyOrdersTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MyOrdersTableViewCell.h"

@implementation MyOrdersTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labState];
    [self.contentView addSubview:self.labPrice];
    [self.contentView addSubview:self.labLine1];
    [self.contentView addSubview:self.imgProduct];
    [self.contentView addSubview:self.labProduct];
    [self.contentView addSubview:self.labSingePrice];
    [self.contentView addSubview:self.labNum];
    [self.contentView addSubview:self.labLine2];
    [self.contentView addSubview:self.labPrice];
    [self.contentView addSubview:self.labLine3];
//    [self.contentView addSubview:self.btnDelete];
    [self.contentView addSubview:self.btnAppraise];
    
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 15, 15)];
        _imgLogo.backgroundColor = [UIColor grayColor];
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 10, DeviceSize.width/2, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labState{
    if (!_labState) {
        _labState = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width -10 -DeviceSize.width/3, 10, DeviceSize.width/3, 15)];
        _labState.textColor = AppDefaultColor;
        _labState.font = [UIFont systemFontOfSize:13];
        _labState.textAlignment = NSTextAlignmentRight;
    }
    return _labState;
}

- (UILabel *)labLine1{
    if (!_labLine1) {
        _labLine1 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.imgLogo.bottom +10, DeviceSize.width - 20, 0.5)];
        _labLine1.backgroundColor = [UIColor colorWithHEX:0xcccccc];
        
    }
    return _labLine1;
}

- (UIImageView *)imgProduct{
    if (!_imgProduct) {
        _imgProduct = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.labLine1.bottom +10, 75, 65)];
        _imgProduct.backgroundColor = [UIColor grayColor];
        
    }
    return _imgProduct;
}

- (UILabel *)labProduct{
    if (!_labProduct) {
        _labProduct = [[UILabel alloc] initWithFrame:CGRectMake(self.imgProduct.right +10, self.labLine1.bottom +10, DeviceSize.width/2, 0)];
        _labProduct.textColor = [UIColor colorWithHEX:0x333333];
        _labProduct.font = [UIFont systemFontOfSize:15];
        _labProduct.numberOfLines = 3;
    }
    return _labProduct;
}

- (UILabel *)labSingePrice{
    if (!_labSingePrice) {
        _labSingePrice = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width - 10 -DeviceSize.width/4, self.labLine1.bottom +10, DeviceSize.width/4, 15)];
        _labSingePrice.textColor = [UIColor colorWithHEX:0x333333];
        _labSingePrice.font = [UIFont systemFontOfSize:15];
        _labSingePrice.textAlignment = NSTextAlignmentRight;
    }
    return _labSingePrice;
}

- (UILabel *)labNum{
    if (!_labNum) {
        _labNum = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width - 10 -DeviceSize.width/4, self.labSingePrice.bottom +15, DeviceSize.width/4, 13)];
        _labNum.textColor = [UIColor colorWithHEX:0x888888];
        _labNum.font = [UIFont systemFontOfSize:13];
        _labNum.textAlignment = NSTextAlignmentRight;
    }
    return _labNum;
}

- (UILabel *)labLine2{
    if (!_labLine2) {
        _labLine2 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.imgProduct.bottom +10, DeviceSize.width - 20, 0.5)];
        _labLine2.backgroundColor = [UIColor colorWithHEX:0xcccccc];
        
    }
    return _labLine2;
}

- (UILabel *)labPrice{
    if (!_labPrice) {
        _labPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labLine2.bottom +10, DeviceSize.width -20, 15)];
        _labPrice.textAlignment = NSTextAlignmentRight;
        _labPrice.font = [UIFont systemFontOfSize:15];
        _labPrice.textColor = [UIColor colorWithHEX:0x888888];
        _labPrice.textAlignment = NSTextAlignmentRight;
        
    }
    return _labPrice;
}

- (UILabel *)labLine3{
    if (!_labLine3) {
        _labLine3 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labPrice.bottom +10, DeviceSize.width - 20, 0.5)];
        _labLine3.backgroundColor = [UIColor colorWithHEX:0xcccccc];
        
    }
    return _labLine3;
}

- (UIButton *)btnDelete{
    if (!_btnDelete) {
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDelete.frame = CGRectMake(self.btnAppraise.left -10 -65, self.labLine3.bottom +7.5, 65, 30);
        _btnDelete.backgroundColor = AppDefaultColor;
        _btnDelete.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnDelete setTitle:@"删除订单" forState:UIControlStateNormal];
        [_btnDelete setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        _btnDelete.layer.masksToBounds = YES;
        _btnDelete.layer.cornerRadius = 3;
        [_btnDelete addTarget:self action:@selector(btnDeleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDelete;
}

- (void)btnDeleteAction{
    
}

- (UIButton *)btnAppraise{
    if (!_btnAppraise) {
        _btnAppraise = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAppraise.frame = CGRectMake(DeviceSize.width -65 -10, self.labLine3.bottom +7.5, 65, 30);
        _btnAppraise.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _btnAppraise.titleLabel.font = [UIFont systemFontOfSize:13];
        _btnAppraise.backgroundColor = AppDefaultColor;
        [_btnAppraise setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnAppraise.layer.masksToBounds = YES;
        _btnAppraise.layer.cornerRadius = 3;
        _btnAppraise.layer.borderColor = AppDefaultColor.CGColor;
        _btnAppraise.layer.borderWidth = 0.5;
        [_btnAppraise addTarget:self action:@selector(btnAppraiseAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAppraise;
}

- (void)btnAppraiseAction{
    if (self.confirmBlock) {
        self.confirmBlock([self.model.status doubleValue]);
    }
}

//赋值
- (void)confingWithModel:(OrderListNewModel *)model{
    self.model = model;
    self.labTitle.text = model.ilist[0][@"goods_name"];
    [self.imgProduct sd_setImageWithURL:SD_IMG(model.ilist[0][@"thumb"])];
    if ([model.status doubleValue] == -1 ) {
        self.labState.text = @"取消订单";
        [self.btnAppraise setTitle:@"取消订单" forState:UIControlStateNormal];
    }else if ([model.status doubleValue] == 0 ){
        self.labState.text = @"待支付";
        [self.btnAppraise setTitle:@"付款" forState:UIControlStateNormal];
    }else if ([model.status doubleValue] == 1 ){
        self.labState.text = @"已确认";
        [self.btnAppraise setTitle:@"再次购买" forState:UIControlStateNormal];
    }else if ([model.status doubleValue] == 2 ){
        self.labState.text = @"已发货";
        [self.btnAppraise setTitle:@"确认收货" forState:UIControlStateNormal];
    }else if ([model.status doubleValue] == 3 ){
        self.labState.text = @"确认收货";
        [self.btnAppraise setTitle:@"确认收货" forState:UIControlStateNormal];
    }
    if ([model.pay_status doubleValue] == 0) {
        self.labProduct.text = 	@"未支付";
    }else if ([model.pay_status doubleValue] == 1){
        self.labProduct.text = 	@"已支付";
    }
    [self.labProduct sizeToFit];
    self.labSingePrice.text = [NSString stringWithFormat:@"￥%.2f",[model.ilist[0][@"price"] doubleValue]];
    self.labNum.text = [NSString stringWithFormat:@"X%@",model.ilist[0][@"qty"]] ;
    self.labPrice.attributedText = [self getLabTitle:[NSString stringWithFormat:@"共%@件商品 实付:",self.labNum.text] Detail:[NSString stringWithFormat:@"￥%.2f",[model.ilist[0][@"price"] doubleValue]*[model.ilist[0][@"qty"] doubleValue]]];
    
}


- (NSMutableAttributedString *)getLabTitle:(NSString *)title Detail:(NSString *)detail{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",title,detail]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x999999] range:NSMakeRange(0,title.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x888888] range:NSMakeRange(title.length,detail.length)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0,title.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(title.length,detail.length)];
    return str;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
