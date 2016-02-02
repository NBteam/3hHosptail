//
//  DynamicDetailModel.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/14.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface DynamicDetailModel : BaseModel

@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, strong) NSNumber *comment_num;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) NSNumber *is_vote;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSNumber *good_num;

@property (nonatomic, copy) NSString *share_url;
@end
