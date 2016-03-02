//
//  MessageListTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 16/3/2.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "MessageListTableViewCell.h"

@implementation MessageListTableViewCell
- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
    [self.contentView addSubview:self.labTime];
    // [self.contentView addSubview:self.labRead];
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

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width - 10 - 160, self.labTitle.top +1.5, 160, 12)];
        _labTime.font = [UIFont systemFontOfSize:12];
        _labTime.textColor = [UIColor colorWithHEX:0x999999];
        _labTime.textAlignment = NSTextAlignmentRight;
        
    }
    return _labTime;
}

- (UILabel *)labRead{
    if (!_labRead) {
        _labRead = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width - 10 - 30, self.labDetail.top, 30, 12)];
        _labRead.font = [UIFont systemFontOfSize:12];
        _labRead.textAlignment = NSTextAlignmentRight;
        
    }
    return _labRead;
}

- (void)confingWithDict:(MessageListsModel *)model imgString:(NSString *)imgString{
    self.labTitle.text = model.title;
    self.labDetail.text = model.content;
    self.labTime.text = model.addtime;
    self.imgLogo.image = [UIImage imageNamed:imgString];
    if ([model.is_read integerValue] == 1) {
        self.labRead.textColor = AppDefaultColor;
        self.labRead.text = @"已读";
    }else{
        self.labRead.textColor = [UIColor redColor];
        self.labRead.text = @"未读";
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
