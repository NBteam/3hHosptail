//
//  MedicationAddInputViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/17.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MedicationAddInputViewController.h"

@interface MedicationAddInputViewController ()
//背景
@property (nonatomic, strong) UIView *backView;
//
@property (nonatomic, strong) UITextField *txtNameInput;
//保存
@property (nonatomic, strong) UIButton *btnSave;

@end

@implementation MedicationAddInputViewController

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
        if (self.index == 0) {
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入首次接待日期" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 1){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入姓名" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 2){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入性别" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 3){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入出生日期" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 4){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入婚姻状况" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 5){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入生育状况" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 6){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入身高" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 7){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入体重" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 8){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入血糖" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 9){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入血压" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 10){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入职业" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 11){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 12){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入邮箱" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 13){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入微信" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 14){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入QQ" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 15){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入邮寄地址" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 16){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入个人兴趣" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 17){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入花粉过敏" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 18){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入喜爱鲜花" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 19){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入吸烟状况" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 20){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入饮食习惯" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 21){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入家族史" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 22){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入既往史" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 23){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入外科手术史" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 24){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入过敏史" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 25){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入重大疾病" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 26){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入最近健康状况" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        }else if(self.index == 27){
            _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入子女个数" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
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
    if (self.infoBlock) {
        self.infoBlock(self.txtNameInput.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSString *)title{
    return @"完善信息";
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
