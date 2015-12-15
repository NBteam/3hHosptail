//
//  MineHeadView.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeadView : UIView

@property (nonatomic, strong) UIImageView *imgPatientPic;

@property (nonatomic, strong) UILabel *labPatientSex;

@property (nonatomic, strong) UILabel *labPatientName;
//赋值

- (void)confingWithName:(NSString * )name Sex:(NSString *)sex Pic:(NSString *)pic;
@end
