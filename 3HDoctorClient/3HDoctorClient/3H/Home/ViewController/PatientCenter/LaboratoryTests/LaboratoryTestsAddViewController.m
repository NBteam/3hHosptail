//
//  LaboratoryTestsAddViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "LaboratoryTestsAddViewController.h"
#import "LaboratoryTestsAddTableViewCell.h"
#import "LaboratoryTestsAddPhotoTableViewCell.h"
#import "HospitalInputViewController.h"
#import "TestModel.h"
#import "TimeView.h"

@interface LaboratoryTestsAddViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSIndexPath * indexPaths;
@property (nonatomic, strong) NSIndexPath * indexPath3;
@property (nonatomic, strong) TimeView * viewTime;
@property (nonatomic, strong) UIView * viewGray;
@end

@implementation LaboratoryTestsAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(finishAction) andTarget:self andButtonTitle:@"完成"];
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"名称:",@"detail":@"未选择"},@{@"title":@"医院:",@"detail":@"未选择"},@{@"title":@"时间:",@"detail":@"未选择"}]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    
    [self.view addSubview:self.viewGray];
    [self.view addSubview:self.viewTime];
    [self getNetWork];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)finishAction{
    
}
- (TimeView *)viewTime{
    if (!_viewTime) {
        _viewTime = [[TimeView alloc]initWithFrame:CGRectMake(0, DeviceSize.height, DeviceSize.width, 260) title:@"用药时间"];
        WeakSelf(LaboratoryTestsAddViewController);
        _viewTime.backgroundColor = [UIColor whiteColor];
        [_viewTime setSureBlock:^(NSString * str) {
            [UIView animateWithDuration:.25 animations:^{
                weakSelf.viewTime.frame = CGRectMake(0, DeviceSize.height, DeviceSize.width, 260);
            } completion:^(BOOL finished) {
                weakSelf.viewGray.hidden = YES;
            }];
            [weakSelf.dataArray replaceObjectAtIndex:2 withObject:@{@"title":@"时间:",@"detail":str}];
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
    WeakSelf(LaboratoryTestsAddViewController);
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
    if (indexPath.section ==3 ) {
        static NSString *identifier = @"idertifier";
        LaboratoryTestsAddPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[LaboratoryTestsAddPhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.indexPath3 = indexPath;
        self.cellHeight = [cell confingWithModel:nil];
        return cell;
    }else{
        static NSString *identifier = @"idertifier";
        LaboratoryTestsAddTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[LaboratoryTestsAddTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dataArray[indexPath.section]];
        return cell;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count +1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return self.cellHeight;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 3 ) {
        if (indexPath.section == 2) {
            self.indexPaths = indexPath;
            [self showViewAnimate];
        }else{
            WeakSelf(LaboratoryTestsAddViewController);
            HospitalInputViewController * HospitalInputVc = [[HospitalInputViewController alloc]init];
            if (indexPath.section == 0) {
                HospitalInputVc.titleStr = @"请输入检验名称";
            }else if(indexPath.section == 1){
                HospitalInputVc.titleStr = @"请输入医院名称";
            }
            [HospitalInputVc setHospitalBlock:^(NSString *str) {
                if (indexPath.section == 0) {
                    [weakSelf.dataArray replaceObjectAtIndex:0 withObject:@{@"title":@"名称:",@"detail":str}];
                }else if(indexPath.section == 1){
                    [weakSelf.dataArray replaceObjectAtIndex:1 withObject:@{@"title":@"医院:",@"detail":str}];
                }
                [weakSelf.tableView reloadData];
            }];
            [self.navigationController pushViewController:HospitalInputVc animated:YES];
        }
    }else{
        self.indexPath3 = indexPath;
        [self.actionSheet showInView: self.view];
    }
}

- (UIActionSheet *)actionSheet{
    if (!_actionSheet) {
        _actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册中选择", nil];
    }
    return _actionSheet;
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self updateMypicture:buttonIndex];
//        NSLog(@"%ld",buttonIndex);
    }else if (buttonIndex == 1){
        [self updateMypicture:buttonIndex];
        NSLog(@"%ld",buttonIndex);
    }
}
- (void)updateMypicture:(NSInteger)index{
    if (index == 0) {//拍照
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            //设置拍照后的图片可被编辑
            picker.allowsEditing = YES;
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:nil];
        }else
        {
            NSLog(@"模拟其中无法打开照相机,请在真机中使用");
            
        }
    }else if (index == 1){//从相册
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        //设置选择后的图片可被编辑
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        
        
        
        
    }
}
//选择某张照片之后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    WeakSelf(LaboratoryTestsAddViewController);
    
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES
                               completion:^{
                                   NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
                                   //当选择的类型是图片
                                   if ([type isEqualToString:@"public.image"])
                                   {
                                       //先把图片转成NSData
                                       UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//                                       LaboratoryTestsAddPhotoTableViewCell * cell = [weakSelf.tableView cellForRowAtIndexPath:weakSelf.indexPaths];
//                                       
//                                       [cell confingWithModel:image] ;
                                       [weakSelf.tableView reloadData];
                                       [weakSelf uploadImageWithImage:image];
                                   }
                                   
                               }];
}
- (void)uploadImageWithImage:(UIImage *)image{

}
- (NSString *)title{
    if (self.index == 1) {
        return @"化验";
    }else{
        return @"检查";
    }
}
- (void)getNetWork{
    if (self.index == 1) {//化验
        [self showHudWaitingView:WaitPrompt];
        WeakSelf(LaboratoryTestsAddViewController);
        [[THNetWorkManager shareNetWork]getPatientAssayMid:@"" id:@"" andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
            [weakSelf removeMBProgressHudInManaual];
            if (response.responseCode == 1) {
                TestModel * model = [response thParseDataFromDic:response.dataDic andModel:[TestModel class]];
                weakSelf.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"名称:",@"detail":model.name},@{@"title":@"医院:",@"detail":model.hospital},@{@"title":@"时间:",@"detail":model.addtime}]];
//                LaboratoryTestsAddPhotoTableViewCell * cell = [weakSelf.tableView cellForRowAtIndexPath:weakSelf.indexPath3];
//                [cell confingWithModel:model];
            }else{
                [weakSelf showHudAuto:response.message andDuration:@"1"];
            }
            [weakSelf.tableView reloadData];
        } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
            [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"1"];
        }];
    }else{
        [self showHudWaitingView:WaitPrompt];
        WeakSelf(LaboratoryTestsAddViewController);
        [[THNetWorkManager shareNetWork]getPatientCheckMid:@"" id:@"" andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
            [weakSelf removeMBProgressHudInManaual];
            if (response.responseCode == 1) {
                TestModel * model = [response thParseDataFromDic:response.dataDic andModel:[TestModel class]];
                weakSelf.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"名称:",@"detail":model.name},@{@"title":@"医院:",@"detail":model.hospital},@{@"title":@"时间:",@"detail":model.addtime}]];
                //                LaboratoryTestsAddPhotoTableViewCell * cell = [weakSelf.tableView cellForRowAtIndexPath:weakSelf.indexPath3];
                //                [cell confingWithModel:model];
            }else{
                [weakSelf showHudAuto:response.message andDuration:@"1"];
            }
            [weakSelf.tableView reloadData];
        } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
            [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"1"];
        }];
    }
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
