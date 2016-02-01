//
//  ShopDetailBuyViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//
extern NSInteger payIndex;
#import "ShopDetailBuyViewController.h"
#import "ShopDetailBuyHeadTableViewCell.h"
#import "ShopDetailBuyDescTableViewCell.h"
#import "ShopDetailBuyPayTableViewCell.h"
#import "AddressAddViewController.h"
#import "AddressListViewController.h"
#import "ShopInfoModel.h"
#import "AppDelegate.h"
#import "CartListModel.h"
#import "ShopBuyFinishViewController.h"

@interface ShopDetailBuyViewController ()

@property (nonatomic, strong) UIButton *btnPay;
@property (nonatomic, strong) AddressListModel *model;
@property (nonatomic, strong) ShopInfoModel *shopModel;
@property (nonatomic, copy) NSString * priceStr;
@end

@implementation ShopDetailBuyViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"BuySuccess" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    payIndex = 2;
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.shopModel.indexStr = self.indexStr;
    self.tableView.height = self.tableView.height -65;
    [self.view addSubview:self.btnPay];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(BuySuccessAction) name:@"BuySuccess" object:nil];
    if (self.type == 0) {
        [self getNetWork];
    }else{
        
    }
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
    if (self.type == 0) {
        [self getUploadNetWork];
    }else{
        [self getUploadTypeNetWork];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == 0) {
        if (indexPath.section == 0) {
            static NSString *identifier = @"ShopDetailBuyHeadTableViewCell";
            ShopDetailBuyHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[ShopDetailBuyHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configWithModel:self.model];
            return cell;
        }else if (indexPath.section == 1){
            static NSString *identifier = @"ShopDetailBuyDescTableViewCell";
            ShopDetailBuyDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[ShopDetailBuyDescTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell confingWithModel:self.shopModel];
            return cell;
        }else{
            static NSString *identifier = @"ShopDetailBuyPayTableViewCell";
            ShopDetailBuyPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[ShopDetailBuyPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configWithModel:self.shopModel];
            return cell;
        }
    }else{
        if (indexPath.section == 0) {
            static NSString *identifier = @"ShopDetailBuyHeadTableViewCell";
            ShopDetailBuyHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[ShopDetailBuyHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configWithModel:self.model];
            return cell;
        }else if (indexPath.section == self.infoArray.count+1){
            static NSString *identifier = @"ShopDetailBuyPayTableViewCell";
            ShopDetailBuyPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[ShopDetailBuyPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell configWithModel:self.infoArray];
            return cell;
        }else{
            static NSString *identifier = @"ShopDetailBuyDescTableViewCell";
            ShopDetailBuyDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[ShopDetailBuyDescTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CartListModel * model = self.infoArray[indexPath.section - 1];
            [cell confingWithModel:model];
            return cell;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.type == 0) {
        return 3;
    }else{
        return self.infoArray.count + 2;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 0 ) {
        if (indexPath.section == 0) {
            return 45;
        }else if(indexPath.section ==1){
            return 130;
        }else{
            return 125;
        }
    }else{
        if (indexPath.section == 0) {
            return 45;
        }else if(indexPath.section == self.infoArray.count + 1){
            return 125;
        }else{
            return 130;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressListViewController *  AddressListVc = [[AddressListViewController alloc]init];
    WeakSelf(ShopDetailBuyViewController);
    [AddressListVc setPlaceBlock:^(AddressListModel *model) {
        weakSelf.model = model;
        [weakSelf.tableView reloadData];
    }];
    [self.navigationController pushViewController:AddressListVc animated:YES];
//    AddressAddViewController * AddAddressVc = [[AddressAddViewController alloc]init];
//    [self.navigationController pushViewController:AddAddressVc animated:YES];
}
- (void)getNetWork{
    WeakSelf(ShopDetailBuyViewController);
    [[THNetWorkManager shareNetWork]getBuyGoodsId:self.id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            ShopInfoModel * model = [response thParseDataFromDic:response.dataDic andModel:[ShopInfoModel class]];
            weakSelf.shopModel = model;
            weakSelf.shopModel.indexStr = weakSelf.indexStr;
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];

    }];
}
- (void)getUploadNetWork{
    if (!self.model.area_ids) {
        [self showHudAuto:@"请选择收货地址" andDuration:@"2"];
    }else{
        AppDelegate * app = [UIApplication sharedApplication].delegate;
        WeakSelf(ShopDetailBuyViewController);
        [[THNetWorkManager shareNetWork]getBuyGoodsPostId:self.id qty:self.indexStr address_id:self.model.id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
            [weakSelf removeMBProgressHudInManaual];
            if (response.responseCode == 1) {
                weakSelf.priceStr = response.dataDic[@"total"] ;
                [app sendPay_demoName:weakSelf.shopModel.name price:response.dataDic[@"total"] desc:@"desc" order_sn:response.dataDic[@"order_sn"]];
            }else{
                [weakSelf showHudAuto:response.message andDuration:@"2"];
            }
        } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
            [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        }];
    }
}
- (void)getUploadTypeNetWork{
    if (!self.model.area_ids) {
        [self showHudAuto:@"请选择收货地址" andDuration:@"2"];
    }else{
        NSMutableArray * array = [NSMutableArray array];
        for (CartListModel * model  in self.infoArray) {
            [array addObject:model.id];
        }
        AppDelegate * app = [UIApplication sharedApplication].delegate;
        WeakSelf(ShopDetailBuyViewController);
        [[THNetWorkManager shareNetWork]getCartPostAddress_id:self.model.id cart_ids:[array componentsJoinedByString:@","] andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
            [weakSelf removeMBProgressHudInManaual];
            if (response.responseCode == 1) {
                weakSelf.priceStr = response.dataDic[@"total"] ;
                [app sendPay_demoName:@"3H商城" price:response.dataDic[@"total"] desc:@"desc" order_sn:response.dataDic[@"order_sn"]];
            }else{
                [weakSelf showHudAuto:response.message andDuration:@"2"];
            }
        } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
            [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        }];
    }
}
- (void)BuySuccessAction{
    ShopBuyFinishViewController * shopBuyFinishVc = [[ShopBuyFinishViewController alloc]init];
    shopBuyFinishVc.priceStr = self.priceStr;
    [self.navigationController pushViewController:shopBuyFinishVc animated:YES];
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
