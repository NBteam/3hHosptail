//
//  DynamicCommentsTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "DynamicCommentsTableViewCell.h"

@implementation DynamicCommentsTableViewCell


- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labType];
    [self.contentView addSubview:self.labDetail];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        _imgLogo.backgroundColor = AppDefaultColor;
        _imgLogo.layer.masksToBounds = YES;
        _imgLogo.layer.cornerRadius = 20;
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.imgLogo.top +5, DeviceSize.width -10 -self.imgLogo.right -10, 15)];
        _labTitle.textColor = AppDefaultColor;
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labType{
    if (!_labType) {
        _labType = [[UILabel alloc] initWithFrame:CGRectMake(self.labTitle.left, self.labTitle.bottom +5, self.labTitle.width, 13)];
        _labType.textColor = [UIColor colorWithHEX:0x999999];
        _labType.font = [UIFont systemFontOfSize:13];
    }
    return _labType;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.labTitle.left, self.labType.bottom +10, self.labTitle.width, 0)];
        _labDetail.textColor = [UIColor colorWithHEX:0x333333];
        _labDetail.font = [UIFont systemFontOfSize:14];
        _labDetail.numberOfLines = 0;
    }
    return _labDetail;
}

//赋值
- (CGFloat)confingWithModel:(NSInteger )dic{
    self.labTitle.text = @"红辣椒红";
    self.labType.text = @"中国医疗新闻网网友";
    self.labDetail.text = @"中国医疗新闻中国医疗新闻中国医疗新闻中国医疗新闻中国医疗新闻中国医疗新闻中国医疗新闻网友";
    [self.labDetail sizeToFit];

    return self.labDetail.bottom +10;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
