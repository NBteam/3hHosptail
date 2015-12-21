//
//  DynamicCommentsViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "DynamicCommentsViewController.h"
#import "DynamicCommentsTableViewCell.h"
#import "CommentsCustomKeyboard.h"
#import "CommentsListModel.h"

@interface DynamicCommentsViewController ()

@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation DynamicCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [[CommentsCustomKeyboard customKeyboard]textViewShowView:self customKeyboardDelegate:self];
    [self getArtCmtListNetWork];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DynamicCommentsTableViewCell";
    DynamicCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DynamicCommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CommentsListModel * model = self.dataArray[indexPath.row];
    self.cellHeight = [cell confingWithModel:model];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 69/2 +10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 69/2 +10)];
    view.backgroundColor = [UIColor colorWithHEX:0xffffff];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, 55, 69/2);
    [btn setImage:[UIImage imageNamed:@"首页-健康资讯-新闻资讯-评论"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
//    UILabel *labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 69/2 +20 -0.5, DeviceSize.width, 0.5)];
//    labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
//    [view addSubview:labLine];
    return view;
}

- (void)btnAction{
    
    [[CommentsCustomKeyboard customKeyboard].mTalkBtn setTitle:@"提交评论" forState:UIControlStateNormal];
    WeakSelf(DynamicCommentsViewController);
    [[CommentsCustomKeyboard customKeyboard].mTextView becomeFirstResponder];
    [CommentsCustomKeyboard customKeyboard].mTalkBtnBlock = ^(NSString * text){
        [weakSelf getCmtArtInfo:text];
//        [weakSelf getAddShortReviewNetWorkText:text];
    };
}
-(void)talkBtnClick:(UITextView *)textViewGet{

}
- (void)getCmtArtInfo:(NSString *)text{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(DynamicCommentsViewController);
    [[THNetWorkManager shareNetWork]getCmtArtId:self.id content:text andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        NSLog(@"查看%@",response.dataDic);
        if (response.responseCode == 1) {
            [weakSelf getArtCmtListNetWork];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (void)getArtCmtListNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(DynamicCommentsViewController);
    [[THNetWorkManager shareNetWork]getArtCmtListId:self.id page:self.pageNO andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (weakSelf.pageNO == 1) {
            [weakSelf.dataArray removeAllObjects];
        }
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                CommentsListModel * model = [response thParseDataFromDic:dict andModel:[CommentsListModel class]];
                [weakSelf.dataArray addObject:model];
            }
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"1"];
        }
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        //  重新加载数据
        [weakSelf.tableView reloadData];
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        //  结束头部刷新
        [weakSelf.tableView.header endRefreshing];
        //  结束尾部刷新
        [weakSelf.tableView.footer endRefreshing];
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"1"];
    }];
}

- (NSString *)title{
    return @"评论";
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