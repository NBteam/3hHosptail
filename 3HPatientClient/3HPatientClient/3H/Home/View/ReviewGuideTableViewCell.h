//
//  ReviewGuideTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MyRecheckListModel.h"

@interface ReviewGuideTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;



//赋值
- (void)confingWithModel:(MyRecheckListModel*)model;



@end
