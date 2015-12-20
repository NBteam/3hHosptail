//
//  PhoneExperToolView.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/20.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneExperToolView : UIView
@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UIButton *btnTelephone;
@property (nonatomic, copy) void (^btnTelephoneBlock)(void);
@end

