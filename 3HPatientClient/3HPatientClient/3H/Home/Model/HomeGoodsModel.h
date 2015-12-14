//
//  HomeGoodsModel.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/14.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface HomeGoodsModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *market_price;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *thumb;
@end
