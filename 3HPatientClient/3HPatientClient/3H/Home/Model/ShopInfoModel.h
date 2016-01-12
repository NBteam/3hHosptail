//
//  ShopInfoModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/12.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface ShopInfoModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *market_price;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *cusid;
@property (nonatomic, copy) NSString *indexStr;
//	id					商品ID
//	name				商品标题
//	thumb				缩略图
//	market_price			原价
//	price				会员价
//	cusid				编号
@end
