//
//  AddPatientsPhoneView.m
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AddPatientsPhoneView.h"

@implementation AddPatientsPhoneView

- (id)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.textField];
        [self addSubview:self.labPrompt];
    }
    return self;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 15, DeviceSize.width-20, 45)];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textColor = [UIColor grayColor];
        _textField.layer.borderWidth = 1;
        _textField.layer.borderColor = [AppDefaultColor CGColor];
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.placeholder = @"请输入手机号";
        _textField.layer.cornerRadius = 6;
        _textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, _textField.height)];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.layer.masksToBounds = YES;
    }
    return _textField;
}
- (UILabel *)labPrompt{
    if (!_labPrompt) {
        _labPrompt = [[UILabel alloc]initWithFrame:CGRectMake(10, self.textField.bottom+5, DeviceSize.width-20, 13)];
        _labPrompt.font = [UIFont systemFontOfSize:13];
        _labPrompt.textColor = [UIColor grayColor];
        _labPrompt.text = @"(以短信的方式提醒患者，扫描二维码添加我)";
    }
    return _labPrompt;
}
@end
