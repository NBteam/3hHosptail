//
//  NewMyArchivesViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "NewMyArchivesViewController.h"

@interface NewMyArchivesViewController ()

@end

@implementation NewMyArchivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyAppointmentTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = self.view.backgroundColor;
    cell.textLabel.text = @"健康档案";
    cell.textLabel.textColor = [UIColor grayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // [cell confingWithModel:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 45)];
    UILabel * labTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, DeviceSize.width - 20, 45)];
    labTitle.font = [UIFont systemFontOfSize:15];
    labTitle.textAlignment = NSTextAlignmentLeft;
    labTitle.text = @"基本信息";
    labTitle.backgroundColor = [UIColor clearColor];
    headView.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    [headView addSubview:labTitle];
    return headView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}



- (NSString *)title{
    return @"我的健康档案";
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
