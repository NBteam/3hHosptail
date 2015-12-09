//
//  ConsultingViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingViewController.h"
#import "ConsultingHeadView.h"
#import "ConsultingTableViewCell.h"
#import "ConsultingToolView.h"
//在线咨询
#import "ConsultingIsOnlineViewController.h"
//电话咨询
#import "ConsultingIsPhoneViewController.h"
@interface ConsultingViewController ()
@property (nonatomic, strong) ConsultingHeadView *headView;
@property (nonatomic, strong) ConsultingToolView *toolView;

@property (nonatomic, assign) CGFloat cellHeight;
@end

@implementation ConsultingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.height = self.tableView.height -45;
    [self.view addSubview:self.toolView];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UI

- (ConsultingHeadView *)headView{
    if (!_headView) {
        _headView = [[ConsultingHeadView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 278/2)];
        [_headView confingWithModel:-1];
    }
    return _headView;
}

- (ConsultingToolView *)toolView{
    WeakSelf(ConsultingViewController);
    if (!_toolView) {
        _toolView = [[ConsultingToolView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, DeviceSize.width, 45)];
        [_toolView setToolBlock:^(NSInteger index) {
            if (index == 0) {
                ConsultingIsOnlineViewController *consultingIsOnlineVc = [[ConsultingIsOnlineViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                [weakSelf.navigationController pushViewController:consultingIsOnlineVc animated:YES];
            }else{
                ConsultingIsPhoneViewController *consultingIsPhoneVc = [[ConsultingIsPhoneViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                [weakSelf.navigationController pushViewController:consultingIsPhoneVc animated:YES];
            }
        }];
    }
    return _toolView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ConsultingTableViewCell";
    ConsultingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ConsultingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cellHeight = [cell confingWithModel:1];
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
    return 10;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 278/2)];
//    view.backgroundColor = self.view.backgroundColor;
//    [view addSubview:self.headView];
//    
////    // 单击的 Recognizer
////    UITapGestureRecognizer* allLabelSingleRecognizer;
////    allLabelSingleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewSingleTap)];
////    //点击的次数
////    allLabelSingleRecognizer.numberOfTapsRequired = 1; // 单击
////    //点击的手指数
////    allLabelSingleRecognizer.numberOfTouchesRequired = 1;
////    //给view添加一个手势监测；
////    [view addGestureRecognizer:allLabelSingleRecognizer];
//    return  view;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
- (NSString *)title{
    return @"我要咨询";
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
