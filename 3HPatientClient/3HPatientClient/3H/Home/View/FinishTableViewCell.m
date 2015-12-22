//
//  FinishTableViewCell.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/22.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "FinishTableViewCell.h"

@implementation FinishTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labFirst];
    [self.contentView addSubview:self.labSecond];
    [self.contentView addSubview:self.labThird];
}
- (UILabel *)labFirst{
    if (!_labFirst) {
        _labFirst = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, DeviceSize.width - 20, 15)];
        _labFirst.font = [UIFont systemFontOfSize:15];
        _labFirst.textAlignment = NSTextAlignmentLeft;
        _labFirst.textColor = [UIColor grayColor];
    }
    return _labFirst;
}
- (UILabel *)labSecond{
    if (!_labSecond) {
        _labSecond = [[UILabel alloc]initWithFrame:CGRectMake(10, self.labFirst.bottom + 10, DeviceSize.width - 20, 15)];
        _labSecond.font = [UIFont systemFontOfSize:15];
        _labSecond.textAlignment = NSTextAlignmentLeft;
        _labSecond.textColor = [UIColor grayColor];
    }
    return _labSecond;
}
- (UILabel *)labThird{
    if (!_labThird) {
        _labThird = [[UILabel alloc]initWithFrame:CGRectMake(10, self.labSecond.bottom + 10, DeviceSize.width - 20, 15)];
        _labThird.font = [UIFont systemFontOfSize:15];
        _labThird.textAlignment = NSTextAlignmentLeft;
        _labThird.textColor = [UIColor grayColor];
    }
    return _labThird;
}
- (CGFloat )configWithModel:(id)model{
    self.labFirst.text = @"您的预约提交成功";
    self.labSecond.text = @"预约时间：2016年01月10日";
    self.labThird.text = @"请您按时就诊";
    return self.labThird.bottom + 10;
}
@end
