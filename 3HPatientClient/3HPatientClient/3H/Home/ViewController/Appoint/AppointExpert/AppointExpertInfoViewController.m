//
//  AppointExpertInfoViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/20.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AppointExpertInfoViewController.h"
#import "ConsultingHeadView.h"
#import "ConsultingTableViewCell.h"
#import "PhoneExperToolView.h"
//在线咨询
#import "ConsultingIsOnlineViewController.h"
//电话咨询
#import "ConsultingIsPhoneViewController.h"
#import "DoctorInfoModel.h"
#import "AppointExpertListModel.h"

@interface AppointExpertInfoViewController ()
@property (nonatomic, strong) ConsultingHeadView *headView;
@property (nonatomic, strong) PhoneExperToolView *toolView;
@property (nonatomic, strong) DoctorInfoModel * model;
@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation AppointExpertInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.height = self.tableView.height -60;
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

- (PhoneExperToolView *)toolView{
    WeakSelf(AppointExpertInfoViewController);
    if (!_toolView) {
        _toolView = [[PhoneExperToolView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, DeviceSize.width, 60)];
        [_toolView setBtnTelephoneBlock:^{
            ConsultingIsPhoneViewController * ConsultingIsPhoneVc = [[ConsultingIsPhoneViewController alloc]init];
            ConsultingIsPhoneVc.id =  weakSelf.model.id;
            [weakSelf.navigationController pushViewController:ConsultingIsPhoneVc animated:YES];
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
    WeakSelf(AppointExpertInfoViewController);
    [[THNetWorkManager shareNetWork]getDoctorInfoId:self.id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            DoctorInfoModel * model = [response thParseDataFromDic:response.dataDic andModel:[DoctorInfoModel class]];
            weakSelf.model = model;
            [weakSelf.headView confingWithModel:model];
            [weakSelf.tableView reloadData];
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
