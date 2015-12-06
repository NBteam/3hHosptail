//
//  CityListFirstLevelViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "CityListFirstLevelViewController.h"
#import "CityListModel.h"
#import "CityListSecondLevelViewController.h"
@interface CityListFirstLevelViewController ()

@end

@implementation CityListFirstLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requsetCityListFirstLevelData];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requsetCityListFirstLevelData{
    WeakSelf(CityListFirstLevelViewController);
    
    [[THNetWorkManager shareNetWork] getCityListCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        [weakSelf.dataArray removeAllObjects];
        if (response.responseCode == 1) {
            
            for (NSDictionary *dict in response.dataArray) {
                CityListModel *model = [response thParseDataFromDic:dict andModel:[CityListModel class]];
                [weakSelf.dataArray addObject:model];
            }
        
            [weakSelf.tableView reloadData];
            
        } else {
            [weakSelf showHudAuto:response.message];
        }
        
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt];
    }];
    [weakSelf showHudWaitingView:WaitPrompt];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithHEX:0x333333];
    CityListModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.areaname;
    return cell;
    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityListSecondLevelViewController *cityListSecondLevelVc = [[CityListSecondLevelViewController alloc] init];
    CityListModel *model = self.dataArray[indexPath.row];
    cityListSecondLevelVc.secondArray = model.slist;
    cityListSecondLevelVc.cityListBlock = self.cityListBlock;
    [self.navigationController pushViewController:cityListSecondLevelVc animated:YES];
}

- (NSString *)title{
    return @"所在城市";
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
