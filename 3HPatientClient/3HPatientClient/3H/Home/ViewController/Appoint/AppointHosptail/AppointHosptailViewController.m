//
//  AppointHosptailViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AppointHosptailViewController.h"
#import "AppointHosptailTableViewCell.h"
//预约完成
#import "AppointFinishViewController.h"
@interface AppointHosptailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;

@property (nonatomic ,strong) UIButton *btnAppoint;
@end

@implementation AppointHosptailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.tableView];
    self.tableView.height = self.tableView.height -65;
    
    [self.view addSubview:self.btnAppoint];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UI
- (UIButton *)btnAppoint{
    if (!_btnAppoint) {
        _btnAppoint = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAppoint.frame = CGRectMake(10, DeviceSize.height -self.frameTopHeight -45 -10, DeviceSize.width -20, 45);
        _btnAppoint.layer.masksToBounds = YES;
        _btnAppoint.layer.cornerRadius = 5;
        _btnAppoint.backgroundColor = AppDefaultColor;
        [_btnAppoint setTitle:@"提交预约" forState:UIControlStateNormal];
        _btnAppoint.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnAppoint setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        [_btnAppoint addTarget:self action:@selector(btnAppointAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnAppoint;
}

- (void)btnAppointAction{
    [self getNetWork];
}

- (TPKeyboardAvoidingTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height -self.frameTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = self.view.backgroundColor;
    }
    return _tableView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"AppointHosptailTableViewCell";
    AppointHosptailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AppointHosptailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:1];
    return cell;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 255;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)getNetWork{
    
    WeakSelf(AppointHosptailViewController);
    AppointHosptailTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([cell.txtView.text isEqualToString:@""]) {
        [self showHudAuto:@"请输入预约信息" andDuration:@"2"];
    }else{
        [self showHudWaitingView:WaitPrompt];
        [[THNetWorkManager shareNetWork]orderHospitalContent:cell.txtView.text andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
            [weakSelf removeMBProgressHudInManaual];
            if (response.responseCode == 1) {
                AppointFinishViewController *appointFinishVc = [[AppointFinishViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                [weakSelf.navigationController pushViewController:appointFinishVc animated:YES];
            }else{
                [weakSelf showHudAuto:response.message andDuration:@"2"];
            }
        } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
            [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        }];
    }
}

- (NSString *)title{
    return @"预约住院";
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
