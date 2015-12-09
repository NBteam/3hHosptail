//
//  CheckDataDetailHeadTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "CheckDataDetailHeadTableViewCell.h"

@implementation CheckDataDetailHeadTableViewCell
- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.labTitle.right +10, 0, DeviceSize.width -self.labTitle.right -20, 45)];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
        _labDetail.font = [UIFont systemFontOfSize:15];
        _labDetail.textAlignment = NSTextAlignmentRight;
    }
    return _labDetail;
}

//赋值
- (void)confingWithModel:(NSInteger )dic{
    if (dic == 0) {
        self.labTitle.text = @"名称:";
        self.labDetail.text = @"血常规";
    }else if(dic ==1){
        self.labTitle.text = @"医院:";
        self.labDetail.text = @"北京306医院";
    }else{
        self.labTitle.text = @"时间:";
        self.labDetail.text = @"2019-09-09";
    }
}
@end
