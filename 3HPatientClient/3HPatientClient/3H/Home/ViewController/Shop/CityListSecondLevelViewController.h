//
//  CityListSecondLevelViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CityListSecondLevelViewController : BaseTableViewController

@property (nonatomic, strong) NSArray *secondArray;
/**
 *  城市名字 城市id 父城市id
 */
@property (nonatomic,copy) void (^cityListBlock)(NSString *areaname,NSString *ids,NSString *parent_id);
@property (nonatomic, copy) NSString * id;
@end
