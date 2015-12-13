//
//  ConsultingIsPhoneViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ConsultingIsPhoneViewController.h"
#import "ConsultingIsPhoneTitleTableViewCell.h"
#import "ConsultingIsPhoneTimeTableViewCell.h"
#import "ConsultingIsPhoneDescTableViewCell.h"
@interface ConsultingIsPhoneViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@end

@implementation ConsultingIsPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.tableView];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (TPKeyboardAvoidingTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, DeviceSize.height -self.frameTopHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = self.view.backgroundColor;
    }
    return _tableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        static NSString *identifier = @"ConsultingIsPhoneTitleTableViewCell";
        ConsultingIsPhoneTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ConsultingIsPhoneTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:1];
        return cell;
    }else if (indexPath.section == 1){
        static NSString *identifier = @"ConsultingIsPhoneTimeTableViewCell";
        ConsultingIsPhoneTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ConsultingIsPhoneTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:1];
        return cell;
    }else{
        static NSString *identifier = @"ConsultingIsPhoneDescTableViewCell";
        ConsultingIsPhoneDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ConsultingIsPhoneDescTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 45;
    }else if (indexPath.section == 1){
        return 180 +35 +50;
    }else{
        return 200;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (NSString *)title{
    return @"电话咨询";
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
