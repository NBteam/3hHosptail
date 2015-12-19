

//
//  AddressListDownCell.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AddressListDownCell.h"

@implementation AddressListDownCell
- (void)customView{
    [self.contentView addSubview:self.labName];
    [self.contentView addSubview:self.imgAdd];
}
- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc]initWithFrame:CGRectMake(15, 22-15/2, 100, 15)];
        _labName.font = [UIFont systemFontOfSize:13];
        _labName.textAlignment = NSTextAlignmentLeft;
        _labName.textColor = [UIColor colorWithHEX:0xcccccc];
        _labName.text = @"新增收货地址";
    }
    return _labName;
}
- (UIImageView *)imgAdd{
    if (!_imgAdd) {
        _imgAdd = [[UIImageView alloc]initWithFrame:CGRectMake(DeviceSize.width - 15 - 17, 44/2-17/2, 17, 17)];
        _imgAdd.image = [UIImage imageNamed:@"首页-健康商城-商品详情-立即购买-收货地址2"];
    }
    return _imgAdd;
}
@end
