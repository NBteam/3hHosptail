//
//  ArchiveDescCell.m
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/31.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "ArchiveDescCell.h"

@implementation ArchiveDescCell
- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labLine];
    [self.contentView addSubview:self.labDesc];
}
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc]initWithFrame:CGRectMake(10,( 44 - 15)/2, DeviceSize.width - 20, 15)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textAlignment = NSTextAlignmentLeft;
    }
    return _labTitle;
}
- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc]initWithFrame:CGRectMake(0,44, DeviceSize.width, 0.5)];
        _labLine.font = [UIFont systemFontOfSize:15];
        _labLine.textAlignment = NSTextAlignmentLeft;
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}
- (UILabel *)labDesc{
    if (!_labDesc) {
        _labDesc = [[UILabel alloc]initWithFrame:CGRectMake(10,self.labLine.bottom + (44 - 15)/2, DeviceSize.width - 20, 0.5)];
        _labDesc.font = [UIFont systemFontOfSize:15];
        _labDesc.textAlignment = NSTextAlignmentLeft;
        _labDesc.numberOfLines = 0;
    }
    return _labDesc;
}
- (CGFloat)cinfigWithModel:(id)model{
    self.labTitle.text = @"11111";
    self.labDesc.text = @"11111111111dsaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa11111111111dsaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    [self.labDesc sizeToFit];
    self.labDesc.top = self.labLine.bottom + (44 - 15)/2;
    self.labDesc.left = 10 ;
    self.labDesc.width = DeviceSize.width - 20;
    return self.labDesc.bottom + (44 - 15)/2;
}
@end
