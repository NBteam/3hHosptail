//
//  PatientAddRequestTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "PatientAddRequestTableViewCell.h"

@implementation PatientAddRequestTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgPatient];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.btnAgreed];
    [self.contentView addSubview:self.btnRefused];
    [self.contentView addSubview:self.labDetail];
    
   
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
//        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
//        _labTitle.font = [UIFont systemFontOfSize:14];
        
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.imgPatient.right +6, self.imgPatient.bottom -9 -12, self.btnRefused.left - self.imgPatient.right -20, 12)];
        _labDetail.textColor = [UIColor colorWithHEX:0x666666];
        _labDetail.font = [UIFont systemFontOfSize:12];
    }
    return _labDetail;
}

- (UIButton *)btnRefused{
    if (!_btnRefused) {
        _btnRefused = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRefused.frame = CGRectMake(self.btnAgreed.left -10 -60, (70-30)/2, 60, 30);
        _btnRefused.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _btnRefused.layer.masksToBounds = YES;
        _btnRefused.layer.cornerRadius = 3;
        _btnRefused.layer.borderColor = AppDefaultColor.CGColor;
        _btnRefused.layer.borderWidth = 0.5;
        [_btnRefused setTitle:@"拒绝" forState:UIControlStateNormal];
        _btnRefused.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnRefused setTitleColor:AppDefaultColor forState:UIControlStateNormal];
        [_btnRefused addTarget:self action:@selector(btnRefusedAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRefused;
}

- (void)btnRefusedAction{
    if (self.btnRefusedBlock) {
        self.btnRefusedBlock();
    }
}

- (UIButton *)btnAgreed{
    if (!_btnAgreed) {
        _btnAgreed = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAgreed.frame = CGRectMake(DeviceSize.width - 60 -10, (70-30)/2, 60, 30);
        _btnAgreed.backgroundColor = AppDefaultColor;
        _btnAgreed.layer.masksToBounds = YES;
        _btnAgreed.layer.cornerRadius = 3;
        _btnAgreed.layer.borderColor = AppDefaultColor.CGColor;
        _btnAgreed.layer.borderWidth = 0.5;
        [_btnAgreed setTitle:@"同意" forState:UIControlStateNormal];
        _btnAgreed.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnAgreed setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        [_btnAgreed addTarget:self action:@selector(btnAgreedAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAgreed;
}

- (void)btnAgreedAction{
    if (self.btnAgreedBlock) {
        self.btnAgreedBlock();
    }
}

//赋值
- (void)confingWithModel:(PatientAddRequestModel *)dic{
    [self.imgPatient sd_setImageWithURL:[NSURL URLWithString:dic.pic] placeholderImage:[UIImage imageNamed:@""]];
    self.labTitle.attributedText = [self getName:dic.truename AndAge:[NSString stringWithFormat:@"  %@",dic.age] AndSex:[NSString stringWithFormat:@"  %@",dic.sex]];
    //  self.labDetail.attributedText
    self.labDetail.text = dic.sick_desc;
}

- (NSMutableAttributedString *)getName:(NSString *)name AndAge:(NSString *)age AndSex:(NSString *)sex{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",name,age,sex]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, name.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x333333] range:NSMakeRange(0, name.length)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(name.length, age.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x999999] range:NSMakeRange(name.length, age.length)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(name.length +age.length, sex.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x999999] range:NSMakeRange(name.length +age.length, sex.length)];
    
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
