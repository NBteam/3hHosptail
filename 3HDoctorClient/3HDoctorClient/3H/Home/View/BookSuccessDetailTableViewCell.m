//
//  BookSuccessDetailTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BookSuccessDetailTableViewCell.h"

@implementation BookSuccessDetailTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceSize.width -20, 0)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = [UIColor colorWithHEX:0x999999];
        _labTitle.numberOfLines = 0;

    }
    return _labTitle;
}
//赋值
- (CGFloat )confingWithModel:(NSString *)time Name:(NSString *)name;{
    self.labTitle.text = [NSString stringWithFormat:@"您成功接收了一次挂号预约!\n您接受的预约时间是:%@\n您接受的预约来自患者%@\n请您准时接诊!",time,name];
    [self.labTitle sizeToFit];
    self.labTitle.top = 10;
    self.labTitle.width = DeviceSize.width -20;
    return self.labTitle.bottom +12;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
