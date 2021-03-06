//
//  QrCodeViewController.m
//  Client
//
//  Created by apple on 15/6/19.
//  Copyright (c) 2015年 CC. All rights reserved.
//

#import "QrCodeViewController.h"
#import "ZBarSDK.h"
//#import "InfDetailedViewController.h"

@interface QrCodeViewController ()<ZBarReaderDelegate,ZBarReaderViewDelegate>

{
    
    BOOL is_Anmotion;
    CGFloat keyboardHight;
    BOOL isKeyboardShow;
    
}

//二维码扫描View
@property (nonatomic, strong) ZBarReaderView *readerView;

//扫描框背景
@property (nonatomic, strong) UIImageView *scanZomeBack;

//扫描动画的中的那个蓝线
@property (nonatomic, strong) UIImageView *readLineView;

@property (nonatomic, strong) UILabel *labTitle;

@end

@implementation QrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];

    //初始化扫描界面 调用相机扫描
    [self initScan];

}

- (void)backAction{
    is_Anmotion = YES;
    //停止扫描
    [_readerView stop];
    [_readerView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 初始化扫描
- (void)initScan
{
    self.readerView = [ZBarReaderView new];
    _readerView.backgroundColor = [UIColor clearColor];
    _readerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _readerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _readerView.readerDelegate = self;
    
    //使用手势变焦
    _readerView.allowsPinchZoom = YES;
    _readerView.trackingColor = [UIColor redColor];
    
    //显示帧率  YES 显示  NO 不显示
    _readerView.showsFPS = NO;
    
    //关闭闪光灯
    _readerView.torchMode = 0;
    //扫码bg
    UIImage *hbImage = [UIImage imageNamed:@"扫码边框"];
    _scanZomeBack = [[UIImageView alloc] initWithImage:hbImage];
    
    //添加一个背景图片
    CGRect mImagerect = CGRectMake((_readerView.frame.size.width - 220) * 0.5, (_readerView.frame.size.height - 220) * 0.5 - 70, 220, 220);
    [_scanZomeBack setFrame:mImagerect];
    //将被扫描的图像的区域
    _readerView.scanCrop = CGRectMake(0, 0, DeviceSize.width, DeviceSize.width);
//    _readerView.scanCrop = [self getScanCrop:mImagerect readerViewBounds:_readerView.bounds];
    
    [_readerView addSubview:_scanZomeBack];
    [_readerView addSubview:_readLineView];
    [_readerView addSubview:self.labTitle];
    
    
    //处理模拟器
    if (TARGET_IPHONE_SIMULATOR) {
        ZBarCameraSimulator *cameraSimulator
        = [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = _readerView;
    }
    
    
    [self.view addSubview:_readerView];
    
    
    //扫描框下面的注释label
    UILabel  *annotationLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_scanZomeBack.frame) - 20, CGRectGetMaxY(_scanZomeBack.frame) + 10 ,_scanZomeBack.frame.size.width + 40 , 30)];
    
    annotationLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    annotationLabel.textAlignment = NSTextAlignmentCenter;
    annotationLabel.font = [UIFont systemFontOfSize:12.0f];
    
    
    //上面view
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(_readerView.frame),CGRectGetMinY(_scanZomeBack.frame))];
    topView.backgroundColor = [UIColor blackColor];
    topView.alpha = 0.1;
    [_readerView addSubview:topView];
    
    //左边view
    UIView  *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(_scanZomeBack.frame), CGRectGetMinX(_scanZomeBack.frame) ,CGRectGetHeight(_scanZomeBack.frame))];
    leftView.backgroundColor = [UIColor blackColor];
    leftView.alpha = 0.1;
    [_readerView addSubview:leftView];
    
    //下面View
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_scanZomeBack.frame),CGRectGetWidth(_readerView.frame),CGRectGetHeight(_readerView.frame) - CGRectGetMaxY(_scanZomeBack.frame))];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.1;
    [_readerView addSubview:bottomView];
    
    //右面View
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_scanZomeBack.frame), CGRectGetMinY(_scanZomeBack.frame), CGRectGetWidth(_readerView.frame ) - CGRectGetMaxX(_scanZomeBack.frame), CGRectGetHeight(_scanZomeBack.frame))];
    rightView.backgroundColor = [UIColor blackColor];
    rightView.alpha = 0.1;
    [_readerView addSubview:rightView];
    
    
    
    
    
    //添加底部视图
