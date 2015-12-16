//
//  BaseViewController.h
//  OC_Project
//
//  Created by 范英强 on 15/11/28.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBarButtonItemExtension.h"

@interface BaseViewController : UIViewController


/// 距离屏幕顶部的距离
@property(nonatomic,readonly) CGFloat viewTop;
/// 距离屏幕顶部的高度
@property(nonatomic,readonly) CGFloat frameTopHeight;

/// 获取登陆后的实例参数
@property (nonatomic, strong) THUser *user;

- (THUser *)refreshUserData;
@end
