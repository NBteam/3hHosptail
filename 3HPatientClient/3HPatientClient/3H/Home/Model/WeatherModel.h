//
//  WeatherModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 16/2/21.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface WeatherModel : BaseModel
@property (nonatomic, copy) NSString * fa;
@property (nonatomic, copy) NSString * temperature;
@property (nonatomic, copy) NSString * weather;
@property (nonatomic, copy) NSString * weather_url;
@property (nonatomic, copy) NSString * wind;
//fa = 00;
//temperature = "-3\U2103~6\U2103";
//weather = "\U6674\U8f6c\U591a\U4e91";
//"weather_url" = "http://123.57.231.12:85/Public/uploads/weather/00.png";
//wind = "\U5fae\U98ce";
@end
