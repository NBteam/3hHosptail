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
#import "WithdrawaListModel.h"
@interface WithdrawalViewController ()

@property (nonatomic, strong) UIButton *btnAddCard;

@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.isOpenFooterRefresh = YES;
    self.isOpenHeaderRefresh = YES;
    [self getNetWork];
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
    WithdrawaListModel * model = self.dataArray[indexPath.section];
    [cell confingWithModel:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WithdrawalTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    WithdrawalDetailViewController *withdrawalDetailVc = [[WithdrawalDetailViewController alloc] init];
    WithdrawaListModel * model = self.dataArray[indexPath.section];
    withdrawalDetailVc.string = cell.labTitle.attributedText;
    withdrawalDetailVc.id = model.id;
    [self.navigationController pushViewController:withdrawalDetailVc animated:YES];
    
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(WithdrawalViewController);
    [[THNetWorkManager shareNetWork]myBankCardListCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (weakSelf.pageNO == 1) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                WithdrawaListModel * model = [response thParseDataFromDic:dict andModel:[WithdrawaListModel class]];
                [weakSelf.dataArray addObject:model];
            }
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"1"];
        }
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        //  重新加载数据
        [weakSelf.tableView reloadData];
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"1"];
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
#pragma mark 提交编辑操作时会调用这个方法(删除，添加)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 删除操作
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 1.删除数据
        [self deleteCellIndexPath:indexPath];
    }
}
- (void)deleteCellIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(WithdrawalViewController);
    [weakSelf showHudWaitingView:WaitPrompt];
    WithdrawaListModel * model = self.dataArray[indexPath.section];
    [[THNetWorkManager shareNetWork]delteBankCardId:model.id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            
            [weakSelf.dataArray removeObjectAtIndex:indexPath.section];
            [weakSelf.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            [weakSelf.tableView reloadData];
            
        } else {
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
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
