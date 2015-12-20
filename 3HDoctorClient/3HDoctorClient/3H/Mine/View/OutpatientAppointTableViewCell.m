//
//  OutpatientAppointTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/16.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "OutpatientAppointTableViewCell.h"

@implementation OutpatientAppointTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.viewBack];
    
    [self.contentView addSubview:self.btnSubmit];
    [self.contentView addSubview:self.backViewss];
    [self.backViewss addSubview:self.txtNameInput];
 
}

- (UIImageView *)imgLogo{
    if(!_imgLogo){
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, (35 -16)/2, 16, 16)];
        _imgLogo.image = [UIImage imageNamed:@"我的-预约设置-电话预约_时间"];
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 0, DeviceSize.width -self.imgLogo.right -20, 35)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.text = @"请选择您的门诊时间";
    }
    return _labTitle;
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom, DeviceSize.width -20, 0)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewBack.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _viewBack.layer.borderWidth = 0.5;
    }
    return _viewBack;
}

#pragma mark -UI

- (UIView *)backViewss{
    if (!_backViewss) {
        _backViewss = [[UIView alloc] initWithFrame:CGRectMake(10, 12, DeviceSize.width - 20, 45)];
        _backViewss.backgroundColor = [UIColor whiteColor];
        _backViewss.layer.masksToBounds = YES;
        _backViewss.layer.cornerRadius = 5;
        _backViewss.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _backViewss.layer.borderWidth = 0.5;
    }
    return _backViewss;
}
- (UITextField *)txtNameInput{
    if (!_txtNameInput) {
        _txtNameInput = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.backViewss.width -20, 45)];
        
        //是否纠错
        _txtNameInput.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtNameInput.font = [UIFont systemFontOfSize:15];
        _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请设置收费金额" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        _txtNameInput.backgroundColor = [UIColor whiteColor];
        
    }
    return _txtNameInput;
}

- (UIButton *)btnSubmit{
    if (!_btnSubmit) {
        _btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSubmit.layer.masksToBounds = YES;
        _btnSubmit.layer.cornerRadius = 5;
        _btnSubmit.backgroundColor = AppDefaultColor;
        [_btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
        _btnSubmit.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnSubmit setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        [_btnSubmit addTarget:self action:@selector(btnSubmitAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnSubmit;
}

- (void)btnSubmitAction{

    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr removeAllObjects];
    for (UIButton *btn in self.viewBack.subviews) {
        NSInteger tags = btn.tag -2008;
        
        if (btn.selected) {
            if (tags == 9) {
                [arr addObject:@"周一上午"];
            }else if (tags == 17){
                [arr addObject:@"周一下午"];
            }else if (tags == 10){
                [arr addObject:@"周二上午"];
            }else if (tags == 18){
                [arr addObject:@"周二下午"];
            }else if (tags == 11){
                [arr addObject:@"周三上午"];
            }else if (tags == 19){
                [arr addObject:@"周三下午"];
            }else if (tags == 12){
                [arr addObject:@"周四上午"];
            }else if (tags == 20){
                [arr addObject:@"周四下午"];
            }else if (tags == 13){
                [arr addObject:@"周五上午"];
            }else if (tags == 21){
                [arr addObject:@"周五下午"];
            }else if (tags == 14){
                [arr addObject:@"周六上午"];
            }else if (tags == 22){
                [arr addObject:@"周六下午"];
            }else if (tags == 15){
                [arr addObject:@"周日上午"];
            }else if (tags == 23){
                [arr addObject:@"周日下午"];
            }
        }
    }
    
    if (self.outpatientAppontBlcok) {
        self.outpatientAppontBlcok([NSArray arrayWithArray:arr],self.txtNameInput.text);
    }
    
}

//赋值
- (CGFloat)confingWithModelWeeks:(NSString *)week Price:(NSString *)price{
    [self customWeekView:[week componentsSeparatedByString:@","]];
    self.backViewss.top = self.viewBack.bottom +10;
    self.btnSubmit.frame = CGRectMake(10, self.backViewss.bottom +25, DeviceSize.width -20, 45);
    self.txtNameInput.text = price;
    NSLog(@"钱呢%@",price);
    return self.btnSubmit.bottom +10;
}


- (void)customWeekView:(NSArray *)array{
    CGFloat f = (self.viewBack.width -0.5)/8 +0.5;
    CGFloat hf = f/3*3.5;
    NSArray *arr = @[@"",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日",];
    for (int i =0; i<24; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0 +(f -0.5)* (i%8), 0 + (hf -0.5)*(i/8), f, hf);
        
        btn.backgroundColor = [UIColor colorWithHEX:0xffffff];
        btn.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor colorWithHEX:0x333333] forState:UIControlStateNormal];
        [self.viewBack addSubview:btn];
        self.viewBack.height = btn.bottom;
        
        
        if (i <8) {
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            btn.selected = NO;
        }else if (i == 8){
            [btn setTitle:@"上午" forState:UIControlStateNormal];
        }else if (i == 16){
            [btn setTitle:@"下午" forState:UIControlStateNormal];
            
        }else if(i ==9){
            
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周一上午"]) {
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==10){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周二上午"]) {
                    
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==11){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周三上午"]) {
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==12){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周四上午"]) {
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==13){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
             [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周五上午"]) {
                   btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==14){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周六上午"]) {
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==15){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周日上午"]) {
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==17){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周一下午"]) {
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==18){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周二下午"]) {
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==19){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周三下午"]) {
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==20){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周四下午"]) {
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==21){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周五下午"]) {
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==22){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周六下午"]) {
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==23){
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"我的-预约设置_选中"] forState:UIControlStateSelected];
            for (NSString *str in array) {
                if ([str isEqualToString:@"周日下午"]) {
                    btn.selected = YES;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
        }
        
        
    }
}

- (void)btnAction:(UIButton *)button{
    if (button.selected) {
        button.selected = NO;
    }else {
        button.selected = YES;
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
