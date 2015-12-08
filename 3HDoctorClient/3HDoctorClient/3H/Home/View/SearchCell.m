//
//  SearchCell.m
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/8.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell
- (void)customView{
    [self.contentView addSubview:self.imgHead];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labSex];
    [self.contentView addSubview:self.labInfo];
}
- (UIImageView *)imgHead{
    if (!_imgHead) {
        _imgHead = [[UIImageView alloc]initWithFrame:CGRectMake(15, 35-30,60 , 60)];
        _imgHead.backgroundColor = [UIColor grayColor];
        _imgHead.layer.masksToBounds = YES;
        _imgHead.layer.cornerRadius = 30;
    }
    return _imgHead;
}
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.imgHead.right+10, self.imgHead.top+10, 100, 15)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = AppDefaultColor;
    }
    return _labTitle;
}
- (UILabel *)labSex{
    if (!_labSex) {
        _labSex = [[UILabel alloc]initWithFrame:CGRectMake(self.labTitle.right+5, self.labTitle.bottom-13, 100, 13)];
        _labSex.font = [UIFont systemFontOfSize:13];
        _labSex.textColor = [UIColor grayColor];
    }
    return _labSex;
}
- (UILabel *)labInfo{
    if (!_labInfo) {
        _labInfo = [[UILabel alloc]initWithFrame:CGRectMake(self.labTitle.left, self.imgHead.bottom-13-10, DeviceSize.width-self.labTitle.left-15, 13)];
        _labInfo.textColor = [UIColor grayColor];
        _labInfo.font = [UIFont systemFontOfSize:13];
    }
    return _labInfo;
}
- (void)configWithModel:(id)model{
    self.labTitle.text = @"王小明";
    self.labSex.text = @"男   26岁";
    self.labInfo.text = @"沙发发发飞洒发发发发发发发";
}
@end
