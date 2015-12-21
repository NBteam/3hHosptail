//
//  ConsultingIsPhoneTitleTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingIsPhoneTitleTableViewCell.h"

@implementation ConsultingIsPhoneTitleTableViewCell

- (id)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.viewBack];
        [self.viewBack addSubview:self.imgLogo];
        [self.viewBack addSubview:self.labTitle];
        [self.viewBack addSubview:self.labDetail];
        [self.viewBack addSubview:self.labLine];
        [self.viewBack addSubview:self.labLine1];
    }
    return self;
}
- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(0, 10, DeviceSize.width, 45)];
        _viewBack.backgroundColor = [UIColor whiteColor];
    }
    return  _viewBack;
}
- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}
- (UILabel *)labLine1{
    if (!_labLine1) {
        _labLine1 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.viewBack.bottom-10.5, DeviceSize.width, 0.5)];
        _labLine1.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine1;
}
- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, (45 -21/2)/2, 32/2, 21/2)];
        _imgLogo.image = [UIImage imageNamed:@"首页-我要预约-预约挂号-2_挂号费用3"];
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 0, 0, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"咨询费用";
        [_labTitle sizeToFit];
        _labTitle.top = (45 -_labTitle.height)/2;
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.labTitle.right +10, 0, DeviceSize.width -self.labTitle.right -10, 45)];
        _labDetail.textColor = AppDefaultColor;
        _labDetail.font = [UIFont systemFontOfSize:15];
    }
    return _labDetail;
}

//赋值
- (void)confingWithModel:(CGFloat )dic{
    self.labDetail.text = [NSString stringWithFormat:@"%.2f元",dic];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
