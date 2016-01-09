//
//  AppointFinishViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AppointFinishViewController.h"
#import "AppointFinishHeadTableViewCell.h"
#import "AppointFinishTableViewCell.h"
@interface AppointFinishViewController ()

@end

@implementation AppointFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    
    
}

- (void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - UI

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"AppointFinishHeadTableViewCell";
        AppointFinishHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[AppointFinishHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *identifier = @"AppointFinishTableViewCell";
        AppointFinishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[AppointFinishTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 130;
    }
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
    return @"预约完成";
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
