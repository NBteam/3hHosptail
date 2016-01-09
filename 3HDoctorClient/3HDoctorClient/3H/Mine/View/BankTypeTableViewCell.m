//
//  BankTypeTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 16/1/9.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BankTypeTableViewCell.h"

@implementation BankTypeTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgArrow];
    [self.contentView addSubview:self.labName];
}


- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.imgArrow.left -20, 45)];
        _labName.textColor = [UIColor colorWithHEX:0x333333];
        _labName.font = [UIFont systemFontOfSize:15];
    }
    return _labName;
}

- (UIImageView *)imgArrow{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 19/2 - 10, (45 - 34/2)/2, 19/2, 34/2)];
        _imgArrow.image = [UIImage imageNamed:@"3H-首页_键"];
        
    }
    return _imgArrow;
}
//赋值
//赋值
- (void)confingWithModel:(NSString *)model{

    self.labName.text = model;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
