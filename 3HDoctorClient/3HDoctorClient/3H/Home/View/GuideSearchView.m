//
//  GuideSearchView.m
//  11111
//
//  Created by kanzhun on 15/9/8.
//  Copyright (c) 2015年 kanzhun. All rights reserved.
//

#import "GuideSearchView.h"
@interface GuideSearchView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView * viewBack;
@property (nonatomic, strong) UIImageView * ImageLeft;
@property (nonatomic, strong) UIButton * btnRight;
@end
@implementation GuideSearchView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.viewBack];
        [self.viewBack addSubview:self.ImageLeft];
        [self.viewBack addSubview:self.textSearch];
        [self.viewBack addSubview:self.btnRight];
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 95/2);
    }
    return self;
}
- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc]initWithFrame:CGRectMake(30/2, 12/2, [UIScreen mainScreen].bounds.size.width-30, 66/2)];
        _viewBack.layer.masksToBounds = YES;
        _viewBack.layer.cornerRadius = 4.0f;
        _viewBack.backgroundColor = [UIColor colorWithHEX:0x4d4d4d];
    }
    return _viewBack;
}
- (UIImageView *)ImageLeft{
    if (!_ImageLeft) {
        _ImageLeft = [[UIImageView alloc]initWithFrame:CGRectMake(9, _viewBack.frame.size.height/2-14/2, 14, 14)];
        _ImageLeft.image = [UIImage imageNamed:@"search"];
    }
    return _ImageLeft;
}
- (UITextField *)textSearch{
    if (!_textSearch) {
        _textSearch = [[UITextField alloc]initWithFrame:CGRectMake(_ImageLeft.frame.origin.x+14+9,1,_viewBack.frame.size.width-18*3-14 , _viewBack.frame.size.height-2)];
        _textSearch.delegate = self;
        _textSearch.textColor = [UIColor colorWithHEX:0xffffff];
        _textSearch.backgroundColor = [UIColor clearColor];
        _textSearch.font = [UIFont systemFontOfSize:15];
        _textSearch.keyboardAppearance = UIKeyboardAppearanceDark;
        [_textSearch addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventEditingChanged];
    }
    return _textSearch;
}

- (UIButton *)btnRight{
    if (!_btnRight) {
        _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = CGRectMake(self.textSearch.frame.origin.x+self.textSearch.frame.size.width+9, self.viewBack.frame.size.height/2-9, 18, 18);
        [_btnRight setImage:[UIImage imageNamed:@"delete1"] forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(btnRightClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnRight.hidden = YES;
    }
    return _btnRight;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textSearch resignFirstResponder];
    return YES;
}
- (void)btnRightClick:(UIButton *)button{
    self.textSearch.text = @"";
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
    if (self.textChangeValue) {
        self.textChangeValue(self.textSearch.text);
    }
    self.btnRight.hidden = YES;
}
- (void)valueChanged:(UITextField *)textFeild{
    if ([textFeild.text isEqualToString:@""]) {
        self.btnRight.hidden = YES;
    }else{
        self.btnRight.hidden = NO;
    }
    //过滤掉除去汉字外的拼音
    UITextRange *selectedRange = [textFeild markedTextRange];
    NSString * newText = [textFeild textInRange:selectedRange];
    //如果含有拼音return 
    if(newText.length>0){
        return;
    }
    if (self.textChangeValue) {
        self.textChangeValue(textFeild.text);
    }
}
- (void)textResignFirstResponder{
    [self.textSearch resignFirstResponder];
}
- (void)textBecomeFirstResponder{
    [self.textSearch becomeFirstResponder];
}
- (void)setSearchText:(NSString *)text{
    self.textSearch.text=text;
}

@end
