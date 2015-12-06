//
//  ConsultingDynamicTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingDynamicTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ConsultingDynamicTableViewCell


- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
    [self.contentView addSubview:self.imgTime];
    [self.contentView addSubview:self.labTime];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 80)];
        _imgLogo.backgroundColor = [UIColor whiteColor];
        _imgLogo.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _imgLogo.layer.borderWidth = 0.5;
        
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 13, DeviceSize.width -20 -self.imgLogo.right -10, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.labTitle.bottom +10, DeviceSize.width -10 -self.imgLogo.right -10, 0)];
        _labDetail.textColor = [UIColor colorWithHEX:0x888888];
        _labDetail.font = [UIFont systemFontOfSize:12];
        _labDetail.numberOfLines = 2;
    }
    return _labDetail;
}

- (UIImageView *)imgTime{
    if (!_imgTime) {
        _imgTime = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100 - 20 +1, 10, 10)];
        _imgTime.image = [UIImage imageNamed:@"首页-资讯动态_时间"];
        
    }
    return _imgTime;
}

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 100 - 20, 0, 12)];
        _labTime.textColor = [UIColor colorWithHEX:0x999999];
        _labTime.font = [UIFont systemFontOfSize:12];
    }
    return _labTime;
}

//赋值
- (void)confingWithModel:(InformationModel *)model{
    self.labTitle.text = model.title;
    self.labDetail.text = model.desc;
    [self.labDetail sizeToFit];
    self.labDetail.top = self.labTitle.bottom +10;
    [self.imgLogo sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@""]];
    self.labTime.text = model.addtime;
    CGSize size = [self.labTime.text sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(0, 12)];
    
    self.labTime.left = DeviceSize.width -size.width -10;
    self.labTime.width = size.width;
    
    self.imgTime.left = self.labTime.left -5 -10;
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
