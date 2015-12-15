//
//  MedicationGuideTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MessageListModel.h"

@interface MedicationGuideTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIView *viewBack;
//药名字
@property (nonatomic, strong) UILabel *labTitle;


//赋值
- (void)confingWithModel:(MessageListModel * )model;


@end
