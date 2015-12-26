//
//  WithdrawalViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "WithdrawalViewController.h"
#import "WithdrawalTableViewCell.h"
//添加银行卡
#import "AddCardsViewController.h"
//提现
#import "WithdrawalDetailViewController.h"
@interface WithdrawalViewController ()

@property (nonatomic, strong) UIButton *btnAddCard;

@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    
    self.tableView.height = self.tableView.height - 65;
    [self.view addSubview:self.btnAddCard];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UI
- (UIButton *)btnAddCard{
    if (!_btnAddCard) {
        _btnAddCard = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAddCard.frame = CGRectMake(10, self.tableView.bottom, DeviceSize.width -20, 45);
        _btnAddCard.layer.masksToBounds = YES;
        _btnAddCard.layer.cornerRadius = 5;
        _btnAddCard.backgroundColor = self.view.backgroundColor;
        [_btnAddCard setTitle:@"+添加银行卡" forState:UIControlStateNormal];
        _btnAddCard.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnAddCard setTitleColor:AppDefaultColor forState:UIControlStateNormal];
        [_btnAddCard addTarget:self action:@selector(btnAddCardAction) forControlEvents:UIControlEventTouchUpInside];
        
        _btnAddCard.layer.borderColor = AppDefaultColor.CGColor;
        _btnAddCard.layer.borderWidth = 1;
        
    }
    return _btnAddCard;
}

- (void)btnAddCardAction{
    WeakSelf(WithdrawalViewController);
    AddCardsViewController *addCardsVc = [[AddCardsViewController alloc] init];
    [addCardsVc setReloadBlock:^{
        [weakSelf.tableView reloadData];
    }];
    [self.navigationController pushViewController:addCardsVc animated:YES];
}

- (NSString *)title{
    return @"提现";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"WalletHeadTableViewCell";
    WithdrawalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[WithdrawalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WithdrawalTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    WithdrawalDetailViewController *withdrawalDetailVc = [[WithdrawalDetailViewController alloc] init];
    
    withdrawalDetailVc.string = cell.labTitle.attributedText;
    [self.navigationController pushViewController:withdrawalDetailVc animated:YES];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
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
