//
//  MyAddressViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MyAddressViewController.h"
#import "MyAddressTableViewCell.h"
@interface MyAddressViewController ()

@property (nonatomic, strong) UIView *viewTool;

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIButton *btnAdd;
@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    
    self.tableView.height = self.tableView.height - 40;
    [self.view addSubview:self.viewTool];
    [self.viewTool addSubview:self.labLine];
    [self.viewTool addSubview:self.labTitle];
    [self.viewTool addSubview:self.btnAdd];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


- (UIView *)viewTool{
    if (!_viewTool) {
        _viewTool = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, DeviceSize.width, 40)];
        _viewTool.backgroundColor = [UIColor colorWithHEX:0xffffff];
        
    }
    return _viewTool;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 40)];
        _labTitle.font = [UIFont systemFontOfSize:13];
        _labTitle.textColor = [UIColor colorWithHEX:0x999999];
        _labTitle.text = @"新增收货地址";
    }
    return _labTitle;
}

- (UIButton *)btnAdd{
    if (!_btnAdd) {
        _btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAdd.frame = CGRectMake(DeviceSize.width -47,0 , 47, 40);
        [_btnAdd setImage:[UIImage imageNamed:@"首页-健康商城-商品详情-立即购买-收货地址2"] forState:UIControlStateNormal];
        [_btnAdd addTarget:self action:@selector(btnAddAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _btnAdd;
}

- (void)btnAddAction{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    MyAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MyAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:@""];
    return cell;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (NSString *)title{
    return @"收货地址";
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
