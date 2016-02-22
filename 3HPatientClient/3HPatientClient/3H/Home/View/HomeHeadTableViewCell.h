//
//  HomeHeadTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "XianXing.h"
#import "WeatherModel.h"

@interface HomeHeadTableViewCell : BaseTableViewCell
//天气img
@property (nonatomic, strong) UIImageView *imgWeather;
@property (nonatomic, strong) UILabel *labWeatherWD;
@property (nonatomic, strong) UILabel *labWeatherTQ;

@property (nonatomic, strong) UILabel *labLine1;
//限号
@property (nonatomic, strong) UIImageView *imgLimit;
@property (nonatomic, strong) UILabel *labLimit;

@property (nonatomic, strong) UILabel *labLine2;
//心率
@property (nonatomic, strong) UIImageView *imgHeartRate;
@property (nonatomic, strong) UILabel *labHeartRateNum;
@property (nonatomic, strong) UILabel *labHeartRateName;
@property (nonatomic, strong) UILabel *labHeartRate;

//赋值
- (void)confingWithModel:(WeatherModel *)model item:(XianXing *)item;


@end
