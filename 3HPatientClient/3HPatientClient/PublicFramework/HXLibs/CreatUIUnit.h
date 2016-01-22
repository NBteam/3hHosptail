//
//  CreatUIUnit.h
//  cocoPoadsDemo
//
//  Created by 崔崔 on 15/7/21.
//  Copyright (c) 2015年 崔崔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "UITextViewEx.h"

@interface CreatUIUnit : NSObject

+ (UILabel *)creatLabelWithBoldFontSize:(CGFloat)fontSize
                          textAlignment:(NSTextAlignment)textAlignment
                                textColor:(UIColor *)textColor
                         parentView:(UIView *)parentView;

+ (UILabel *)creatLabelWithFontSize:(CGFloat)fontSize
                      textAlignment:(NSTextAlignment)textAlignment
                          textColor:(UIColor *)textColor
                         parentView:(UIView *)parentView;

+ (UILabel *)creatLabelWithText:(NSString *)text
                       fontSize:(CGFloat)fontSize
                  textAlignment:(NSTextAlignment)textAlignment
                      textColor:(UIColor *)textColor
                     parentView:(UIView *)parentView;

+ (UIButton *)creatButtonWithTitile:(NSString *)title
                    backGroundImage:(UIImage *)backGroundImage
                           fontSize:(CGFloat)fontSize
                         titleColor:(UIColor *)titleColor
                         parentView:(UIView *)parentView;

+ (UIButton *)creatButtonWithTitile:(NSString *)title
                              image:(UIImage *)image
                           fontSize:(CGFloat)fontSize
                         titleColor:(UIColor *)titleColor
                         parentView:(UIView *)parentView;

+ (UIImageView *)creatImageViewWithDefultImageName:(NSString *)imageName
                                        parentView:(UIView *)parentView;

+ (UITextField *)creatTextFieldWithDelegate:(id)delegate
                                   fontSize:(CGFloat)fontSize
                                placeholder:(NSString *)placeholder
                                 parentView:(UIView *)parentView;

//+ (UITextViewEx *)creatTextViewExWithDelegate:(id)delegate
//                                   fontSize:(CGFloat)fontSize
//                                placeholder:(NSString *)placeholder
//                                 parentView:(UIView *)parentView;

+ (UITextView *)creatTextViewWithDelegate:(id)delegate
                                 fontSize:(CGFloat)fontSize
                                textColor:(UIColor *)textColor
                               parentView:(UIView *)parentView;

@end
