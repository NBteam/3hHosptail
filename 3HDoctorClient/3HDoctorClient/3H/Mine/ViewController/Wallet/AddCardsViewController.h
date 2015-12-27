//
//  AddCardsViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/26.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseViewController.h"
#import "WithdrawaListModel.h"

@interface AddCardsViewController : BaseViewController
@property (nonatomic, retain) WithdrawaListModel * model;

@property (nonatomic, copy) void (^reloadBlock)();
//3绑定银行卡
@property (nonatomic, assign) NSInteger index;
@end
