//
//  ConsultingDoctorListViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingDoctorListViewController.h"
#import "ConsultingDoctorListTableViewCell.h"
#import "ConsultingViewController.h"
#import "ConsultingDoctorListNewCell.h"
#import "DoctorListModel.h"
#import "AppointExpertListModel.h"

@interface ConsultingDoctorListViewController ()
@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation ConsultingDoctorListViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(headerRequestWithData) name:@"reloadInfo" object:nil];
     self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.isOpenFooterRefresh = YES ;
    self.isOpenHeaderRefresh = YES;
    [self getNetWork];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:HXMessagesLogs object:nil];
}

- (void)reloadTableView{
    
    
    for (int i = 0; i< self.dataArray.count; i++) {
        AppointExpertListModel * model = self.dataArray[i];
        model.isMessages = [self isMessages:[NSString stringWithFormat:@"%@",model.group_id]];
        NSLog(@"我的住%d",model.isMessages);
        [self.dataArray replaceObjectAtIndex:i withObject:model];
    }
    
    
    [self.tableView reloadData];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ConsultingTableViewCell";
    ConsultingDoctorListNewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ConsultingDoctorListNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AppointExpertListModel * model = self.dataArray[indexPath.row];
    self.cellHeight = [cell confingWithAppointExpertListModel:model];
    return cell;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
//    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppointExpertListModel * model = self.dataArray[indexPath.row];
    
    ConsultingViewController *consultingVc = [[ConsultingViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    consultingVc.id = model.id;
    consultingVc.md5_id = model.md5_id;
    consultingVc.group_id = model.group_id;
    WeakSelf(ConsultingDoctorListViewController);
    [consultingVc setReloadBlock:^{
        
        [self.user.dictHX removeObjectForKey:[NSString stringWithFormat:@"%@",model.group_id]];
        //  写入本地
        NSLog(@"字典内容%@",self.user.dictHX);
        [THUser writeUserToLacalPath:UserPath andFileName:@"User" andWriteClass:self.user];
        [weakSelf reloadTableView];
    }];
    [self.navigationController pushViewController:consultingVc animated:YES];
}
- (NSString *)title{
    return @"专家团队";
}

- (void)getNetWork{
    
    
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ConsultingDoctorListViewController);
    [[THNetWorkManager shareNetWork]getMyDoctorsPage:self.pageNO andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dic in response.dataDic[@"list"]) {
                AppointExpertListModel * model = [response thParseDataFromDic:dic andModel:[AppointExpertListModel class]];
                
                model.isMessages = [weakSelf isMessages:[NSString stringWithFormat:@"%@",model.group_id]];
                
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
            //  结束头部刷新
            [weakSelf.tableView.header endRefreshing];
            //  结束尾部刷新
            [weakSelf.tableView.footer endRefreshing];
        }else{
            //  结束头部刷新
            [weakSelf.tableView.header endRefreshing];
            //  结束尾部刷新
            [weakSelf.tableView.footer endRefreshing];
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}

// 是否有这个环信id
- (BOOL)isMessages:(NSString *)groupId{
    self.user = nil;
    self.user = [self refreshUserData];
    NSMutableDictionary *dic = self.user.dictHX;
    for(id key in [dic allKeys]){
        NSLog(@"key%@",key);
        if ([key isEqualToString:groupId]) {
            return YES;
        }
    }
    return  NO;
}
#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    [self getNetWork];
}
- (void)footerRequestWithData
{
    [self getNetWork];
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
