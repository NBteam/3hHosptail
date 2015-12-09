//
//  LoginInputView.m
//  NR
//
//  Created by kanzhun on 15/10/20.
//  Copyright (c) 2015年 范英强. All rights reserved.
//

#import "LoginInputView.h"

@implementation LoginInputView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder{
    self.strTitle = title;
    self.placeholder = placeholder;
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.backView];
        [self.backView addSubview:self.labPhone];
        [self.backView addSubview:self.textField];
    }
    return self;
}
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, DeviceSize.width-30, 90/2)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 3;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}
- (UILabel *)labPhone{
    if (!_labPhone) {
        _labPhone = [[UILabel alloc]initWithFrame:CGRectMake(10, (self.backView.height-15)/2, 60, 15)];
        _labPhone.text = self.strTitle;
        [_labPhone sizeToFit];
        _labPhone.left = 10;
        _labPhone.top = (self.backView.height - _labPhone.height)/2;
        _labPhone.font = [UIFont systemFontOfSize:15];
        _labPhone.textColor = [UIColor colorWithHEX:0x333333];
    }
    return _labPhone;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0,self.backView.width-self.labPhone.right-15-80, self.backView.height)];
        _textField.placeholder = self.placeholder;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textColor = [UIColor colorWithHEX:0x888888];
    }
    return _textField;
}
- (void)confingWithInfo{
    self.labPhone.text = @"手机";
    [self.labPhone sizeToFit];
    self.labPhone.left = 10;
    self.textField.left = self.labPhone.right + 15;
    self.labPhone.top = (self.backView.height - self.labPhone.height)/2;
    self.textField.top =(self.backView.height - self.labPhone.height)/2;
}
- (void)confingWithTitle:(NSString *)tltle{

}
@end
