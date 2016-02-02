//
//  DynamicDetailViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "DynamicDetailViewController.h"
#import "DynamicDetailTableViewCell.h"
#import "DynamicDetailToolView.h"
#import "DynamicDetailModel.h"
#import "DynamicCommentsViewController.h"
@interface DynamicDetailViewController ()
//cell高度
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic ,strong) DynamicDetailToolView *toolView;
@end

@implementation DynamicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.height = self.tableView.height - 45;
    [self.view addSubview:self.toolView];
    self.view.backgroundColor = [UIColor colorWithHEX:0xffffff];
    self.toolView.hidden = YES;
    [self getDynamicDetailData];
    
}

- (void)getDynamicDetailData{
    [self.dataArray removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(DynamicDetailViewController);
    [[THNetWorkManager shareNetWork] getArtInfoIds:self.ids CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            DynamicDetailModel * model = [response thParseDataFromDic:response.dataDic andModel:[DynamicDetailModel class]];
            [weakSelf.dataArray addObject:model];
            
            [weakSelf.toolView confingWithModel:weakSelf.dataArray[0]];
            [weakSelf.tableView reloadData];
            self.toolView.hidden = NO;
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
        
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (DynamicDetailToolView *)toolView{
    //0 == 评论  1 == 点赞
    WeakSelf(DynamicDetailViewController);
    if (!_toolView) {
        _toolView = [[DynamicDetailToolView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, DeviceSize.width, 45)];
        [_toolView setToolBlock:^(NSInteger index) {
            if (index == 0) {
                DynamicDetailModel * model = weakSelf.dataArray[0];
                DynamicCommentsViewController *dynamicCommentsVc = [[DynamicCommentsViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                dynamicCommentsVc.id = model.id;
                [weakSelf.navigationController pushViewController:dynamicCommentsVc animated:YES];
                
            }else{
                [weakSelf getNetWork];
            }
        }];
    }
    return _toolView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    DynamicDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DynamicDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cellHeight = [cell confingWithModel:self.dataArray[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(DynamicDetailViewController);
    [[THNetWorkManager shareNetWork]voteArtId:self.ids andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        NSLog(@"查看%@",response.dataDic);
        if (response.responseCode == 1) {
            weakSelf.toolView.labTitle2.text = [NSString stringWithFormat:@"点赞(%@)",response.dataDic[@"good_num"]];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}

- (NSString *)title{
    return @"医疗资讯";
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
