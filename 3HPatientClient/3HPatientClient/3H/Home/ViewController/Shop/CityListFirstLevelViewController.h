//
//  CityListFirstLevelViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CityListFirstLevelViewController : BaseTableViewController
/**
 *  城市名字 城市id 父城市id
 */
@property (nonatomic,copy) void (^cityListBlock)(NSString *areaname,NSString *ids,NSString *parent_id);
@end
