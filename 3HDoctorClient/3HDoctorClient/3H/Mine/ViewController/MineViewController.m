//
//  MineViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeadTableViewCell.h"
#import "MineTableViewCell.h"
//个人资料
#import "PersonalViewController.h"
//我的钱包
#import "WalletViewController.h"
//设置
#import "SetUpViewController.h"
//邀请
#import "InvitationViewController.h"
//预约设置
#import "AppointViewController.h"

@interface MineViewController ()
@property (nonatomic, retain) NSDictionary * dict;
@end

@implementation MineViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadHomeInfo" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dict = [NSDictionary dictionary];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    [self getNetWorkInfo];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNetWorkInfo) name:@"reloadHomeInfo" object:nil];
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"img":@"3H-我的_我的钱包-未点击",@"title":@"我的钱包"},@{@"img":@"3H-我的_预约设置-未点击",@"title":@"预约设置"},@{@"img":@"3H-我的_邀请同行-未点击",@"title":@"邀请同行"},@{@"img":@"3H-我的_设置-未点击",@"title":@"设置"}]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"idertifier";
        MineHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[MineHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dict];
        return cell;
    }else{
        static NSString *identifier = @"idertifier";
        MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dataArray[indexPath.row]];
        return cell;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 45;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PersonalViewController *personalVc = [[PersonalViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        personalVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:personalVc animated:YES];
        
    }else{
        if (indexPath.row == 0) {
            WalletViewController *wallVc = [[WalletViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            wallVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wallVc animated:YES];
        }else if(indexPath.row ==1){
            AppointViewController *appointVc = [[AppointViewController alloc] init];
            appointVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:appointVc animated:YES];
        }else if(indexPath.row ==2){
            InvitationViewController *invitationVc = [[InvitationViewController alloc] init];
            invitationVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:invitationVc animated:YES];
            
        }else{
            SetUpViewController *setUpVc = [[SetUpViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            setUpVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setUpVc animated:YES];
        }
    }
}
- (void)getNetWorkInfo{
    [self showHudAuto:WaitPrompt];
    WeakSelf(MineViewController);
    [[THNetWorkManager shareNetWork]getUserInfoCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            weakSelf.dict = response.dataDic;
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"1"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"1"];
    }];
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
