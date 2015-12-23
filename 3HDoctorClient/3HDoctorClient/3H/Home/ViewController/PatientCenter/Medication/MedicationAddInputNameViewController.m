//
//  MedicationAddInputNameViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/23.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MedicationAddInputNameViewController.h"
#import "DiagnosisListModel.h"
@interface MedicationAddInputNameViewController ()
//背景
@property (nonatomic, strong) UIView *backView;
//
@property (nonatomic, strong) UITextField *txtNameInput;

//保存
@property (nonatomic, strong) UIButton *btnSave;


@end

@implementation MedicationAddInputNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.backView];
    [self.view addSubview:self.txtNameInput];
    [self.view addSubview:self.btnSave];
    
    self.tableView.top = self.backView.bottom;
    self.tableView.height = self.tableView.height - self.backView.height;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(addAction) andTarget:self andButtonTitle:@"搜索"];
}

- (void)getDiagosisListData{
    
    [self.dataArray removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(MedicationAddInputNameViewController);
    [[THNetWorkManager shareNetWork] getSickListshort:self.txtNameInput.text CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            for (NSDictionary * dict in response.dataDic[@"list"]) {
                DiagnosisListModel * model = [response thParseDataFromDic:dict andModel:[DiagnosisListModel class]];
                [weakSelf.dataArray addObject:model];
            }
            
            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addAction{
    [self.txtNameInput resignFirstResponder];
    [self getDiagosisListData];
}

#pragma mark -UI

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(12, 12, DeviceSize.width - 24, 45)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 5;
        _backView.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _backView.layer.borderWidth = 0.5;
    }
    return _backView;
}
- (UITextField *)txtNameInput{
    if (!_txtNameInput) {
        _txtNameInput = [[UITextField alloc] initWithFrame:CGRectMake(24, 12 +2.5, DeviceSize.width -30 -24, 40)];
        
        //是否纠错
        _txtNameInput.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtNameInput.font = [UIFont systemFontOfSize:15];
        _txtNameInput.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入药物名称" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x888888]}];
        _txtNameInput.backgroundColor = [UIColor whiteColor];
        
    }
    return _txtNameInput;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DiagnosisDetailTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithHEX:0x333333];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    DiagnosisListModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
    DiagnosisListModel *model = self.dataArray[indexPath.row];
    if (self.nameBlock){
        self.nameBlock(model.name);
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (NSString *)title{
    return @"添加用药";
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
