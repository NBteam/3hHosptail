//
//  WayDrugViewController.m
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "WayDrugViewController.h"

@interface WayDrugViewController ()
@property (nonatomic, strong) UIView * headView;
@property (nonatomic, strong) UILabel * labTitle;
@property (nonatomic, strong) UILabel * labLine;
@end

@implementation WayDrugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.headView addSubview:self.labLine];
//    [self.headView addSubview:self.labTitle];
//    self.tableView.tableHeaderView = self.headView;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.dataArray = [NSMutableArray arrayWithObjects:@"口服",@"口含",@"肌肉注射",@"皮下注射",@"静滴",@"其他", nil];

    // Do any additional setup after loading the view.
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 50)];
    }
    return _headView;
}
- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc]initWithFrame:CGRectMake(0, self.headView.bottom-10, DeviceSize.width, 10)];
        _labLine.backgroundColor = [UIColor grayColor];
    }
    return _labLine;
}
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc]initWithFrame:CGRectMake(15,0, DeviceSize.width-30, 40)];
//        _labTitle.textColor = [UIColor grayColor];
        _labTitle.text = @"请选择用药途径:";
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
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
    //    DepartmentModel * model = self.dataArray[indexPath.row];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    DepartmentModel * model = self.dataArray[indexPath.row];
    //    if (self.choiceBlock) {
    //        self.choiceBlock(model.id,model.name,model.pid);
    //    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSString *)title{
    return @"用药途径";
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
