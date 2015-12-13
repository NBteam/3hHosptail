//
//  AppointHosptailTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AppointHosptailTableViewCell.h"

@implementation AppointHosptailTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labLine];
    [self.contentView addSubview:self.txtView];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 16, 16)];
        _imgLogo.image = [UIImage imageNamed:@"首页-我要预约-预约住院_预约留言"];
        
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 9, 100, 16)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"预约留言";
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

- (CustomTextView *)txtView{
    if (!_txtView) {
        _txtView = [[CustomTextView alloc] initWithFrame:CGRectMake(10, self.labLine.bottom +10, DeviceSize.width - 20, 200) placeholderFont:[UIFont systemFontOfSize:13] Color:[UIColor colorWithHEX:0x999999] Text:@"请输入留言信息..."];
        _txtView.font = [UIFont systemFontOfSize:13];
        _txtView.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtView.layer.borderWidth = 0.5;
        _txtView.layer.masksToBounds = YES;
        _txtView.layer.cornerRadius = 3;
    }
    return _txtView;
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
