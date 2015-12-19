//
//  GoodsDetailModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"
//comments =     (
//);
//content = "\Uff08CREAJOY\Uff09 CY-9096 \U65f6\U5c1a\U5927\U5c3a\U5bf8 \U591a\U529f\U80fd\U9759\U97f3\U6db2\U538b\U6447\U6446\U8e0f\U6b65\U673a";
//id = 7;
//"market_price" = "369.00";
//name = "\Uff08CREAJOY\Uff09 CY-9096 \U65f6\U5c1a\U5927\U5c3a\U5bf8 \U591a\U529f\U80fd\U9759\U97f3\U6db2\U538b\U6447\U6446\U8e0f\U6b65\U673a";
//pics =     (
//);
//price = "299.00";
//"rec_title" = "\Uff08CREAJOY\Uff09 CY-9096 \U65f6\U5c1a\U5927\U5c3a\U5bf8 \U591a\U529f\U80fd\U9759\U97f3\U6db2\U538b\U6447\U6446\U8e0f\U6b65\U673a";
//thumb = "http://123.57.231.12:85/Public/uploads/goods//201512/20151201112357_39289.png";
@interface GoodsDetailModel : BaseModel
@property (nonatomic, strong) NSArray * comments;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * market_price;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, strong) NSArray * pics;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * rec_title;
@property (nonatomic, copy) NSString * thumb;
@end
