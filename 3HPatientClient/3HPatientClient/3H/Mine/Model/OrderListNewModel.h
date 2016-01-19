//
//  OrderListNewModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/18.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface OrderListNewModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, retain) NSArray *ilist;
@property (nonatomic, copy) NSString *order_sn;
@property (nonatomic, copy) NSString *pay_status;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *status_n;
@property (nonatomic, copy) NSString *total;

@end
