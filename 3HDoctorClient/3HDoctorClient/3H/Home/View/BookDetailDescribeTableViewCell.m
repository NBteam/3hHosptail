//
//  BookDetailDescribeTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BookDetailDescribeTableViewCell.h"

@implementation BookDetailDescribeTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
    
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width -20, 0)];
        _labTitle.textColor = [UIColor colorWithHEX:0x999999];
        _labTitle.font = [UIFont systemFontOfSize:13];
        _labTitle.numberOfLines = 0;
    }
    return _labTitle;
}

//赋值
- (CGFloat)confingWithModel:(PhoneDetailModel *)dic{
    self.labTitle.text = dic.desc;
    [self.labTitle sizeToFit];
    self.labTitle.top = 10;
    self.labTitle.width = DeviceSize.width -20;
    return self.labTitle.bottom +10;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
