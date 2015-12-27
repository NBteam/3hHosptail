//
//  MyCollectionModel.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/27.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface MyCollectionModel : BaseModel


@property (nonatomic, copy) NSString *id;//					商品ID
@property (nonatomic, copy) NSString *name;//				商品标题
@property (nonatomic, copy) NSString *thumb;//				缩略图
@property (nonatomic, copy) NSString *market_price;//			原价
@property (nonatomic, copy) NSString *price	;//			会员价
@end
