//
//  CommentsToolBarView.h
//  3HDoctorClient
//
//  Created by 范英强 on 16/2/2.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsToolBarView : UIView

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) UIButton *btnComment;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, copy) void (^btnCommentBlock)();
@end
