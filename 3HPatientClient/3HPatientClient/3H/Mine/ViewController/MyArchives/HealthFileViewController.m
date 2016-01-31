//
//  HealthFileViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/31.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "HealthFileViewController.h"
#import "NewMyArchivesViewController.h"
#import "ArchiveListViewController.h"

@interface HealthFileViewController ()

@end

@implementation HealthFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的健康档案";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.dataArray = [NSMutableArray arrayWithArray:@[@"个人基本资料",@"健康档案信息"]];
    // Do any additional setup after loading the view.
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellName = @"cellId";
    UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        UIImageView * imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 19/2 - 10, (45 - 34/2)/2, 19/2, 34/2)];
        imgArrow.image = [UIImage imageNamed:@"arrowImg"];
        [cell.contentView addSubview:imgArrow];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NewMyArchivesViewController * NewMyArchivesVc = [[NewMyArchivesViewController alloc]initWithTableViewStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:NewMyArchivesVc animated:YES];
    }else{
        ArchiveListViewController * ArchiveListVc = [[ArchiveListViewController alloc]init];
        [self.navigationController pushViewController:ArchiveListVc animated:YES];
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
