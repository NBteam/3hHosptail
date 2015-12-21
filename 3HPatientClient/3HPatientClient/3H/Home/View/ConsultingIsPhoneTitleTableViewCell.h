//
//  ConsultingIsPhoneTitleTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ConsultingIsPhoneTitleTableViewCell : UIView

@property (nonatomic, strong) UIView *viewBack;

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UILabel *labLine1;
//赋值
- (void)confingWithModel:(CGFloat )dic;
@end
