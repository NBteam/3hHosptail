//
//  PersonalHeadTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PersonalHeadTableViewCell.h"

@implementation PersonalHeadTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.imgDoctorPic];

}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 80)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"头像";
        
    }
    return _labTitle;
}

- (UIImageView *)imgDoctorPic{
    if (!_imgDoctorPic) {
        _imgDoctorPic = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width -50 -10, 15, 50, 50)];
        _imgDoctorPic.backgroundColor = [UIColor grayColor];
        _imgDoctorPic.layer.masksToBounds = YES;
        _imgDoctorPic.layer.cornerRadius = 25.0f;
    }
    return _imgDoctorPic;
    
}




- (void)confingWithModel:(NSString *)dic{
    [self.imgDoctorPic sd_setImageWithURL:URL(dic) placeholderImage:IMG(@"")];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
