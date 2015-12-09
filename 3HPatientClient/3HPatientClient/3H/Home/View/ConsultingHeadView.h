//
//  ConsultingHeadView.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsultingHeadView : UIView

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UIImageView *imgDoctorPic;

@property (nonatomic, strong) UILabel *labDoctorName;

@property (nonatomic, strong) UILabel *labDoctorInfo;
//赋值

- (void)confingWithModel:(NSInteger )model;
@end
