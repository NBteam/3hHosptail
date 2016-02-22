//
//  InviteCodeTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 16/2/22.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "InviteCodeTableViewCell.h"

@implementation InviteCodeTableViewCell


- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.btn];
    [self.contentView addSubview:self.labDetail];
    
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"我的邀请码";
        
    }
    
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 45)];
        _labDetail.textColor = [UIColor colorWithHEX:0x666666];
        _labDetail.font = [UIFont systemFontOfSize:15];
        
    }
    
    return _labDetail;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(DeviceSize.width - 60 -10, 7.5 , 60, 30);
        _btn.backgroundColor = AppDefaultColor;
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        [_btn setTitle:@"复制" forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.layer.cornerRadius = 4;
        _btn.layer.masksToBounds = YES;
    }
    return _btn;
}

- (void)btnAction{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.labDetail.text;
    
    if (self.btnBlock) {
        self.btnBlock();
    }
}


//赋值
- (void)confingWithModel:(NSString *)model{
    self.labDetail.text  = model;
    [self.labDetail sizeToFit];
    self.labDetail.frame = CGRectMake(self.btn.left - self.labDetail.width - 10, 0, self.labDetail.width, 45);
}


@end
