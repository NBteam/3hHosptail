//
//  TimeView.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeView : UIView
@property (nonatomic, retain) UIButton * btnLeft;
@property (nonatomic, retain) UIButton * btnRight;
@property (nonatomic, retain) UILabel * labLine;
@property (nonatomic, retain) UILabel * labTitle;
@property (nonatomic, strong) UIDatePicker *datePicker;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
@property (nonatomic, copy) void (^cancelBlock)(void);
@property (nonatomic, copy) void (^sureBlock)(NSString * str);
@property (nonatomic, copy) NSString * dateStr;
@end
