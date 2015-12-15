//
//  SetUpTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "SetUpTableViewCell.h"

@implementation SetUpTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.imgArrow];
    [self.contentView addSubview:self.labDetail];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, (45 -16)/2, 16, 16)];
        
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +8, 0, DeviceSize.width/2, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width -DeviceSize.width/2 -10, 0, DeviceSize.width/2, 45)];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
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

//赋值
- (void)confingWithModel:(NSInteger )index Cache:(NSString *)cache{
    NSArray *arrTitle = @[@"清理缓存",@"意见反馈",@"评价软件",@"关于",@"版本更新"];
    NSArray *arrImg = @[@"我的-设置_清理缓存-未点击",@"我的-设置_意见反馈-未点击",@"我的-设置_评价软件-未点击",@"我的-设置_关于-未点击",@"我的-设置_版本更新-未点击"];
    self.labTitle.text = arrTitle[index];
    self.imgLogo.image = [UIImage imageNamed:arrImg[index]];
    if (index == 0 ||index == 4) {
        self.imgArrow.hidden = YES;
        self.labDetail.hidden = NO;
        self.labDetail.text = cache;
    }else{
        self.imgArrow.hidden = NO;
        self.labDetail.hidden = YES;
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
