//
//  NewMyArchivesViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "NewMyArchivesViewController.h"
#import "NewMyArchivesModel.h"
#import "MedicationAddInputViewController.h"
#import "TimeView.h"
#import "ChangeInfoViewController.h"

@interface NewMyArchivesViewController ()
@property (nonatomic, strong) NewMyArchivesModel * model;
@property (nonatomic, strong) TimeView * viewTime;
@property (nonatomic, strong) UIView *viewGray;
@property (nonatomic, assign) NSInteger index;
@end

@implementation NewMyArchivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"更新"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.viewGray];
    [self.view addSubview:self.viewTime];
    [self getNetWork];
    // Do any additional setup after loading the view.
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightAction{
    if ([self.model.first_access_date isEqualToString:@""]) {
        [self showHudAuto:@"请填写首次接待日期" andDuration:@"2"];
    }else if ([self.model.truename isEqualToString:@""]){
        [self showHudAuto:@"姓名不能为空" andDuration:@"2"];
    }else if ([self.model.birth_date isEqualToString:@""]){
        [self showHudAuto:@"出生日期不能为空" andDuration:@"2"];
    }else if ([self.model.marry_info isEqualToString:@""]){
        [self showHudAuto:@"婚姻状况不能为空" andDuration:@"2"];
    }else if ([self.model.born_info isEqualToString:@""]){
        [self showHudAuto:@"生育状况不能为空" andDuration:@"2"];
    }else if ([self.model.child_info isEqualToString:@""]){
        [self showHudAuto:@"子女人数不能为空" andDuration:@"2"];
    }else if ([self.model.hight isEqualToString:@""]){
        [self showHudAuto:@"身高不能为空" andDuration:@"2"];
    }else if ([self.model.weight isEqualToString:@""]){
        [self showHudAuto:@"体重不能为空" andDuration:@"2"];
    }else if ([self.model.blood_sugar isEqualToString:@""]){
        [self showHudAuto:@"血糖不能为空" andDuration:@"2"];
    }else if ([self.model.blood_pressure isEqualToString:@""]){
        [self showHudAuto:@"血压不能为空" andDuration:@"2"];
    }else if ([self.model.job isEqualToString:@""]){
        [self showHudAuto:@"职业不能为空" andDuration:@"2"];
    }else if ([self.model.mobile isEqualToString:@""]){
        [self showHudAuto:@"手机不能为空" andDuration:@"2"];
    }else if ([self.model.email isEqualToString:@""]){
        [self showHudAuto:@"邮箱不能为空" andDuration:@"2"];
    }else if ([self.model.weixin isEqualToString:@""]){
        [self showHudAuto:@"微信不能为空" andDuration:@"2"];
    }else if ([self.model.qq isEqualToString:@""]){
        [self showHudAuto:@"QQ不能为空" andDuration:@"2"];
    }else if ([self.model.address isEqualToString:@""]){
        [self showHudAuto:@"邮寄地址不能为空" andDuration:@"2"];
    }else if ([self.model.interest isEqualToString:@""]){
        [self showHudAuto:@"个人兴趣不能为空" andDuration:@"2"];
    }else if ([self.model.huafen_guomin isEqualToString:@""]){
        [self showHudAuto:@"花粉过敏不能为空" andDuration:@"2"];
    }else if ([self.model.flower_fav isEqualToString:@""]){
        [self showHudAuto:@"喜爱鲜花不能为空" andDuration:@"2"];
    }else if ([self.model.smoke isEqualToString:@""]){
        [self showHudAuto:@"吸烟状况不能为空" andDuration:@"2"];
    }else if ([self.model.food isEqualToString:@""]){
        [self showHudAuto:@"饮食习惯不能为空" andDuration:@"2"];
    }else if ([self.model.family isEqualToString:@""]){
        [self showHudAuto:@"家族史不能为空" andDuration:@"2"];
    }else if ([self.model.sick_his isEqualToString:@""]){
        [self showHudAuto:@"既往史不能为空" andDuration:@"2"];
    }else if ([self.model.waike_his isEqualToString:@""]){
        [self showHudAuto:@"外科手术史不能为空" andDuration:@"2"];
    }else if ([self.model.guomin_his isEqualToString:@""]){
        [self showHudAuto:@"过敏史不能为空" andDuration:@"2"];
    }else if ([self.model.big_sick isEqualToString:@""]){
        [self showHudAuto:@"重大疾病不能为空" andDuration:@"2"];
    }else if ([self.model.latest_health isEqualToString:@""]){
        [self showHudAuto:@"最近健康状况不能为空" andDuration:@"2"];
    }else{
        [self updateHealthInfoNetWork];
    } 
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyAppointmentTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSLog(@"%f",DeviceSize.width - 19/2 - 10);
        UIImageView * imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 19/2 - 10, (45 - 34/2)/2, 19/2, 34/2)];
        imgArrow.image = [UIImage imageNamed:@"arrowImg"];
        [cell.contentView addSubview:imgArrow];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0 ) {
        cell.textLabel.text = [NSString stringWithFormat:@"首次接待时间：%@",self.model.first_access_date];
    }else if (indexPath.row == 1 ){
        cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@",self.model.truename];
    }else if (indexPath.row == 2 ){
        cell.textLabel.text = [NSString stringWithFormat:@"性别：%@",self.model.sex];
    }else if (indexPath.row == 3 ){
        cell.textLabel.text = [NSString stringWithFormat:@"出生日期：%@",self.model.birth_date];
    }else if (indexPath.row == 4 ){
        cell.textLabel.text = [NSString stringWithFormat:@"婚姻状况：%@",self.model.marry_info];
    }else if (indexPath.row == 5 ){
        cell.textLabel.text = [NSString stringWithFormat:@"生育状况：%@",self.model.born_info];
    }else if (indexPath.row == 6 ){
        cell.textLabel.text = [NSString stringWithFormat:@"身高：%@",self.model.hight];
    }else if (indexPath.row == 7 ){
        cell.textLabel.text = [NSString stringWithFormat:@"体重：%@",self.model.weight];
    }else if (indexPath.row == 8 ){
        cell.textLabel.text = [NSString stringWithFormat:@"血糖：%@",self.model.blood_sugar];
    }else if (indexPath.row == 9 ){
        cell.textLabel.text = [NSString stringWithFormat:@"血压：%@",self.model.blood_pressure];
    }else if (indexPath.row == 10 ){
        cell.textLabel.text = [NSString stringWithFormat:@"职业：%@",self.model.job];
    }else if (indexPath.row == 11 ){
        cell.textLabel.text = [NSString stringWithFormat:@"手机：%@",self.model.mobile];
    }else if (indexPath.row == 12 ){
        cell.textLabel.text = [NSString stringWithFormat:@"邮箱：%@",self.model.email];
    }else if (indexPath.row == 13 ){
        cell.textLabel.text = [NSString stringWithFormat:@"微信：%@",self.model.weixin];
    }else if (indexPath.row == 14 ){
        cell.textLabel.text = [NSString stringWithFormat:@"QQ：%@",self.model.qq];
    }else if (indexPath.row == 15 ){
        cell.textLabel.text = [NSString stringWithFormat:@"邮寄地址：%@",self.model.address];
    }else if (indexPath.row == 16 ){
        cell.textLabel.text = [NSString stringWithFormat:@"个人兴趣：%@",self.model.interest];
    }else if (indexPath.row == 17 ){
        cell.textLabel.text = [NSString stringWithFormat:@"花粉过敏：%@",self.model.huafen_guomin];
    }else if (indexPath.row == 18 ){
        cell.textLabel.text = [NSString stringWithFormat:@"喜爱鲜花：%@",self.model.flower_fav];
    }else if (indexPath.row == 19 ){
        cell.textLabel.text = [NSString stringWithFormat:@"吸烟状况：%@",self.model.smoke];
    }else if (indexPath.row == 20 ){
        cell.textLabel.text = [NSString stringWithFormat:@"饮食习惯：%@",self.model.food];
    }else if (indexPath.row == 21 ){
        cell.textLabel.text = [NSString stringWithFormat:@"家族史：%@",self.model.family];
    }else if (indexPath.row == 22 ){
        cell.textLabel.text = [NSString stringWithFormat:@"既往史：%@",self.model.sick_his];
    }else if (indexPath.row == 23 ){
        cell.textLabel.text = [NSString stringWithFormat:@"外科手术史：%@",self.model.waike_his];
    }else if (indexPath.row == 24 ){
        cell.textLabel.text = [NSString stringWithFormat:@"过敏史：%@",self.model.guomin_his];
    }else if (indexPath.row == 25 ){
        cell.textLabel.text = [NSString stringWithFormat:@"重大疾病：%@",self.model.big_sick];
    }else if (indexPath.row == 26 ){
        cell.textLabel.text = [NSString stringWithFormat:@"最近健康状况：%@",self.model.latest_health];
    }else if (indexPath.row == 27 ){
        cell.textLabel.text = [NSString stringWithFormat:@"子女个数：%@",self.model.child_info];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 28;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 45)];
    UILabel * labTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, DeviceSize.width - 20, 45)];
    labTitle.font = [UIFont systemFontOfSize:15];
    labTitle.textAlignment = NSTextAlignmentLeft;
    labTitle.text = @"基本信息";
    labTitle.backgroundColor = [UIColor clearColor];
    headView.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    [headView addSubview:labTitle];
    return headView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(NewMyArchivesViewController);
    if (indexPath.row == 0 ||indexPath.row == 3) {
        self.index = indexPath.row;
       [self showViewAnimate];
    }else if (indexPath.row == 2||indexPath.row == 4 || indexPath.row == 5 ||indexPath.row ==17 ||indexPath.row ==19 ||indexPath.row == 18){
        ChangeInfoViewController * cvc  = [[ChangeInfoViewController alloc]initWithTableViewStyle:UITableViewStyleGrouped];
        cvc.infoBlock = ^(NSString * str){
            if (indexPath.row == 2) {
                self.model.sex = str;
            }else if (indexPath.row == 4){
                self.model.marry_info = str;
            }else if (indexPath.row == 5){
                self.model.born_info = str;
            }else if (indexPath.row == 17){
                self.model.huafen_guomin = str;
            }else if (indexPath.row == 18){
                self.model.flower_fav = str;
            }else if (indexPath.row == 19){
                self.model.smoke = str;
            }
            [weakSelf.tableView reloadData];
        };
        cvc.index = indexPath.row;
        [self.navigationController pushViewController:cvc animated:YES];
    }else{
        MedicationAddInputViewController * medicationVc = [[MedicationAddInputViewController alloc]init];
        medicationVc.index = indexPath.row;
        
        [medicationVc setInfoBlock:^(NSString *string) {
            if (indexPath.row == 1 ){
                self.model.truename = string;
            }else if (indexPath.row == 6 ){
                self.model.hight = string;
            }else if (indexPath.row == 7 ){
                self.model.weight = string;
            }else if (indexPath.row == 8 ){
                self.model.blood_sugar = string;
            }else if (indexPath.row == 9 ){
                self.model.blood_pressure = string;
            }else if (indexPath.row == 10 ){
                self.model.job = string;
            }else if (indexPath.row == 11 ){
                self.model.mobile = string;
            }else if (indexPath.row == 12 ){
                self.model.email = string;
            }else if (indexPath.row == 13 ){
                self.model.weixin = string;
            }else if (indexPath.row == 14 ){
                self.model.qq = string;
            }else if (indexPath.row == 15 ){
                self.model.address = string;
            }else if (indexPath.row == 16 ){
                self.model.interest = string;
            }else if (indexPath.row == 20 ){
                self.model.food = string;
            }else if (indexPath.row == 21 ){
                self.model.family = string;
            }else if (indexPath.row == 22 ){
                self.model.sick_his = string;
            }else if (indexPath.row == 23 ){
                self.model.waike_his = string;
            }else if (indexPath.row == 24 ){
                self.model.guomin_his = string;
            }else if (indexPath.row == 25 ){
                self.model.big_sick = string;
            }else if (indexPath.row == 26 ){
                self.model.latest_health = string;
            }else if (indexPath.row == 27 ){
                self.model.child_info = string;
            }
            [weakSelf.tableView reloadData];
        }];
        [self.navigationController pushViewController:medicationVc animated:YES];
    }
    
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(NewMyArchivesViewController);
    [[THNetWorkManager shareNetWork]getHealthInfoCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NewMyArchivesModel * model = [response thParseDataFromDic:response.dataDic andModel:[NewMyArchivesModel class]];
            weakSelf.model = model;
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
- (TimeView *)viewTime{
    if (!_viewTime) {
        _viewTime = [[TimeView alloc]initWithFrame:CGRectMake(0, DeviceSize.height, DeviceSize.width, 260) title:@"选择时间"];
        WeakSelf(NewMyArchivesViewController);
        _viewTime.backgroundColor = [UIColor whiteColor];
        [_viewTime setSureBlock:^(NSString * str) {
            [UIView animateWithDuration:.25 animations:^{
                weakSelf.viewTime.frame = CGRectMake(0, DeviceSize.height, DeviceSize.width, 260);
            } completion:^(BOOL finished) {
                weakSelf.viewGray.hidden = YES;
            }];
            if (weakSelf.index == 0) {
                weakSelf.model.first_access_date = str;
            }else{
                weakSelf.model.birth_date = str;
            }
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
    WeakSelf(NewMyArchivesViewController);
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
- (void)updateHealthInfoNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(NewMyArchivesViewController);
    [[THNetWorkManager shareNetWork]updateHealthInfoFirst_access_date:self.model.first_access_date truename:self.model.truename sex:self.model.sex birth_date:self.model.birth_date marry_info:self.model.marry_info born_info:self.model.born_info child_info:self.model.child_info hight:self.model.hight weight:self.model.weight blood_sugar:self.model.blood_sugar blood_pressure:self.model.blood_pressure job:self.model.job mobile:self.model.mobile email:self.model.email weixin:self.model.weixin qq:self.model.qq address:self.model.address interest:self.model.interest huafen_guomin:self.model.huafen_guomin flower_fav:self.model.flower_fav smoke:self.model.smoke food:self.model.food family:self.model.family sick_his:self.model.sick_his waike_his:self.model.waike_his guomin_his:self.model.guomin_his big_sick:self.model.big_sick latest_health:self.model.latest_health andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            [weakSelf showHudAuto:@"更新成功" andDuration:@"2"];
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];

}
- (NSString *)title{
    return @"我的健康档案";
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
