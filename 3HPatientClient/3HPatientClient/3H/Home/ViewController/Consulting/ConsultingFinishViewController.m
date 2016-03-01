//
//  ConsultingFinishViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/22.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ConsultingFinishViewController.h"
#import "FinishHeadView.h"
#import "FinishTableViewCell.h"

@interface ConsultingFinishViewController ()
@property (nonatomic, retain) FinishHeadView * headView;
@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation ConsultingFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView  = self.headView;
    self.title = @"预约完成";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    // Do any additional setup after loading the view.
}
- (void)backAction{
    [self.navigationController popToViewController:self.navigationController.viewControllers[self.navigationController.viewControllers.count - 4] animated:YES];
}

- (FinishHeadView *)headView{
    if (!_headView) {
        _headView = [[FinishHeadView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 140)];
    }
    return _headView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellName";
    FinishTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[FinishTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    self.cellHeight = [cell configWithModel:self.str];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
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
