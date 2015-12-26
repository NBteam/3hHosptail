//
//  OutpatientAppointTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/16.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DoctorsInfoModel.h"
@interface OutpatientAppointTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIView *viewBack;

@property (nonatomic, strong) UIButton *btnSubmit;

//背景
@property (nonatomic, strong) UIView *backViewss;
//
@property (nonatomic, strong) UITextField *txtNameInput;

@property (nonatomic, strong) UILabel *labDate;
@property (nonatomic, strong) NSArray * infoArray;

@property (nonatomic, copy) void(^outpatientAppontBlcok)(DoctorsInfoModel *model,NSString *string);
@property (nonatomic, copy) void(^alertBlock)(void);
//赋值
- (CGFloat)confingWithModelWeeks:(NSArray *)week Price:(NSString *)price clickArray:(NSArray *)clickArray;



@end
