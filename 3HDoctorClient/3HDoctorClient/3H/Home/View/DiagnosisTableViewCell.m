//
//  DiagnosisListTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "DiagnosisTableViewCell.h"

@implementation DiagnosisTableViewCell


- (void)customView{
    [self.contentView addSubview:self.viewBack];
    [self.contentView addSubview:self.labTitle];
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width - 20, 45)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewBack.layer.masksToBounds = YES;
        _viewBack.layer.cornerRadius = 2;
        _viewBack.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _viewBack.layer.borderWidth = 0.5;
    }
    return _viewBack;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.viewBack.width -20, 45)];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

//赋值
- (void)confingWithModel:(DiagnosisModel *)model{
    if ([model.diag_name isEqualToString:@"请输入诊断名称"]) {
        self.labTitle.textColor = [UIColor colorWithHEX:0x999999];
    }else{
        self.labTitle.textColor = [UIColor colorWithHEX:0x333333];
    }
    self.labTitle.text = model.diag_name;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
