//
//  AppointDoctorsViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AppointDoctorsViewController.h"
#import "AppointDoctorsHeadView.h"
#import "AppointDoctorsTableViewCell.h"
#import "DoctorInfoModel.h"
#import "AppointDoctorsInfoViewController.h"
@interface AppointDoctorsViewController ()
@property (nonatomic, strong) AppointDoctorsHeadView *headView;

@property (nonatomic, strong) UIButton *btnAppoint;

@property (nonatomic, strong) DoctorInfoModel * model;


@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation AppointDoctorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.height = self.tableView.height -65;
    [self getNetWork];
    [self.view addSubview:self.btnAppoint];

    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI

- (AppointDoctorsHeadView *)headView{
    if (!_headView) {
        _headView = [[AppointDoctorsHeadView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 278/2)];
        [_headView confingWithModel:nil];
    }
    return _headView;
}

#pragma mark -UI
- (UIButton *)btnAppoint{
    if (!_btnAppoint) {
        _btnAppoint = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAppoint.frame = CGRectMake(10, DeviceSize.height -self.frameTopHeight -45 -10, DeviceSize.width -20, 45);
        _btnAppoint.layer.masksToBounds = YES;
        _btnAppoint.layer.cornerRadius = 5;
        _btnAppoint.backgroundColor = AppDefaultColor;
        [_btnAppoint setTitle:@"预约挂号" forState:UIControlStateNormal];
        _btnAppoint.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnAppoint setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        [_btnAppoint addTarget:self action:@selector(btnAppointAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnAppoint;
}

- (void)btnAppointAction{
    AppointDoctorsInfoViewController *  AppointDoctorsInfoVc = [[AppointDoctorsInfoViewController alloc]init];
    AppointDoctorsInfoVc.id = self.model.id;
    [self.navigationController pushViewController:AppointDoctorsInfoVc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"AppointDoctorsTableViewCell";
    AppointDoctorsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AppointDoctorsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cellHeight = [cell confingWithModel:indexPath.section model:self.model];
    return cell;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
    return @"预约挂号";
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(AppointDoctorsViewController);
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
