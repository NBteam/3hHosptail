//
//  DiagnosisViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "MedicalHistoryViewController.h"
#import "PatientCenterNotCustomView.h"
#import "MedicalHistoryTableViewCell.h"
#import "MedicalHistoryDetailTableViewCell.h"
#import "MedicalHistoryEditorViewController.h"

@interface MedicalHistoryViewController ()
@property (nonatomic, strong) PatientCenterNotCustomView *customView;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, copy) NSMutableDictionary * dictInfo;
@end

@implementation MedicalHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"编辑"];
    self.dictInfo = [NSMutableDictionary dictionary];
   // [self.view addSubview:self.customView];
    
    
    [self getPatientSickHistory];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction{
    MedicalHistoryEditorViewController *diagnosisEditorVc = [[MedicalHistoryEditorViewController alloc] init];
    diagnosisEditorVc.gmString = self.dataArray[0][@"detail"];
    diagnosisEditorVc.xxString = self.dataArray[1][@"detail"];
    diagnosisEditorVc.detailString = self.dataArray[2][@"detail"];
    diagnosisEditorVc.mid = self.mid;
    WeakSelf(MedicalHistoryViewController);
    [diagnosisEditorVc setReloadBlock:^{
        [weakSelf getPatientSickHistory];
    }];
    [self.navigationController pushViewController:diagnosisEditorVc animated:YES];
}

#pragma mark - UI

- (PatientCenterNotCustomView *)customView{
    WeakSelf(MedicalHistoryViewController);
    if (!_customView) {
        _customView = [[PatientCenterNotCustomView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height -self.frameTopHeight) LabText:@"您还没有添加病史,请添加!" BtnText:@"添加病史"];
        _customView.backgroundColor = self.view.backgroundColor;
        [_customView setBtnBlock:^{
          
        }];
    }
    return _customView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        static NSString *identifier = @"DiagnosisDetailTableViewCell";
        MedicalHistoryDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[MedicalHistoryDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellHeight = [cell confingWithModel:self.dictInfo];
        return cell;
    }else{
        static NSString *identifier = @"idertifier";
        MedicalHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[MedicalHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dictInfo index:indexPath.section];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return self.cellHeight;
    }else{
        return 45;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (NSString *)title{
    return @"病史";
}
- (void)getPatientSickHistory{
    WeakSelf(MedicalHistoryViewController);
    [weakSelf showHudWaitingView:WaitPrompt];;
    [[THNetWorkManager shareNetWork]getPatientSickHistoryMid:self.mid andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        [weakSelf.dataArray removeAllObjects];
        NSLog(@"查看sss%@",response.dataDic);
        if (response.responseCode == 1) {
            weakSelf.dictInfo = [NSMutableDictionary dictionaryWithDictionary:response.dataDic];
            weakSelf.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"是否有过敏史:",@"detail":weakSelf.dictInfo[@"guomin"]},@{@"title":@"血型:",@"detail":weakSelf.dictInfo[@"blood_type"]},@{@"title":@"病情描述:",@"detail":weakSelf.dictInfo[@"desc"]}]];
            
            [weakSelf.tableView reloadData];
        } else {
            [weakSelf showHudAuto:response.message];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt];
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
