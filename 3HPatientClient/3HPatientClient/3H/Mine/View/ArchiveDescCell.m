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
- (CGFloat)cinfigWithModel:(id)model index:(NSInteger)index{
    if ([model isKindOfClass:[NSDictionary class]]) {
        if (index == 0) {
            self.labTitle.text = @"3H健康管理专家建议及指南";
            self.labDesc.text = model[@"zhinan"];
        }else if (index == 1){
            self.labTitle.text = @"癌症早期筛查风险评估系统";
            self.labDesc.text = model[@"xitong"];
        }else if (index == 2){
            self.labTitle.text = @"PET—CT检查报告";
            self.labDesc.text = model[@"jiancha"];
        }else if (index == 3){
            self.labTitle.text = @"无痛胃镜检查报告";
            self.labDesc.text = model[@"baogao"];
        }else if (index == 4){
            self.labTitle.text = @"常规查体报告";
            self.labDesc.text = model[@"changgui"];
        }
    }else{
        if (index == 0) {
            self.labTitle.text = @"3H健康管理专家建议及指南";            
        }else if (index == 1){
            self.labTitle.text = @"癌症早期筛查风险评估系统";
        }else if (index == 2){
            self.labTitle.text = @"PET—CT检查报告";
        }else if (index == 3){
            self.labTitle.text = @"无痛胃镜检查报告";
        }else if (index == 4){
            self.labTitle.text = @"常规查体报告";
        }
        self.labDesc.text = model;
    }
    self.labDesc.numberOfLines = 0;
    [self.labDesc sizeToFit];
    self.labDesc.top = self.labLine.bottom + (44 - 15)/2;
    self.labDesc.left = 10 ;
    self.labDesc.width = DeviceSize.width - 20;
    return self.labDesc.bottom + (44 - 15)/2;
}
@end
