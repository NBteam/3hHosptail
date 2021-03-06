//
//  HomeViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeadView.h"
#import "HomeTableViewCell.h"

//患者中心
#import "PatientCenterViewController.h"
//咨询服务
//#import "ConsultingServicesViewController.h"
#import "ConsultingMainViewController.h"
//预约管理
#import "BookManagementViewController.h"
//助理医生
#import "AssistantDoctorViewController.h"
//咨询动态
#import "ConsultingDynamicViewController.h"
//二维码
#import "QrCodeViewController.h"
//个人资料
#import "PersonalViewController.h"

@interface HomeViewController ()<EMChatManagerChatDelegate>


@property (nonatomic, strong) HomeHeadView *headView;

@property (nonatomic, strong) UIView *changeView;
@end

@implementation HomeViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"reloadHomeInfo" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.title = @"3H健康管理";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(addAction) andTarget:self andImageName:@"首页-患者中心_添加"];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    NSLog(@"我的名字%@",self.user.truename);
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHEX:0xffffff];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view insertSubview:self.changeView belowSubview:self.tableView];
    self.tableView.separatorColor = [UIColor colorWithHEX:0xffffff];
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"img":@"3H-首页_患者中心",@"title":@"患者中心"},@{@"img":@"3H-首页_咨询服务",@"title":@"咨询服务"},@{@"img":@"3H-首页_预约管理",@"title":@"预约管理"},@{@"img":@"3H-首页_助理医生",@"title":@"助理医生"},@{@"img":@"3H-首页_咨询动态",@"title":@"资讯动态"}]];
    self.tableView.top = 0;
    self.tableView.height = DeviceSize.height -49;
//    self.tableView.tableHeaderView = self.headView;
    [self.headView confingWithModelOfName:self.user.truename Hosptail:self.user.hospital Job:self.user.job_title Pic:self.user.pic];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getHomeInfo) name:@"reloadHomeInfo" object:nil];

    [self registerNotifications];
    [self setupUnreadMessageCount];
}
#pragma mark - private

-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}
// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}
// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        
        if (!conversation.latestMessageFromOthers.isRead) {
            [self hxloadNum:conversation.latestMessageFromOthers.from];
        }
        
        unreadCount += conversation.unreadMessagesCount;
    }
    NSLog(@"~~%ld",(long)unreadCount);
    if (unreadCount) {
        self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",unreadCount];
    }else{
        self.navigationController.tabBarItem.badgeValue = nil;
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}
// 计算未读数量
- (void)hxloadNum:(NSString *)hxNum{
    
    
    // 把环信群组id进行保存
    self.user = nil;
    self.user = [self refreshUserData];
    NSMutableDictionary *dict = self.user.dictHX;
    
    if (dict) {
        
        if ([self isMessagesKey:hxNum dict:dict]) {
            
        }else{
            
            [dict setObject:hxNum forKey:hxNum];
            self.user.dictHX = dict;
            //  写入本地
            [THUser writeUserToLacalPath:UserPath andFileName:@"User" andWriteClass:self.user];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HXMessagesLogs object:nil];
        }
        
    }else{
        if (hxNum) {
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:hxNum forKey:hxNum];
            self.user.dictHX = nil;
            self.user.dictHX = dic;
            
            
            //  写入本地
            [THUser writeUserToLacalPath:UserPath andFileName:@"User" andWriteClass:self.user];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HXMessagesLogs object:nil];
        }
    }
    
}

- (BOOL)isMessagesKey:(NSString *)keys dict:(NSMutableDictionary *)dict{
    
    for (id key in dict) {
        if ([key isEqualToString:keys]) {
            return YES;
        }
    }
    return NO;
}

- (void)addAction{
    QrCodeViewController *qrCodeVc = [[QrCodeViewController alloc] init];
    qrCodeVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:qrCodeVc animated:YES];
}

- (void)getHomeInfo{
    self.user = [self refreshUserData];
    [self.headView confingWithModelOfName:self.user.truename Hosptail:self.user.hospital Job:self.user.job_title Pic:self.user.pic];
}

#pragma mark -UI

- (UIView *)changeView{
    if (!_changeView) {
        _changeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.width)];
        _changeView.backgroundColor = AppDefaultColor;
    }
    return _changeView;
}

- (HomeHeadView *)headView{
    if (!_headView) {
        WeakSelf(HomeViewController);
        _headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 230 -64)];
        UITapGestureRecognizer *singleTap =           [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UesrClicked)];
        [_headView.imgMyPicture addGestureRecognizer:singleTap];
        //点击的次数
        singleTap.numberOfTapsRequired = 1; // 单击
        //点击的手指数
        singleTap.numberOfTouchesRequired = 1;
        [_headView setImgHeadBlock:^{
            PersonalViewController *personalVc = [[PersonalViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            personalVc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:personalVc animated:YES];
        }];
        
    }
    return _headView;
}

- (void)UesrClicked{
    PersonalViewController *personalVc = [[PersonalViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    personalVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:personalVc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:self.dataArray[indexPath.row]];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55 +12 +9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 230 -64;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {//患者中心
        
        PatientCenterViewController *patientCenterVc = [[PatientCenterViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        patientCenterVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:patientCenterVc animated:YES];
        
    }else if (indexPath.row == 1){//咨询服务
        
        ConsultingMainViewController *consultingServicesVc= [[ConsultingMainViewController alloc] init];
        consultingServicesVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:consultingServicesVc animated:YES];
//        ConsultingServicesViewController *consultingServicesVc= [[ConsultingServicesViewController alloc] init];
//        consultingServicesVc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:consultingServicesVc animated:YES];
        
    }else if (indexPath.row == 2){//预约管理
        
        BookManagementViewController *bookManagementVc= [[BookManagementViewController alloc] init];
        bookManagementVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bookManagementVc animated:YES];
        
    }else if (indexPath.row == 3){//助理医生
        
        AssistantDoctorViewController *assistantDoctorVc= [[AssistantDoctorViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        assistantDoctorVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:assistantDoctorVc animated:YES];
        
    }else{//资讯动态
        
        ConsultingDynamicViewController *consultingDynamicVc= [[ConsultingDynamicViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        consultingDynamicVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:consultingDynamicVc animated:YES];
        
    }
}
#pragma mark -
#pragma mark net


//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat f = scrollView.contentOffset.y;
    self.changeView.height = DeviceSize.width -f;
}

//- (NSString *)title{
//    return @"3H健康管理";
//}


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
