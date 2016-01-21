//
//  CheckDataDetailTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CheckDataDetailModel.h"
#import "SDPhotoBrowser.h"
@interface CheckDataDetailTableViewCell : BaseTableViewCell<SDPhotoBrowserDelegate>
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, strong) NSMutableArray *imagesArrays;
@property (nonatomic, strong) UIView *bgView;

//赋值
- (CGFloat)confingWithModel:(CheckDataDetailModel *)model;
@end
