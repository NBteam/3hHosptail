//
//  NewMyArchivesModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/28.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface NewMyArchivesModel : BaseModel
@property (nonatomic, copy) NSString *first_access_date;
@property (nonatomic, copy) NSString *truename;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *birth_date;
@property (nonatomic, copy) NSString *marry_info;
@property (nonatomic, copy) NSString *born_info;
@property (nonatomic, copy) NSString *child_info;
@property (nonatomic, copy) NSString *hight;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *blood_sugar;
@property (nonatomic, copy) NSString *blood_pressure;
@property (nonatomic, copy) NSString *job;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *weixin;
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *interest;
@property (nonatomic, copy) NSString *huafen_guomin;
@property (nonatomic, copy) NSString *flower_fav;
@property (nonatomic, copy) NSString *smoke;
@property (nonatomic, copy) NSString *food;
@property (nonatomic, copy) NSString *family;
@property (nonatomic, copy) NSString *sick_his;
@property (nonatomic, copy) NSString *waike_his;
@property (nonatomic, copy) NSString *guomin_his;
@property (nonatomic, copy) NSString *big_sick;
@property (nonatomic, copy) NSString *latest_health;
//	first_access_date				首次接待日期
//	truename					姓名
//	sex							性别
//	birth_date					出生日期
//	marry_info					婚姻状况
//	born_info					生育状况
//	child_info					子女人数
//	hight						身高
//	weight						体重
//	blood_sugar					血糖
//	blood_pressure				血压
//	job							职业
//	mobile						手机
//	email						邮箱
//	weixin						微信
//	qq							QQ
//	address						邮寄地址
//	interest						个人兴趣
//	huafen_guomin				花粉过敏
//	flower_fav					喜爱鲜花
//	smoke						吸烟
//	food							饮食习惯
//	family						家族史
//	sick_his						既往史
//	waike_his					外科手术史
//	guomin_his					过敏史
//	big_sick						重大疾病
//	latest_health					最近健康状况
@end
