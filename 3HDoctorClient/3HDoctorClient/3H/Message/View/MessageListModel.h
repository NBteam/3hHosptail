//
//  MessageListModel.h
//  3HDoctorClient
//
//  Created by 范英强 on 16/2/29.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface MessageListModel : BaseModel

@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *is_read;
@property (nonatomic, copy) NSString *title;

@end
