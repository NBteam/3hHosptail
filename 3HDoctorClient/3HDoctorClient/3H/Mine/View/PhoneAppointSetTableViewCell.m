//
//  PhoneAppointSetTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PhoneAppointSetTableViewCell.h"

@implementation PhoneAppointSetTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.imgArrow];
    [self.contentView addSubview:self.labDetail];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.imgArrow.left -10 -100, 0, 100, 45)];

        _labDetail.font = [UIFont systemFontOfSize:13];
        _labDetail.textAlignment = NSTextAlignmentRight;
    }
    return _labDetail;
}

- (UIImageView *)imgArrow{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 19/2 - 10, (45 - 34/2)/2, 19/2, 34/2)];
        _imgArrow.image = [UIImage imageNamed:@"3H-首页_键"];
        
    }
    return _imgArrow;
}

- (void)confingWithModel:(NSDictionary *)dict{
    self.labTitle.text = dict[@"title"];
    self.labDetail.text = dict[@"detail"];
    
    if ([self.labDetail.text isEqualToString:@"未选择"]) {
        self.labDetail.textColor = [UIColor colorWithHEX:0x999999];
    }else{
        self.labDetail.textColor = [UIColor colorWithHEX:0x333333];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
