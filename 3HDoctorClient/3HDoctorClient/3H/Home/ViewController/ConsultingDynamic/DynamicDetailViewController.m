//
//  DynamicDetailViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "DynamicDetailViewController.h"
#import "DynamicDetailTableViewCell.h"
#import "DynamicToolView.h"
#import "DynamicCommentsViewController.h"
#import "DynamicDetailModel.h"
#import "CommentsToolBarView.h"

@interface DynamicDetailViewController ()
//cell高度
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, retain) NSMutableDictionary * dict;
@property (nonatomic, retain) DynamicToolView * toolView;
@property (nonatomic, retain) DynamicDetailModel * detailModel;

//@property (nonatomic, strong) CommentsToolBarView *toolBarView;
@end

@implementation DynamicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.view.backgroundColor = [UIColor colorWithHEX:0xffffff];
    self.tableView.height = DeviceSize.height-44;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.toolView];
    
    [self getDetailInfo];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    DynamicDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DynamicDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    self.cellHeight = [cell confingWithModel:self.dict];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (NSString *)title{
    return @"医疗资讯";
}
- (void)getDetailInfo{
    WeakSelf(DynamicDetailViewController);
    [weakSelf showHudWaitingView:WaitPrompt];
    [[THNetWorkManager shareNetWork]getArtInfoId:self.id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        
        NSLog(@"----%@",response.dataDic);
        [weakSelf removeMBProgressHudInManaual];
        [weakSelf.dataArray removeAllObjects];
        if (response.responseCode == 1) {
            weakSelf.dict = [NSMutableDictionary dictionaryWithDictionary:response.dataDic];
            DynamicDetailModel * model = [response thParseDataFromDic:response.dataDic andModel:[DynamicDetailModel class]];
            weakSelf.detailModel =  model;
            [weakSelf.toolView.btnLeft setTitle:[NSString stringWithFormat:@"  评论(%@)",response.dataDic[@"comment_num"]] forState:UIControlStateNormal];
            [weakSelf.toolView.btnRight setTitle:[NSString stringWithFormat:@"  点赞(%@)",response.dataDic[@"good_num"]] forState:UIControlStateNormal];
            [weakSelf.tableView reloadData];
        } else {
            [weakSelf showHudAuto:response.message];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt];
    }];
}
- (DynamicToolView *)toolView{
    if (!_toolView) {
        WeakSelf(DynamicDetailViewController);
        _toolView = [[DynamicToolView alloc]initWithFrame:CGRectMake(0, DeviceSize.height-44-64, DeviceSize.width, 44)];
        _toolView.backgroundColor = [UIColor colorWithHEX:0xffffff];
        [_toolView setBtnRightBlock:^{
            [weakSelf getGoodNetWork];
        }];
        [_toolView setBtnLeftBlock:^{
            DynamicCommentsViewController * DynamicCommentsVc = [[DynamicCommentsViewController alloc]initWithTableViewStyle:UITableViewStyleGrouped];

            DynamicCommentsVc.id = weakSelf.detailModel.id;
            [weakSelf.navigationController pushViewController:DynamicCommentsVc animated:YES];
        }];
    }
    return _toolView;
}
- (void)getGoodNetWork{
    WeakSelf(DynamicDetailViewController);
    [weakSelf showHudWaitingView:WaitPrompt];
    [[THNetWorkManager shareNetWork]getVoteArtId:self.id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {

            [weakSelf.toolView.btnRight setTitle:[NSString stringWithFormat:@"  点赞(%@)",response.dataDic[@"good_num"]] forState:UIControlStateNormal];
        } else {
            [weakSelf showHudAuto:response.message];
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
