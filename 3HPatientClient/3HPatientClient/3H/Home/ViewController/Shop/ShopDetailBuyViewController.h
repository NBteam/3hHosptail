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
@property (nonatomic, retain) NSMutableArray * infoArray;
@property (nonatomic, assign) NSInteger type;//1 购物车  0 直接购买
@end
