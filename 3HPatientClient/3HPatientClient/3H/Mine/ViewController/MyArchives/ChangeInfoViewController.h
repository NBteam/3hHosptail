//
//  ChangeInfoViewController.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/28.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"

@interface ChangeInfoViewController : BaseTableViewController
@property (nonatomic, assign) NSInteger index;

@property (nonatomic,copy) void (^infoBlock)(NSString *string);
@end
