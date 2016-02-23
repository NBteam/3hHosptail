//
//  HomeHeadTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "HomeHeadTableViewCell.h"

@implementation HomeHeadTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labLine1];
    [self.contentView addSubview:self.labLine2];
    [self.contentView addSubview:self.imgWeather];
    [self.contentView addSubview:self.labWeatherWD];
    [self.contentView addSubview:self.labWeatherTQ];
    [self.contentView addSubview:self.imgHeartRate];
    [self.contentView addSubview:self.imgLimit];
    [self.contentView addSubview:self.labLimit];
    [self.imgHeartRate addSubview:self.labHeartRateNum];
    [self.contentView addSubview:self.labHeartRateName];
    [self.contentView addSubview:self.labHeartRate];
}

- (UIImageView *)imgWeather{
    if (!_imgWeather) {
        _imgWeather = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12.5, 50, 50)];
        
    }
    return _imgWeather;
}

- (UILabel *)labWeatherWD{
    if (!_labWeatherWD) {
        _labWeatherWD = [[UILabel alloc] initWithFrame:CGRectMake(self.imgWeather.right +10, self.imgWeather.top +5, DeviceSize.width/2 -self.imgWeather.right -20, 15)];

    }
    return _labWeatherWD;
}

- (UILabel *)labWeatherTQ{
    if (!_labWeatherTQ) {
        _labWeatherTQ = [[UILabel alloc] initWithFrame:CGRectMake(self.imgWeather.right +10, self.labWeatherWD.bottom +10, DeviceSize.width/2 -self.imgWeather.right -20, 12)];
        _labWeatherTQ.textColor = [UIColor colorWithHEX:0x888888];
        _labWeatherTQ.font = [UIFont systemFontOfSize:12];
    }
    return _labWeatherTQ;
}

- (UILabel *)labLine1{
    if (!_labLine1) {
        _labLine1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 70 -0.25, DeviceSize.width/2, 0.5)];
        _labLine1.backgroundColor = [UIColor colorWithHEX:0xcccccc];
        
    }
    return _labLine1;
}

- (UILabel *)labLine2{
    if (!_labLine2) {
        _labLine2 = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width/2 -0.25, 0, 0.5, 105)];
        _labLine2.backgroundColor = [UIColor colorWithHEX:0xcccccc];
        
    }
    return _labLine2;
}

- (UIImageView *)imgLimit{
    if (!_imgLimit) {
        _imgLimit = [[UIImageView alloc] initWithFrame:CGRectMake(self.imgWeather.left +(self.imgWeather.width -67/2)/2, self.labLine1.bottom +(35 -39/2)/2, 67/2, 39/2)];
        _imgLimit.image = [UIImage imageNamed:@"3H-首页_小车"];
    }
    return _imgLimit;
}

- (UILabel *)labLimit{
    if (!_labLimit) {
        _labLimit = [[UILabel alloc] initWithFrame:CGRectMake(self.labWeatherTQ.left, self.labLine1.bottom, self.labWeatherTQ.width, 35)];
        _labLimit.textColor = [UIColor colorWithHEX:0x666666];
        _labLimit.font = [UIFont systemFontOfSize:12];
    }
    return _labLimit;
}

- (UIImageView *)imgHeartRate{
    if (!_imgHeartRate) {
        _imgHeartRate = [[UIImageView alloc] initWithFrame:CGRectMake(self.labLine2.right +10, (105 -172/2)/2, 177/2, 172/2)];
        _imgHeartRate.image = [UIImage imageNamed:@"3H-首页_心率0"];
    }
    return _imgHeartRate;
}

- (UILabel *)labHeartRateNum{
    if (!_labHeartRateNum) {
        _labHeartRateNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 177/2, 172/2)];
        _labHeartRateNum.textColor = AppDefaultColor;
        _labHeartRateNum.font = [UIFont systemFontOfSize:30];
        _labHeartRateNum.textAlignment = NSTextAlignmentCenter;
        
    }
    return _labHeartRateNum;
}

- (UILabel *)labHeartRateName{
    if (!_labHeartRateName) {
        _labHeartRateName = [[UILabel alloc] initWithFrame:CGRectMake(self.imgHeartRate.right, (105 -18 -5 -12)/2, DeviceSize.width -self.imgHeartRate.right, 18)];
        _labHeartRateName.textColor = [UIColor colorWithHEX:0x666666];
        _labHeartRateName.font = [UIFont systemFontOfSize:18];
        _labHeartRateName.textAlignment = NSTextAlignmentCenter;
        _labHeartRateName.text = @"心率";
    }
    return _labHeartRateName;
}

- (UILabel *)labHeartRate{
    if (!_labHeartRate) {
        _labHeartRate = [[UILabel alloc] initWithFrame:CGRectMake(self.imgHeartRate.right, self.labHeartRateName.bottom +5, DeviceSize.width -self.imgHeartRate.right, 12)];
        _labHeartRate.textColor = [UIColor colorWithHEX:0x888888];
        _labHeartRate.font = [UIFont systemFontOfSize:12];
        _labHeartRate.textAlignment = NSTextAlignmentCenter;
    }
    return _labHeartRate;
}

//赋值
- (void)confingWithModel:(WeatherModel *)model item:(XianXing *)item{
//    self.imgWeather.image = [UIImage imageNamed:@"3H-首页-天气"];
    if (model) {
        [self.imgWeather sd_setImageWithURL:SD_IMG(model.weather_url)];
        self.labWeatherWD.attributedText = [self getLabTitle:model.temperature Detail:@""];
        self.labWeatherTQ.text = [NSString stringWithFormat:@"%@ %@",model.wind,model.weather];
        if ([item.isxianxing integerValue] == 0) {
            self.labLimit.text = [NSString stringWithFormat:@"今日不限号"];
        }else{
            self.labLimit.text = [NSString stringWithFormat:@"日限号 %@",item.xxweihao];
        }
        self.labHeartRateNum.text = @"85";
        self.labHeartRate.text = @"85次/分";
    }
}

- (NSMutableAttributedString *)getLabTitle:(NSString *)title Detail:(NSString *)detail{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",title,detail]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x999999] range:NSMakeRange(0,title.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x888888] range:NSMakeRange(title.length,detail.length)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,title.length)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(title.length,detail.length)];
    return str;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
