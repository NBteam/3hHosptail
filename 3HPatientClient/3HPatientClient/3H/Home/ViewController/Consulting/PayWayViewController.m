//
//  PayWayViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 16/3/1.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "PayWayViewController.h"

@interface PayWayViewController ()
@property (nonatomic, strong) UIView * toolView;
@property (nonatomic, strong) UILabel * labLine;
@property (nonatomic, strong) UIButton * btnSure;
@end

@implementation PayWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray arrayWithObjects:@"余额支付",@"支付宝支付",@"微信支付", nil];
    self.title = @"支付方式";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.toolView];
    [self.toolView addSubview:self.labLine];
    [self.toolView addSubview:self.btnSure];
    // Do any additional setup after loading the view.
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIView *)toolView{
    if (!_toolView) {
        _toolView = [[UIView alloc]initWithFrame:CGRectMake(0, DeviceSize.height - 64 - 49, DeviceSize.width, 49)];
        _toolView.backgroundColor = [UIColor whiteColor];
    }
    return _toolView;
}
- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}
- (UIButton *)btnSure{
    if (!_btnSure) {
        _btnSure = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSure.frame = CGRectMake(10, (49 - 40)/2, DeviceSize.width - 20, 40);
        [_btnSure setTitle:@"确认支付" forState:UIControlStateNormal];
        _btnSure.layer.cornerRadius = 6.f;
        _btnSure.layer.masksToBounds = YES;
        _btnSure.backgroundColor = AppDefaultColor;
        _btnSure.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btnSure addTarget:self action:@selector(btnSureClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSure;
}
- (void)btnSureClick:(UIButton *)button{

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellName = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = AppDefaultColor;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
