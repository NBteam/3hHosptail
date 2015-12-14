//
//  BookDetailHeadTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BookDetailHeadTableViewCell.h"

@implementation BookDetailHeadTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgPatientPic];
    [self.contentView addSubview:self.labPatientName];
    [self.contentView addSubview:self.labPatientInfo];
    [self.contentView addSubview:self.imgArrow];

}

- (UIImageView *)imgPatientPic{
    if (!_imgPatientPic) {
        _imgPatientPic = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 70, 70)];
        _imgPatientPic.backgroundColor = [UIColor grayColor];
        _imgPatientPic.layer.masksToBounds = YES;
        _imgPatientPic.layer.cornerRadius = 35.0f;
    }
    return _imgPatientPic;
    
}

- (UILabel *)labPatientName{
    if (!_labPatientName) {
        _labPatientName = [[UILabel alloc] initWithFrame:CGRectMake(self.imgPatientPic.right +10, self.imgPatientPic.top +10, 100, 15)];
        _labPatientName.textColor = [UIColor colorWithHEX:0x333333];
        _labPatientName.font = [UIFont systemFontOfSize:15];
    }
    return _labPatientName;
}

- (UILabel *)labPatientInfo{
    if (!_labPatientInfo) {
        _labPatientInfo = [[UILabel alloc] initWithFrame:CGRectMake(self.imgPatientPic.right +10, self.imgPatientPic.bottom -24, DeviceSize.width/2, 14)];
        _labPatientInfo.textColor = [UIColor colorWithHEX:0x999999];
        _labPatientInfo.font = [UIFont systemFontOfSize:14];
    }
    return _labPatientInfo;
}

- (UIImageView *)imgArrow{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 19/2 - 10, (100 - 34/2)/2, 19/2, 34/2)];
        _imgArrow.image = [UIImage imageNamed:@"3H-首页_键"];
        
    }
    return _imgArrow;
}

- (void)confingWithModel:(NSDictionary *)dic{
    self.labPatientName.text = dic[@"truename"];
    self.labPatientInfo.text = [NSString stringWithFormat:@"%@岁 %@",dic[@"birth_y"],dic[@"sex"]] ;
    [self.imgPatientPic sd_setImageWithURL:URL(dic[@"pic"]) placeholderImage:IMG(@"")];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
