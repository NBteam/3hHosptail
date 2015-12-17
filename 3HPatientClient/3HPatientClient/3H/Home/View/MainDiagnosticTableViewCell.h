//
//  MainDiagnosticTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MyDiagnosisListModel.h"

@interface MainDiagnosticTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIImageView *imgArrow;
//赋值
- (void)confingWithModel:(MyDiagnosisListModel * )dic;

@end
