
//
//  TimeView.m
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "TimeView.h"

@implementation TimeView
- (id)initWithFrame:(CGRect)frame title:(NSString *)title{
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.labLine];
        [self addSubview:self.btnLeft];
        [self addSubview:self.btnRight];
        [self addSubview:self.labTitle];
        self.labTitle.text = title;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        
        self.dateStr = [formatter stringFromDate:[NSDate date]];;
        [self addSubview:self.datePicker];
    }
    return self;
}
- (UIButton *)btnLeft{
    if (!_btnLeft) {
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeft.frame = CGRectMake(10, 0,40, 44);
        [_btnLeft setTitleColor:[UIColor colorWithHEX:0x999999] forState:UIControlStateNormal];
        [_btnLeft setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_btnLeft setTitle:@"取消" forState:UIControlStateNormal];
        [_btnLeft addTarget:self action:@selector(btnLeftClick) forControlEvents:UIControlEventTouchUpInside];
        _btnLeft.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _btnLeft;
}
- (UIButton *)btnRight{
    if (!_btnRight) {
        _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = CGRectMake(DeviceSize.width-10-40, 0, 40, 44);
        [_btnRight setTitleColor:AppDefaultColor forState:UIControlStateNormal];
        [_btnRight setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _btnRight.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnRight setTitle:@"确定" forState:UIControlStateNormal];
        [_btnRight addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRight;
}
- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 44, DeviceSize.width, 1)];
        _labLine.backgroundColor = AppDefaultColor;
    }
    return _labLine;
}
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc]initWithFrame:CGRectMake(DeviceSize.width/2-50, 0, 100, 44)];
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.font = [UIFont systemFontOfSize:16];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
    }
    return _labTitle;
}
#pragma mark UI

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.labLine.bottom , DeviceSize.width, 216)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = locale;
        //当前时间创建NSDate
        NSDate *localDate = [NSDate date];
        self.datePicker.maximumDate = localDate;
        [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        NSDateFormatter *formatter = [[NSDateFormatter  alloc] init];
        
        //        if (self.dateString.length == 0) {
        //            [formatter setDateFormat:@"yyyy年MM月dd日"];
        _datePicker.date = localDate;
        //            self.labTime.text = [formatter stringFromDate:localDate];
        //        }else{
        //            [formatter setDateFormat:@"yyyy年MM月dd日"];
        //            NSLog(@"wo dekan%@",self.dateString);
        //            NSDate *nd = [NSDate dateWithTimeIntervalSince1970:[self.dateString doubleValue]/1000.0];
        //            _datePicker.date = nd;
        //            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        //            [dateFormat setDateFormat:@"yyyy年MM月dd日"];
        //            NSString *dateString = [dateFormat stringFromDate:nd];
        //            self.labTime.text = dateString;
        
        
        //        }
        
    }
    return _datePicker;
}
- (void)dateChange:(id)sender{
    UIDatePicker *picker = (UIDatePicker *)sender;
    NSDate  *date = picker.date;
    //转成时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
//    NSString *timeSp = [NSString stringWithFormat:@"%li%@", (long)[date timeIntervalSince1970],@"000"];
//        self.labTime.text = [formatter stringFromDate:date];
//        if (self.BirthdayBlock) {
//            self.BirthdayBlock(timeSp);
//        }
    NSLog(@"%@",[formatter stringFromDate:date]);
    self.dateStr = [formatter stringFromDate:date];
}
- (void)btnLeftClick{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
- (void)btnRightClick{
    if (self.sureBlock) {
        self.sureBlock(self.dateStr);
    }
}

@end
