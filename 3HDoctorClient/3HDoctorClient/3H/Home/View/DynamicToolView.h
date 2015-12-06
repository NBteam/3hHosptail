//
//  DynamicToolView.h
//  3HDoctorClient
//
//  Created by kanzhun on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicToolView : UIView
@property (nonatomic, retain) UIButton * btnLeft;
@property (nonatomic, retain) UIButton * btnRight;
@property (nonatomic, retain) UILabel * labLine;
@property (nonatomic, retain) UILabel * labLine1;
@property (nonatomic, copy) void(^btnRightBlock)(void);
@end
