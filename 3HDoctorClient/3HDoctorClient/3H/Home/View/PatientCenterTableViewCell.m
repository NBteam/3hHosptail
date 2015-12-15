//
//  PatientCenterTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "PatientCenterTableViewCell.h"

@implementation PatientCenterTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgPatient];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
    [self.contentView addSubview:self.imgArrow];
}

- (UIImageView *)imgPatient{
    if (!_imgPatient) {
        _imgPatient = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        _imgPatient.backgroundColor = [UIColor grayColor];
        _imgPatient.layer.masksToBounds = YES;
        _imgPatient.layer.cornerRadius = 25;
    }
    return _imgPatient;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgPatient.right +6, 19, DeviceSize.width/2, 14)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:14];
        
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.imgPatient.right +6, self.imgPatient.bottom -9 -12, DeviceSize.width - self.imgPatient.right -6 - 10 -9 -10, 12)];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
        _labDetail.font = [UIFont systemFontOfSize:12];
    }
    return _labDetail;
}

- (UIImageView *)imgArrow{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 19/2 - 10, (70 - 34/2)/2, 19/2, 34/2)];
        _imgArrow.image = [UIImage imageNamed:@"3H-首页_键"];
        
    }
    return _imgArrow;
}

//赋值
- (void)confingWithModel:(PatientListModel *)dic{
    self.labTitle.attributedText = [self getName:dic.truename AndAge:[NSString stringWithFormat:@"  %@",dic.age] AndSex:[NSString stringWithFormat:@"  %@",dic.sex]];
  //  self.labDetail.attributedText
    self.labDetail.text = dic.sick_desc;
}

- (NSMutableAttributedString *)getName:(NSString *)name AndAge:(NSString *)age AndSex:(NSString *)sex{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",name,age,sex]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, name.length)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(name.length, age.length)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(name.length +age.length, sex.length)];
    
    return str;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
