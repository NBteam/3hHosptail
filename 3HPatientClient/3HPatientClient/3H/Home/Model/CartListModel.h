//
//  CartListModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/9.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface CartListModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *qty;
@property (nonatomic, copy) NSString *sum;
@property (nonatomic, assign) BOOL choice;
@end
//	id					购物车记录ID
//	goods_id			商品ID
//	goods_name			商品标题
//	thumb				缩略图
//	price				会员价
//	qty					购买数量
//data.sum				所列记录商品总价