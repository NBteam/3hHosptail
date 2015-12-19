//
//  ShopDetailDescTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShopDetailDescTableViewCell.h"

@implementation ShopDetailDescTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceSize.width -20, 0)];
        _labTitle.textColor = [UIColor colorWithHEX:0x999999];
        _labTitle.font = [UIFont systemFontOfSize:12];
        _labTitle.numberOfLines = 0;
    }
    return _labTitle;
}

//赋值
- (CGFloat)confingWithModel:(NSString *)model{
    self.labTitle.text = model;
    [self.labTitle sizeToFit];
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
