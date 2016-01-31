//
//  ArchiveDescCell.h
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/31.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ArchiveDescCell : BaseTableViewCell
@property (nonatomic, strong) UILabel * labTitle;
@property (nonatomic, strong) UILabel * labLine;
@property (nonatomic, strong) UILabel * labDesc;
- (CGFloat)cinfigWithModel:(id)model;
@end
