//
//  MineViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewCell.h"
#import "MineHeadView.h"
//个人资料
#import "PersonalViewController.h"
//设置
#import "SetUpViewController.h"
//钱包
#import "WalletViewController.h"
//我的档案
#import "HealthFileViewController.h"
//我的预约
#import "MyAppointmentViewController.h"
//我的订单
#import "AllOrderViewController.h"
//我的收藏
#import "MyCollectionViewController.h"
//收货地址
#import "MyAddressViewController.h"

@interface MineViewController ()
@property (nonatomic, strong) MineHeadView *headView;

@property (nonatomic, strong) UIView *viewBack;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshBaseInfoOperation) name:@"refreshBaseInfoNatification" object:nil];
    [self.view insertSubview:self.viewBack belowSubview:self.tableView];
    self.tableView.height =  self.tableView.height- 49;
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"img":@"3H-我的_我的健康档案-非点击状态",@"title":@"我的健康档案"},@{@"img":@"3H-我的_我的预约-非点击状态",@"title":@"我的预约"},@{@"img":@"3H-我的_我的积分-非点击状态",@"title":@"我的积分"},@{@"img":@"3H-我的_我的钱包-非点击状态",@"title":@"我的钱包"},@{@"img":@"3H-我的_我的订单-非点击状态",@"title":@"我的订单"},@{@"img":@"3H-我的_我的收藏-非点击状态",@"title":@"我的收藏"},@{@"img":@"3H-我的_我的收藏-非点击状态",@"title":@"收货地址"},@{@"img":@"3H-我的_设置-非点击状态",@"title":@"设置"}]];
    //self.tableView.tableHeaderView = self.headView;
}

- (void)refreshBaseInfoOperation{
    self.user = [self refreshUserData];
    [self.headView confingWithName:self.user.nickname Sex:self.user.sex Pic:self.user.pic];
}
#pragma mark - UI

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.width)];
        _viewBack.backgroundColor = AppDefaultColor;
    }
    return _viewBack;
}
- (MineHeadView *)headView{
    if (!_headView) {
        _headView = [[MineHeadView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 120)];
        [_headView confingWithName:self.user.nickname Sex:self.user.sex Pic:self.user.pic];
    }
    return _headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:self.dataArray[indexPath.row]Points:self.user.points];
    return cell;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 130.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 130)];
    view.backgroundColor = self.view.backgroundColor;
    [view addSubview:self.headView];
    
    // 单击的 Recognizer
    UITapGestureRecognizer* allLabelSingleRecognizer;
    allLabelSingleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewSingleTap)];
    //点击的次数
    allLabelSingleRecognizer.numberOfTapsRequired = 1; // 单击
    //点击的手指数
    allLabelSingleRecognizer.numberOfTouchesRequired = 1;
    //给view添加一个手势监测；
    [view addGestureRecognizer:allLabelSingleRecognizer];
    return  view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat f = scrollView.contentOffset.y;
    self.viewBack.height = DeviceSize.width -f;
}

- (void)headerViewSingleTap{
    PersonalViewController *personalVc = [[PersonalViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    personalVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personalVc animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        
        HealthFileViewController *myArchivesVc = [[HealthFileViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        myArchivesVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myArchivesVc animated:YES];
        
    }else if (indexPath.row ==1){
        
        MyAppointmentViewController *myAppointmentVc = [[MyAppointmentViewController alloc] init];
        myAppointmentVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myAppointmentVc animated:YES];
        
    }else if (indexPath.row ==2){
        
    }else if (indexPath.row ==3){
        WalletViewController *walletVc = [[WalletViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        walletVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:walletVc animated:YES];
    }else if (indexPath.row ==4){
        
        AllOrderViewController *myOrdersVc = [[AllOrderViewController alloc] init];
        myOrdersVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myOrdersVc animated:YES];
        
    }else if(indexPath.row ==5){
        
        MyCollectionViewController *myCollectionVc= [[MyCollectionViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        myCollectionVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myCollectionVc animated:YES];
        
    }else if(indexPath.row == 6){
        MyAddressViewController *myAddressVc = [[MyAddressViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        myAddressVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myAddressVc animated:YES];
    }else{
        SetUpViewController *setUpVc = [[SetUpViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        setUpVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setUpVc animated:YES];
    }
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
