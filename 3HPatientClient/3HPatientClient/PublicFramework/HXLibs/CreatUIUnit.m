//
//  CreatUIUnit.m
//  cocoPoadsDemo
//
//  Created by 崔崔 on 15/7/21.
//  Copyright (c) 2015年 崔崔. All rights reserved.
//

#import "CreatUIUnit.h"

@implementation CreatUIUnit

+ (UILabel *)creatLabelWithBoldFontSize:(CGFloat)fontSize
                          textAlignment:(NSTextAlignment)textAlignment
                              textColor:(UIColor *)textColor
                             parentView:(UIView *)parentView
{
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.font = [UIFont boldSystemFontOfSize:fontSize];
    if (textAlignment == 0) {
        label.textAlignment = NSTextAlignmentLeft;
        
    }else {
        label.textAlignment = textAlignment;
    }
    if (textColor != nil) {
        label.textColor = textColor;
    }
    
    
    [parentView addSubview:label];
    return label;

}
+ (UILabel *)creatLabelWithFontSize:(CGFloat)fontSize
                      textAlignment:(NSTextAlignment)textAlignment
                          textColor:(UIColor *)textColor
                         parentView:(UIView *)parentView
{
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    if (textAlignment == 0) {
        label.textAlignment = NSTextAlignmentLeft;

    }else {
        label.textAlignment = textAlignment;
    }
    if (textColor != nil) {
        label.textColor = textColor;
    }
    
    
    [parentView addSubview:label];
    return label;
}



+ (UILabel *)creatLabelWithText:(NSString *)text
                       fontSize:(CGFloat)fontSize
                  textAlignment:(NSTextAlignment)textAlignment
                      textColor:(UIColor *)textColor
                     parentView:(UIView *)parentView;
{
    UILabel *label = [UILabel new];
    label.text = text;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    if (textAlignment == 0) {
        label.textAlignment = NSTextAlignmentLeft;
        
    }else {
        label.textAlignment = textAlignment;
    }
    if (textColor != nil) {
        label.textColor = textColor;
    }
    [parentView addSubview:label];
    return label;

}
+ (UIButton *)creatButtonWithTitile:(NSString *)title
                    backGroundImage:(UIImage *)backGroundImage
                           fontSize:(CGFloat)fontSize
                         titleColor:(UIColor *)titleColor
                         parentView:(UIView *)parentView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];

    }
    if (backGroundImage) {
        [button setBackgroundImage:backGroundImage forState:UIControlStateNormal];
    }

    if (fontSize > 0) {
        [button.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];

    }else {
        [button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];

    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];

    }
    [parentView addSubview:button];
    return button;
}


+ (UIButton *)creatButtonWithTitile:(NSString *)title
                              image:(UIImage *)image
                           fontSize:(CGFloat)fontSize
                         titleColor:(UIColor *)titleColor
                         parentView:(UIView *)parentView
{

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    
    if (fontSize > 0) {
        [button.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
        
    }else {
        [button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        
    }else {
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }

    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [parentView addSubview:button];
    return button;

}
+ (UIImageView *)creatImageViewWithDefultImageName:(NSString *)imageName parentView:(UIView *)parentView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [parentView addSubview:imageView];
    return imageView;
}

+ (UITextField *)creatTextFieldWithDelegate:(id)delegate
                                   fontSize:(CGFloat)fontSize
                                placeholder:(NSString *)placeholder
                                 parentView:(UIView *)parentView
{
    UITextField *textField = [UITextField new];
    textField.placeholder = placeholder;
    textField.delegate = delegate;
    if (fontSize > 0) {
        textField.font = [UIFont systemFontOfSize:fontSize];
    }
    [parentView addSubview:textField];
    return textField;
    
}

//+ (UITextViewEx *)creatTextViewExWithDelegate:(id)delegate fontSize:(CGFloat)fontSize placeholder:(NSString *)placeholder parentView:(UIView *)parentView
//{
//    UITextViewEx *textView = [UITextViewEx new];
//    textView.placeholder = placeholder;
//    textView.placeholderFontSize = fontSize;
//    textView.delegate = delegate;
//    if (fontSize > 0) {
//        textView.font = [UIFont systemFontOfSize:fontSize];
//    }
//    [parentView addSubview:textView];
//    return textView;
//
//}

+ (UITextView *)creatTextViewWithDelegate:(id)delegate
                                 fontSize:(CGFloat)fontSize
                                textColor:(UIColor *)textColor
                               parentView:(UIView *)parentView
{
    UITextView *textView = [UITextView new];
    textView.delegate = delegate;
    if (fontSize > 0) {
        textView.font = [UIFont systemFontOfSize:fontSize];
    }
    if (textColor) {
        textView.textColor = textColor;
    }
    [parentView addSubview:textView];
    return textView;
    
}



@end
