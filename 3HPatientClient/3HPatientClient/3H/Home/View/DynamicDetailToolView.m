//
//  DynamicDetailToolView.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "DynamicDetailToolView.h"

@implementation DynamicDetailToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHEX:0xffffff];
        [self customView];
    }
    return self;
}

- (void)customView{
    [self addSubview:self.labLine];
    NSArray *arr = @[@"评论(154)",@"点赞(23)"];
    NSArray *arrImg = @[@"首页-新药研发_评论",@"首页-新药研发_点赞"];
    CGSize size = [arr[0] sizeWithFont:[UIFont systemFontOfSize:16] maxSize:CGSizeMake(0, 45)];
    CGFloat  f = 18 +10 +size.width;
    for (int i = 0; i<arr.count; i++) {
        
        UIButton *img = [UIButton buttonWithType:UIButtonTypeCustom];
        img.frame = CGRectMake((DeviceSize.width/2 -f)/2 +DeviceSize.width/2*i, (45 -20)/2 , 20, 20);
        [img setImage:[UIImage imageNamed:arrImg[i]] forState:UIControlStateNormal];
        [self addSubview:img];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(img.right +10, 0, size.width, 45)];
        lab.font = [UIFont systemFontOfSize:16];
        lab.text = arr[i];
        lab.textColor = AppDefaultColor;
        [self addSubview:lab];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0 +DeviceSize.width/2*i, 0, DeviceSize.width/2, 45);
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 600+i;
        [self addSubview:btn];
        
    }
    [self addSubview:self.labLine1];
}

- (void)btnAction:(UIButton *)button{
    if (self.toolBlock) {
        self.toolBlock(button.tag - 600);
    }
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}

- (UILabel *)labLine1{
    if (!_labLine1) {
        _labLine1 = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width/2 -0.5, 7.5, 1, 30)];
        _labLine1.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
