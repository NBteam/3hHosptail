//
//  ShopDetailBuyViewController.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface ShopDetailBuyViewController : BaseTableViewController
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * indexStr;
@property (nonatomic, retain) NSArray * infoArray;
@property (nonatomic, assign) NSInteger type;//0 购物车  1 直接购买
@end
