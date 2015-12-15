//
//  CheckDataDetailModel.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface CheckDataDetailModel : BaseModel
//记录ID
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;		//名称
@property (nonatomic, copy) NSString *hospital;			//医院
@property (nonatomic, strong) NSArray *pics;

@property (nonatomic, copy) NSString *addtime;
@end