//    [self initBottomBackground];
    
    //添加线view
    [self initReadLineView];
    
    //开始扫描
    [_readerView start];
    
    //开启扫描动画
    [self loopDrawLine];
    
    
}

#pragma mark 获取扫描区域
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}



#pragma mark - lineView
- (void)initReadLineView
{
    
    CGRect  rect = CGRectMake(_scanZomeBack.frame.origin.x, _scanZomeBack.frame.origin.y, _scanZomeBack.frame.size.width, 2);
    if (_readLineView) {
        [_readLineView removeFromSuperview];
    }
    
    self.readLineView = [[UIImageView alloc] initWithFrame:rect];
    [_readLineView setImage:[UIImage imageNamed:@"扫码line"]];
    // 添加到扫描视图上
    [_readerView addSubview:_readLineView];
    
    
    
}




#pragma mark - 扫描动画
-(void)loopDrawLine
{
    CGRect  rect = CGRectMake(_scanZomeBack.frame.origin.x, _scanZomeBack.frame.origin.y, _scanZomeBack.frame.size.width, 2);
    
    //重新复位
    _readLineView.frame = rect;
    
    [UIView animateWithDuration: 3.0
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         //修改fream的代码写在这里
                         _readLineView.frame = CGRectMake(_scanZomeBack.frame.origin.x, _scanZomeBack.frame.origin.y +_scanZomeBack.frame.size.height, _scanZomeBack.frame.size.width, 2);
                         [_readLineView setAnimationRepeatCount:0];
                         
                     }
                     completion:^(BOOL finished){
                         if (!is_Anmotion) {
                             
                             //递归调用实现循环
                             [self loopDrawLine];
                             
                         }
                         
                     }];
    
    
}


#pragma mark - readViewDelegate
//获取扫描结果
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    
    //停止动画
    is_Anmotion = YES;
    
    // 得到扫描的条码内容
    const zbar_symbol_t *symbol = zbar_symbol_set_first_symbol(symbols.zbarSymbolSet);
    
    //二维码内容
     NSString *symbolStr = [NSString stringWithUTF8String: zbar_symbol_get_data(symbol)];
    NSLog(@"8888%@",symbolStr);
    
    
    
    
    // 是否QR二维码
    if (zbar_symbol_get_type(symbol) == ZBAR_QRCODE) {
        
        for (ZBarSymbol *symbol in symbols) {
           
            //扫描成功 推出详情页
            [self beHelperDoctor_id:symbol.data];
            
            break;
        }
        
    }
    //停止扫描
    [readerView stop];
    
    //停止扫描后从俯视图上移除
    [readerView removeFromSuperview];
    
    
    
    
}

//开始扫描的回调
- (void)readerViewDidStart:(ZBarReaderView *)readerView
{
    
    NSLog(@"//开始扫描的回调");
    
}
//扫描失败的回调
-  (void)readerView:(ZBarReaderView *)readerView didStopWithError:(NSError *)error
{
    NSLog(@"//扫描失败的回调");
    
}

#pragma mark -  gotoBack
- (void)goBack
{
    UIViewController *topCtrl = self.navigationController.topViewController;
    if (topCtrl == self) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


- (void)beHelperDoctor_id:(NSString *)doctor_id{
    NSLog(@"医生id%@",doctor_id);
    [self showHudAuto:@"添加中..."];
    WeakSelf(QrCodeViewController);
    [[THNetWorkManager shareNetWork] beHelperDoctor_id:doctor_id andCompletionBlockWithSuccess:^(NSURLSessionDataTask *urlSessionDataTask, THHttpResponse *response) {
        [weakSelf removeMBProgressHudInManaual];
        if (response.responseCode == 1) {
            [weakSelf showHudAuto:@"添加成功" andDuration:@"2"];
 
        }else{
            [weakSelf showHudAuto:response.message andDuration:@"2"];
        }
        [weakSelf backAction];
    } andFailure:^(NSURLSessionDataTask *urlSessionDataTask, NSError *error) {
        [weakSelf showHudAuto:InternetFailerPrompt andDuration:@"2"];
        ;
    } ];
    
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scanZomeBack.bottom +20, DeviceSize.width, 16)];
        _labTitle.font = [UIFont boldSystemFontOfSize:15];
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.textColor = AppDefaultColor;
        _labTitle.text = @"请将二维码放入框内,将自动扫描";
    }
    return _labTitle;
}

- (NSString *)title{
    return @"扫一扫";
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
