//
//  DynamicToolView.m
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "DynamicToolView.h"

@implementation DynamicToolView
- (id)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.labLine];
        [self addSubview:self.btnLeft];
        [self addSubview:self.btnRight];
        [self addSubview:self.labLine1];
    }
    return self;
}
- (UIButton *)btnLeft{
    if (!_btnLeft) {
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeft.frame = CGRectMake(0, 0, DeviceSize.width/2-1, 44);
        [_btnLeft setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_btnLeft setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_btnLeft setTitle:@"评论" forState:UIControlStateNormal];
        [_btnLeft addTarget:self action:@selector(btnLeftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLeft;
}
- (UIButton *)btnRight{
    if (!_btnRight) {
        _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = CGRectMake(DeviceSize.width/2+1, 0, DeviceSize.width/2-1, 44);
        [_btnRight setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_btnRight setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_btnRight setTitle:@"点赞" forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}
- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 1)];
        _labLine.backgroundColor = [UIColor grayColor];
    }
    return _labLine;
}
- (UILabel *)labLine1{
    if (!_labLine1) {
        _labLine1 = [[UILabel alloc]initWithFrame:CGRectMake(DeviceSize.width/2, (44-30)/2, 1, 30)];
        _labLine1.backgroundColor = [UIColor grayColor];
    }
    return _labLine1;
}
- (void)btnLeftClick{

}
- (void)btnRightClick{
    if (self.btnRightBlock) {
        self.btnRightBlock();
    }
}
@end
