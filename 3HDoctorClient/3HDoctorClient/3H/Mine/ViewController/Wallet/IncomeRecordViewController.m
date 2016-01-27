//
//  IncomeRecordViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "IncomeRecordViewController.h"
#import "IncomeRecordTableViewCell.h"
@interface IncomeRecordViewController ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *labName;
@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIButton *btnDown;
@property (nonatomic, strong) UIButton *btnUp;
@property (nonatomic, strong) UIView *bgWhite;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labDetail;

@property (nonatomic, strong) UIView *dateView;


@end

@implementation IncomeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    
}

- (UIView *)bgView{
    if (!_bgView){
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 190)];
        _bgView.backgroundColor = [UIColor clearColor];
        
    }
    return _bgView;
}

- (UIView *)blueView{
    if (!_blueView) {
        _blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 45)];
        _blueView.backgroundColor = [UIColor colorWithRed:168 / 255.0f green:213 / 255.0f blue:254 / 255.0f alpha:1];
    }
    return _blueView;
}

- (UIButton *)btnUp{
    if (!_btnUp) {
        _btnUp = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnUp setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_左"] forState:UIControlStateNormal];
        _btnUp.frame = CGRectMake(0, 0, 60, 45);
        [_btnUp addTarget:self action:@selector(btnUpAction) forControlEvents:UIControlEventTouchUpInside];
        _btnUp.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
        _btnUp.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _btnUp.layer.borderWidth = 0.5;
    }
    return _btnUp;
}

- (void)btnUpAction{
    
}

- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc] initWithFrame:CGRectMake(self.btnUp.right, 0, self.btnDown.left - self.btnUp.right, 45)];
        _labName.font = [UIFont systemFontOfSize:18];
        _labName.textColor = [UIColor colorWithHEX:0x666666];
        _labName.textAlignment = NSTextAlignmentCenter;
        _labName.text = @"2015年12月";
    }
    return _labName;
}

- (UIButton *)btnDown{
    if (!_btnDown) {
        _btnDown = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDown setImage:[UIImage imageNamed:@"首页-我要预约-预约挂号-2_右"] forState:UIControlStateNormal];
        _btnDown.frame = CGRectMake(self.blueView.width - 60, 0, 60, 45);
        [_btnDown addTarget:self action:@selector(btnDownAction) forControlEvents:UIControlEventTouchUpInside];
        _btnDown.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
        _btnDown.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _btnDown.layer.borderWidth = 0.5;
    }
    return _btnDown;
}

- (void)btnDownAction{
    
}

- (UIView *)bgWhite{
    if (!_bgWhite) {
        _bgWhite = [[UIView alloc] initWithFrame:CGRectMake(0, self.blueView.bottom, DeviceSize.width, 90)];
        _bgWhite.backgroundColor = [UIColor blackColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 90 - 0.5, DeviceSize.width, 0.5)];
        lab.backgroundColor = [UIColor colorWithHEX:0xcccccc];
        [_bgWhite addSubview:lab];
        
    }
    return _bgWhite;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, DeviceSize.width, 15)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = [UIColor colorWithHEX:0x666666];
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.text = @"2015年12月";
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, self.labTitle.bottom, DeviceSize.width, 90 - self.labTitle.bottom)];
        _labDetail.font = [UIFont systemFontOfSize:45];
        _labDetail.textColor = [UIColor redColor];
        _labDetail.textAlignment = NSTextAlignmentCenter;
        _labDetail.text = @"10000.00";
    }
    return _labDetail;
}

- (UIView *)dateView{
    if (!_dateView) {
        _dateView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bgWhite.bottom +10, DeviceSize.width, 40)];
        NSLog(@"%f",self.bgWhite.bottom );
        _dateView.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
        NSArray *arr = @[@"金额",@"日期"];
        for (int i = 0; i<arr.count; i++) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width / 2 * i, 0, DeviceSize.width / 2, 40)];
            lab.font = [UIFont systemFontOfSize:15];
            lab.textColor = [UIColor colorWithHEX:0x666666];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
            lab.layer.borderWidth = 0.5;
            lab.text = arr[i];
            [_dateView addSubview:lab];
        }
    }
    
    return _dateView;
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"WalletHeadTableViewCell";
    IncomeRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[IncomeRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:1];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 185.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    [self.bgView addSubview:self.blueView];
    [self.blueView addSubview:self.btnUp];
    [self.blueView addSubview:self.btnDown];
    [self.blueView addSubview:self.labName];
    [self.bgView addSubview:self.bgWhite];
    [self.bgWhite addSubview:self.labTitle];
    [self.bgWhite addSubview:self.labDetail];
    [self.bgView addSubview:self.dateView];
    return  self.bgView;
}

- (NSString *)title{
    return @"收入记录";
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
