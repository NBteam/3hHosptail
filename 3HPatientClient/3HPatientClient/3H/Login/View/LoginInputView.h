//
//  LoginInputView.h
//  NR
//
//  Created by kanzhun on 15/10/20.
//  Copyright (c) 2015年 范英强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginInputView : UIView
@property (nonatomic, strong) UIView * backView;
@property (nonatomic, strong) UILabel * labPhone;
@property (nonatomic, strong) UITextField * textField;
//输入框前部文字
@property (nonatomic, copy) NSString * strTitle;
//输入框中提示文字
@property (nonatomic, copy) NSString *placeholder;
- (void)confingWithTitle:(NSString *)tltle;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder;
@end
