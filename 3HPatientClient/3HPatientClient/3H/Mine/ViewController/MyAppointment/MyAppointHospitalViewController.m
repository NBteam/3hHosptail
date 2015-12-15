//
//  MyAppointHospitalViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/14.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MyAppointHospitalViewController.h"
#import "MyAppointHospitalTableViewCell.h"
@interface MyAppointHospitalViewController ()

@end

@implementation MyAppointHospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.height = self.tableView.height - 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyAppointmentTableViewCell";
    MyAppointHospitalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyAppointHospitalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = self.view.backgroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
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
