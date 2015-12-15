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
#import "PersonalInputViewController.h"
#import "SexViewController.h"
#import "BirthdayViewController.h"
@interface PersonalViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIActionSheet *actionSheet;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"性别%@",self.user.sex);
    self.dataArray = [NSMutableArray arrayWithArray:@[@{@"title":@"用户名",@"detail":self.user.nickname},@{@"title":@"姓名",@"detail":self.user.truename},@{@"title":@"性别",@"detail":self.user.sex},@{@"title":@"出生日期",@"detail":self.user.birth},@{@"title":@"通讯地址",@"detail":self.user.address},@{@"title":@"电话",@"detail":self.user.mobile},@{@"title":@"身份证号",@"detail":self.user.card_id}]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(rightAction) andTarget:self andButtonTitle:@"保存"];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction{
    WeakSelf(PersonalViewController);
    [self showHudAuto:@"保存中..."];
    [[THNetWorkManager shareNetWork] updateUserInfoNickname:self.user.nickname Truename:self.user.truename Sex:self.user.sex Birth:self.user.birth Address:self.user.address Tel:self.user.tel Card_id:self.user.card_id CompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            //            for (NSDictionary * dict in response.dataDic[@"list"]) {
            //                InformationModel * model = [response thParseDataFromDic:dict andModel:[InformationModel class]];
            //                [weakSelf.dataArray addObject:model];
            //            }
            
            [weakSelf showHudAuto:@"保存成功" andDuration:@"2"];
            
            //  写入文件
            [THUser writeUserToLacalPath:UserPath andFileName:@"User" andWriteClass:weakSelf.user];
            //  下次在那重新获取保存数据
            
            weakSelf.user = nil;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshBaseInfoNatification" object:nil];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
        
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
        
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
                NSLog(@"00000000%@",content);
//                [weakSelf.dict setObject:image forKey:@"pic"];
                weakSelf.user.pic = content[@"data"][@"savename"];
                
                //  写入文件
                [THUser writeUserToLacalPath:UserPath andFileName:@"User" andWriteClass:weakSelf.user];
                //  下次在那重新获取保存数据
                
                weakSelf.user = nil;
                
                
                [weakSelf.tableView reloadData];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshBaseInfoNatification" object:nil];
                NSLog(@"%@",self.user.pic);
            }else{
                [weakSelf showHudAuto:content[@"info"]];
            }
        } andFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        } andProgress:^(long long bytesSent, long long totalBytesSent, long long totalBytesExpectedToSend) {
            
        }];
    }
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
//index 0 == 用户名 1 == 姓名  2 == 通讯地址  3 == 电话  4 == 身份证号
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(PersonalViewController);
    if (indexPath.section == 0) {
        [self.actionSheet showInView: self.view];
        
    }else{
        
        if (indexPath.row == 2) {
            SexViewController *sexVc = [[SexViewController alloc] init];
            [sexVc setSexBlock:^(NSString *sex) {
                weakSelf.user.sex = sex;
                [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":self.dataArray[indexPath.row][@"title"],@"detail":sex}];
                [weakSelf.tableView reloadData];
            }];
            [self.navigationController pushViewController:sexVc animated:YES];
        }else if(indexPath.row == 3){
            //出生日期
            
            BirthdayViewController *birthdayVc = [[BirthdayViewController alloc] init];
            birthdayVc.dateString = self.user.birth;
            [birthdayVc setBirthdayBlock:^(NSString *name) {
                weakSelf.user.birth = name;
                [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":self.dataArray[indexPath.row][@"title"],@"detail":name}];
                [weakSelf.tableView reloadData];
            }];
            
            [self.navigationController pushViewController:birthdayVc animated:YES];
            
        }else{
            PersonalInputViewController *personalInputVc = [[PersonalInputViewController alloc] init];
            
            if (indexPath.row == 0) {//用户名
                
                personalInputVc.index = 0;
                personalInputVc.string = self.user.nickname;
                [personalInputVc setNameBlock:^(NSString *name) {
                    weakSelf.user.nickname = name;
                    [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":self.dataArray[indexPath.row][@"title"],@"detail":name}];
                    [weakSelf.tableView reloadData];
                }];
                
            }else if(indexPath.row == 1){//姓名
                personalInputVc.index = 1;
                personalInputVc.string = self.user.truename;
                
                [personalInputVc setNameBlock:^(NSString *name) {
                    weakSelf.user.truename = name;
                    [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":self.dataArray[indexPath.row][@"title"],@"detail":name}];
                    [weakSelf.tableView reloadData];
                }];
                
            }else if(indexPath.row == 2){//性别
                
                
                
            }else if(indexPath.row == 3){
                
            }else if(indexPath.row == 4){//通讯地址
                personalInputVc.index = 2;
                personalInputVc.string = self.user.address;
                
                [personalInputVc setNameBlock:^(NSString *name) {
                    weakSelf.user.address = name;
                    [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":self.dataArray[indexPath.row][@"title"],@"detail":name}];
                    [weakSelf.tableView reloadData];
                }];
                
            }else if(indexPath.row == 5){//电话
                personalInputVc.index = 3;
                personalInputVc.string = self.user.tel;
                
                [personalInputVc setNameBlock:^(NSString *name) {
                    weakSelf.user.tel = name;
                    [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":self.dataArray[indexPath.row][@"title"],@"detail":name}];
                    [weakSelf.tableView reloadData];
                }];
                
            }else{//身份证
                personalInputVc.index = 4;
                personalInputVc.string = self.user.card_id;
                
                [personalInputVc setNameBlock:^(NSString *name) {
                    weakSelf.user.card_id = name;
                    [weakSelf.dataArray replaceObjectAtIndex:indexPath.row withObject:@{@"title":self.dataArray[indexPath.row][@"title"],@"detail":name}];
                    [weakSelf.tableView reloadData];
                }];
            }
            
            
            [self.navigationController pushViewController:personalInputVc animated:YES];
        }
        
        
    }
    
}

- (NSString *)title{
    return @"个人资料";
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
