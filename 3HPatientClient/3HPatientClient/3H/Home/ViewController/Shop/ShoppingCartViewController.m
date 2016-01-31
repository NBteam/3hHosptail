//
//  ShoppingCartViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/27.
//  Copyright © 2015年 fyq. All rights reserved.
//
BOOL edit;
#import "ShoppingCartViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "ShoppingCartToolView.h"
#import "CartListModel.h"
#import "ShopDetailBuyViewController.h"

@interface ShoppingCartViewController ()

@property (nonatomic, strong) ShoppingCartToolView *toolView;

@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, assign) double sum;
@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sum = 0;
    edit = NO;
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.height = self.tableView.height - 50;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
    [self.view addSubview:self.toolView];
    self.isOpenFooterRefresh = YES;
    self.isOpenHeaderRefresh = YES;
    [self getNetWork];
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_rightButton setTitle:@"完成" forState:UIControlStateSelected];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightButton setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.frame = CGRectMake(0, 0, 30, 16);
    }
    return _rightButton;
}

- (void)rightButtonAction:(UIButton *)btn{
    if (btn.selected) {
        edit = NO;
        btn.selected = NO;
        [self.toolView.btnSubmit setTitle:@"去结算" forState:UIControlStateNormal];
    }else{
        edit = YES;
        btn.selected = YES;
        [self.toolView.btnSubmit setTitle:@"删除" forState:UIControlStateNormal];
    }
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (ShoppingCartToolView *)toolView{
    if (!_toolView) {
        _toolView = [[ShoppingCartToolView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, DeviceSize.width, 50)];
        _toolView.backgroundColor = [UIColor colorWithHEX:0xffffff];
        WeakSelf(ShoppingCartViewController);
        [_toolView setBtnSelectBlock:^{
            double subTotal = 0;
            for (int i = 0; i< weakSelf.dataArray.count; i++) {
                CartListModel * model = weakSelf.dataArray[i];
                model.choice = YES;
                subTotal += [model.price doubleValue]*[model.qty doubleValue];
                weakSelf.sum = subTotal;
            }
            weakSelf.toolView.labTitle.text = [NSString stringWithFormat:@"总计:%.2f元",weakSelf.sum];
            [weakSelf.tableView reloadData];
        }];
        [_toolView setBtnSubmitBlock:^{
            if (edit) {
                NSMutableArray * array = [NSMutableArray array];
                for (int i = 0; i< weakSelf.dataArray.count; i++) {
                    CartListModel * model = weakSelf.dataArray[i];
                    if (model.choice ) {
                        [array addObject:model.id];
                    }
                }
                [weakSelf removeCartCidsNetWork:[array componentsJoinedByString:@","]];
            }else{
                ShopDetailBuyViewController * ShopDetailBuyVc = [[ShopDetailBuyViewController alloc]initWithTableViewStyle:UITableViewStyleGrouped];
                ShopDetailBuyVc.type = 1;
                ShopDetailBuyVc.infoArray = [NSMutableArray array];
                for (CartListModel * model in weakSelf.dataArray) {
                    if (model.choice) {
                        [ShopDetailBuyVc.infoArray addObject:model];
                    }
                }
                if (ShopDetailBuyVc.infoArray.count != 0) {
                    [weakSelf.navigationController pushViewController:ShopDetailBuyVc animated:YES];
                }else{
                    [weakSelf showHudAuto:@"请选择商品" andDuration:@"2"];
                }
            }
        }];
    }
    return _toolView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ShoppingCartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CartListModel * model = self.dataArray[indexPath.section];
    WeakSelf(ShoppingCartViewController);
    [cell setAddCartNum:^{
        double subTotal = 0;
        for (CartListModel * newModel in weakSelf.dataArray) {
            if (newModel.choice) {
                subTotal += [newModel.price doubleValue]*[newModel.qty doubleValue];
            }
            weakSelf.sum = subTotal;
        }
        weakSelf.toolView.labTitle.text = [NSString stringWithFormat:@"总计:%.2f元",subTotal];
        CartListModel * model1 = weakSelf.dataArray[indexPath.section];
        [weakSelf addCarNetWork:model1.goods_id];
    }];
    [cell setDecreaseCartNum:^{
        double subTotal = 0;
        for (CartListModel * newModel in weakSelf.dataArray) {
            if (newModel.choice) {
                subTotal += [newModel.price doubleValue]*[newModel.qty doubleValue];
            }
            weakSelf.sum = subTotal;
        }
        weakSelf.toolView.labTitle.text = [NSString stringWithFormat:@"总计:%.2f元",subTotal];
        CartListModel * model2 = weakSelf.dataArray[indexPath.section];
        [weakSelf decreaseCartNumNetWork:model2.goods_id];
    }];
    [cell setBtnSelectBlock:^(BOOL choise){
        CartListModel * model3 = weakSelf.dataArray[indexPath.section];
        model3.choice = choise;
        double subTotal = 0;
        for (CartListModel * newModel in weakSelf.dataArray) {
            if (newModel.choice) {
                subTotal += [newModel.price doubleValue]*[newModel.qty doubleValue];
            }
            weakSelf.sum = subTotal;
        }
        weakSelf.toolView.labTitle.text = [NSString stringWithFormat:@"总计:%.2f元",subTotal];
    }];
    [cell confingWithModel:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ShoppingCartViewController);
    [[THNetWorkManager shareNetWork]getCartListCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dic in response.dataDic[@"list"]) {
                CartListModel * model = [response thParseDataFromDic:dic andModel:[CartListModel class]];
                model.choice = NO;
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
            //  结束头部刷新
            [weakSelf.tableView.header endRefreshing];
            //  结束尾部刷新
            [weakSelf.tableView.footer endRefreshing];
        }else{
            //  结束头部刷新
            [weakSelf.tableView.header endRefreshing];
            //  结束尾部刷新
            [weakSelf.tableView.footer endRefreshing];
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    [self getNetWork];
}
- (void)footerRequestWithData
{
    [self getNetWork];
}
#pragma mark ---- 加
- (void)addCarNetWork:(NSString *)id{
    WeakSelf(ShoppingCartViewController);
    [[THNetWorkManager shareNetWork]addCartNumGoods_id:id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
#pragma mark ---- 减
- (void)decreaseCartNumNetWork:(NSString *)id{
    WeakSelf(ShoppingCartViewController);
    [[THNetWorkManager shareNetWork]decreaseCartNumGoods_id:id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (void)removeCartCidsNetWork:(NSString *)id{
    WeakSelf(ShoppingCartViewController);
    [[THNetWorkManager shareNetWork]removeCartCids:id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            weakSelf.toolView.labTitle.text = [NSString stringWithFormat:@"总计:0元"];
            [weakSelf getNetWork];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (void)butShopInfoNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ShoppingCartViewController);
    [[THNetWorkManager shareNetWork]getCartPostAddress_id:@"" cart_ids:@"" andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}

- (NSString *)title{
    return @"购物车";
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
