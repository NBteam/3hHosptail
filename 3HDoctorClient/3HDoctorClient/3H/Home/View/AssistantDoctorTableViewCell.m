//
//  AssistantDoctorTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "AssistantDoctorTableViewCell.h"

@implementation AssistantDoctorTableViewCell


- (void)customView{
    [self.contentView addSubview:self.imgAssistant];
    [self.contentView addSubview:self.labAssistant];
    [self.contentView addSubview:self.imgArrow];
    //[self.contentView addSubview:self.labDetail];
}

- (UIImageView *)imgAssistant{
    if (!_imgAssistant) {
        _imgAssistant = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        _imgAssistant.layer.masksToBounds = YES;
        _imgAssistant.layer.cornerRadius = 25;
        _imgAssistant.backgroundColor = [UIColor grayColor];
    }
    return _imgAssistant;
}

- (UILabel *)labAssistant{
    if (!_labAssistant) {
        _labAssistant = [[UILabel alloc] initWithFrame:CGRectMake(self.imgAssistant.right +10, self.imgAssistant.top +5, 100, 15)];
        _labAssistant.textColor = [UIColor colorWithHEX:0x333333];
        _labAssistant.font = [UIFont systemFontOfSize:15];
        
    }
    return _labAssistant;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.imgAssistant.right +10, self.imgAssistant.bottom -13 -5, self.imgArrow.left - self.imgAssistant.right -20, 13)];
        _labDetail.textColor = [UIColor colorWithHEX:0x888888];
        _labDetail.font = [UIFont systemFontOfSize:13];
        
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
- (void )confingWithModel:(AssistantDoctorModel *)model{
    NSLog(@"%@---",model);
    [self.imgAssistant sd_setImageWithURL:URL(model.pic) placeholderImage:[UIImage imageNamed:@""]];
    self.labAssistant.text = model.truename;
//    self.labDetail.text = [NSString stringWithFormat:@"%@ %@",model.hospital,model.job_title];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
