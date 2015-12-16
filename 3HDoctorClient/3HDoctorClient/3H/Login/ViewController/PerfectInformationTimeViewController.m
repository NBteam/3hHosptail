//
//  PerfectInformationTimeViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/16.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PerfectInformationTimeViewController.h"
#import "OutpatientAppointTableViewCell.h"


@interface PerfectInformationTimeViewController ()
@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation PerfectInformationTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(PerfectInformationTimeViewController);
    static NSString *identifier = @"idertifier";
    OutpatientAppointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OutpatientAppointTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cellHeight = [cell confingWithModel:1];
    //拿到数据；
    [cell setOutpatientAppontBlcok:^(NSArray *arr) {
        
        
        if (weakSelf.PerfectInformationTimeBlock) {
            weakSelf.PerfectInformationTimeBlock([arr componentsJoinedByString:@","]);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (NSString *)title{
    return @"门诊时间";
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
