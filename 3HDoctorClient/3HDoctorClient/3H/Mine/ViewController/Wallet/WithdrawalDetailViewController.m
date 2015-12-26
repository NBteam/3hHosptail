//
//  WithdrawalDetailViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/26.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "WithdrawalDetailViewController.h"
#import "AddCardsResultViewController.h"

@interface WithdrawalDetailViewController ()


@property (nonatomic, strong) UIView *viewCard;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIView *viewPrice;

@property (nonatomic, strong) UILabel *labName;

@property (nonatomic, strong) UITextField *txtField;

@end

@implementation WithdrawalDetailViewController

- (void)loadView{
    [super loadView];
    self.view = [[TPKeyboardAvoidingScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.viewCard];
    [self.viewCard addSubview:self.labTitle];
    [self.view addSubview:self.viewPrice];
    [self.viewPrice addSubview:self.labName];
    [self.viewPrice addSubview:self.txtField];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"下一步"];
    

}

- (void)rightAction{
    AddCardsResultViewController *addCardsResultVc = [[AddCardsResultViewController alloc] init];
    addCardsResultVc.index = 1;
    [self.navigationController pushViewController:addCardsResultVc animated:YES];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)viewCard{
    if (!_viewCard) {
        _viewCard = [[UIView alloc] initWithFrame:CGRectMake(0, 10, DeviceSize.width +1, 45)];
        _viewCard.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewCard.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _viewCard.layer.borderWidth = 0.5;
    }
    return _viewCard;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width -20, 45)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.attributedText = self.string;
    }
    
    return _labTitle;
}

- (UIView *)viewPrice{
    if (!_viewPrice) {
        _viewPrice = [[UIView alloc] initWithFrame:CGRectMake(0, self.viewCard.bottom +10, DeviceSize.width +1, 45)];
        _viewPrice.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewPrice.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _viewPrice.layer.borderWidth = 0.5;
    }
    return _viewPrice;
}

- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 40, 45)];
        _labName.font = [UIFont systemFontOfSize:15];
        _labName.textColor = [UIColor colorWithHEX:0x333333];
        _labName.text = @"金额";
        
    }
    
    return _labName;
}

- (UITextField *)txtField{
    if (!_txtField) {
        _txtField = [[UITextField alloc] initWithFrame:CGRectMake(self.labName.right, 0, DeviceSize.width -60, 45)];
        _txtField.textColor = [UIColor colorWithHEX:0x333333];
        _txtField.font = [UIFont systemFontOfSize:15];
        //是否纠错
        _txtField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _txtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请填写提现金额" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
    }
    return _txtField;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title{
    return @"提现";
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
