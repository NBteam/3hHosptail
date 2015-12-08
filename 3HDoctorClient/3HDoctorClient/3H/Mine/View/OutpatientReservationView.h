//
//  OutpatientReservationView.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/8.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutpatientReservationView : UIView
@property (nonatomic, strong) UIImageView * imgTime;
@property (nonatomic, strong) UILabel * labTitle;
@property (nonatomic, strong) UILabel * labTime;
@property (nonatomic, strong) UIButton * btnLeft;
@property (nonatomic, strong) UIButton * btnRight;
@property (nonatomic, strong) UILabel * labEmtry;
@property (nonatomic, strong) UILabel * labWeek1;
@property (nonatomic, strong) UILabel * labWeek2;
@property (nonatomic, strong) UILabel * labWeek3;
@property (nonatomic, strong) UILabel * labWeek4;
@property (nonatomic, strong) UILabel * labWeek5;
@property (nonatomic, strong) UILabel * labWeek6;
@property (nonatomic, strong) UILabel * labWeek7;
@property (nonatomic, strong) UILabel * labAm;
@property (nonatomic, strong) UILabel * labPm;
@property (nonatomic, strong) UIButton * btnWeekAm1;
@property (nonatomic, strong) UIButton * btnWeekAm2;
@property (nonatomic, strong) UIButton * btnWeekAm3;
@property (nonatomic, strong) UIButton * btnWeekAm4;
@property (nonatomic, strong) UIButton * btnWeekAm5;
@property (nonatomic, strong) UIButton * btnWeekAm6;
@property (nonatomic, strong) UIButton * btnWeekAm7;
@property (nonatomic, strong) UIButton * btnWeekPm1;
@property (nonatomic, strong) UIButton * btnWeekPm2;
@property (nonatomic, strong) UIButton * btnWeekPm3;
@property (nonatomic, strong) UIButton * btnWeekPm4;
@property (nonatomic, strong) UIButton * btnWeekPm5;
@property (nonatomic, strong) UIButton * btnWeekPm6;
@property (nonatomic, strong) UIButton * btnWeekPm7;
@property (nonatomic, assign) NSInteger clickIndex;
- (id)initWithFrame:(CGRect)frame array:(NSArray *)array;
@end
