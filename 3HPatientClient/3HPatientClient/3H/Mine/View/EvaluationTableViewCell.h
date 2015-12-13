//
//  EvaluationTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CustomTextView.h"
@interface EvaluationTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) CustomTextView *txtView;

//赋值
- (void)confingWithModel:(NSInteger )dic;

@end
