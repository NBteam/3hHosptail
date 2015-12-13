//
//  AppointFinishTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AppointFinishTableViewCell.h"

@implementation AppointFinishTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
    
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceSize.width - 20, 55)];
        _labTitle.textColor = [UIColor colorWithHEX:0x999999];
        _labTitle.font = [UIFont systemFontOfSize:13];
        _labTitle.numberOfLines = 0;
        _labTitle.text = @"您的预约住院留言提交成功!\n有新消息,我们工作人员会尽快与您取得联系!\n祝您身体健康!生活愉快!";
        [_labTitle sizeToFit];
        _labTitle.top = (70 -_labTitle.height)/2;
    }
    return _labTitle;
}

//赋值
- (void)confingWithModel:(NSInteger )dic{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
