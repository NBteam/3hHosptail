//
//  DiagnosisListViewController.m
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "DiagnosisViewController.h"
#import "DiagnosisModel.h"
#import "DiagnosisTableViewCell.h"
#import "DiagnosisAddViewController.h"
#import "DiagnosisDetailViewController.h"
#import "DiagnosisAddInputViewController.h"

@interface DiagnosisViewController ()

@property (nonatomic, strong) NSMutableArray *newsArray;
@end

@implementation DiagnosisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.separatorColor = [UIColor clearColor];
    [self getNetWork];
    
    self.newsArray = [[NSMutableArray alloc] init];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    DiagnosisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DiagnosisTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    DiagnosisModel * model = self.dataArray[indexPath.section];
    [cell confingWithModel:model];
    cell.backgroundColor = self.view.backgroundColor;
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(DiagnosisViewController);
    DiagnosisModel *model = self.dataArray[indexPath.section];
    
    if ([model.diag_name isEqualToString:@"请输入诊断名称"]) {
        DiagnosisAddInputViewController *diagnosisAddInputVc = [[DiagnosisAddInputViewController alloc] init];
        diagnosisAddInputVc.mid = self.mid;
        diagnosisAddInputVc.idx = model.idx;
        [diagnosisAddInputVc setReloadBlock:^{
            [weakSelf getNetWork];
        }];
        
        [self.navigationController pushViewController:diagnosisAddInputVc animated:YES];
    }else{
        DiagnosisDetailViewController *detailVc = [[DiagnosisDetailViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        detailVc.mid = self.mid;
        detailVc.idx = model.idx;
        
        [detailVc setReloadBlock:^{
            [weakSelf getNetWork];
        }];
        [self.navigationController pushViewController:detailVc animated:YES];
    }
    
}
- (NSString *)title{
    return @"诊断";
}

- (void)getNetWork{
    
    WeakSelf(DiagnosisViewController);
    [[THNetWorkManager shareNetWork]getPatientDiagnosisListMid:self.mid andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        [weakSelf.newsArray removeAllObjects];
        [weakSelf.dataArray removeAllObjects];
        
        for (int i = 1; i<11; i++) {
            DiagnosisModel * model = [[DiagnosisModel alloc] init];
            model.idx = [NSString stringWithFormat:@"%i",i];
            model.diag_name = @"请输入诊断名称";
            
            [weakSelf.dataArray addObject:model];
        }
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                DiagnosisModel * model = [response thParseDataFromDic:dict andModel:[DiagnosisModel class]];
                [weakSelf.newsArray addObject:model];
            }
            
            
            for (int i =0; i<10; i++) {
                
                DiagnosisModel *model = weakSelf.dataArray[i];
                for (DiagnosisModel *newModel in weakSelf.newsArray) {
                    if ([[NSString stringWithFormat:@"%@",newModel.idx] isEqualToString:model.idx]) {
                        [weakSelf.dataArray replaceObjectAtIndex:i withObject:newModel];
                    }
                }
            }
            
            
            
            [weakSelf.tableView reloadData];
        } else {
            [weakSelf showHudAuto:response.message];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt];
    }];
    [weakSelf showHudWaitingView:WaitPrompt];
}

//#pragma mark 提交编辑操作时会调用这个方法(删除，添加)
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    // 删除操作
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // 1.删除数据
//        //[self deleteCellIndexPath:indexPath];
//        
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }
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
