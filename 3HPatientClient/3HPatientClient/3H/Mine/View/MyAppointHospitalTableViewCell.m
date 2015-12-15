//
//  MyAppointHospitalTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/14.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MyAppointHospitalTableViewCell.h"

@implementation MyAppointHospitalTableViewCell


- (void)customView{
    [self.contentView addSubview:self.viewBack];
    [self.viewBack addSubview:self.labTitle];
    
    [self.viewBack addSubview:self.labLine];
    [self.viewBack addSubview:self.labTime];
    
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width - 20, 145)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewBack.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _viewBack.layer.borderWidth = 0.5;
        _viewBack.layer.masksToBounds = YES;
        _viewBack.layer.cornerRadius = 5;
    }
    return _viewBack;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, self.viewBack.width -20, 105 -20)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.numberOfLines = 0;
    }
    return _labTitle;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 105, self.viewBack.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
        
    }
    return _labLine;
}

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labLine.bottom +10, self.labTitle.width, 15)];
        _labTime.font = [UIFont systemFontOfSize:15];
        _labTime.textColor = [UIColor colorWithHEX:0x999999];
    }
    return _labTime;
}

//赋值
- (void)confingWithModel:(NSInteger )index{
    self.labTitle.text = @"李小光 主治医生李小光 主治医生李小光 主治医生李小光 主治医生李小光 主治医生李小光 主治医生李小光 主治医生李小光 主治医生李小光 主治医生李小光 主治医生";
    self.labTime.text = @"2015-09-08";
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
