//
//  MedicationAddViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "MedicationAddViewController.h"
#import "MedicationAddHeadTableViewCell.h"
#import "MedicationAddTableViewCell.h"
#import "TimeView.h"
#import "WayDrugViewController.h"
//用药和剂量
#import "MedicationAddInputViewController.h"
//用药次数
#import "MedicationAddNumViewController.h"

@interface MedicationAddViewController ()
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) TimeView *viewTime;
@property (nonatomic, strong) UIView *viewGray;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSIndexPath * indexPaths;
//药物名称
@property (nonatomic, copy) NSString *ywName;
//剂量
@property (nonatomic, copy) NSString *jlName;
//次数
@property (nonatomic, copy) NSString *csName;
//用药时间
@property (nonatomic, copy) NSString *yyTime;
//用药途径
@property (nonatomic, copy) NSString *yyType;
//开始时间
@property (nonatomic, copy) NSString *ksTime;
//结束时间
@property (nonatomic, copy) NSString *jsTime;



@end

@implementation MedicationAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"真的爱你%@",self.mid );
    //默认值
    self.ywName = @"";
    self.jlName = @"一次(100mg)";
    self.csName = @"一天三次(8:00、12:00、18:00)";
    self.yyTime = @"餐后";
    self.yyType = @"口服";
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    
    NSDate *date = [NSDate date];
    
    
    NSDate *tomorrow = [NSDate dateWithTimeInterval:60 * 60 * 24 *15 sinceDate:date];
    
    
    self.ksTime = [formatter stringFromDate:date];
    self.jsTime = [formatter stringFromDate:tomorrow];
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"药物名称",@"detail":self.ywName},
  @{@"title":@"剂量",@"detail":self.jlName},
  @{@"title":@"次数",@"detail":self.csName},
  @{@"title":@"用药时间",@"detail":self.yyTime},
  @{@"title":@"用药途径",@"detail":self.yyType},
  @{@"title":@"开始时间",@"detail":self.ksTime},
  @{@"title":@"结束时间",@"detail":self.jsTime}]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.height = self.tableView.height -65;
    [self.view addSubview:self.btn];
    [self.view addSubview:self.viewGray];
    [self.view addSubview:self.viewTime];
//    [self.viewTime addSubview:self.datePicker];
}

