//
//  MedicalInformationModel.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"
//	id					记录ID
//	title				标题
//  desc				描述
//  thumb				缩略图
//  addtime				日期，yyyy-mm-dd
//	url					文章访问链接
@interface MedicalInformationModel : BaseModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * thumb;
@property (nonatomic, copy) NSString * addtime;
@property (nonatomic, copy) NSString * url;

@end
