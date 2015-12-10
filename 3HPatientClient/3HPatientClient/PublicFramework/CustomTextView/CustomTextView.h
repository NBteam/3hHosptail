//
//  CustomTextView.h
//  textViewDemo
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UITextView<UITextViewDelegate>

//提示语
@property (nonatomic, strong) UILabel *placeholderLabel;
/**
 *  初始化放大
 *
 *  @param frame frame
 *  @param font  提示语字体大小
 *  @param color 提示语字体颜色
 *  @param text  提示语文字
 *
 *  @return customTextView
 */

- (instancetype)initWithFrame:(CGRect)frame placeholderFont:(UIFont *)font Color:(UIColor *)color Text:(NSString *)text;
@end
