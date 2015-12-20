//
//  MedicalHistoryEditorViewController.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/19.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseViewController.h"

@interface MedicalHistoryEditorViewController : BaseViewController
@property (nonatomic, copy) NSString * mid;
@property (nonatomic, copy) void(^reloadBlock)(void);

@property (nonatomic, copy) NSString *gmString;
@property (nonatomic, copy) NSString *xxString;
@property (nonatomic, copy) NSString *detailString;

@end
