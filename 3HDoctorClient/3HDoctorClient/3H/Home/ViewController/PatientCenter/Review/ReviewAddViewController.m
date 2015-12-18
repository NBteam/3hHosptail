//
//  ReviewAddViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "ReviewAddViewController.h"
#import "ReviewAddTitleTableViewCell.h"
#import "ReviewAddChooseTableViewCell.h"
#import "ReviewAddProjectTableViewCell.h"
#import "ReviewAddHosptailViewController.h"
#import "TimeView.h"

@interface ReviewAddViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView *viewBack;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labLine;
//发送提醒
@property (nonatomic, strong) UIButton *btn;
//复查日期
@property (nonatomic, copy) NSString *fcTime;
//复查时段
@property (nonatomic, copy) NSString *fcShiD;
//复查医院
@property (nonatomic, copy) NSString *fcHosptail;
//复查项目 1 == 门诊复查 2 == 手动
@property (nonatomic, copy) NSString *fcXiangM;

@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;

@property (nonatomic, strong) TimeView *viewTime;
@property (nonatomic, strong) UIView *viewGray;

@end

@implementation ReviewAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.viewBack];
    [self.viewBack addSubview:self.labTitle];
    [self.viewBack addSubview:self.labLine];
    [self.view addSubview:self.tableView];
//    self.tableView.top = self.viewBack.bottom;
//    self.tableView.height = self.tableView.height - 44 -65;
    [self.view addSubview:self.btn];
    
    self.fcTime = @"复查日期";
    self.fcShiD = @"上午";
    self.fcHosptail = @"复查医院";
    self.fcXiangM = @"门诊随诊";
    [self.view addSubview:self.viewGray];
    [self.view addSubview:self.viewTime];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -ui



- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 44)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
    }
    return _viewBack;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width -20, 44)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"提醒患者按以下方式进行复查";
        _labTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labTitle;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.viewBack.bottom -0.5, DeviceSize.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}

- (TPKeyboardAvoidingTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectMake(0, self.viewBack.bottom, DeviceSize.width, DeviceSize.height -self.frameTopHeight -self.viewBack.height -65) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = self.view.backgroundColor;
    }
    return _tableView;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(12, self.tableView.bottom +10, DeviceSize.width - 24, 45);
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_btn setTitle:@"发送提醒" forState:UIControlStateNormal];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = 5;
        _btn.backgroundColor = [UIColor colorWithHEX:0x008aff];
        
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)btnAction{
    
    
    if ([self.fcXiangM isEqualToString:@"门诊随诊"]) {
        
    }else{
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:3];
        ReviewAddProjectTableViewCell *cell = (ReviewAddProjectTableViewCell *)[self.tableView cellForRowAtIndexPath:index];
        self.fcXiangM = cell.txtField.text;
    }
    
    NSLog(@"---%@",self.fcTime);
    NSLog(@"---%@",self.fcShiD);
    NSLog(@"---%@",self.fcHosptail);
    NSLog(@"---%@",self.fcXiangM);
    
    if ([self.fcTime isEqualToString:@"复查日期"]) {
         [self showHudAuto:@"请选择复查日期" andDuration:@"2"];
    }else if([self.fcHosptail isEqualToString:@"复查医院"]){
        [self showHudAuto:@"请选择复查医院" andDuration:@"2"];
    }else if(self.fcXiangM.length ==0){
        [self showHudAuto:@"请输入复查项目的名称" andDuration:@"2"];
    }

}

- (TimeView *)viewTime{
    if (!_viewTime) {
        _viewTime = [[TimeView alloc]initWithFrame:CGRectMake(0, DeviceSize.height, DeviceSize.width, 260) title:@"用药时间"];
        WeakSelf(ReviewAddViewController);
        _viewTime.backgroundColor = [UIColor whiteColor];
        [_viewTime setSureBlock:^(NSString * str) {
            [UIView animateWithDuration:.25 animations:^{
                weakSelf.viewTime.frame = CGRectMake(0, DeviceSize.height, DeviceSize.width, 260);
            } completion:^(BOOL finished) {
                weakSelf.viewGray.hidden = YES;
            }];
            weakSelf.fcTime = str;
            [weakSelf.tableView reloadData];
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
    WeakSelf(ReviewAddViewController);
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(ReviewAddViewController);
    if (indexPath.section == 0) {
        static NSString *identifier = @"ReviewAddTitleTableViewCell";
        ReviewAddTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ReviewAddTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.fcTime];
        return cell;
    }else if(indexPath.section == 1){
        static NSString *identifier = @"ReviewAddChooseTableViewCell";
        ReviewAddChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ReviewAddChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setBtnBlock:^(NSInteger index) {
            if (index == 1) {
                weakSelf.fcShiD = @"上午";
            }else{
                weakSelf.fcShiD = @"下午";
            }
        }];
        
        return cell;
    }else if(indexPath.section == 2){
        static NSString *identifier = @"ReviewAddTitleTableViewCell";
        ReviewAddTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ReviewAddTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.fcHosptail];
        
        return cell;
    }else{
        static NSString *identifier = @"ReviewAddProjectTableViewCell";
        ReviewAddProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ReviewAddProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell setBtnBlock:^(NSInteger index, NSString *str) {
            if (index == 1) {
                weakSelf.fcXiangM = @"门诊随诊";
            }else{
                
                weakSelf.fcXiangM = @"";
            }
        }];
        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 190;
    }else{
        return 45;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(ReviewAddViewController);
    if (indexPath.section ==2) {
        ReviewAddHosptailViewController *reviewAddHosptailVc = [[ReviewAddHosptailViewController alloc] init];
        [reviewAddHosptailVc setReviewAddHosptailBlock:^(NSString *name) {
            weakSelf.fcHosptail =name;
            [weakSelf.tableView reloadData];
        }];
        
        [self.navigationController pushViewController:reviewAddHosptailVc animated:YES];
    }
    
    if (indexPath.section == 0) {
         [self showViewAnimate];
    }
}

- (NSString *)title{
    return @"复查提醒";
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
