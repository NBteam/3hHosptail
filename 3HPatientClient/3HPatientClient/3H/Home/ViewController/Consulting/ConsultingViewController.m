//
//  ConsultingViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingViewController.h"
#import "ConsultingHeadView.h"
#import "ConsultingTableViewCell.h"
#import "ConsultingToolView.h"
//在线咨询
#import "ConsultingIsOnlineViewController.h"
//电话咨询
#import "ConsultingIsPhoneViewController.h"
#import "DoctorInfoModel.h"
#import "ChatViewController.h"

@interface ConsultingViewController ()
@property (nonatomic, strong) ConsultingHeadView *headView;
@property (nonatomic, strong) ConsultingToolView *toolView;
@property (nonatomic, strong) DoctorInfoModel * model;
@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation ConsultingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.height = self.tableView.height -45;
    [self.view addSubview:self.toolView];
    [self getNetWork];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI

- (ConsultingHeadView *)headView{
    if (!_headView) {
        _headView = [[ConsultingHeadView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 278/2)];
        [_headView confingWithModel:nil];
    }
    return _headView;
}

- (ConsultingToolView *)toolView{
    WeakSelf(ConsultingViewController);
    if (!_toolView) {
        _toolView = [[ConsultingToolView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, DeviceSize.width, 45)];
        [_toolView setToolBlock:^(NSInteger index) {
            if (index == 0) {
                if ([weakSelf.group_id doubleValue] == 0) {
                    [weakSelf showHudWaitingView:@"请稍后"];
                    EMGroupStyleSetting *groupStyleSetting = [[EMGroupStyleSetting alloc] init];
                    groupStyleSetting.groupMaxUsersCount = 500; // 创建500人的群，如果不设置，默认是200人。
                    groupStyleSetting.groupStyle = eGroupStyle_PrivateMemberCanInvite; // 创建不同类型的群组，这里需要才传入不同的类型
                    [[EaseMob sharedInstance].chatManager asyncCreateGroupWithSubject:@"群组名称" description:@"群组描述" invitees:@[weakSelf.md5_id] initialWelcomeMessage:@"邀请您加入群组" styleSetting:groupStyleSetting completion:^(EMGroup *group, EMError *error) {
                        if(!error){
                            NSLog(@"创建成功 -- %@",group);
                            [weakSelf getCreatGroup_id:group.groupId];
                        }
                    } onQueue:nil];
                }else{
                    ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:weakSelf.group_id conversationType:eConversationTypeGroupChat];
                    chatController.myHeadImage = weakSelf.user.pic;
                    chatController.yourHeadImage = weakSelf.model.pic;
                    chatController.title = weakSelf.group_id;
                    [weakSelf.navigationController pushViewController:chatController animated:YES];
                }
            }else{
                ConsultingIsPhoneViewController *consultingIsPhoneVc = [[ConsultingIsPhoneViewController alloc] init];
                consultingIsPhoneVc.id =  weakSelf.model.id;
                [weakSelf.navigationController pushViewController:consultingIsPhoneVc animated:YES];
            }
        }];
    }
    return _toolView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ConsultingTableViewCell";
    ConsultingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ConsultingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cellHeight = [cell confingWithModel:self.model];
    return cell;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ConsultingViewController);
    [[THNetWorkManager shareNetWork]getDoctorInfoId:self.id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            DoctorInfoModel * model = [response thParseDataFromDic:response.dataDic andModel:[DoctorInfoModel class]];
            weakSelf.model = model;
            [weakSelf.headView confingWithModel:model];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (void)getCreatGroup_id:(NSString *)group_id{
    WeakSelf(ConsultingViewController);
    [[THNetWorkManager shareNetWork]createGroupDoctor_id:self.id group_id:group_id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            ChatViewController *chatController = [[ChatViewController alloc] initWithChatter:group_id conversationType:eConversationTypeGroupChat];
            chatController.myHeadImage = weakSelf.user.pic;
            chatController.yourHeadImage = weakSelf.model.pic;
            chatController.title = group_id;
            [weakSelf.navigationController pushViewController:chatController animated:YES];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
    
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 278/2)];
//    view.backgroundColor = self.view.backgroundColor;
//    [view addSubview:self.headView];
//    
////    // 单击的 Recognizer
////    UITapGestureRecognizer* allLabelSingleRecognizer;
////    allLabelSingleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewSingleTap)];
////    //点击的次数
////    allLabelSingleRecognizer.numberOfTapsRequired = 1; // 单击
////    //点击的手指数
////    allLabelSingleRecognizer.numberOfTouchesRequired = 1;
////    //给view添加一个手势监测；
////    [view addGestureRecognizer:allLabelSingleRecognizer];
//    return  view;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
- (NSString *)title{
    return @"我要咨询";
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
