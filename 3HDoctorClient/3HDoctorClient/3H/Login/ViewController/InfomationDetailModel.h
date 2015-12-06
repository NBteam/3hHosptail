//
//  InfomationDetailModel.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface InfomationDetailModel : BaseModel
@property (nonatomic, copy) NSString * addtime;
@property (nonatomic, copy) NSString * author;
@property (nonatomic, copy) NSString * comment_num;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * good_num;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * is_vote;
@property (nonatomic, retain) NSArray * pics;
@property (nonatomic, copy) NSString * thumb;
@property (nonatomic, copy) NSString * title;
@end
