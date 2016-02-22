//
//  HomeViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/11/30.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeadTableViewCell.h"
#import "HomeFunctionTableViewCell.h"
#import "HomeTitleTableViewCell.h"
#import "HomeTableViewCell.h"
#import "HomeSlidingTableViewCell.h"
//健康管理
#import "ManageViewController.h"
//我要预约
#import "AppointViewController.h"
//资讯
#import "ConsultingDynamicViewController.h"
//商城
#import "ShopViewController.h"
//健康日程
#import "ScheduleViewController.h"
//资讯详情
#import "DynamicDetailViewController.h"
//商品详情
#import "ShopDetailViewController.h"
//我要咨询
#import "ConsultingViewController.h"
//我要咨询医生列表
#import "ConsultingDoctorListViewController.h"
#import "HomeGoodsModel.h"
#import "HomeNewsModel.h"
//添加医生
#import "QrCodeViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "WeatherModel.h"
#import "XianXing.h"

@interface HomeViewController ()<IChatManagerDelegate, EMCallManagerDelegate,CLLocationManagerDelegate>
@property (nonatomic,retain) CLLocationManager * locationManager;
@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, strong) WeatherModel * weatherModel;
@property (nonatomic, strong) XianXing * xianxingItem;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"3H健康管理";
    // Do any additional setup after loading the view.
    //
    self.navigationItem.rightBarButtonItem = [UIBarButtonItemExtension rightButtonItem:@selector(addAction) andTarget:self andImageName:@"首页+"];
    [self getHomeData];
    [self registerNotifications];
    [self setupUnreadMessageCount];
    [self createLoction];
}
#pragma mark - private

-(void)registerNotifications
{
    [self unregisterNotifications];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}
// 未读消息数量变化回调
-(void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
}
// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }

    NSLog(@"~~%ld",(long)unreadCount);
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}
- (void)addAction{
    QrCodeViewController *addDoctorVc = [[QrCodeViewController alloc] init];
    addDoctorVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addDoctorVc animated:YES];
}

- (NSMutableArray *)newsArray{
    if (!_newsArray) {
        _newsArray = [[NSMutableArray alloc] init];
    }
    return _newsArray;
}

