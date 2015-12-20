//
//  CityListFirstLevelModel.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface CityListModel : BaseModel

@property (nonatomic, copy) NSString *areaname;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *parent_id;
@property (nonatomic, strong) NSArray *slist;
@end
