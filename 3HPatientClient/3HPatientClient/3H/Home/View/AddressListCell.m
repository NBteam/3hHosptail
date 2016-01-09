//
//  AddressListCell.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AddressListCell.h"

@implementation AddressListCell
- (void)customView{
    [self.contentView addSubview:self.labDetail];
    [self.contentView addSubview:self.labName];
    [self.contentView addSubview:self.btnModify];
}
- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, DeviceSize.width - 40 - 40, 15)];
        _labDetail.font = [UIFont systemFontOfSize:15];
        _labDetail.numberOfLines = 0;
        _labDetail.textAlignment = NSTextAlignmentLeft;
    }
    return _labDetail;
}
- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc]initWithFrame:CGRectMake(15, self.labDetail.bottom + 10, self.labDetail.width, 15)];
        _labName.font = [UIFont systemFontOfSize:15];
        _labName.textAlignment = NSTextAlignmentLeft;
    }
    return _labName;
}
- (UIButton *)btnModify{
    if (!_btnModify) {
        _btnModify = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnModify.frame = CGRectMake(DeviceSize.width -  50, 20, 40, 40);
        [_btnModify addTarget:self action:@selector(btnModifyClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnModify setImage:[UIImage imageNamed:@"笔.jpg"] forState:UIControlStateNormal];
    }
    return _btnModify;
}
- (void)btnModifyClick:(UIButton *)button{
    if (self.btnModifyBlock) {
        self.btnModifyBlock();
    }
}
- (CGFloat )configWithModel:(AddressListModel *)model{
    self.labDetail.text = model.address;
    [self.labDetail sizeToFit];
    self.labDetail.top = 15;
    self.labDetail.left = 15;
    self.labDetail.width = DeviceSize.width - 30 - 50;
    self.labName.text = [NSString stringWithFormat:@"%@  %@",model.name,model.mobile];
    self.labName.top = self.labDetail.bottom + 10;
    self.btnModify.top = (self.labName.bottom + 10)/2 - 20;
    return self.labName.bottom + 15;
}

@end