- (void)medicationAddData{
    if (self.ywName.length == 0) {
        [self showHudAuto:@"请输入药物名称" andDuration:@"2"];
    }else{
        [self showHudAuto:@"保存中..."];
        WeakSelf(MedicationAddViewController);
        [[THNetWorkManager shareNetWork] addPatientDrugMid:self.mid Name:self.ywName Use_level:self.jlName Use_num:self.csName Use_time:self.yyTime Use_method:self.yyType Start_time:self.ksTime End_time:self.jsTime CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
            [weakSelf removeMBProgressHudInManaual];
            if (response.responseCode == 1) {
                NSLog(@"查看%@",response.dataDic);
                [weakSelf showHudAuto:@"保存成功" andDuration:@"2"];
                
            }else{
                [weakSelf showHudAuto:response.message andDuration:@"2"];
            }
        } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
            [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
            ;
        } ];
    }
        
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -ui

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(12, self.tableView.bottom +10, DeviceSize.width - 24, 45);
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_btn setTitle:@"提交" forState:UIControlStateNormal];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = 5;
        _btn.backgroundColor = [UIColor colorWithHEX:0x008aff];
        
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)btnAction{
    [self medicationAddData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"idertifier";
    MedicationAddTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MedicationAddTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell confingWithModel:self.dataArray[indexPath.section]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(MedicationAddViewController);
    if (indexPath.section == 0) {
        MedicationAddInputViewController *medicationAddInputVc= [[MedicationAddInputViewController alloc] init];
        medicationAddInputVc.index = 0;
        [medicationAddInputVc setNameBlock:^(NSString *name) {
            weakSelf.ywName = name;
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.section withObject:@{@"title":@"药物名称",@"detail":self.ywName}];
            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:medicationAddInputVc animated:YES];
    }
    
    if (indexPath.section == 1) {
        MedicationAddInputViewController *medicationAddInputVc= [[MedicationAddInputViewController alloc] init];
        medicationAddInputVc.index = 1;
        [medicationAddInputVc setNameBlock:^(NSString *name) {
            weakSelf.jlName = name;
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.section withObject:@{@"title":@"剂量",@"detail":self.jlName}];
            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:medicationAddInputVc animated:YES];
    }
    
    if (indexPath.section == 2) {
        MedicationAddNumViewController *medicationAddNumVc = [[MedicationAddNumViewController alloc] init];
        [medicationAddNumVc setMedicationAddNumBlock:^(NSString *name) {
            self.csName = name;
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.section withObject:@{@"title":@"次数",@"detail":self.csName}];
            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:medicationAddNumVc animated:YES];
    }
    
    if (indexPath.section == 3) {
        WayDrugViewController * WayDrugVc = [[WayDrugViewController alloc]init];
        WayDrugVc.index = 0;
        [WayDrugVc setWayDrugBlock:^(NSString *name) {
            weakSelf.yyTime = name;
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.section withObject:@{@"title":@"用药时间",@"detail":self.yyTime}];
            [weakSelf.tableView reloadData];
            
        }];
        [self.navigationController pushViewController:WayDrugVc animated:YES];
    }
    
    
    if (indexPath.section == 4) {
        WayDrugViewController * WayDrugVc = [[WayDrugViewController alloc]init];
        WayDrugVc.index = 1;
        [WayDrugVc setWayDrugBlock:^(NSString *name) {
            weakSelf.yyType = name;
            [weakSelf.dataArray replaceObjectAtIndex:indexPath.section withObject:@{@"title":@"用药途径",@"detail":self.yyType}];
            [weakSelf.tableView reloadData];
            
        }];
        [self.navigationController pushViewController:WayDrugVc animated:YES];
    }
    
    
    if (indexPath.section == 5||indexPath.section == 6) {
        self.indexPaths = indexPath;
        [self showViewAnimate];
    }
   
}
- (NSString *)title{
    return @"添加用药";
}
- (TimeView *)viewTime{
    if (!_viewTime) {
        _viewTime = [[TimeView alloc]initWithFrame:CGRectMake(0, DeviceSize.height, DeviceSize.width, 260) title:@"用药时间"];
        WeakSelf(MedicationAddViewController);
        _viewTime.backgroundColor = [UIColor whiteColor];
        [_viewTime setSureBlock:^(NSString * str) {
            [UIView animateWithDuration:.25 animations:^{
                weakSelf.viewTime.frame = CGRectMake(0, DeviceSize.height, DeviceSize.width, 260);
            } completion:^(BOOL finished) {
                weakSelf.viewGray.hidden = YES;
            }];
            MedicationAddTableViewCell * cell = [weakSelf.tableView cellForRowAtIndexPath:weakSelf.indexPaths];
            cell.labDetail.text = str;
        }];
        [_viewTime setCancelBlock:^{
            [UIView animateWithDuration:.25 animations:^{
                weakSelf.viewTime.frame = CGRectMake(0, DeviceSize.height, DeviceSize.width, 260);
            } completion:^(BOOL finished) {
                weakSelf.viewGray.hidden = YES;
            }];
        }];
    }
    return _viewTime;
}
- (UIView *)viewGray{
    if (!_viewGray) {
        _viewGray = [[UIView alloc]initWithFrame:CGRectMake(0,0 , DeviceSize.width, DeviceSize.height)];
        _viewGray.backgroundColor = [UIColor grayColor];
        _viewGray.alpha = 0.6;
        _viewGray.hidden = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGray)];
        
        [_viewGray addGestureRecognizer:tap];
    }
    return _viewGray;
}
- (void)tapGray{
    WeakSelf(MedicationAddViewController);
    [UIView animateWithDuration:.25 animations:^{
        weakSelf.viewTime.frame = CGRectMake(0, DeviceSize.height, DeviceSize.width, 260);
    } completion:^(BOOL finished) {
        weakSelf.viewGray.hidden = YES;
    }];
}
- (void)showViewAnimate{
    [UIView animateWithDuration:.25 animations:^{
        self.viewTime.frame = CGRectMake(0, DeviceSize.height-260-self.frameTopHeight, DeviceSize.width, 260);
        self.viewGray.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
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
