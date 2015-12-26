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
    [self.contentView addSubview:self.labDate];
    [self.contentView addSubview:self.viewBack];
    
    [self.contentView addSubview:self.btnSubmit];
//    [self.contentView addSubview:self.backViewss];
//    [self.backViewss addSubview:self.txtNameInput];
 
}

- (UIImageView *)imgLogo{
    if(!_imgLogo){
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, (35 -16)/2, 16, 16)];
        _imgLogo.image = [UIImage imageNamed:@"首页-我要预约-预约挂号-2_预约时间"];
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
- (UILabel *)labDate{
    if (!_labDate) {
        _labDate = [[UILabel alloc]initWithFrame:CGRectMake(10, self.labTitle.bottom, DeviceSize.width -20, 40)];
        _labDate.layer.masksToBounds = YES;
        _labDate.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _labDate.layer.borderWidth = 0.5;
        NSDate *  senddate=[NSDate date];
        
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        _labDate.font = [UIFont systemFontOfSize:15];
        [dateformatter setDateFormat:@"YYYY年MM月dd日"];
        _labDate.textAlignment = NSTextAlignmentCenter;
        NSString *  locationString=[dateformatter stringFromDate:senddate];
        _labDate.text = [NSString stringWithFormat:@"今天：%@",locationString];
        _labDate.textColor = AppDefaultColor;
    }
    return _labDate;
}
- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(10, self.labDate.bottom, DeviceSize.width -20, 0)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewBack.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _viewBack.layer.borderWidth = 0.5;
    }
    return _viewBack;
}

//#pragma mark -UI
//
- (UIView *)backViewss{
    if (!_backViewss) {
        _backViewss = [[UIView alloc] initWithFrame:CGRectMake(10, 12, DeviceSize.width - 20, 45)];
        _backViewss.backgroundColor = [UIColor whiteColor];
//        _backViewss.layer.masksToBounds = YES;
//        _backViewss.layer.cornerRadius = 5;
//        _backViewss.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
//        _backViewss.layer.borderWidth = 0.5;
    }
    return _backViewss;
}
//- (UITextField *)txtNameInput{
//    if (!_txtNameInput) {
//        _txtNameInput = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.backViewss.width -20, 45)];
//        _txtNameInput.textAlignment = NSTextAlignmentCenter;
//        //是否纠错
//        _txtNameInput.autocorrectionType = UITextAutocorrectionTypeNo;
//        _txtNameInput.enabled = NO;
//        _txtNameInput.font = [UIFont systemFontOfSize:15];
//        _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"预约时间是999999" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
//        _txtNameInput.backgroundColor = [UIColor whiteColor];
//        
//    }
//    return _txtNameInput;
//}

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
    NSString *str = @"";
    DoctorsInfoModel * model = [[DoctorsInfoModel alloc]init];
    for (UIButton *btn in self.viewBack.subviews) {
        NSInteger tags = btn.tag -2008;
        if (btn.selected) {
            if (tags == 9) {
                str = @"FORENOON";
                model = self.infoArray[0];
            }else if (tags == 17){
                str = @"AFTERNOON";
                model = self.infoArray[0];
            }else if (tags == 10){
                str = @"FORENOON";
                model = self.infoArray[1];
            }else if (tags == 18){
                str = @"AFTERNOON";
                model = self.infoArray[1];
            }else if (tags == 11){
                str = @"FORENOON";
                model = self.infoArray[2];
            }else if (tags == 19){
                str = @"AFTERNOON";
                model = self.infoArray[2];
            }else if (tags == 12){
                str = @"FORENOON";
                model = self.infoArray[3];
            }else if (tags == 20){
                str = @"AFTERNOON";
                model = self.infoArray[3];
            }else if (tags == 13){
                str = @"FORENOON";
                model = self.infoArray[4];
            }else if (tags == 21){
                str = @"AFTERNOON";
                model = self.infoArray[4];
            }else if (tags == 14){
                str = @"FORENOON";
                model = self.infoArray[5];
            }else if (tags == 22){
                str = @"AFTERNOON";
                model = self.infoArray[5];
            }else if (tags == 15){
                str = @"FORENOON";
                model = self.infoArray[6];
            }else if (tags == 23){
                str = @"AFTERNOON";
                model = self.infoArray[6];
            }
        }
    }
    if (self.outpatientAppontBlcok) {
        self.outpatientAppontBlcok(model,str);
    }
    
}

