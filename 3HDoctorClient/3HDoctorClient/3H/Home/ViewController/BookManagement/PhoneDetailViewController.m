//
//  PhoneDetailViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//
//uploadView tag
#define UIAlertViewTag1 201
#define UIAlertViewTag2 202

#import "PhoneDetailViewController.h"
#import "BookDetailHeadTableViewCell.h"
#import "BookDetailTimeTableViewCell.h"
#import "BookDetailDescribeTableViewCell.h"
//toolView
#import "BookDetailToolView.h"
//成功成功接受预约
#import "BookSuccessViewController.h"
//预约拒绝理由
#import "BookRefuseReasonViewController.h"
#import "PhoneDetailModel.h"
@interface PhoneDetailViewController ()

//描述cell的高度
@property (nonatomic, assign) CGFloat cellHeigth;
@property (nonatomic, strong) BookDetailToolView *toolView;

@end

@implementation PhoneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.height = self.tableView.height - 65;
    [self.view addSubview:self.toolView];
    //显示同意和拒绝按钮
    [self.toolView changeViewHide:BookDetailToolViewTypeIsUp andTitle:@""];
    [self getMyOrdertelInfo];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getMyOrdertelInfo{
    [self showHudAuto:WaitPrompt];
    WeakSelf(PhoneDetailViewController);
    [weakSelf.dataArray removeAllObjects];
    [[THNetWorkManager shareNetWork] getMyOrdertelInfoId:self.ids andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            PhoneDetailModel * model = [response thParseDataFromDic:response.dataDic andModel:[PhoneDetailModel class]];
            [weakSelf.dataArray addObject:model];
            

            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
        
}

- (void)getPhoneDetailDataOfOpt:(NSInteger )opt{
    [self showHudAuto:WaitPrompt];
    WeakSelf(PhoneDetailViewController);
    [[THNetWorkManager shareNetWork] processMyOrdertelId:self.ids opt:opt andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            PhoneDetailModel *model = weakSelf.dataArray[0];
            NSLog(@"查看%@",response.dataDic[@"status"]);
            WeakSelf(PhoneDetailViewController);
            BookSuccessViewController *bookSuccessVc = [[BookSuccessViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            bookSuccessVc.timeStrig = model.order_date_n;
            bookSuccessVc.nameString = model.truename;
            [bookSuccessVc setBookSuccessBlock:^{
                [weakSelf.toolView changeViewHide:BookDetailToolViewTypeIsDown andTitle:@"打电话"];
            }];
            [self.navigationController pushViewController:bookSuccessVc animated:YES];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
        
}

#pragma mark -UI

- (BookDetailToolView *)toolView{
    WeakSelf(PhoneDetailViewController);
    if (!_toolView) {
        _toolView = [[BookDetailToolView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, DeviceSize.width, 65)];
        _toolView.backgroundColor = self.view.backgroundColor;
        //同意
        [_toolView setAgreedBlock:^{
            
            UIAlertView * uploadView = [[UIAlertView alloc]initWithTitle:@"" message:@"确定要同意患者李可的电话预约吗?" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            uploadView.tag = UIAlertViewTag1;
            [uploadView show];
            
        }];
        
        //拒绝
        [_toolView setRefusedBlock:^{
            BookRefuseReasonViewController *bookRefuseReasonVc = [[BookRefuseReasonViewController alloc] init];
            [bookRefuseReasonVc setBookRefuseReasonBlock:^{
                [weakSelf.toolView changeViewHide:BookDetailToolViewTypeIsDown andTitle:@"已拒绝"];
            }];
            [weakSelf.navigationController pushViewController:bookRefuseReasonVc animated:YES];
        }];
        //打电话
        [_toolView setCallPhoneBlock:^{
            UIAlertView * uploadView = [[UIAlertView alloc]initWithTitle:@"" message:@"确定要拨打患者李可的电话\n18911512662?" delegate:weakSelf cancelButtonTitle:@"取消" otherButtonTitles:@"拨打",nil];
            uploadView.tag = UIAlertViewTag2;
            [uploadView show];
        }];
        
    }
    return _toolView;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == UIAlertViewTag1) {
        if (buttonIndex==0) {
            
        }else{
            
            [self getPhoneDetailDataOfOpt:1];
            
            
           
        }
    }else{
        if (buttonIndex==0) {
            
        }else{
            
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"BookDetailHeadTableViewCell";
        BookDetailHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[BookDetailHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dataArray[0]];
        return cell;
    }else if (indexPath.section == 1){
        static NSString *identifier = @"BookDetailTimeTableViewCell";
        BookDetailTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[BookDetailTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dataArray[0]];
        return cell;
    }else{
        static NSString *identifier = @"BookDetailDescribeTableViewCell";
        BookDetailDescribeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[BookDetailDescribeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellHeigth = [cell confingWithModel:self.dataArray[0]];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }else if(indexPath.section == 1){
        return 44;
    }else{
        return self.cellHeigth;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (NSString *)title{
    return @"预约详情";
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
