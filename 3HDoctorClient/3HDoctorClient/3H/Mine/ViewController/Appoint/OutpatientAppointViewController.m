//
//  OutpatientAppointViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "OutpatientAppointViewController.h"
#import "OutpatientReservationView.h"
#import "OutpatientAppointTableViewCell.h"
@interface OutpatientAppointViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, copy)NSString *priceString;

@end

@implementation OutpatientAppointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSArray *arr = ;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (TPKeyboardAvoidingTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height -self.frameTopHeight -44) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = self.view.backgroundColor;
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(OutpatientAppointViewController);
    static NSString *identifier = @"idertifier";
    OutpatientAppointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OutpatientAppointTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cellHeight = [cell confingWithModelWeeks:self.user.work_week Price:self.user.work_price];
    //拿到数据；
    [cell setOutpatientAppontBlcok:^(NSArray *arr ,NSString *price) {
        weakSelf.user.work_price = price;
        weakSelf.user.work_week = [arr componentsJoinedByString:@","];
        [weakSelf getUpdateUserInfo];
    }];
    return cell;
}

- (void)getUpdateUserInfo{
    [self showHudAuto:@"保存中..."];
    WeakSelf(OutpatientAppointViewController);
    [[THNetWorkManager shareNetWork]getUpdateUserInfoTruename:self.user.truename sex:self.user.sex hospital:self.user.hospital department:self.user.department job_title:self.user.job_title sign_word:self.user.sign_word work_week:self.user.work_week work_price:self.user.work_price area_ids:self.user.area_ids andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            //  写入文件
            [THUser writeUserToLacalPath:UserPath andFileName:@"User" andWriteClass:weakSelf.user];
            //  下次在那重新获取保存数据
            
            weakSelf.user = nil;
            [weakSelf.navigationController popViewControllerAnimated:YES];

        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
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
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
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
