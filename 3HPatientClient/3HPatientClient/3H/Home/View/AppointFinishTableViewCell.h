//
//  AppointFinishTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface AppointFinishTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

//赋值
- (void)confingWithModel:(NSInteger )dic;
@end
