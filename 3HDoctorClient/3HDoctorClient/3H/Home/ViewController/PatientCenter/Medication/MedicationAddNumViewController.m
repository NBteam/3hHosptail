//
//  MedicationAddNumViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/17.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MedicationAddNumViewController.h"

@interface MedicationAddNumViewController ()
//日期
@property (nonatomic, strong) UILabel *labTitle;
//上个月
@property (nonatomic, strong) UIButton *btnUp;
//下个月
@property (nonatomic, strong) UIButton *btnDown;

@property (nonatomic, strong) UIView *viewBack;

@property (nonatomic, strong) UIView *viewNum;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger num;

@property (nonatomic, strong) UIButton *btnCancel;
@end

@implementation MedicationAddNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //默认用药次数为3次
    self.num = 3;
    self.dataArray = [NSMutableArray arrayWithArray:@[@"6:00",@"7:00",@"8:00",@"9:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00"]];
    [self.view addSubview:self.viewBack];
    [self.viewBack addSubview:self.btnDown];
    [self.viewBack addSubview:self.labTitle];
    [self.viewBack addSubview:self.btnUp];
    [self.view addSubview:self.viewNum];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self customButtons];
    [self.view addSubview:self.btnCancel];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 10, DeviceSize.width, 35)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewBack.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _viewBack.layer.borderWidth = 0.5;
    }
    return _viewBack;
}
- (UIButton *)btnUp{
    if (!_btnUp) {
        _btnUp = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnUp setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_左"] forState:UIControlStateNormal];
        _btnUp.frame = CGRectMake(0, 0, 50, 35);
        [_btnUp addTarget:self action:@selector(btnUpAction) forControlEvents:UIControlEventTouchUpInside];
        _btnUp.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
        _btnUp.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _btnUp.layer.borderWidth = 0.5;
    }
    return _btnUp;
}

- (void)btnUpAction{
    if (self.num >1) {
        self.num -- ;
        self.labTitle.text = [NSString stringWithFormat:@"设置用药次数 %li次",self.num];
        for (UIButton *btn in self.viewNum.subviews) {
            if ([btn isKindOfClass:[UIButton class]]) {
                if (btn.selected) {
                    btn.selected = NO;
                }
            }
        }
    }
}

- (UIButton *)btnDown{
    if (!_btnDown) {
        _btnDown = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDown setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_右"] forState:UIControlStateNormal];
        _btnDown.frame = CGRectMake(self.labTitle.right-0.5 ,0, 50, 35);
        [_btnDown addTarget:self action:@selector(btnDownAction) forControlEvents:UIControlEventTouchUpInside];
        _btnDown.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
        _btnDown.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _btnDown.layer.borderWidth = 0.5;
        
    }
    return _btnDown;
}

- (void)btnDownAction{
    if (self.num <4) {
        self.num ++ ;
        self.labTitle.text = [NSString stringWithFormat:@"设置用药次数 %li次",self.num];
        
        for (UIButton *btn in self.viewNum.subviews) {
            if ([btn isKindOfClass:[UIButton class]]) {
                if (btn.selected) {
                    btn.selected = NO;
                }
            }
        }
    }
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.btnUp.right -0.5, 0, DeviceSize.width -100 +1, 35)];
        _labTitle.textColor = AppDefaultColor;
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = [NSString stringWithFormat:@"设置用药次数 %li次",self.num];
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _labTitle.layer.borderWidth = 0.5;
    }
    return _labTitle;
}

- (UIView *)viewNum{
    if (!_viewNum) {
        _viewNum = [[UIView alloc] initWithFrame:CGRectMake(0, self.viewBack.bottom +10, DeviceSize.width, 0)];
        _viewNum.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewNum.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _viewNum.layer.borderWidth = 0.5;
        
    }
    return _viewNum;
}

- (void)customButtons{
    

    CGFloat f = DeviceSize.width/self.num;
    for (int i = 0; i<self.dataArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0 +f*(i%3), 0 +35*(i/3), f, 35);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:self.dataArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHEX:0x333333] forState:UIControlStateNormal];
        [btn setTitleColor:AppDefaultColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.viewNum addSubview:btn];
        self.viewNum.height = btn.bottom;
    }
    
}

- (void)btnAction:(UIButton *)button{
    NSInteger nums = 0;
    
    for (UIButton *btn in self.viewNum.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.selected) {
                nums ++;
            }
        }
    }
    if (nums<self.num) {
        if (button.selected) {
            button.selected = NO;
        }else{
            button.selected = YES;
        }
    }else{
       [self showHudAuto:[NSString stringWithFormat:@"您只能设置 %li个用药时间",self.num] andDuration:@"2"];
    }
}

#pragma mark -UI
- (UIButton *)btnCancel{
    if (!_btnCancel) {
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCancel.frame = CGRectMake(10, DeviceSize.height -self.frameTopHeight -45 -10, DeviceSize.width -20, 45);
        _btnCancel.layer.masksToBounds = YES;
        _btnCancel.layer.cornerRadius = 5;
        _btnCancel.backgroundColor = AppDefaultColor;
        [_btnCancel setTitle:@"确定" forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnCancel setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        [_btnCancel addTarget:self action:@selector(btnCancelAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnCancel;
}

- (void)btnCancelAction{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    if (self.medicationAddNumBlock) {
        for (UIButton *btn in self.viewNum.subviews) {
            if ([btn isKindOfClass:[UIButton class]]) {
                if (btn.selected) {
                    [arr addObject:btn.titleLabel.text];
                }
            }
        }
        
        if (arr.count == self.num) {
            NSString *str = [arr componentsJoinedByString:@"、"];
            self.medicationAddNumBlock([NSString stringWithFormat:@"一天%li次 (%@)",arr.count,str]);
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showHudAuto:[NSString stringWithFormat:@"您需要设置 %li个用药时间",self.num] andDuration:@"2"];
        }
    }
}

- (NSString *)title{
    return @"用药次数";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
