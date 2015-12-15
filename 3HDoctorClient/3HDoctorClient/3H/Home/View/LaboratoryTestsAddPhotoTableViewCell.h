//
//  LaboratoryTestsAddPhotoTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface LaboratoryTestsAddPhotoTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIButton *btnTakingPictures;
//报告单
@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, copy) void(^btnTakingBlock)();

//赋值
- (CGFloat)confingWithModel:(NSMutableArray *)array;


@end
