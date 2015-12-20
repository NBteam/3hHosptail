//
//  PhoneExperToolView.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/20.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PhoneExperToolView.h"

@implementation PhoneExperToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHEX:0xffffff];
//        [self customView];
        [self addSubview:self.labLine];
        [self addSubview:self.btnTelephone];
    }
    return self;
}
- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}
- (UIButton *)btnTelephone{
    if (!_btnTelephone) {
        _btnTelephone = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTelephone.frame = CGRectMake(10, 10, DeviceSize.width - 20, 40);
        _btnTelephone.titleLabel.font = [UIFont systemFontOfSize:15];
        _btnTelephone.backgroundColor = [UIColor yellowColor];
        _btnTelephone.layer.masksToBounds = YES;
        _btnTelephone.layer.cornerRadius = 6.f;
        [_btnTelephone setTitle:@"电话预约" forState:UIControlStateNormal];
        [_btnTelephone addTarget:self action:@selector(btnTelephoneClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnTelephone;
}
- (void)btnTelephoneClick:(UIButton *)button{
    if (self.btnTelephoneBlock) {
        self.btnTelephoneBlock();
    }
}
@end
