//
//  MessageTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell


- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
    [self.contentView addSubview:self.imgArrow];
    [self.contentView addSubview:self.labNum];
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
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.imgLogo.bottom -13, DeviceSize.width -self.labTitle.left -40, 13)];
        _labDetail.font = [UIFont systemFontOfSize:13];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
        
    }
    return _labDetail;
}

- (UIImageView *)imgArrow{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 19/2 - 10, (60 - 34/2)/2, 19/2, 34/2)];
        _imgArrow.image = [UIImage imageNamed:@"3H-首页_键"];
        
    }
    return _imgArrow;
}

- (UILabel *)labNum{
    if (!_labNum) {
        _labNum = [[UILabel alloc] initWithFrame:CGRectMake(self.imgArrow.left -17 -15 , self.imgArrow.top - 1.5, 20, 20)];
        _labNum.font = [UIFont systemFontOfSize:12];
        _labNum.textColor = [UIColor colorWithHEX:0xffffff];
        _labNum.backgroundColor = [UIColor redColor];
        _labNum.layer.cornerRadius = 10;
        _labNum.layer.masksToBounds = YES;
        _labNum.textAlignment = NSTextAlignmentCenter;
        
    }
    return _labNum;
}

//赋值

- (void)confingWithDict:(NSMutableDictionary *)dict Index:(NSInteger)index draging:(BOOL)draging{
    

    NSArray *arrImg = @[@"3H-消息_挂号预约",
                        @"3H-消息_电话预约",
                        @"3H-消息_咨询信息",
                        @"3H-消息_患者添加请求",
                        @"3H-消息_系统消息"];
    
    NSArray *arr = @[@"guahao_msg_info",@"otel_msg_info",@"chat_msg_info",@"user_add_msg_info",@"sys_msg_info"];
    NSArray *arrNum = @[@"guahao_msg_num",@"otel_msg_num",@"chat_msg_num",@"user_add_msg_num",@"sys_msg_num"];
    
    NSArray *arrTitle = @[@"挂号预约",
                          @"电话预约",
                          @"咨询信息",
                          @"添加请求",
                          @"系统消息"];
    
    self.imgLogo.image = [UIImage imageNamed:arrImg[index]];
    self.labTitle.text = arrTitle[index];
    
    if ([dict[arr[index]] length] == 0) {
        self.labDetail.text = @"暂无最新消息";
    }else{
        self.labDetail.text = dict[arr[index]];
    }
    if ([dict[arrNum[index]] integerValue] == 0) {
        self.labNum.hidden = YES;
    }else{
        self.labNum.hidden = NO;
        self.labNum.text = [NSString stringWithFormat:@"%@",dict[arrNum[index]]];
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
