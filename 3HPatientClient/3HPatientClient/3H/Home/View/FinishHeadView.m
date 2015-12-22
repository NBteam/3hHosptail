//
//  FinishHeadView.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/22.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "FinishHeadView.h"

@implementation FinishHeadView

- (id)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.backView];
        [self.backView addSubview:self.labLine1];
        [self.backView addSubview:self.imgTitle];
        [self.backView addSubview:self.labInfo];
        [self.backView addSubview:self.labLine2];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, DeviceSize.width, 130)];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
- (UILabel *)labLine1{
    if (!_labLine1) {
        _labLine1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0.5)];
        _labLine1.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine1;
}
- (UILabel *)labLine2{
    if (!_labLine2) {
        _labLine2 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.backView.bottom - 10.5, DeviceSize.width, 0.5)];
        _labLine2.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine2;
}
- (UIImageView *)imgTitle{
    if (!_imgTitle) {
        _imgTitle = [[UIImageView alloc]initWithFrame:CGRectMake(self.backView.width/2 - 25, 20, 50, 50)];
        _imgTitle.image = [UIImage imageNamed:@"首页-我要预约-预约挂号2-预约成功_预约成功"];
    }
    return _imgTitle;
}
- (UILabel *)labInfo{
    if (!_labInfo) {
        _labInfo = [[UILabel alloc]initWithFrame:CGRectMake(self.backView.width/2-100, self.imgTitle.bottom +15,200 , 21)];
        _labInfo.font = [UIFont systemFontOfSize:21];
        _labInfo.textColor = [UIColor colorWithHEX:0x77be31];
        _labInfo.text = @"预约提交成功";
        _labInfo.textAlignment = NSTextAlignmentCenter;
    }
    return _labInfo;
}
@end
