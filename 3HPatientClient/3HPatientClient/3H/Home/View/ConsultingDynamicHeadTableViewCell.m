//
//  ConsultingDynamicHeadTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/14.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ConsultingDynamicHeadTableViewCell.h"

@implementation ConsultingDynamicHeadTableViewCell


- (void)customView{
    [self.contentView addSubview:self.imgBack];
    [self.contentView addSubview:self.viewBlack];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labTime];
    [self.contentView addSubview:self.imgLogo];
}


- (UIImageView *)imgBack{
    if (!_imgBack) {
        _imgBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 150)];
    }
    return _imgBack;
}

- (UIView *)viewBlack{
    if (!_viewBlack) {
        _viewBlack = [[UIView alloc] initWithFrame:CGRectMake(0, self.imgBack.height - 35, DeviceSize.width, 35)];
        _viewBlack.backgroundColor = [UIColor blackColor];
        _viewBlack.alpha = 0.5;
    }
    return _viewBlack;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, self.imgBack.height - 35 +10, DeviceSize.width -20, 15)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = [UIColor colorWithHEX:0xffffff];
    }
    return _labTitle;
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 11, 10, 10)];
        _imgLogo.image = [UIImage imageNamed:@"首页-资讯动态_时间"];
        
    }
    return _imgLogo;
}

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 0, 12)];
        _labTime.textColor = [UIColor colorWithHEX:0x999999];
        _labTime.font = [UIFont systemFontOfSize:12];
    }
    return _labTime;
}


//赋值
- (void)confingWithModel:(ConsultingDynamicListModel *)dic{
    self.labTitle.text = dic.title;
    self.labTime.text = dic.addtime;
    [self.imgBack sd_setImageWithURL:SD_IMG(dic.thumb)];
    CGSize size = [self.labTime.text sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(0, 12)];
    
    self.labTime.left = DeviceSize.width -size.width -10;
    self.labTime.width = size.width;
    
    self.imgLogo.left = self.labTime.left -5 -10;
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
