//
//  HomeHeadView.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "HomeHeadView.h"

@implementation HomeHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHEX:0xffffff];
        [self addSubview:self.viewWhite];
        [self addSubview:self.imgBack];
        [self addSubview:self.labTitle];
        [self addSubview:self.imgMyPicture];
        [self addSubview:self.labName];
        [self addSubview:self.labDetail];
    }
    return self;
}
- (UIView *)viewWhite{
    if (!_viewWhite) {
        _viewWhite = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 20)];
        _viewWhite.backgroundColor = AppDefaultColor;
    }
    return _viewWhite;
}
- (UIImageView *)imgBack{
    if (!_imgBack) {
        _imgBack = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, DeviceSize.width, 200)];
        _imgBack.image = [UIImage imageNamed:@"3H-首页_背景"];
    }
    return _imgBack;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 15 +20, DeviceSize.width, 17)];
        _labTitle.textColor = [UIColor colorWithHEX:0xffffff];
        _labTitle.font = [UIFont systemFontOfSize:17];
        _labTitle.textAlignment = NSTextAlignmentCenter;
        
    }
    return _labTitle;
}

- (UIImageView *)imgMyPicture{
    if (!_imgMyPicture) {
        _imgMyPicture = [[UIImageView alloc] initWithFrame:CGRectMake((DeviceSize.width -84)/2, self.labTitle.bottom +25, 84, 84)];
        _imgMyPicture.backgroundColor = [UIColor grayColor];
        _imgMyPicture.layer.masksToBounds = YES;
        _imgMyPicture.layer.cornerRadius = 42;
        _imgMyPicture.layer.borderColor = [UIColor colorWithHEX:0xffffff].CGColor;
        _imgMyPicture.layer.borderWidth = 2;
        
    }
    return _imgMyPicture;
}

- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imgMyPicture.bottom +10, DeviceSize.width, 16)];
        _labName.textColor = [UIColor colorWithHEX:0xffffff];
        _labName.font = [UIFont systemFontOfSize:16];
        _labName.textAlignment = NSTextAlignmentCenter;
    }
    return _labName;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, self.labName.bottom +5, DeviceSize.width, 13)];
        _labDetail.textColor = [UIColor colorWithHEX:0xffffff];
        _labDetail.font = [UIFont systemFontOfSize:13];
        _labDetail.textAlignment = NSTextAlignmentCenter;
    }
    return _labDetail;
}

- (void)confingWithModel:(NSDictionary *)dict{
   // self.labTitle.text = @"";
    self.labName.text = dict[@"truename"];
    self.labDetail.text = [NSString stringWithFormat:@"%@  %@",dict[@"hospital"],dict[@"job_title"]];
    [self.imgMyPicture sd_setImageWithURL:[NSURL URLWithString:dict[@"pic"]] placeholderImage:[UIImage imageNamed:@""]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
