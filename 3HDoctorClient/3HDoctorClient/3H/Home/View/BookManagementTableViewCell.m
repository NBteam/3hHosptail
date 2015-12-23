//
//  BookManagementTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BookManagementTableViewCell.h"

@implementation BookManagementTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgPatient];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labTime];
    [self.contentView addSubview:self.labState];
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

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(self.imgPatient.right +6, self.imgPatient.bottom -9 -12, DeviceSize.width - self.imgPatient.right -6 - 10 -9 -10, 12)];
        _labTime.textColor = [UIColor colorWithHEX:0x888888];
        _labTime.font = [UIFont systemFontOfSize:12];
    }
    return _labTime;
}

- (UILabel *)labState{
    if (!_labState) {
        _labState = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width -10 -50, self.labTitle.top, 50, 12)];
        _labState.textColor = [UIColor colorWithHEX:0x888888];
        _labState.font = [UIFont systemFontOfSize:12];
    }
    return _labState;
}

//赋值
- (void)confingWithModel:(BookIsPhoneModel *)dic{
    self.labTitle.attributedText = [self getName:dic.truename AndAge:[NSString stringWithFormat:@"  %@",dic.age] AndSex:[NSString stringWithFormat:@"  %@",dic.sex]];
    //  self.labDetail.attributedText
    self.labTime.text = [NSString stringWithFormat:@"预约时间:%@",dic.addtime];
    [self.imgPatient sd_setImageWithURL:[NSURL URLWithString:dic.pic] placeholderImage:[UIImage imageNamed:@""]];
    self.labState.text = [NSString stringWithFormat:@"%@",dic.status_n];
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
