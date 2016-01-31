//
//  AssistantDoctorViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "AssistantDoctorViewController.h"
#import "AssistantDoctorTableViewCell.h"
#import "AddAssistantDoctorViewController.h"

@interface AssistantDoctorViewController ()

@end

@implementation AssistantDoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(addAction) andTarget:self andImageName:@"首页-患者中心_添加"];
    self.isOpenHeaderRefresh = YES;
    self.isOpenFooterRefresh = YES;
    [self getAssistantDoctorData];
}

- (void)getAssistantDoctorData{
    [self.dataArray removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(AssistantDoctorViewController);
    
    [[THNetWorkManager shareNetWork] myHelperspage:self.pageNO andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            
            if (weakSelf.pageNO == 1) {
                [weakSelf.dataArray removeAllObjects];
            }
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                AssistantDoctorModel * model = [response thParseDataFromDic:dict andModel:[AssistantDoctorModel class]];
                [weakSelf.dataArray addObject:model];
            }

            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
    } ];
        
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addAction{
    AddAssistantDoctorViewController *addAssistantDoctorVc = [[AddAssistantDoctorViewController alloc] init];
    [self.navigationController pushViewController:addAssistantDoctorVc animated:YES];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    AssistantDoctorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[AssistantDoctorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:self.dataArray[indexPath.section]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

#pragma mark -- 重新父类方法进行刷新
- (void)headerRequestWithData
{
    
    [self getAssistantDoctorData];
}
- (void)footerRequestWithData
{
    
    [self getAssistantDoctorData];
}

- (NSString *)title{
    return @"助理医生";
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
    WeakSelf(AssistantDoctorViewController);
    AssistantDoctorModel * model = self.dataArray[indexPath.section];
    [self showHudAuto:@"删除中..."];
    
    [[THNetWorkManager shareNetWork] deleteMyHelperDoctorId:[model.id integerValue] andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        if (response.responseCode == 1) {
            [weakSelf.dataArray removeObjectAtIndex:indexPath.section];
            if (weakSelf.dataArray.count == 0) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                NSLog(@"-------------%@",weakSelf.dataArray);
                [weakSelf.tableView reloadData];
            }
            
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
        
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AssistantDoctorModel *model = self.dataArray[indexPath.section];
    
    //查看详情
    if (self.isMain) {
        
    }else{//聊天需呀
        if (self.chatBlock) {
            self.chatBlock(model);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