- (void)getHomeData{
    [self.dataArray removeAllObjects];
    [self.newsArray removeAllObjects];
    [self showHudAuto:WaitPrompt];
    WeakSelf(HomeViewController);
    [[THNetWorkManager shareNetWork] getHomeInfoCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            for (NSDictionary * dict in response.dataDic[@"goods"]) {
                HomeGoodsModel * model = [response thParseDataFromDic:dict andModel:[HomeGoodsModel class]];
                [weakSelf.dataArray addObject:model];
            }
            
            for (NSDictionary * dict in response.dataDic[@"news"]) {
                HomeNewsModel * model = [response thParseDataFromDic:dict andModel:[HomeNewsModel class]];
                [weakSelf.newsArray addObject:model];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(HomeViewController);
    if (indexPath.section == 0) {
        static NSString *identifier = @"HomeHeadTableViewCell";
        HomeHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[HomeHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell confingWithModel:self.weatherModel item:self.xianxingItem];
        return cell;
    }else if(indexPath.section == 1){
        static NSString *identifier = @"HomeFunctionTableViewCell";
        HomeFunctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[HomeFunctionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //[cell confingWithModel:1];
        [cell setHomefunctionBlock:^(NSInteger index) {
            if (index == 0) {
                ManageViewController *manageVc = [[ManageViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                manageVc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:manageVc animated:YES];
            }else if (index == 1){
//                ConsultingViewController *consultingVc= [[ConsultingViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
//                consultingVc.hidesBottomBarWhenPushed = YES;
//                [weakSelf.navigationController pushViewController:consultingVc animated:YES];
                
                ConsultingDoctorListViewController *consultingVc= [[ConsultingDoctorListViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                consultingVc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:consultingVc animated:YES];
                
                
            }else if(index == 2){
                ScheduleViewController *scheduleVc = [[ScheduleViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                scheduleVc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:scheduleVc animated:YES];
            }else{
                AppointViewController *appointVc = [[AppointViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                appointVc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:appointVc animated:YES];
            }
        }];
        return cell;
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            static NSString *identifier = @"HomeTitleTableViewCell";
            HomeTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[HomeTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell confingWithModel:@"健康资讯"];
            return cell;
        }else{
            static NSString *identifier = @"HomeTableViewCell";
            HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell confingWithModel:self.newsArray[indexPath.row -1]];
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            static NSString *identifier = @"HomeTitleTableViewCell";
            HomeTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[HomeTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell confingWithModel:@"健康商城"];
            return cell;
        }else{
            static NSString *identifier = @"HomeSlidingTableViewCell";
            HomeSlidingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[HomeSlidingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            [cell setSlidingBlock:^(NSInteger index) {
                ShopDetailViewController *shopDetailVc = [[ShopDetailViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
                shopDetailVc.id = [NSString stringWithFormat:@"%ld",(long)index];
                shopDetailVc.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:shopDetailVc animated:YES];
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell confingWithModel:self.dataArray];
            return cell;
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
        return 3;
    }else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat f;
    if (DeviceSize.width >375) {
        f = (DeviceSize.width *86)/375;
    }else{
        f = 86;
    }
    if (indexPath.section == 0) {
        return 105;
    }else if(indexPath.section ==1){
        return f;
    }else if(indexPath.section ==2){
        if (indexPath.row == 0) {
            return 42;
        }else{
            return 70;
        }
    }else{
        if (indexPath.row == 0) {
            return 42;
        }else{
            return 215;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.dataArray.count !=0&&self.newsArray.count !=0) {
        return 4;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return  [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            ConsultingDynamicViewController *cnsultingDynamicVc = [[ConsultingDynamicViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            cnsultingDynamicVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cnsultingDynamicVc animated:YES];
        }else{
            HomeNewsModel *model = self.newsArray[indexPath.row -1];
            DynamicDetailViewController *dynamicDetailVc = [[DynamicDetailViewController alloc] init];
            dynamicDetailVc.ids = model.id;
            dynamicDetailVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:dynamicDetailVc animated:YES];
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            ShopViewController *shopVc = [[ShopViewController alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            shopVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shopVc animated:YES];
        }
    }
}

#pragma mark - CoreLocation 代理
- (void)createLoction{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [UIApplication sharedApplication].idleTimerDisabled = TRUE;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 3600.0f; // 如果设为kCLDistanceFilterNone，则每秒更新一次;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        //        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self positioning];
}
-(void)positioning{
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation];
    }else {
        NSLog(@"请开启定位功能！");
    }
}
#pragma mark - CLLocationManagerDelegate
// 地理位置发生改变时触发0
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *currLocation = [locations lastObject];
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    WeakSelf(HomeViewController);
    [geocoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks,NSError *error){
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSLog(@"~~%@",[NSString stringWithFormat:@"%@%@%@%@%@%@\n经度=%f 纬度=%f 高度=%f",placemark.country,placemark.administrativeArea,placemark.locality,placemark.subLocality,placemark.thoroughfare,placemark.subThoroughfare,currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude]);
            NSMutableArray * arr = [NSMutableArray array];
            NSString *hanziText = placemark.administrativeArea;
            if ([hanziText length]) {
                NSMutableString *ms = [[NSMutableString alloc] initWithString:hanziText];
                if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
                    NSLog(@"pinyin: %@", ms);
                }
                if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
                    arr = [NSMutableArray arrayWithArray:[ms componentsSeparatedByString:@" "]];
                    [arr removeLastObject];
                }  
            }
            [weakSelf getWeatherXianxingInfoNetWork:[NSString stringWithFormat:@"%f",currLocation.coordinate.latitude] lng:[NSString stringWithFormat:@"%f",currLocation.coordinate.longitude] city:[arr componentsJoinedByString:@""]];
//            for (CLPlacemark * placemark in placemarks) {
//                
//                NSDictionary *test = [placemark addressDictionary];
//                //  Country(国家)  State(城市)  SubLocality(区)
//                NSLog(@"%@", test[@"Country"]);
//                NSLog(@"%@", test[@"State"]);
//            }
        }
    }];
    [manager stopUpdatingLocation];
}
// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error:%@",error);
    [self positioning];
}
#
- (void)getWeatherXianxingInfoNetWork:(NSString *)lat lng:(NSString *)lng city:(NSString *)city{
    [self showHudAuto:WaitPrompt];
    WeakSelf(HomeViewController);
    [[THNetWorkManager shareNetWork]getWeatherXianxingInfo:lat lng:lng city:city andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            WeatherModel * model = [response thParseDataFromDic:response.dataDic[@"tianqi"] andModel:[WeatherModel class]];
            weakSelf.weatherModel = model;
            if ([response.dataDic[@"xianxing"] isKindOfClass:[NSDictionary class]]) {
                XianXing * item = [response thParseDataFromDic:response.dataDic[@"xianxing"] andModel:[XianXing class]];
                weakSelf.xianxingItem = item;
            }
            [weakSelf.tableView reloadData];
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




@end
