//
//  ShopPicModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/9.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface ShopPicModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *market_price;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *thumb;

//id = 24;
//"market_price" = "0.00";
//name = "\U5b8f\U4e03";
//price = "9680.00";
//thumb = "http://123.57.231.12:85/Public/uploads/goods/201512/20151229120224_60181.jpg";
@end
