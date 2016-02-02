//
//  CommentsToolBarView.m
//  3HDoctorClient
//
//  Created by 范英强 on 16/2/2.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "CommentsToolBarView.h"

@implementation CommentsToolBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.labLine];
    [self addSubview:self.btnComment];
    [self.btnComment addSubview:self.labTitle];
    [self.btnComment addSubview:self.imgLogo];
}


- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}

- (UIButton *)btnComment{
    if (!_btnComment) {
        _btnComment = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnComment.frame = CGRectMake(10, 5, DeviceSize.width - 20, 44 - 10);
        _btnComment.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _btnComment.layer.masksToBounds = YES;
        _btnComment.layer.cornerRadius = 5;
        _btnComment.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _btnComment.layer.borderWidth = 0.5;
        [_btnComment addTarget:self action:@selector(btnCommentAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnComment;
}

- (void)btnCommentAction{
    if (self.btnCommentBlock) {
        self.btnCommentBlock();
    }
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, self.btnComment.height)];
        _labTitle.textColor = [UIColor colorWithHEX:0x999999];
        _labTitle.font = [UIFont systemFontOfSize:12];
        _labTitle.text = @"输入您的评论信息";
    }
    return _labTitle;
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(self.btnComment.width - 24 -10, (self.btnComment.height - 22)/2, 24, 22)];
        _imgLogo.image = [UIImage imageNamed:@"首页-健康资讯-新闻资讯-评论_铅笔"];
    }
    return _imgLogo;
}


@end
