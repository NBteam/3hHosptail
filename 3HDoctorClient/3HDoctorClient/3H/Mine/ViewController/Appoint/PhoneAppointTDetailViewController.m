//
//  PhoneAppointTDetailViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PhoneAppointTDetailViewController.h"
#import "PhoneAppointTDetailModel.h"
@interface PhoneAppointTDetailViewController ()

@property (nonatomic, strong) UIView *viewBack;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PhoneAppointTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"删除"];
    [self.view addSubview:self.viewBack];
    [self.viewBack addSubview:self.labTitle];
    [self getOrderTelSetdate];
    
    
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightAction{
    [self removeTimeItemsNetWork];
}
- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(10, 10, DeviceSize.width -20, 10)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewBack.layer.borderColor = [UIColor colorWithHEX:0xccccccc].CGColor;
        _viewBack.layer.borderWidth = 0.5;
    }
    return _viewBack;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.viewBack.width, 40)];
        _labTitle.backgroundColor = [UIColor colorWithHEX:0xffae58];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = [UIColor colorWithHEX:0xffffff];
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.text = self.dateString;
    }
    return _labTitle;
}

- (void)customButton{
    
    CGFloat f = self.viewBack.width/4 +0.25 +0.125;
    for (int i =0;i < self.dataArray.count; i++) {
        PhoneAppointTDetailModel *model = self.dataArray[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0+(f -0.5)*(i%4), self.labTitle.bottom - 0.5 +(f/3 *2 -0.5)*(i/4), f, f/3 *2);
        btn.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        btn.layer.borderWidth = 0.5;
        btn.backgroundColor = [UIColor colorWithHEX:0xffffff];
        
        btn .titleLabel.numberOfLines=2;
        
        
        if (model.member_n.length  != 0) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(btn.width -33, 0, 33, 33)];
            img.image = [UIImage imageNamed:@"我的-预约设置-电话预约-30_已约"];
            [btn addSubview:img];
            [btn setTitle:[NSString stringWithFormat:@"%@\n%@",model.member_n,model.start_time] forState:UIControlStateNormal];
            [btn setTitleColor:AppDefaultColor forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
        }else{
            
            [btn setTitle:model.start_time forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor colorWithHEX:0x333333] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        
        
        [self.viewBack addSubview:btn];
        self.viewBack.height = btn.bottom;
    }
}



- (void)getOrderTelSetdate{
    [self.dataArray removeAllObjects];
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(PhoneAppointTDetailViewController);
    [[THNetWorkManager shareNetWork] getOrderTelSetdate:self.dateString CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            for (NSDictionary * dict in response.dataDic[@"items"]) {
                PhoneAppointTDetailModel * model = [response thParseDataFromDic:dict andModel:[PhoneAppointTDetailModel class]];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf customButton];
    
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
        
}
- (void)removeTimeItemsNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(PhoneAppointTDetailViewController);
    [[THNetWorkManager shareNetWork]removeTimeItemsDate:self.dateString andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            if (weakSelf.reloadInfo) {
                weakSelf.reloadInfo();
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (NSString *)title{
    return @"预约详情";
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
