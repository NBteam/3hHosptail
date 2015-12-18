//
//  ShopDetailBuyViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShopDetailBuyViewController.h"
#import "ShopDetailBuyHeadTableViewCell.h"
#import "ShopDetailBuyDescTableViewCell.h"
#import "ShopDetailBuyPayTableViewCell.h"
#import "AddAddressViewController.h"

@interface ShopDetailBuyViewController ()

@property (nonatomic, strong) UIButton *btnPay;
@end

@implementation ShopDetailBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
  
    self.tableView.height = self.tableView.height -65;
    [self.view addSubview:self.btnPay];
    
    
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UI
- (UIButton *)btnPay{
    if (!_btnPay) {
        _btnPay = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPay.frame = CGRectMake(10, DeviceSize.height -self.frameTopHeight -45 -10, DeviceSize.width -20, 45);
        _btnPay.layer.masksToBounds = YES;
        _btnPay.layer.cornerRadius = 5;
        _btnPay.backgroundColor = AppDefaultColor;
        [_btnPay setTitle:@"确认并支付" forState:UIControlStateNormal];
        _btnPay.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnPay setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        [_btnPay addTarget:self action:@selector(btnPayAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnPay;
}

- (void)btnPayAction{
    //  [(AppDelegate*)[UIApplication sharedApplication].delegate setWindowRootViewControllerIsLogin];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"ShopDetailBuyHeadTableViewCell";
        ShopDetailBuyHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ShopDetailBuyHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell confingWithModel:nil];
        return cell;
    }else if (indexPath.section == 1){
        static NSString *identifier = @"ShopDetailBuyDescTableViewCell";
        ShopDetailBuyDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ShopDetailBuyDescTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:nil];
        return cell;
    }else{
        static NSString *identifier = @"ShopDetailBuyPayTableViewCell";
        ShopDetailBuyPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ShopDetailBuyPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // [cell confingWithModel:nil];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 45;
    }else if(indexPath.section ==1){
        return 130;
    }else{
        return 125;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddAddressViewController * AddAddressVc = [[AddAddressViewController alloc]init];
    [self.navigationController pushViewController:AddAddressVc animated:YES];
}

- (NSString *)title{
    return @"确认订单";
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
