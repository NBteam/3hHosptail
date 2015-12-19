//
//  GoodsListModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsListModel : BaseModel
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * market_price;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * thumb;
@end
