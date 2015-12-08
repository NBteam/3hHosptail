//
//  SearchViewController.m
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/8.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "SearchViewController.h"
#import "GuideSearchView.h"
#import "SearchCell.h"
@interface SearchViewController ()
@property (nonatomic,strong) GuideSearchView * viewSearch;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.title=@"搜索";
    self.tableView.top = 95/2;
    self.tableView.height = DeviceSize.height-95/2-64;
    [self.view addSubview:self.viewSearch];
    // Do any additional setup after loading the view.
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (GuideSearchView *)viewSearch{
    if (!_viewSearch) {
        _viewSearch = [[GuideSearchView alloc]init];
        _viewSearch.frame=CGRectMake(0, 0, self.view.frame.size.width, 95/2);
        WeakSelf(SearchViewController);
//        [_viewSearch setSearchText:self.majorNameStr];
        _viewSearch.textChangeValue=^(NSString * text){
//            [weakSelf searchDataString:text];
        };
        _viewSearch.btnClickBlock=^(){
//            [weakSelf.majorDataArray removeAllObjects];
        };
    }
    return _viewSearch;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"";
    SearchCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (nil==cell) {
        cell = [[SearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell configWithModel:nil];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
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
