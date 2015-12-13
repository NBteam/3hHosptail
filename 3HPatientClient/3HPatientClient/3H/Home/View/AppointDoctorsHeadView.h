//
//  AppointDoctorsHeadView.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointDoctorsHeadView : UIView

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UIImageView *imgDoctorPic;

@property (nonatomic, strong) UILabel *labDoctorName;

@property (nonatomic, strong) UILabel *labDoctorInfo;
//赋值

- (void)confingWithModel:(NSInteger )model;

@end
