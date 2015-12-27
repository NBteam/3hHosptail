//
//  WithdrawaListModel.h
//  3HDoctorClient
//
//  Created by 郑彦华 on 15/12/27.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface WithdrawaListModel : BaseModel
@property (nonatomic, copy) NSString *bank_info;
@property (nonatomic, copy) NSString *bank_type;
@property (nonatomic, copy) NSString *bank_name;
@property (nonatomic, copy) NSString *bank_pic;
@property (nonatomic, copy) NSString *bank_username;
@property (nonatomic, copy) NSString *bank_bind_mobile;
@property (nonatomic, copy) NSString *id;
@end
//bank_info			卡号描述，如：尾号2233
//bank_type			卡号类型
//bank_name			银行名称
//bank_pic			银行图标
//bank_username		账户名
//bank_bind_mobile	绑定手机号
