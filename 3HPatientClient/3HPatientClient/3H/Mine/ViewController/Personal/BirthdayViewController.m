//
//  BirthdayViewController.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BirthdayViewController.h"

@interface BirthdayViewController ()
@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *labTime;
@property (nonatomic, strong) UILabel *labLine;
@end

@implementation BirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHEX:0xffffff];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItemExtension leftBackButtonItem:@selector(backAction) andTarget:self];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.labTime];
    [self.view addSubview:self.datePicker];
    [self.view addSubview:self.labLine];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UI

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, DeviceSize.height -216 -self.frameTopHeight -20, DeviceSize.width, 216)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = locale;
        //当前时间创建NSDate
        NSDate *localDate = [NSDate date];
        self.datePicker.maximumDate = localDate;
        [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        NSDateFormatter *formatter = [[NSDateFormatter  alloc] init];
        
        if (self.dateString.length == 0) {
            [formatter setDateFormat:@"yyyy-MM-dd"];
            _datePicker.date = localDate;
            self.labTime.text = [formatter stringFromDate:localDate];
        }else{
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSLog(@"wo dekan%@",self.dateString);
            
            NSDate* inputDate = [formatter dateFromString:self.dateString];;
            _datePicker.date = inputDate;
            self.labTime.text = self.dateString;
            
            
        }
        
    }
    return _datePicker;
}

- (void)dateChange:(id)sender{
    UIDatePicker *picker = (UIDatePicker *)sender;
    NSDate  *date = picker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    self.labTime.text = [formatter stringFromDate:date];
    if (self.BirthdayBlock) {
        self.BirthdayBlock(self.labTime.text);
    }
    
}

- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(15, 52, DeviceSize.width -30, 96/2)];
        _backView.backgroundColor = [UIColor colorWithHEX:0xefefef];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 3;
    }
    return _backView;
}

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.backView.width, self.backView.height)];
        _labTime.font = [UIFont systemFontOfSize:15];
        _labTime.textColor = AppDefaultColor;
        _labTime.textAlignment = NSTextAlignmentCenter;
    }
    return _labTime;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.datePicker.top -1, DeviceSize.width, 1)];
        _labLine.backgroundColor = AppDefaultColor;
    }
    return _labLine;
}

- (NSString *)title{
    return @"完善资料";
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
