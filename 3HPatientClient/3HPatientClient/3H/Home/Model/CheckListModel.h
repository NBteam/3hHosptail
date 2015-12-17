//
//  CheckListModel.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface CheckListModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *hospital;
@property (nonatomic, retain) NSArray *pics;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *addtime;
@end
