//
//  BookDetailTimeTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BookDetailTimeTableViewCell.h"

@implementation BookDetailTimeTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
    
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width -20, 44)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

//赋值
- (void)confingWithModel:(NSDictionary *)dic{
    self.labTitle.text = [NSString stringWithFormat:@"预约时间:%@",dic[@"	addtime"]] ;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
