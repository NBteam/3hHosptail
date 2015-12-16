//
//  PhoneAppointTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/16.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PhoneAppointTableViewCell.h"

@implementation PhoneAppointTableViewCell


- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.calendarView];
}

- (UIImageView *)imgLogo{
    if(!_imgLogo){
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, (35 -16)/2, 16, 16)];
        _imgLogo.image = [UIImage imageNamed:@"我的-预约设置-电话预约_时间"];
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 0, DeviceSize.width -self.imgLogo.right -20, 35)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.text = @"请选择您的预约时间";
    }
    return _labTitle;
}

- (PhoneAppointCalendarView *)calendarView{
    WeakSelf(PhoneAppointTableViewCell);
    if (!_calendarView) {
        _calendarView = [[PhoneAppointCalendarView alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom, DeviceSize.width -20, 0)];
        [_calendarView setCalendarBlock:^(NSString *year, NSString *month, NSString *day) {
            NSLog(@"%@%@%@",year,month,day);
        }];
        
        [_calendarView setCalendarFloatBlock:^(CGFloat f) {
            if (weakSelf.phoneAppointBlock) {
                weakSelf.phoneAppointBlock();
            }
        }];
        
    }
    return _calendarView;
}

//赋值
- (CGFloat)confingWithModel:(NSInteger )dic{
    return self.calendarView.bottom +10;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
