//
//  ConsultingMainViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 16/1/21.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "ConsultingMainViewController.h"
#import "PatientCenterTableViewCell.h"
#import "PatientAddRequestViewController.h"
//患者详情
#import "PatientDetailViewController.h"
#import "PatientListModel.h"
#import "SearchViewController.h"
#import "AddPatientsViewController.h"
//聊天页面
#import "ChatViewController.h"
@interface ConsultingMainViewController ()

@end

@implementation ConsultingMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self registerNotifications];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(addAction) andTarget:self andImageName:@"首页-患者中心_添加"];
    self.isOpenHeaderRefresh = YES;
    self.isOpenFooterRefresh = YES;
    [self getNetWorkInfo];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)searchAction{
    SearchViewController * SearchVc = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:SearchVc animated:YES];
}

- (void)addAction{
    AddPatientsViewController * addVc = [[AddPatientsViewController alloc]init];
    [self.navigationController pushViewController:addVc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    PatientCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PatientCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PatientListModel * model = self.dataArray[indexPath.row];
    [cell confingWithModel:model];
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PatientListModel *model = self.dataArray[indexPath.row];
    if ([model.group_id doubleValue] != 0) {
        ChatViewController*chatController = [[ChatViewController alloc] initWithChatter:[NSString stringWithFormat:@"%@",model.group_id] conversationType:eConversationTypeGroupChat];
        chatController.title = [NSString stringWithFormat:@"您正在与%@聊天",model.truename];
        chatController.myImageString = self.user.pic;
        chatController.youImageString = model.pic;
        chatController.patientId = [NSString stringWithFormat:@"%@",model.id];
        chatController.groupId = [NSString stringWithFormat:@"%@",model.group_id];
        chatController.is_assist_patient = [model.is_assist_patient integerValue];
//        chatController.groupId = @"1454230107375";
        chatController.doctorId = self.user.id;
        
        [self.navigationController pushViewController:chatController animated:YES];
    }else{
        [self showHudWaitingView:@"请稍后"];
        WeakSelf(ConsultingMainViewController);
        EMGroupStyleSetting *groupStyleSetting = [[EMGroupStyleSetting alloc] init];
        groupStyleSetting.groupMaxUsersCount = 500; // 创建500人的群，如果不设置，默认是200人。
        groupStyleSetting.groupStyle = eGroupStyle_PrivateMemberCanInvite; // 创建不同类型的群组，这里需要才传入不同的类型
        [[EaseMob sharedInstance].chatManager asyncCreateGroupWithSubject:@"群组名称" description:@"群组描述" invitees:@[model.md5_id] initialWelcomeMessage:@"邀请您加入群组" styleSetting:groupStyleSetting completion:^(EMGroup *group, EMError *error) {
            if(!error){
                NSLog(@"创建成功 -- %@",group);
                [weakSelf getCreatGroup_id:group.groupId model:model];
            }
        } onQueue:nil];
    }
}

- (void)getCreatGroup_id:(NSString *)group_id model:(PatientListModel *)model{
    WeakSelf(ConsultingMainViewController);
    [[THNetWorkManager shareNetWork]createGroupMember_id:model.id group_id:group_id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            ChatViewController*chatController = [[ChatViewController alloc] initWithChatter:[NSString stringWithFormat:@"%@",model.group_id] conversationType:eConversationTypeGroupChat];
            chatController.title = [NSString stringWithFormat:@"您正在与%@聊天",model.truename];
            chatController.myImageString = self.user.pic;
            chatController.youImageString = model.pic;
            chatController.patientId = [NSString stringWithFormat:@"%@",model.id];
            chatController.groupId = [NSString stringWithFormat:@"%@",model.group_id];
            chatController.doctorId = self.user.id;
            chatController.is_assist_patient = [model.is_assist_patient integerValue];
            [self.navigationController pushViewController:chatController animated:YES];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
    
}

- (void)getNetWorkInfo{
    WeakSelf(ConsultingMainViewController);
    [weakSelf showHudWaitingView:WaitPrompt];
    [[THNetWorkManager shareNetWork]getMyPatientsPage:self.pageNO andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (weakSelf.pageNO == 1) {
            [weakSelf.dataArray removeAllObjects];
        }
        
        if (response.responseCode == 1) {
            NSLog(@"----%@",response.dataDic[@"list"]);
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                
                PatientListModel * model = [response thParseDataFromDic:dict andModel:[PatientListModel class]];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
        } else {
            [weakSelf showHudAuto:response.message];
        }
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        //  重新加载数据
        [weakSelf.tableView reloadData];
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt];
    }];
}
#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    
    [self getNetWorkInfo];
}
- (void)footerRequestWithData
{
    
    [self getNetWorkInfo];
}

- (void)deleteMyPatientMember_id:(NSString *)member_id{
    
    
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
    WeakSelf(ConsultingMainViewController);
    PatientListModel * model = self.dataArray[indexPath.row];
    [self showHudAuto:@"删除中..."];
    
    [[THNetWorkManager shareNetWork] deleteMyPatientMember_id:model.id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
        
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
}

- (NSString *)title{
    return @"咨询服务";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - private
//
//-(void)registerNotifications
//{
//    [self unregisterNotifications];
//    
//    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
//}
//
//-(void)unregisterNotifications
//{
//    [[EaseMob sharedInstance].chatManager removeDelegate:self];
//}
//
//// 未读消息数量变化回调
//-(void)didUnreadMessagesCountChanged
//{
//    [self setupUnreadMessageCount];
//}
//
//- (void)didFinishedReceiveOfflineMessages
//{
//    [self setupUnreadMessageCount];
//}
//
//// 统计未读消息数
//-(void)setupUnreadMessageCount
//{
//    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
//    NSInteger unreadCount = 0;
//    for (EMConversation *conversation in conversations) {
//        unreadCount += conversation.unreadMessagesCount;
//        NSLog(@"-------- %@",conversation);
//    }
//    
//    NSLog(@"未度消息数%i",(int)unreadCount);
////    if (_chatListVC) {
////        if (unreadCount > 0) {
////            _chatListVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
////        }else{
////            _chatListVC.tabBarItem.badgeValue = nil;
////        }
////    }
////    
//    UIApplication *application = [UIApplication sharedApplication];
//    [application setApplicationIconBadgeNumber:unreadCount];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
