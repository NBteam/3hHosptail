//
//  HomeSlidingTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HomeSlidingCustomView.h"

@interface HomeSlidingTableViewCell : BaseTableViewCell<UIScrollViewDelegate>

//@property (nonatomic, strong) HomeSlidingCustomView *customView;
@property (nonatomic, strong) UIScrollView *scrollView;
//点击时间回调
@property (nonatomic,copy) void(^slidingBlock)(NSInteger index);
- (void)confingWithModel:(NSString *)model;

@end
