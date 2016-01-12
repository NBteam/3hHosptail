//
//  AddressListViewController.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewController.h"
#import "AddressListModel.h"

@interface AddressListViewController : BaseTableViewController
@property (nonatomic, copy) void (^placeBlock)(AddressListModel *model);
@end
