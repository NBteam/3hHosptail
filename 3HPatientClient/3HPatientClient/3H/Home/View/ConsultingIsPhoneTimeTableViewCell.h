//
//  ConsultingIsPhoneTimeTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ConsultingIsPhoneTimeTableViewCell : BaseTableViewCell<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labTime;

@property (nonatomic, strong) UIView *viewBack;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *btnLeft;

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UIButton *btnRight;

@property (nonatomic, strong) NSArray * dataArray;

@property (nonatomic, strong) UIButton *btnOld;
//赋值
- (void)confingWithModel:(NSMutableArray *)array;

@property (nonatomic, copy) void (^btnBlock)(NSDictionary *dict);
@property (nonatomic, copy) void (^isEmptyBlock)(void);
@end
