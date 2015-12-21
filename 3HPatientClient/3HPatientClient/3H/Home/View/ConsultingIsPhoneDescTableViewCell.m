//
//  ConsultingIsPhoneDescTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingIsPhoneDescTableViewCell.h"

@implementation ConsultingIsPhoneDescTableViewCell


- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labLine];
    [self.contentView addSubview:self.textView];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 32/2, 32/2)];
        _imgLogo.image = [UIImage imageNamed:@"首页-我要预约-预约挂号-2_预约时间"];
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 10, 0, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"描述信息";
        [_labTitle sizeToFit];
        _labTitle.top = 10;
    }
    return _labTitle;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom +10, DeviceSize.width -20, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}

- (CustomTextView *)textView{
    if (!_textView) {
        _textView = [[CustomTextView alloc] initWithFrame:CGRectMake(10, self.labLine.bottom +10, DeviceSize.width -20, 100) placeholderFont:[UIFont systemFontOfSize:13] Color:[UIColor colorWithHEX:0x999999] Text:@"请输入描述信息"];
        _textView.textColor = [UIColor colorWithHEX:0x333333];
        _textView.font = [UIFont systemFontOfSize:13];
        _textView.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.layer.masksToBounds = YES;
        _textView.layer.cornerRadius = 3;
    }
    return _textView;
}


@end
