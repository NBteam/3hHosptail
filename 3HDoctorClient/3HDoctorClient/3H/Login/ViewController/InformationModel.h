//
//  InformationModel.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseModel.h"

@interface InformationModel : BaseModel
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *url;
@end
