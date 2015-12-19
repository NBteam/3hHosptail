//
//  ReviewAddProjectTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ReviewAddProjectTableViewCell.h"

@implementation ReviewAddProjectTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labLine1];
    [self.contentView addSubview:self.btnUp];
    [self.contentView addSubview:self.labUp];
    [self.contentView addSubview:self.labLine2];
    [self.contentView addSubview:self.btnDown];
    [self.contentView addSubview:self.labDown];
    [self.contentView addSubview:self.labLine3];
    [self.contentView addSubview:self.viewBack];
    [self.viewBack addSubview:self.txtField];
    
    if (self.btnBlock) {
        self.btnBlock(1,@"");
    }
    
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"复查项目:";
        [_labTitle sizeToFit];
        _labTitle.top = (45 -_labTitle.height)/2;
        
    }
    return _labTitle;
}

- (UILabel *)labLine1{
    if (!_labLine1) {
        _labLine1 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom +10, DeviceSize.width -20, 0.5)];
        _labLine1.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine1;
}

- (UIButton *)btnUp{
    if (!_btnUp) {
        _btnUp = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnUp.frame =CGRectMake(10, self.labLine1.bottom +5, 30, 30);
        [_btnUp setImage:[UIImage imageNamed:@"首页-患者中心-患者详情-复查提醒-添加复查_未选中"] forState:UIControlStateNormal];
        [_btnUp setImage:[UIImage imageNamed:@"首页-患者中心-患者详情-复查提醒-添加复查_选中"] forState:UIControlStateSelected];
        _btnUp.selected = YES;
        [_btnUp addTarget:self action:@selector(btnUpAction) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _btnUp;
}

- (void)btnUpAction{
    self.txtField.userInteractionEnabled = NO;
    self.txtField.text = @"";
    self.btnUp.selected = YES;
    self.btnDown.selected = NO;
    if (self.btnBlock) {
        self.btnBlock(1, @"门诊随诊");
    }
}


- (UILabel *)labUp{
    if (!_labUp) {
        _labUp = [[UILabel alloc] initWithFrame:CGRectMake(self.btnUp.right +5, self.labLine1.bottom +5, 100, 30)];
        _labUp.textColor = [UIColor colorWithHEX:0x333333];
        _labUp.font = [UIFont systemFontOfSize:15];
        _labUp.text = @"门诊随诊";
        
    }
    return _labUp;
}

- (UILabel *)labLine2{
    if (!_labLine2) {
        _labLine2 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.btnUp.bottom +5, DeviceSize.width -20, 0.5)];
        _labLine2.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine2;
}

- (UIButton *)btnDown{
    if (!_btnDown) {
        _btnDown = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDown.frame =CGRectMake(10, self.labLine2.bottom +5, 30, 30);
        [_btnDown setImage:[UIImage imageNamed:@"首页-患者中心-患者详情-复查提醒-添加复查_未选中"] forState:UIControlStateNormal];
        [_btnDown setImage:[UIImage imageNamed:@"首页-患者中心-患者详情-复查提醒-添加复查_选中"] forState:UIControlStateSelected];
        _btnDown.selected = NO;
        [_btnDown addTarget:self action:@selector(btnDownAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDown;
}

- (void)btnDownAction{
    self.txtField.userInteractionEnabled = YES;
    self.btnUp.selected = NO;
    self.btnDown.selected = YES;
    if (self.btnBlock) {
        self.btnBlock(2,self.txtField.text);
    }
}

- (UILabel *)labDown{
    if (!_labDown) {
        _labDown = [[UILabel alloc] initWithFrame:CGRectMake(self.btnDown.right +5, self.labLine2.bottom +5, 200, 30)];
        _labDown.textColor = [UIColor colorWithHEX:0x333333];
        _labDown.font = [UIFont systemFontOfSize:15];
        _labDown.text = @"手动输入复查项目";
        
    }
    return _labDown;
}

- (UILabel *)labLine3{
    if (!_labLine3) {
        _labLine3 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labDown.bottom +5, DeviceSize.width -20, 0.5)];
        _labLine3.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine3;
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(10, self.labLine3.bottom +10, DeviceSize.width -20, 45)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewBack.layer.masksToBounds = YES;
        _viewBack.layer.cornerRadius =3;
        _viewBack.layer.borderColor = AppDefaultColor.CGColor;
        _viewBack.layer.borderWidth = 0.5;
    }
    return _viewBack;
}

- (UITextField *)txtField{
    if (!_txtField) {
        _txtField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, self.viewBack.width -20, 35)];
        
        //是否纠错
        _txtField.autocorrectionType = UITextAutocorrectionTypeNo;
    

        _txtField.font = [UIFont systemFontOfSize:13];
        _txtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入复查的项目名称..." attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtField.textColor = [UIColor colorWithHEX:0x333333];
        _txtField.userInteractionEnabled = NO;
    }
    return _txtField;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
