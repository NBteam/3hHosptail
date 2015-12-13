//
//  AppointFinishHeadTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AppointFinishHeadTableViewCell.h"

@implementation AppointFinishHeadTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];

}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake((DeviceSize.width - 50)/2, 25, 50, 50)];
        _imgLogo.image = [UIImage imageNamed:@"首页-我要预约-预约挂号2-预约成功_预约成功"];
        
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgLogo.bottom +20, DeviceSize.width, 20)];
        _labTitle.textColor = AppDefaultColor;
        _labTitle.font = [UIFont systemFontOfSize:16];
        _labTitle.text = @"预约提交成功";
        _labTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labTitle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
