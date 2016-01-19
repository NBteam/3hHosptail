//
//  OrderModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/18.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"


@interface OrderModel : BaseModel
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *goods_name;
@property (nonatomic, copy) NSString *is_cmt;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *qty;
@property (nonatomic, copy) NSString *thumb;
//"goods_id" = 1;
//"goods_name" = "\U5546\U54c1\U6d4b\U8bd5";
//"is_cmt" = 0;
//price = "0.01";
//qty = 1;
//thumb = "http://123.57.231.12:85/Public/uploads/goods/201510/20151021231209_35632.jpg";
@end
