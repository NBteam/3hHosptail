//
//  PersonalViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalHeadTableViewCell.h"
#import "PersonalTableViewCell.h"
#import "NameInputViewController.h"
#import "HospitalInputViewController.h"
#import "PositionViewController.h"
#import "HospitalTableViewController.h"
#import "DepartmentViewController.h"
#import "SexViewController.h"
#import "CityListFirstLevelViewController.h"

@interface PersonalViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, copy) NSString * sexStr;
@property (nonatomic, copy) NSString * idS;
@property (nonatomic, copy) NSString * parent_id;
@property (nonatomic, copy) NSString * area_ids;
@property (nonatomic, copy) NSString * hospital_id;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self getNetWorkInfo];

    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"姓名",@"detail":self.user.truename},@{@"title":@"性别",@"detail":self.user.sex},@{@"title":@"城市",@"detail":self.user.area_names},@{@"title":@"医院",@"detail":self.user.hospital},@{@"title":@"科室",@"detail":self.user.department},@{@"title":@"职称",@"detail":self.user.job_title},@{@"title":@"个人签名",@"detail":self.user.sign_word}]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"保存"];
}
- (void)rightAction{
    if ([self.dataArray[0][@"detail"] isEqualToString:@"未填写"]||[self.dataArray[0][@"detail"] isEqualToString:@"未填写"]) {
        [self showHudAuto:@"请填写姓名" andDuration:@"2"];
    }else if ([self.dataArray[2][@"detail"] isEqualToString:@"未填写"]||[self.dataArray[2][@"detail"] isEqualToString:@"未填写"]){
        [self showHudAuto:@"请选择城市" andDuration:@"2"];
    }
    else if ([self.dataArray[3][@"detail"] isEqualToString:@"未填写"]||[self.dataArray[2][@"detail"] isEqualToString:@"未填写"]){
        [self showHudAuto:@"请选择医院" andDuration:@"2"];
    }else if ([self.dataArray[4][@"detail"] isEqualToString:@"未填写"]||[self.dataArray[3][@"detail"] isEqualToString:@"未填写"]){
        [self showHudAuto:@"请选择科室" andDuration:@"2"];
    }else if ([self.dataArray[5][@"detail"] isEqualToString:@"未填写"]||[self.dataArray[4][@"detail"] isEqualToString:@"未填写"]){
        [self showHudAuto:@"请选择职称" andDuration:@"2"];
    }
    else{
        [self showHudAuto:WaitPrompt];
        WeakSelf(PersonalViewController);
        [[THNetWorkManager shareNetWork]getUpdateUserInfoTruename:self.dataArray[0][@"detail"] sex:self.user.sex hospital:self.dataArray[3][@"detail"] department:self.dataArray[4][@"detail"] job_title:self.dataArray[5][@"detail"] sign_word:self.dataArray[6][@"detail"] work_week:self.user.work_week work_price:self.user.work_price area_ids:self.user.area_ids andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
            [weakSelf removeMBProgressHudInManaual];
            if (response.responseCode == 1) {
                
                [weakSelf showHudAuto:@"保存成功" andDuration:@"2"];
                
                //  写入文件
                [THUser writeUserToLacalPath:UserPath andFileName:@"User" andWriteClass:weakSelf.user];
                //  下次在那重新获取保存数据
                
                weakSelf.user = nil;
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadHomeInfo" object:nil];
                
            }else{
                [weakSelf showHudAuto:response.message andDuration:@"1"];
            }
        } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
            [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"1"];
        }];
    }
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"PersonalHeadTableViewCell";
        PersonalHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[PersonalHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.user.pic];
        return cell;
    }else{
        static NSString *identifier = @"PersonalTableViewCell";
        PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[PersonalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.dataArray[indexPath.row]];
        return cell;
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return self.dataArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 45;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (NSString *)title{
    return @"个人资料";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self.actionSheet showInView: self.view];
    }
    if (indexPath.section !=0) {
        WeakSelf(PersonalViewController);
        if (indexPath.row == 0) {//您的姓名
            
            NameInputViewController *nameInputVc = [[NameInputViewController alloc] init];
            nameInputVc.index = 0;
            
            [nameInputVc setNameBlock:^(NSString *str) {
                
                [weakSelf.dataArray replaceObjectAtIndex:0 withObject:@{@"title":@"姓名",@"detail":str}];
                weakSelf.user.truename = str;
                [weakSelf.tableView reloadData];
            }];
            
            [self.navigationController  pushViewController:nameInputVc animated:YES];
            
        }else if (indexPath.row == 1){//
            
            SexViewController *cityListFirstLevelVc= [[SexViewController alloc] init];
            [cityListFirstLevelVc setHospitalBlock:^(NSString *name) {
                NSString * sex = @"";
                if ([name isEqualToString:@"0"]) {
                    sex = @"保密";
                }else if ([name isEqualToString:@"1"]) {
                    sex = @"男";
                }else if ([name isEqualToString:@"2"]) {
                    sex = @"女";
                }
                weakSelf.sexStr = name;
                weakSelf.user.sex = name;
                [weakSelf.dataArray replaceObjectAtIndex:1 withObject:@{@"title":@"性别",@"detail":sex}];
                [weakSelf.tableView reloadData];
            }];
            
            [self.navigationController pushViewController:cityListFirstLevelVc animated:YES];
            
        }else if (indexPath.row == 2){//城市
            CityListFirstLevelViewController * CityListFirstLevelVc = [[CityListFirstLevelViewController alloc]init];
            [CityListFirstLevelVc setCityListBlock:^(NSString *name, NSString *ids, NSString *parent_id) {
                NSLog(@"%@-->%@-->%@",name,ids,parent_id);
                weakSelf.area_ids = [@[ids,parent_id]componentsJoinedByString:@","];
                weakSelf.idS = ids;
                weakSelf.parent_id = parent_id;
                weakSelf.user.area_names = name;
                [weakSelf.dataArray replaceObjectAtIndex:2 withObject:@{@"title":@"城市",@"detail":name}];
                [weakSelf.tableView reloadData];
            }];
            [self.navigationController pushViewController:CityListFirstLevelVc animated:YES];
        }else if (indexPath.row == 3){//
            if (self.idS==nil||[self.idS isEqualToString:@""]) {
                [self showHudAuto:@"请先选择城市" andDuration:@"2"];
            }else{
                
                HospitalTableViewController*hospitalInputVc = [[HospitalTableViewController alloc] init];
                hospitalInputVc.ids = self.idS;
                [hospitalInputVc setHospitalBlock:^(NSString *str,NSString * id) {
                    weakSelf.hospital_id = id;
                    [weakSelf.dataArray replaceObjectAtIndex:3 withObject:@{@"title":@"医院",@"detail":str}];
                    weakSelf.user.hospital = str;
                    [weakSelf.tableView reloadData];
                }];
                [self.navigationController pushViewController:hospitalInputVc animated:YES];
            }
        }else if (indexPath.row == 4){//
            NSString * idStr = @"";
            if (self.parent_id==nil||[self.parent_id isEqualToString:@""]) {
                idStr = @"0";
            }else{
                idStr = self.parent_id;
            }
            DepartmentViewController * DepartmentVc = [[DepartmentViewController alloc]init];
            DepartmentVc.id = idStr;
            [DepartmentVc setChoiceBlock:^(NSString *id, NSString *name, NSString *pid) {
                
                [weakSelf.dataArray replaceObjectAtIndex:4 withObject:@{@"title":@"科室",@"detail":name}];
                weakSelf.user.department = name;
                [weakSelf.tableView reloadData];
            }];
            [self.navigationController pushViewController:DepartmentVc animated:YES];
        }else if (indexPath.row == 5){//
            PositionViewController * pvc = [[PositionViewController alloc]init];
            [pvc setChoiceBlock:^(NSString *positionStr) {
                [weakSelf.dataArray replaceObjectAtIndex:5 withObject:@{@"title":@"职称",@"detail":positionStr}];
                weakSelf.user.job_title = positionStr;
                [weakSelf.tableView reloadData];
            }];
            [self.navigationController pushViewController:pvc animated:YES];
        }else if (indexPath.row == 6){//
            NameInputViewController *nameInputVc = [[NameInputViewController alloc] init];
            nameInputVc.index = 1;
            
            [nameInputVc setNameBlock:^(NSString *str) {
                
                [weakSelf.dataArray replaceObjectAtIndex:6 withObject:@{@"title":@"个人签名",@"detail":str}];
                weakSelf.user.sign_word = str;
                [weakSelf.tableView reloadData];
            }];
            
            [self.navigationController  pushViewController:nameInputVc animated:YES];
        }
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
    WeakSelf(PersonalViewController);
    
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
                                       NSData *data = UIImageJPEGRepresentation(image, 0.25);
                                       NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
                                       
                                       //文件管理器
                                       NSFileManager *fileManager = [NSFileManager defaultManager];
                                       
                                       //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
                                       [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
                                       [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
//                                       [weakSelf.tableView reloadData];
                                       [weakSelf uploadImageWithImage:image];
                                   }
                                   
                               }];
}
- (void)uploadImageWithImage:(UIImage *)image{
    WeakSelf(PersonalViewController);
    NSData *imageData = UIImageJPEGRepresentation(image, 0.25);
    [weakSelf showHudWaitingView:WaitPrompt];
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,@"/image.png"];
    NSLog(@"%@",filePath);
    if (filePath) {
        [[THNetWorkManager shareNetWork]getUploadFaceFile:imageData faceString:filePath andCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [weakSelf removeMBProgressHudInManaual];
            NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([content[@"status"] doubleValue] == 1) {

                 weakSelf.user.pic = content[@"data"][@"savename"];
                
                //  写入文件
                [THUser writeUserToLacalPath:UserPath andFileName:@"User" andWriteClass:weakSelf.user];
                //  下次在那重新获取保存数据
                
                weakSelf.user = nil;
                [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadHomeInfo" object:nil];
                [weakSelf.tableView reloadData];
            }else{
                [weakSelf showHudAuto:content[@"info"]];
            }
        } andFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        } andProgress:^(long long bytesSent, long long totalBytesSent, long long totalBytesExpectedToSend) {
            
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
