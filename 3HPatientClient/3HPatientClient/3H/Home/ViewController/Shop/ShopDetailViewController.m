//
//  ShopDetailViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "ShopDetailNameTableViewCell.h"
#import "ShopDetailNumTableViewCell.h"
#import "ShopDetailTitleTableViewCell.h"
#import "ShopDetailDescTableViewCell.h"
#import "ShopDetailCommentsTableViewCell.h"
#import "ShopDetailToolView.h"
#import "ShopDetailBuyViewController.h"
#import "GoodsDetailModel.h"
#import "ShoppingCartViewController.h"
#import "CommentsModel.h"

@interface ShopDetailViewController ()

@property (nonatomic, strong) UIImageView *imgHead;
@property (nonatomic, strong) ShopDetailToolView *toolView;
@property (nonatomic, assign) CGFloat cellHeightName;
@property (nonatomic, assign) CGFloat cellHeightDesc;
@property (nonatomic, strong) GoodsDetailModel *goodsDetailModel;
@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    self.tableView.tableHeaderView = self.imgHead;
    self.tableView.height = self.tableView.height -65;
    [self.view addSubview:self.toolView];
    [self getNetWork];
    
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UI

- (UIImageView *)imgHead{
    if (!_imgHead) {
        _imgHead = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 150)];
        _imgHead.backgroundColor = [UIColor grayColor];
    }
    return _imgHead;
}

- (void)favGoodsgoods_id{

    [self showHudAuto:@"收藏中..." andDuration:@"2"];
    ;
    WeakSelf(ShopDetailViewController);
    
    [[THNetWorkManager shareNetWork] favGoodsgoods_id:self.id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        if (response.responseCode == 1) {
            NSLog(@"查看%@",response.dataDic);
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
        
    
    
}



- (ShopDetailToolView *)toolView{
    WeakSelf(ShopDetailViewController);
    if (!_toolView) {
        _toolView = [[ShopDetailToolView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, DeviceSize.width, 65)];
        [_toolView setShopDetailToolBlock:^(NSInteger index) {
            if (index == 0) {
                [weakSelf favGoodsgoods_id];
            }else if(index == 1){
                [weakSelf getAddCardNetWork];
            }else if(index == 2){
                ShopDetailNumTableViewCell *cell = [weakSelf.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                ShopDetailBuyViewController *shopDetailBuyVc = [[ShopDetailBuyViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                shopDetailBuyVc.id = weakSelf.id;
                shopDetailBuyVc.indexStr = cell.labNum.text;
                [weakSelf.navigationController pushViewController:shopDetailBuyVc animated:YES];
            }else{
                ShoppingCartViewController *shoppingCartVc = [[ShoppingCartViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                [weakSelf.navigationController pushViewController:shoppingCartVc animated:YES];
            }
        }];
    }
    return _toolView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"ShopDetailNameTableViewCell";
        ShopDetailNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ShopDetailNameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellHeightName = [cell confingWithModel:self.goodsDetailModel];
        return cell;
    }else if(indexPath.section == 1){
        static NSString *identifier = @"ShopDetailNameTableViewCell";
        ShopDetailNumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ShopDetailNumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            static NSString *identifier = @"ShopDetailNameTableViewCell";
            ShopDetailTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[ShopDetailTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell confingWithModel:@"商品详情"];
            
            return cell;
        }else{
            static NSString *identifier = @"ShopDetailDescTableViewCell";
            ShopDetailDescTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[ShopDetailDescTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.cellHeightDesc = [cell confingWithModel:self.goodsDetailModel.content];
            
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            static NSString *identifier = @"ShopDetailNameTableViewCell";
            ShopDetailTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[ShopDetailTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell confingWithModel:@"评价"];
            
            return cell;
        }else{
            static NSString *identifier = @"ShopDetailCommentsTableViewCell";
            ShopDetailCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[ShopDetailCommentsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CommentsModel * model = self.dataArray[indexPath.row - 1];
            [cell confingWithModel:model];
            
            return cell;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0 ||section == 1) {
        return 1;
    }else if(section == 2){
        return 2;
    }else{
        return self.dataArray.count + 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return self.cellHeightName;
    }else if(indexPath.section == 1){
        return 45;
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            return 35;
        }else{
            return self.cellHeightDesc;
        }
    }else{
        if (indexPath.row == 0) {
            return 35;
        }else{
            return 70;
        }
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

- (NSString *)title{
    return @"商品详情";
}
- (void)getNetWork{
    [self showHudWaitingView:WaitPrompt];
    WeakSelf(ShopDetailViewController);
    [[THNetWorkManager shareNetWork]getGoodsFlashId:self.id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            GoodsDetailModel * model = [response thParseDataFromDic:response.dataDic andModel:[GoodsDetailModel class]];
            weakSelf.goodsDetailModel = model;
            [weakSelf.imgHead sd_setImageWithURL:SD_IMG(model.thumb)];
            for (NSDictionary * dict in response.dataDic[@""]) {
                CommentsModel * cModel = [response thParseDataFromDic:dict andModel:[CommentsModel class]];
                [weakSelf.dataArray addObject:cModel];
            }
            if ([model.is_fav integerValue] == 0) {
                weakSelf.toolView.btnCollection.backgroundColor = [UIColor colorWithHEX:0xfffffff];
            }else{
                weakSelf.toolView.btnCollection.backgroundColor = AppDefaultColor;
            }
            
            [weakSelf.tableView reloadData];
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
    }];
}
#pragma mark --- 加入购物车
- (void)getAddCardNetWork{
    [self showHudWaitingView:WaitPrompt];
    ShopDetailNumTableViewCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    WeakSelf(ShopDetailViewController);
    [[THNetWorkManager shareNetWork]addCartGoods_id:self.id qty:cell.labNum.text andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            NSLog(@"-----%@",response.dataDic);
            
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
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
