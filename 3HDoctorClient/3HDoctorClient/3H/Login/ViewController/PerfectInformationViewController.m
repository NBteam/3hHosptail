//
//  PerfectInformationViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "PerfectInformationViewController.h"
#import "PerfectInformationTableViewCell.h"
//输入名字
#import "NameInputViewController.h"
//医院名称
#import "HospitalTableViewController.h"
#import "AppDelegate.h"
//所在城市
#import "CityListFirstLevelViewController.h"
//职称
#import "PositionViewController.h"
//科室
#import "DepartmentViewController.h"
//门诊时间
#import "PerfectInformationTimeViewController.h"

@interface PerfectInformationViewController ()
//友情提示
@property (nonatomic, strong) UILabel *labPrompt;
//提交
@property (nonatomic, strong) UIButton *btnSubmit;
@property (nonatomic, copy) NSString * idS;
@property (nonatomic, copy) NSString * parent_id;
@end

@implementation PerfectInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.dataArray = [NSMutableArray arrayWithArray:@[@"您的姓名",@"所在城市",@"您的职称",@"医院名称",@"科室名称",@"门诊时间"]];
    self.tableView.top = self.labPrompt.bottom;
    self.tableView.height = DeviceSize.height - self.frameTopHeight - self.labPrompt.height - 45 -20 - 15;
    self.tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:self.labPrompt];
    
    [self.view addSubview:self.btnSubmit];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -UI

- (UILabel *)labPrompt{
    if (!_labPrompt) {
        _labPrompt = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 40)];
        _labPrompt.backgroundColor = [UIColor orangeColor];
        _labPrompt.font = [UIFont systemFontOfSize:15];
        _labPrompt.textAlignment = NSTextAlignmentCenter;
        _labPrompt.textColor = [UIColor colorWithHEX:0xffffff];
        _labPrompt.text = @"请填写您的真实信息,以便我们提供更好的服务!";
    }
    return _labPrompt;
}

- (UIButton *)btnSubmit{
    if (!_btnSubmit) {
        _btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSubmit.frame = CGRectMake(12, self.tableView.bottom +20, DeviceSize.width - 24, 45);
        [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSubmit.titleLabel.font = [UIFont systemFontOfSize:17];
        [_btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
        _btnSubmit.layer.masksToBounds = YES;
        _btnSubmit.layer.cornerRadius = 5;
        _btnSubmit.backgroundColor = [UIColor colorWithHEX:0x008aff];
        
        [_btnSubmit addTarget:self action:@selector(btnSubmitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSubmit;
}

- (void)btnSubmitAction{
    ;
    
    
    [self showHudAuto:@"保存中..."];
    WeakSelf(PerfectInformationViewController);
    [[THNetWorkManager shareNetWork]getUpdateUserInfoTruename:self.user.truename sex:self.user.sex hospital:self.user.hospital department:self.user.department job_title:self.user.job_title sign_word:self.user.sign_word work_week:self.user.work_week work_price:self.user.work_price area_ids:self.user.area_ids andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            //  写入文件
            [THUser writeUserToLacalPath:UserPath andFileName:@"User" andWriteClass:weakSelf.user];
            //  下次在那重新获取保存数据
            
            weakSelf.user = nil;
            
            [(AppDelegate*)[UIApplication sharedApplication].delegate setWindowRootViewControllerIsTabBar];
            
            
            
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    PerfectInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[PerfectInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = self.view.backgroundColor;
    [cell confingWithModel:self.dataArray[indexPath.row]];
    return cell;

}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count ;
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45 +10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(PerfectInformationViewController);
    if (indexPath.row == 0) {//您的姓名
        
        NameInputViewController *nameInputVc = [[NameInputViewController alloc] init];
        
        [nameInputVc setNameBlock:^(NSString *str) {
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:str];
            weakSelf.user.truename = str;
            [weakSelf.tableView reloadData];
        }];
        
        [self.navigationController  pushViewController:nameInputVc animated:YES];
        
    }else if (indexPath.row == 1){//所在城市
        
        CityListFirstLevelViewController *cityListFirstLevelVc= [[CityListFirstLevelViewController alloc] init];
        [cityListFirstLevelVc setCityListBlock:^(NSString *name, NSString *ids, NSString *parent_id) {
            NSLog(@"%@-->%@-->%@",name,ids,parent_id);
            weakSelf.idS = ids;
            weakSelf.parent_id = parent_id;
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:name];
            weakSelf.user.area_ids = [NSString stringWithFormat:@"%@,%@",parent_id,ids];
            weakSelf.user.area_names = name;
            [weakSelf.tableView reloadData];
        }];
        
        [self.navigationController pushViewController:cityListFirstLevelVc animated:YES];
        
    }else if (indexPath.row == 2){//您的职称
        PositionViewController * pvc = [[PositionViewController alloc]init];
        [pvc setChoiceBlock:^(NSString *positionStr) {
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:positionStr];
            weakSelf.user.job_title = positionStr;
            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:pvc animated:YES];
    }else if (indexPath.row == 3){//医院名称
        if (self.idS==nil||[self.idS isEqualToString:@""]) {
            [self showHudAuto:@"请先选择城市" andDuration:@"2"];
        }else{
            HospitalTableViewController*hospitalInputVc = [[HospitalTableViewController alloc] init];
            hospitalInputVc.ids = self.idS;
            [hospitalInputVc setHospitalBlock:^(NSString *name,NSString * id) {
                [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:name];
                weakSelf.user.hospital = name;
                [weakSelf.tableView reloadData];
            }];
            
            [self.navigationController pushViewController:hospitalInputVc animated:YES];
        }
    }else if (indexPath.row == 4){//科室名称
        NSString * idStr = @"";
        if (self.parent_id==nil||[self.parent_id isEqualToString:@""]) {
            idStr = @"0";
        }else{
            idStr = self.parent_id;
        }
        DepartmentViewController * DepartmentVc = [[DepartmentViewController alloc]init];
        DepartmentVc.id = idStr;
        [DepartmentVc setChoiceBlock:^(NSString *id, NSString *name, NSString *pid) {
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:name];
            weakSelf.user.department = name;
            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:DepartmentVc animated:YES];
    }else if (indexPath.row == 5){//门诊时间
        PerfectInformationTimeViewController *perfectInformationTimeVc = [[PerfectInformationTimeViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        
        [perfectInformationTimeVc setPerfectInformationTimeBlock:^(NSString *name,NSString *price) {
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:[NSString stringWithFormat:@"%@(收费:%@)",name,price]];
            weakSelf.user.work_week = name;
            weakSelf.user.work_price = price;
            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:perfectInformationTimeVc animated:YES];
    }
    
}



- (NSString *)title{
    return @"完善资料";
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
