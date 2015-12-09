//
//  ConsultingToolView.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsultingToolView : UIView

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UILabel *labLine1;

@property (nonatomic,copy) void(^toolBlock)(NSInteger index);
@end
