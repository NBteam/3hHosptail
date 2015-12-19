//
//  AddressListCell.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface AddressListCell : BaseTableViewCell
//详细地址
@property (nonatomic, strong) UILabel * labDetail;
//名字 + 手机号
@property (nonatomic, strong) UILabel * labName;
// 修改按钮
@property (nonatomic, strong) UIButton * btnModify;
- (CGFloat )configWithModel:(id)model;
@end
