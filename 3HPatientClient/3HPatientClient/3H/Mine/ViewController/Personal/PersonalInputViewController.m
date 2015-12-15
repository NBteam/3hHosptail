//
//  PersonalInputViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PersonalInputViewController.h"

@interface PersonalInputViewController ()
//背景
@property (nonatomic, strong) UIView *backView;
//
@property (nonatomic, strong) UITextField *txtNameInput;
//保存
@property (nonatomic, strong) UIButton *btnSave;

@end

@implementation PersonalInputViewController

- (void)loadView{
    [super loadView];
    self.view = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.backView];
    [self.view addSubview:self.txtNameInput];
    [self.view addSubview:self.btnSave];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -UI

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(12, 12, DeviceSize.width - 24, 45)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 5;
        _backView.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _backView.layer.borderWidth = 0.5;
    }
    return _backView;
}
- (UITextField *)txtNameInput{
    if (!_txtNameInput) {
        _txtNameInput = [[UITextField alloc] initWithFrame:CGRectMake(24, 12 +2.5, DeviceSize.width -30 -24, 40)];
        
        //是否纠错
        _txtNameInput.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtNameInput.font = [UIFont systemFontOfSize:15];
        
        
        //index 0 == 用户名 1 == 姓名  2 == 通讯地址  3 == 电话  4 == 身份证号
        
        if (self.index == 0) {
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"您的用户名" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if (self.index == 1){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"您的姓名" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if (self.index == 2){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"您的通讯地址" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if (self.index == 3){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"您的电话" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else{
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"您的身份证号" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }
        
        if (self.string.length) {
            _txtNameInput.text = self.string;
        }else{
            
        }
        
        _txtNameInput.backgroundColor = [UIColor whiteColor];
        
    }
    return _txtNameInput;
}

- (UIButton *)btnSave{
    if (!_btnSave) {
        _btnSave = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSave.frame = CGRectMake(12, DeviceSize.height - self.frameTopHeight -60, DeviceSize.width - 24, 45);
        [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSave.titleLabel.font = [UIFont systemFontOfSize:17];
        [_btnSave setTitle:@"保存" forState:UIControlStateNormal];
        _btnSave.layer.masksToBounds = YES;
        _btnSave.layer.cornerRadius = 5;
        _btnSave.backgroundColor = AppDefaultColor;
        
        [_btnSave addTarget:self action:@selector(btnSaveAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSave;
}

- (void)btnSaveAction{
    if (self.nameBlock) {
        self.nameBlock(self.txtNameInput.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSString *)title{
    return @"完善资料";
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
