//
//  ConsultingIsPhoneTitleTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingIsPhoneTitleTableViewCell.h"

@implementation ConsultingIsPhoneTitleTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
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
- (void)confingWithModel:(NSInteger )dic{
    self.labDetail.text = @"1800元";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
