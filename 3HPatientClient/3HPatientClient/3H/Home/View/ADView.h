//
//  ADView.h
//  UITableView_Cell定制
//
//  Created by LZXuan on 14-12-18.
//  Copyright (c) 2014年 LZXuan. All rights reserved.
//

#import <UIKit/UIKit.h>
//广告位 视图  按页显示
typedef void(^ADOpenBlock) (NSInteger tag);

@interface ADView : UIView <UIScrollViewDelegate>
@property (nonatomic,copy)ADOpenBlock ADBlock;
@property (nonatomic)NSTimer *timer;//记录定时器是否启动
- (id)initWithFrame:(CGRect)frame imagesArr:(NSArray*)arr;
- (void)stopTimer;
- (void)startTimer;
- (void)configWithArray:(NSArray *)array;
@end
