//
//  CheckDataDetailTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "CheckDataDetailTableViewCell.h"

@implementation CheckDataDetailTableViewCell
- (void)customView{
    [self.contentView addSubview:self.labTitle];
    
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

//赋值
- (void)confingWithModel:(NSInteger )dic{
    self.labTitle.text = @"报告单";
}
@end
