//
//  DynamicDetailViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "DynamicDetailViewController.h"
#import "DynamicDetailTableViewCell.h"
#import "DynamicDetailToolView.h"
@interface DynamicDetailViewController ()
//cell高度
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic ,strong) DynamicDetailToolView *toolView;
@end

@implementation DynamicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.height = self.tableView.height - 45;
    [self.view addSubview:self.toolView];
    self.view.backgroundColor = [UIColor colorWithHEX:0xffffff];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (DynamicDetailToolView *)toolView{
    WeakSelf(DynamicDetailViewController);
    if (!_toolView) {
        _toolView = [[DynamicDetailToolView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, DeviceSize.width, 45)];
        [_toolView setToolBlock:^(NSInteger index) {
            
        }];
    }
    return _toolView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    DynamicDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[DynamicDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cellHeight = [cell confingWithModel:nil];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHeight;
}

- (NSString *)title{
    return @"医疗资讯";
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
