//
//  OutpatientAppointViewController.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "OutpatientAppointViewController.h"
#import "OutpatientReservationView.h"

@interface OutpatientAppointViewController ()
@property (nonatomic, strong) OutpatientReservationView * reservationView;
@end

@implementation OutpatientAppointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.reservationView];
    // Do any additional setup after loading the view.
}
- (OutpatientReservationView *)reservationView{
    if (!_reservationView) {
        _reservationView = [[OutpatientReservationView alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 300) array:nil];
    }
    return _reservationView;
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
