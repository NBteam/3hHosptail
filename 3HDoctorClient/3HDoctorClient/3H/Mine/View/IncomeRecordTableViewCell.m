//
//  IncomeRecordTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "IncomeRecordTableViewCell.h"

@implementation IncomeRecordTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width / 2, 40)];
        _labTitle.textColor = [UIColor colorWithHEX:0x666666];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.layer.borderWidth = 0.5;
        _labTitle.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _labTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width / 2, 0, DeviceSize.width / 2, 40)];
        _labDetail.textColor = [UIColor colorWithHEX:0x888888];
        _labDetail.font = [UIFont systemFontOfSize:15];
        _labDetail.layer.borderWidth = 0.5;
        _labDetail.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _labDetail.textAlignment = NSTextAlignmentCenter;
    }
    return _labDetail;
}

//赋值
- (void)confingWithModel:(NSInteger )index{
    self.labTitle.text = @"70元";
    self.labDetail.text = @"2012-12-12";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
