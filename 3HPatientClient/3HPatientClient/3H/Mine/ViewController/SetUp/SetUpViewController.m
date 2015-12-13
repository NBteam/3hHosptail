//
//  SetUpViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "SetUpViewController.h"
#import "SetUpTableViewCell.h"
#import "AppDelegate.h"
//意见反馈
#import "FeedbackViewController.h"
//评价
#import "EvaluationViewController.h"
//关于
#import "AboutViewController.h"
@interface SetUpViewController ()
//注销
@property (nonatomic, strong) UIButton *btnCancel;
@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.height = self.tableView.height -65;
    [self.view addSubview:self.btnCancel];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UI
- (UIButton *)btnCancel{
    if (!_btnCancel) {
        _btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCancel.frame = CGRectMake(10, DeviceSize.height -self.frameTopHeight -45 -10, DeviceSize.width -20, 45);
        _btnCancel.layer.masksToBounds = YES;
        _btnCancel.layer.cornerRadius = 5;
        _btnCancel.backgroundColor = AppDefaultColor;
        [_btnCancel setTitle:@"注销" forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnCancel setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        [_btnCancel addTarget:self action:@selector(btnCancelAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnCancel;
}

- (void)btnCancelAction{
    [(AppDelegate*)[UIApplication sharedApplication].delegate setWindowRootViewControllerIsLogin];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SetUpTableViewCell";
    SetUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[SetUpTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {//清理缓存
        
    }else if (indexPath.row == 1){//意见
        
        FeedbackViewController *feedbackVc = [[FeedbackViewController alloc] init];
        [self.navigationController pushViewController:feedbackVc animated:YES];
        
    }else if (indexPath.row == 2){//评价
        
        EvaluationViewController *evaluationVc = [[EvaluationViewController alloc] init];
        [self.navigationController pushViewController:evaluationVc animated:YES];
        
    }else{//关于
        
        AboutViewController *aboutVc = [[AboutViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:aboutVc animated:YES];
        
    }
}

- (NSString *)title{
    return @"设置";
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
