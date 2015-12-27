//
//  MessageTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.imgArrow];
    [self.contentView addSubview:self.labDetail];
    
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12.5, 35, 35)];
        
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.imgLogo.top, DeviceSize.width/2, 15)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.imgLogo.bottom -13, self.imgArrow.left -self.imgLogo.right -20, 13)];
        _labDetail.font = [UIFont systemFontOfSize:13];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
        
    }
    return _labDetail;
}

- (UIImageView *)imgArrow{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 19/2 - 10, (60 - 34/2)/2, 19/2, 34/2)];
        _imgArrow.image = [UIImage imageNamed:@"arrowImg"];
        
    }
    return _imgArrow;
}

//赋值

- (void)confingWithModel:(ScheduleCalendarDayModel *)model{
    NSArray *arrImg = @[@"3H-消息_预约提醒",
                        @"3H-消息_用药提醒",
                        @"3H-消息_复查提醒",
                        @"3H-消息_订单提醒",
                        @"3H-消息_系统消息"];
    
//    NSArray *arrTitle = @[@"预约提醒",
//                          @"用药提醒",
//                          @"复查提醒",
//                          @"订单提醒",
//                          @"系统消息"];
    
    if ([model.title isEqualToString:@"预约提醒"]) {
        self.labTitle.text = model.title;
        self.labDetail.text = model.info;
        self.imgLogo.image = [UIImage imageNamed:arrImg[0]];
    }else if([model.title isEqualToString:@"用药提醒"]){
        self.labTitle.text = model.title;
        self.labDetail.text = model.info;
        self.imgLogo.image = [UIImage imageNamed:arrImg[1]];
    }else if([model.title isEqualToString:@"复查提醒"]){
        self.labTitle.text = model.title;
        self.labDetail.text = model.info;
        self.imgLogo.image = [UIImage imageNamed:arrImg[2]];
    }else if([model.title isEqualToString:@"订单提醒"]){
        self.labTitle.text = model.title;
        self.labDetail.text = model.info;
        self.imgLogo.image = [UIImage imageNamed:arrImg[3]];
    }else{
        self.labTitle.text = model.title;
        self.labDetail.text = model.info;
        self.imgLogo.image = [UIImage imageNamed:arrImg[4]];
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