//赋值
- (CGFloat)confingWithModelWeeks:(NSArray *)week Price:(NSString *)price clickArray:(NSArray *)clickArray{
    self.infoArray = clickArray;
    [self customWeekView:clickArray];
    self.backViewss.top = self.viewBack.bottom +10;
    self.btnSubmit.frame = CGRectMake(10, self.viewBack.bottom +25, DeviceSize.width -20, 45);
    self.txtNameInput.text = price;
    return self.btnSubmit.bottom +10;
}


- (void)customWeekView:(NSArray *)array{
    CGFloat f = (self.viewBack.width -0.5)/8 +0.5;
    CGFloat hf = f/3*3.5;
    NSArray *arr = @[@"",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    if (array.count == 7) {
        DoctorsInfoModel *model0 = array[0];
        DoctorsInfoModel *model1 = array[1];
        DoctorsInfoModel *model2 = array[2];
        DoctorsInfoModel *model3 = array[3];
        DoctorsInfoModel *model4 = array[4];
        DoctorsInfoModel *model5 = array[5];
        DoctorsInfoModel *model6 = array[6];
        arr = @[@"",[NSString stringWithFormat:@"周一\n%@",[model0.date componentsSeparatedByString:@"-"][2]],[NSString stringWithFormat:@"周二\n%@",[model1.date componentsSeparatedByString:@"-"][2]],[NSString stringWithFormat:@"周三\n%@",[model2.date componentsSeparatedByString:@"-"][2]],[NSString stringWithFormat:@"周四\n%@",[model3.date componentsSeparatedByString:@"-"][2]],[NSString stringWithFormat:@"周五\n%@",[model4.date componentsSeparatedByString:@"-"][2]],[NSString stringWithFormat:@"周六\n%@",[model5.date componentsSeparatedByString:@"-"][2]],[NSString stringWithFormat:@"周日\n%@",[model6.date componentsSeparatedByString:@"-"][2]]];
    }
    for (int i =0; i<24; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0 +(f -0.5)* (i%8), 0 + (hf -0.5)*(i/8), f, hf);
        
        btn.backgroundColor = [UIColor colorWithHEX:0xffffff];
        btn.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
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
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count != 0) {
                DoctorsInfoModel *model = array[0];
                if ([model.forenoon_enable doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==10){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[1];
                if ([model.forenoon_enable doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==11){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[2];
                if ([model.forenoon_enable doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==12){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[3];
                if ([model.forenoon_enable doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==13){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[4];
                if ([model.forenoon_enable doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==14){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[5];
                if ([model.forenoon_enable doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==15){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[6];
                if ([model.forenoon_enable doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==17){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[0];
                if ([model.afternoon_enable	 doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==18){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[1];
                if ([model.afternoon_enable	 doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==19){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[2];
                if ([model.afternoon_enable	 doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==20){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[3];
                if ([model.afternoon_enable	 doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==21){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[4];
                if ([model.afternoon_enable	 doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==22){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[5];
                if ([model.afternoon_enable	 doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
            
        }else if(i ==23){
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－未选中"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2－选中"] forState:UIControlStateSelected];
            if (array.count == 7) {
                DoctorsInfoModel *model = array[6];
                if ([model.afternoon_enable	 doubleValue] == 0) {
                    [btn setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_日期-未选中"] forState:UIControlStateNormal];
                    btn.enabled = NO;
                }
            }
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 2008 +i;
        }
    }
}

- (void)btnAction:(UIButton *)button{
    if (button.tag<2025) {
        DoctorsInfoModel *model = self.infoArray[button.tag-2017];
        if ([model.forenoon_enable doubleValue] == 0) {
            if (self.alertBlock) {
                self.alertBlock();
            }
        }else{
            if (button.selected == NO) {
                for (UIButton *btn in self.viewBack.subviews) {
                    btn.selected = NO;
                }
                button.selected = YES ;
            }
        }
    }else{
        DoctorsInfoModel *model = self.infoArray[button.tag-2025];
        if ([model.afternoon_enable doubleValue] == 0) {
            if (self.alertBlock) {
                self.alertBlock();
            }
        }else{
            if (button.selected == NO) {
                for (UIButton *btn in self.viewBack.subviews) {
                    btn.selected = NO;
                }
                button.selected = YES ;
            }
        }
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
