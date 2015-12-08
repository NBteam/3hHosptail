//
//  BriefCaseHeadTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BriefCaseHeadTableViewCell.h"

@implementation BriefCaseHeadTableViewCell


- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 0, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 0, 15)];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
        _labDetail.font = [UIFont systemFontOfSize:15];
    }
    return _labDetail;
}

//赋值
- (void)confingWithModel:(NSInteger )model{
    NSString *str;
    if (model == 0) {
        str = @"是否有过敏史:";
    }else{
        str = @"血型:";
    }
    self.labTitle.text = str;
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, 15)];
    self.labTitle.width = size.width;
    self.labDetail.text = @"str";
    self.labDetail.left = self.labTitle.right +5;
    self.labDetail.width = DeviceSize.width/2;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
