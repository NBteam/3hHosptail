//
//  CalendarView.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/8.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "CalendarView.h"

@implementation CalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHEX:0xffffff];
        
        [self customView];
    }
    return self;
}

- (void)customView{
    //初始化日历类，并设置日历类的格式是阳历 若想设置中国日历 设置为NSChineseCalendar
    myCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //设置每周的第一天从星期几开始  设置为 1 是周日，2是周一
    [myCalendar setFirstWeekday:1];
    //设置每个月或者每年的第一周必须包含的最少天数  设置为1 就是第一周至少要有一天
    [myCalendar setMinimumDaysInFirstWeek:1];
    //设置时区，不设置时区获取月的第一天和星期的第一天的时候可能会提前一天。
    [myCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:0]];
    //计算绘制日历需要的数据，我传入当前日期  输入月份或年不同的日期就能得到不同的日历。
    
    self.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
    self.layer.borderWidth = 0.5;
    [self addSubview:self.btnUp];
    [self addSubview:self.labTitle];
    [self addSubview:self.btnDown];
    [self customLables];
    [self addSubview:self.viewBack];
    [self addSubview:self.labLine];
}

- (UIButton *)btnUp{
    if (!_btnUp) {
        _btnUp = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnUp setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_左"] forState:UIControlStateNormal];
        _btnUp.frame = CGRectMake(0, 0, 50, 35);
        [_btnUp addTarget:self action:@selector(btnUpAction) forControlEvents:UIControlEventTouchUpInside];
        _btnUp.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
        _btnUp.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _btnUp.layer.borderWidth = 0.5;
    }
    return _btnUp;
}

- (void)btnUpAction{
    if (self.CalendarBlock) {
        self.CalendarBlock(self.pre_date_m);
    }
}

- (UIButton *)btnDown{
    if (!_btnDown) {
        _btnDown = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDown setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_右"] forState:UIControlStateNormal];
        _btnDown.frame = CGRectMake(self.labTitle.right-0.5 ,0, 50, 35);
        [_btnDown addTarget:self action:@selector(btnDownAction) forControlEvents:UIControlEventTouchUpInside];
        _btnDown.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
        _btnDown.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _btnDown.layer.borderWidth = 0.5;
        
    }
    return _btnDown;
}

- (void)btnDownAction{
    if (self.CalendarBlock) {
        self.CalendarBlock(self.next_date_m);
    }
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.btnUp.right -0.5, 0, self.width -100 +1, 35)];
        _labTitle.textColor = AppDefaultColor;
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"2016年09月20日";
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _labTitle.layer.borderWidth = 0.5;
    }
    return _labTitle;
}

- (void)customLables{
    NSArray *arr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    for (int i = 0; i<7; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10 +((self.width -20)/7)*i, self.btnUp.bottom, (self.width -20)/7, 35)];
        lab.font = [UIFont systemFontOfSize:15];
        lab.text = arr[i];
        lab.textColor = [UIColor colorWithHEX:0x333333];
        lab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lab];
    }
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, self.btnUp.bottom +35, self.width, 125)];
        //_viewBack.backgroundColor = [UIColor grayColor];
    }
    return _viewBack;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.btnUp.bottom +35, self.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}

- (CGFloat)reloadCalendarView:(NSMutableArray *)array{
    ScheduleCalendarModel *model = array[0];
    
    self.next_date_m = model.next_date_m;
    self.pre_date_m = model.pre_date_m;
    
    self.labTitle.text = [NSString stringWithFormat:@"%@-%@",model.y,model.m];
    //获取时间
    NSString *dateString= [NSString stringWithFormat:@"%@-%@-%@",model.y,model.m,@"01"];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    //时间date
    NSDate* date = [formater dateFromString:dateString];
    
    NSTimeInterval interval;
    NSDate *firstDayOfMonth;
    //如果firstDayOfMonth和interval可计算，下边这个方法会返回YES，并且由firstDayOfMonth可得到date所在的设置的时间段（NSMonthCalendarUnit）里的第一天
    if ([myCalendar rangeOfUnit: NSMonthCalendarUnit startDate:&firstDayOfMonth interval:&interval forDate:date])
    {
        NSLog(@"%@",firstDayOfMonth);
        NSLog(@"%f",interval);
    }
    //获取date所在月的第一天在其所在周的位置，即第几天。
    firstDayIndexOfWeek = [myCalendar ordinalityOfUnit:NSDayCalendarUnit
                                                inUnit:NSWeekCalendarUnit
                                               forDate:firstDayOfMonth];
    //画按钮
    return [self drawBtn:model.list];
    
}

-(CGFloat)drawBtn:(NSArray *)array
{
    self.dataArrays = [NSMutableArray arrayWithArray:array];
    for (UIButton *btn in self.viewBack.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn removeFromSuperview];
        }
    }
    //获取当前的时间
    CGFloat f = (self.width -0.5)/7 +0.5;
    //为了方便计算按钮的frame，我的i没从0开始
    for (NSInteger i = firstDayIndexOfWeek - 1 ; i < array.count + firstDayIndexOfWeek -1 ; i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0 +(f -0.5)* (i%7), 0 + (f -0.5)*(i/7), f, f);
        btn.tag = i + 2 - firstDayIndexOfWeek;
        
        [btn setTitle:[NSString stringWithFormat:@"%ld",i + 2 - firstDayIndexOfWeek ] forState:UIControlStateNormal];
        
        //判断字体颜色
        NSString *colorString = [NSString stringWithFormat:@"%@",array[i + 2 - firstDayIndexOfWeek-1][@"after_today"]];
        NSLog(@"----%@",colorString);
        //        if ([colorString isEqualToString:@"0"]) {
        //            [btn setTitleColor:[UIColor colorWithHEX:0x999999] forState:UIControlStateNormal];
        //            btn.userInteractionEnabled = NO;
        //        }else {
        //            [btn setTitleColor:[UIColor colorWithHEX:0x333333] forState:UIControlStateNormal];
        //            btn.userInteractionEnabled = YES;
        //        }
        
        
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self
                action:@selector(nslogBtnTag:)
      forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        //是否已经有预约
        NSString *appointString = [NSString stringWithFormat:@"%@",array[i + 2 - firstDayIndexOfWeek-1][@"tel_item_num"]];
        
        if ([appointString isEqualToString:@"0"]) {
            [btn setTitleColor:[UIColor colorWithHEX:0x333333] forState:UIControlStateNormal];
        }else{
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22.5, 22.5)];
            img.image = [UIImage imageNamed:@"我的-预约设置-电话预约_选择"];
            [btn addSubview:img];
            [btn setTitleColor:AppDefaultColor forState:UIControlStateNormal];
        }
        
        [self.viewBack addSubview:btn];
        
        self.viewBack.height = btn.bottom;
        
        self.height = self.viewBack.bottom;
        
    }
    return self.height;
}

-(void)nslogBtnTag:(UIButton *)btn{
    NSString *str = self.dataArrays[btn.tag -1][@"date"];
    //i + 2 - firstDayIndexOfWeek
    
    NSString *tel_item_num = self.dataArrays[btn.tag -1][@"tel_item_num"];
    NSLog(@"生气的日子%@----%@",str,tel_item_num);
    if (self.CalendarBtnBlock) {
        self.CalendarBtnBlock(str,[NSString stringWithFormat:@"%@",tel_item_num]);
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
