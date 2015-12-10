//
//  CustomTextView.m
//  textViewDemo
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "CustomTextView.h"

@interface CustomTextView ()
//提示语
@property (nonatomic, copy) NSString *placeholderText;
//提示语字体大小
@property (nonatomic, strong) UIFont *placeholderFont;
//提示语字体大小
@property (nonatomic, strong) UIColor *placeholderColor;


@end
@implementation CustomTextView

- (instancetype)initWithFrame:(CGRect)frame placeholderFont:(UIFont *)font Color:(UIColor *)color Text:(NSString *)text{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.font = font;
        self.placeholderText = text;
        self.placeholderFont = font;
        self.placeholderColor = color;
        [self addSubview:self.placeholderLabel];
    }
    return self;
}

- (UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.text = self.placeholderText;
        _placeholderLabel.textColor = self.placeholderColor;
        _placeholderLabel.font = self.placeholderFont;
        [_placeholderLabel sizeToFit];
        _placeholderLabel.frame = CGRectMake(5, 10, _placeholderLabel.frame.size.width, _placeholderLabel.frame.size.height);
    }
    return _placeholderLabel;
}

-(void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.placeholderLabel.text = self.placeholderText;
    }else{
        self.placeholderLabel.text = @"";
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
