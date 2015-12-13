//
//  PersonalViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalHeadTableViewCell.h"
#import "PersonalTableViewCell.h"
#import "PersonalInputViewController.h"
#import "SexViewController.h"
@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"用户名",@"detail":@"未填写"},@{@"title":@"姓名",@"detail":@"未填写"},@{@"title":@"性别",@"detail":@"未填写"},@{@"title":@"出生日期",@"detail":@"未填写"},@{@"title":@"通讯地址",@"detail":@"未填写"},@{@"title":@"电话",@"detail":@"未填写"},@{@"title":@"身份证号",@"detail":@"未填写"}]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"PersonalHeadTableViewCell";
        PersonalHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[PersonalHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dataArray[indexPath.row]];
        return cell;
    }else{
        static NSString *identifier = @"PersonalTableViewCell";
        PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[PersonalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dataArray[indexPath.row]];
        return cell;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 45;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}
//index 0 == 用户名 1 == 姓名  2 == 通讯地址  3 == 电话  4 == 身份证号
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(PersonalViewController);
    if (indexPath.section == 0) {
        
    }else{
        
        if (indexPath.row == 2) {
            SexViewController *sexVc = [[SexViewController alloc] init];
            [self.navigationController pushViewController:sexVc animated:YES];
        }else{
            PersonalInputViewController *personalInputVc = [[PersonalInputViewController alloc] init];
            
            if (indexPath.row == 0) {//用户名
                
                personalInputVc.index = 0;
            }else if(indexPath.row == 1){//姓名
                personalInputVc.index = 1;
                
            }else if(indexPath.row == 2){//性别
                
                
                
            }else if(indexPath.row == 3){//出生日期
                
            }else if(indexPath.row == 4){//通讯地址
                personalInputVc.index = 2;
                
            }else if(indexPath.row == 5){//电话
                personalInputVc.index = 3;
                
            }else{//身份证
                personalInputVc.index = 4;
            }
            
            [personalInputVc setNameBlock:^(NSString *name) {
                [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":self.dataArray[indexPath.row][@"title"],@"detail":name}];
                [weakSelf.tableView reloadData];
            }];
            [self.navigationController pushViewController:personalInputVc animated:YES];
        }
        
        
    }
    
}

- (NSString *)title{
    return @"个人资料";
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
