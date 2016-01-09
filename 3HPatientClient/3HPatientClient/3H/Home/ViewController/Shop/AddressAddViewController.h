//
//  AddressAddViewController.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/20.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressListModel.h"

@interface AddressAddViewController : BaseViewController
@property (nonatomic, copy) void (^reloadInfo)(void);
@property (nonatomic, retain) AddressListModel * model;
//0 添加 1 修改
@property (nonatomic, assign) NSInteger index;
@end
