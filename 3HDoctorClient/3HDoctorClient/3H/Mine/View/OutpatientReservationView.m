//
//  OutpatientReservationView.m
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/8.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "OutpatientReservationView.h"

@implementation OutpatientReservationView

- (id)initWithFrame:(CGRect)frame array:(NSArray *)array{
    if (self == [super initWithFrame:frame]) {
        self.clickIndex = 0;
        [self addSubview:self.imgTime];
        [self addSubview:self.labTitle];
        [self addSubview:self.btnLeft];
        [self addSubview:self.labTime];
        [self addSubview:self.btnRight];
        [self addSubview:self.labEmtry];
        [self addSubview:self.labWeek1];
        [self addSubview:self.labWeek2];
        [self addSubview:self.labWeek3];
        [self addSubview:self.labWeek4];
        [self addSubview:self.labWeek5];
        [self addSubview:self.labWeek6];
        [self addSubview:self.labWeek7];
        [self addSubview:self.labAm];
        [self addSubview:self.labPm];
        [self addSubview:self.btnWeekAm1];
        [self addSubview:self.btnWeekAm2];
        [self addSubview:self.btnWeekAm3];
        [self addSubview:self.btnWeekAm4];
        [self addSubview:self.btnWeekAm5];
        [self addSubview:self.btnWeekAm6];
        [self addSubview:self.btnWeekAm7];
        [self addSubview:self.btnWeekPm1];
        [self addSubview:self.btnWeekPm2];
        [self addSubview:self.btnWeekPm3];
        [self addSubview:self.btnWeekPm4];
        [self addSubview:self.btnWeekPm5];
        [self addSubview:self.btnWeekPm6];
        [self addSubview:self.btnWeekPm7];
        [self getTime];
        
        
    }
    return self;
}
- (UIImageView *)imgTime{
    if (!_imgTime) {
        _imgTime = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
        _imgTime.image = [UIImage imageNamed:@""];
        _imgTime.backgroundColor = [UIColor grayColor];
    }
    return _imgTime;
}
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.imgTime.right+5, self.imgTime.top, 200, 30)];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}
- (UIButton *)btnLeft{
    if (!_btnLeft) {
        _btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeft.frame = CGRectMake(10, self.labTitle.bottom+5, (DeviceSize.width-20)/8, (DeviceSize.width-20)/8);
        [_btnLeft setBackgroundColor:[UIColor grayColor]];
        _btnLeft.layer.borderColor = [UIColor grayColor].CGColor;
        _btnLeft.layer.borderWidth = 0.5;
        [_btnLeft addTarget:self action:@selector(btnLeftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLeft;
}
- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc]initWithFrame:CGRectMake(self.btnLeft.right, self.btnLeft.top, DeviceSize.width-20-2*self.btnLeft.width, (DeviceSize.width-20)/8)];
        _labTime.text = @"请选择时间";
        _labTime.font = [UIFont systemFontOfSize:15];
        _labTime.textAlignment = NSTextAlignmentCenter;
        _labTime.layer.borderColor = [UIColor grayColor].CGColor;
        _labTime.layer.borderWidth = 0.5;
    }
    return _labTime;
}
- (UIButton *)btnRight{
    if (!_btnRight) {
        _btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.frame = CGRectMake(self.labTime.right, self.labTitle.bottom+5, (DeviceSize.width-20)/8, (DeviceSize.width-20)/8);
        [_btnRight addTarget:self action:@selector(btnRightClick) forControlEvents:UIControlEventTouchUpInside];
        [_btnRight setBackgroundColor:[UIColor grayColor]];
        _btnRight.layer.borderColor = [UIColor grayColor].CGColor;
        _btnRight.layer.borderWidth = 0.5;
    }
    return _btnRight;
}
- (UILabel *)labEmtry{
    if (!_labEmtry) {
        _labEmtry = [[UILabel alloc]initWithFrame:CGRectMake(self.btnLeft.left, self.btnLeft.bottom,(DeviceSize.width-20)/8,(DeviceSize.width-20)/8)];
        _labEmtry.layer.borderColor = [UIColor grayColor].CGColor;
        _labEmtry.layer.borderWidth = 0.5;
    }
    return _labEmtry;
}
- (UILabel *)labWeek1{
    if (!_labWeek1) {
        _labWeek1 = [[UILabel alloc]initWithFrame:CGRectMake(self.labEmtry.right, self.btnLeft.bottom,(DeviceSize.width-20)/8, (DeviceSize.width-20)/8)];
        _labWeek1.lineBreakMode = UILineBreakModeWordWrap;
        _labWeek1.numberOfLines = 0;
        _labWeek1.font = [UIFont systemFontOfSize:15];
        _labWeek1.textAlignment = NSTextAlignmentCenter;
        _labWeek1.layer.borderColor = [UIColor grayColor].CGColor;
        _labWeek1.layer.borderWidth = 0.5;
    }
    return _labWeek1;
}
- (UILabel *)labWeek2{
    if (!_labWeek2) {
        _labWeek2 = [[UILabel alloc]initWithFrame:CGRectMake(self.labWeek1.right, self.btnLeft.bottom, (DeviceSize.width-20)/8, (DeviceSize.width-20)/8)];
        _labWeek2.layer.borderColor = [UIColor grayColor].CGColor;
        _labWeek2.lineBreakMode = UILineBreakModeWordWrap;
        _labWeek2.numberOfLines = 0;
        _labWeek2.font = [UIFont systemFontOfSize:15];
        _labWeek2.textAlignment = NSTextAlignmentCenter;
        _labWeek2.layer.borderWidth = 0.5;
    }
    return _labWeek2;
}
- (UILabel *)labWeek3{
    if (!_labWeek3) {
        _labWeek3 = [[UILabel alloc]initWithFrame:CGRectMake(self.labWeek2.right, self.btnLeft.bottom,(DeviceSize.width-20)/8,(DeviceSize.width-20)/8)];
        _labWeek3.layer.borderColor = [UIColor grayColor].CGColor;
        _labWeek3.lineBreakMode = UILineBreakModeWordWrap;
        _labWeek3.numberOfLines = 0;
        _labWeek3.font = [UIFont systemFontOfSize:15];
        _labWeek3.textAlignment = NSTextAlignmentCenter;
        _labWeek3.layer.borderWidth = 0.5;
    }
    return _labWeek3;
}
- (UILabel *)labWeek4{
    if (!_labWeek4) {
        _labWeek4 = [[UILabel alloc]initWithFrame:CGRectMake(self.labWeek3.right, self.btnLeft.bottom, (DeviceSize.width-20)/8, (DeviceSize.width-20)/8)];
        _labWeek4.layer.borderColor = [UIColor grayColor].CGColor;
        _labWeek4.lineBreakMode = UILineBreakModeWordWrap;
        _labWeek4.numberOfLines = 0;
        _labWeek4.font = [UIFont systemFontOfSize:15];
        _labWeek4.textAlignment = NSTextAlignmentCenter;
        _labWeek4.layer.borderWidth = 0.5;
    }
    return _labWeek4;
}
- (UILabel *)labWeek5{
    if (!_labWeek5) {
        _labWeek5 = [[UILabel alloc]initWithFrame:CGRectMake(self.labWeek4.right, self.btnLeft.bottom, (DeviceSize.width-20)/8, (DeviceSize.width-20)/8)];
        _labWeek5.layer.borderColor = [UIColor grayColor].CGColor;
        _labWeek5.layer.borderWidth = 0.5;
        _labWeek5.lineBreakMode = UILineBreakModeWordWrap;
        _labWeek5.numberOfLines = 0;
        _labWeek5.font = [UIFont systemFontOfSize:15];
        _labWeek5.textAlignment = NSTextAlignmentCenter;
    }
    return _labWeek5;
}
- (UILabel *)labWeek6{
    if (!_labWeek6) {
        _labWeek6 = [[UILabel alloc]initWithFrame:CGRectMake(self.labWeek5.right, self.btnLeft.bottom, (DeviceSize.width-20)/8, (DeviceSize.width-20)/8)];
        _labWeek6.layer.borderColor = [UIColor grayColor].CGColor;
        _labWeek6.layer.borderWidth = 0.5;
        _labWeek6.lineBreakMode = UILineBreakModeWordWrap;
        _labWeek6.numberOfLines = 0;
        _labWeek6.font = [UIFont systemFontOfSize:15];
        _labWeek6.textAlignment = NSTextAlignmentCenter;
    }
    return _labWeek6;
}
- (UILabel *)labWeek7{
    if (!_labWeek7) {
        _labWeek7 = [[UILabel alloc]initWithFrame:CGRectMake(self.labWeek6.right, self.btnLeft.bottom, (DeviceSize.width-20)/8, (DeviceSize.width-20)/8)];
        _labWeek7.layer.borderColor = [UIColor grayColor].CGColor;
        _labWeek7.layer.borderWidth = 0.5;
        _labWeek7.lineBreakMode = UILineBreakModeWordWrap;
        _labWeek7.numberOfLines = 0;
        _labWeek7.font = [UIFont systemFontOfSize:15];
        _labWeek7.textAlignment = NSTextAlignmentCenter;
    }
    return _labWeek7;
}
- (UILabel *)labAm{
    if (!_labAm) {
        _labAm = [[UILabel alloc]initWithFrame:CGRectMake(self.labEmtry.left, self.labEmtry.bottom, (DeviceSize.width-20)/8, (DeviceSize.width-20)/8)];
        _labAm.layer.borderColor = [UIColor grayColor].CGColor;
        _labAm.layer.borderWidth = 0.5;
        _labAm.text = @"上午";
        _labAm.textAlignment = NSTextAlignmentCenter;
    }
    return _labAm;
}
- (UILabel *)labPm{
    if (!_labPm) {
        _labPm = [[UILabel alloc]initWithFrame:CGRectMake(self.labEmtry.left, self.labAm.bottom, (DeviceSize.width-20)/8, (DeviceSize.width-20)/8)];
        _labPm.layer.borderColor = [UIColor grayColor].CGColor;
        _labPm.layer.borderWidth = 0.5;
        _labPm.textAlignment = NSTextAlignmentCenter;
        _labPm.text = @"下午";
    }
    return _labPm;
}
- (UIButton *)btnWeekAm1{
    if (!_btnWeekAm1) {
        _btnWeekAm1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekAm1.frame = CGRectMake(self.labAm.right, self.labWeek1.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekAm1.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekAm1.layer.borderWidth = 0.5;
    }
    return _btnWeekAm1;
}
- (UIButton *)btnWeekAm2{
    if (!_btnWeekAm2) {
        _btnWeekAm2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekAm2.frame = CGRectMake(self.btnWeekAm1.right, self.labWeek1.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekAm2.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekAm2.layer.borderWidth = 0.5;
    }
    return _btnWeekAm2;
}
- (UIButton *)btnWeekAm3{
    if (!_btnWeekAm3) {
        _btnWeekAm3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekAm3.frame = CGRectMake(self.btnWeekAm2.right, self.labWeek1.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekAm3.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekAm3.layer.borderWidth = 0.5;
    }
    return _btnWeekAm3;
}
- (UIButton *)btnWeekAm4{
    if (!_btnWeekAm4) {
        _btnWeekAm4 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekAm4.frame = CGRectMake(self.btnWeekAm3.right, self.labWeek1.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekAm4.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekAm4.layer.borderWidth = 0.5;
    }
    return _btnWeekAm4;
}
- (UIButton *)btnWeekAm5{
    if (!_btnWeekAm5) {
        _btnWeekAm5 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekAm5.frame = CGRectMake(self.btnWeekAm4.right, self.labWeek1.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekAm5.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekAm5.layer.borderWidth = 0.5;
    }
    return _btnWeekAm5;
}
- (UIButton *)btnWeekAm6{
    if (!_btnWeekAm6) {
        _btnWeekAm6 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekAm6.frame = CGRectMake(self.btnWeekAm5.right, self.labWeek1.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekAm6.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekAm6.layer.borderWidth = 0.5;
    }
    return _btnWeekAm6;
}
- (UIButton *)btnWeekAm7{
    if (!_btnWeekAm7) {
        _btnWeekAm7 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekAm7.frame = CGRectMake(self.btnWeekAm6.right, self.labWeek1.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekAm7.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekAm7.layer.borderWidth = 0.5;
    }
    return _btnWeekAm7;
}
- (UIButton *)btnWeekPm1{
    if (!_btnWeekPm1) {
        _btnWeekPm1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekPm1.frame = CGRectMake(self.labPm.right, self.btnWeekAm7.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekPm1.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekPm1.layer.borderWidth = 0.5;
    }
    return _btnWeekPm1;
}
- (UIButton *)btnWeekPm2{
    if (!_btnWeekPm2) {
        _btnWeekPm2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekPm2.frame = CGRectMake(self.btnWeekPm1.right, self.btnWeekAm7.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekPm2.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekPm2.layer.borderWidth = 0.5;
    }
    return _btnWeekPm2;
}
- (UIButton *)btnWeekPm3{
    if (!_btnWeekPm3) {
        _btnWeekPm3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekPm3.frame = CGRectMake(self.btnWeekPm2.right, self.btnWeekAm7.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekPm3.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekPm3.layer.borderWidth = 0.5;
    }
    return _btnWeekPm3;
}
- (UIButton *)btnWeekPm4{
    if (!_btnWeekPm4) {
        _btnWeekPm4 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekPm4.frame = CGRectMake(self.btnWeekPm3.right, self.btnWeekAm7.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekPm4.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekPm4.layer.borderWidth = 0.5;
    }
    return _btnWeekPm4;
}
- (UIButton *)btnWeekPm5{
    if (!_btnWeekPm5) {
        _btnWeekPm5 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekPm5.frame = CGRectMake(self.btnWeekPm4.right, self.btnWeekAm7.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekPm5.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekPm5.layer.borderWidth = 0.5;
    }
    return _btnWeekPm5;
}
- (UIButton *)btnWeekPm6{
    if (!_btnWeekPm6) {
        _btnWeekPm6 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekPm6.frame = CGRectMake(self.btnWeekPm5.right, self.btnWeekAm7.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekPm6.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekPm6.layer.borderWidth = 0.5;
    }
    return _btnWeekPm6;
}
- (UIButton *)btnWeekPm7{
    if (!_btnWeekPm7) {
        _btnWeekPm7 = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWeekPm7.frame = CGRectMake(self.btnWeekPm6.right, self.btnWeekAm7.bottom, (DeviceSize.width-20)/8,(DeviceSize.width-20)/8);
        _btnWeekPm7.layer.borderColor = [UIColor grayColor].CGColor;
        _btnWeekPm7.layer.borderWidth = 0.5;
    }
    return _btnWeekPm7;
}
- (void)btnLeftClick{
    NSDate* date = [[NSDate alloc] init];
    self.clickIndex++;
    NSLog(@"%@",self.labTime.text);
    
    

//    date = [date dateByAddingTimeInterval:-0*3600*24];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate: [formatter dateFromString:self.labTime.text]];//前一天
    
    self.labTime.text = [formatter stringFromDate:lastDay];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    NSString * str = @"";
    comps = [calendar components:unitFlags fromDate:date];
    if ([comps weekday]==1) {//周日
        self.labWeek7.text = [NSString stringWithFormat:@"周日\n%@日",[self createTime:[comps weekday] type:0]];
        self.labWeek6.text = [NSString stringWithFormat:@"周六\n%@日",[self createTime:[comps weekday] type:1]];
        self.labWeek5.text = [NSString stringWithFormat:@"周五\n%@日",[self createTime:[comps weekday] type:2]];
        self.labWeek4.text = [NSString stringWithFormat:@"周四\n%@日",[self createTime:[comps weekday] type:3]];
        self.labWeek3.text = [NSString stringWithFormat:@"周三\n%@日",[self createTime:[comps weekday] type:4]];
        self.labWeek2.text = [NSString stringWithFormat:@"周二\n%@日",[self createTime:[comps weekday] type:5]];
        self.labWeek1.text = [NSString stringWithFormat:@"周一\n%@日",[self createTime:[comps weekday] type:6]];
        
    }else if ([comps weekday]==2){
        self.labWeek7.text = [NSString stringWithFormat:@"周日\n%@日",[self createTime:[comps weekday] type:-6]];
        self.labWeek6.text = [NSString stringWithFormat:@"周六\n%@日",[self createTime:[comps weekday] type:-5]];
        self.labWeek5.text = [NSString stringWithFormat:@"周五\n%@日",[self createTime:[comps weekday] type:-4]];
        self.labWeek4.text = [NSString stringWithFormat:@"周四\n%@日",[self createTime:[comps weekday] type:-3]];
        self.labWeek3.text = [NSString stringWithFormat:@"周三\n%@日",[self createTime:[comps weekday] type:-2]];
        self.labWeek2.text = [NSString stringWithFormat:@"周二\n%@日",[self createTime:[comps weekday] type:-1]];
        self.labWeek1.text = [NSString stringWithFormat:@"周一\n%@日",[self createTime:[comps weekday] type:0]];
    }else if ([comps weekday]==3){
        self.labWeek7.text = [NSString stringWithFormat:@"周日\n%@日",[self createTime:[comps weekday] type:-5]];
        self.labWeek6.text = [NSString stringWithFormat:@"周六\n%@日",[self createTime:[comps weekday] type:-4]];
        self.labWeek5.text = [NSString stringWithFormat:@"周五\n%@日",[self createTime:[comps weekday] type:-3]];
        self.labWeek4.text = [NSString stringWithFormat:@"周四\n%@日",[self createTime:[comps weekday] type:-2]];
        self.labWeek3.text = [NSString stringWithFormat:@"周三\n%@日",[self createTime:[comps weekday] type:-1]];
        self.labWeek2.text = [NSString stringWithFormat:@"周二\n%@日",[self createTime:[comps weekday] type:0]];
        self.labWeek1.text = [NSString stringWithFormat:@"周一\n%@日",[self createTime:[comps weekday] type:1]];
    }

    
}
- (void)btnRightClick{
    NSDate* date = [[NSDate alloc] init];
    self.clickIndex--;
    NSLog(@"%ld",(long)self.clickIndex);
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *lastDay = [NSDate dateWithTimeInterval:24*60*60 sinceDate: [formatter dateFromString:self.labTime.text]];//后一天
    
    self.labTime.text = [formatter stringFromDate:lastDay];
}
- (void)getTime{
    NSString* time;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    time = [formatter stringFromDate:[NSDate date]];
    self.labTime.text = time;

}
- (NSString *)createTime:(NSInteger)index type:(NSInteger)type{
    NSDate* date = [[NSDate alloc] init];
    date = [date dateByAddingTimeInterval:-type*3600*24];
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.labTime.text = [formatter stringFromDate:date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
//    NSString * str = @"";
    comps = [calendar components:unitFlags fromDate:date];
    return [NSString stringWithFormat:@"%ld",[comps day]];
}
@end
