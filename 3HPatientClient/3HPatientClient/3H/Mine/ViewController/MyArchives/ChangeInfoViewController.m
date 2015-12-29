//
//  ChangeInfoViewController.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/28.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ChangeInfoViewController.h"

@interface ChangeInfoViewController ()

@end

@implementation ChangeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"数据选择";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    if (self.index == 2) {//性别
        self.dataArray = [NSMutableArray arrayWithObjects:@"保密",@"男",@"女", nil];
    }else if(self.index == 4){//婚姻状况
        self.dataArray = [NSMutableArray arrayWithObjects:@"已婚",@"未婚", nil];
    }else if(self.index == 5){//生育状况
        self.dataArray = [NSMutableArray arrayWithObjects:@"已生育",@"未生育", nil];
    }else if(self.index == 17){//花粉过敏
        self.dataArray = [NSMutableArray arrayWithObjects:@"过敏",@"不过敏", nil];
    }else if(self.index == 19){//吸烟状况
        self.dataArray = [NSMutableArray arrayWithObjects:@"吸烟",@"不吸烟", nil];
    }else if(self.index == 18){//喜爱鲜花
        self.dataArray = [NSMutableArray arrayWithObjects:@"喜欢",@"不喜欢", nil];
    }
//    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightAction{
    
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
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.infoBlock) {
        self.infoBlock(self.dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
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
