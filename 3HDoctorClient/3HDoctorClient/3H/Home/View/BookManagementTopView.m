//
//  BookManagementTopView.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/1.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BookManagementTopView.h"

@interface BookManagementTopView()

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation BookManagementTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}

- (void)customView{
    [self customButtons];
    [self addSubview:self.labLine];
    [self addSubview:self.labColorLine];
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 1, DeviceSize.width, 1)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}

- (UILabel *)labColorLine{
    if (!_labColorLine) {
        _labColorLine = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height - 2, DeviceSize.width/2, 2)];
        _labColorLine.backgroundColor = AppDefaultColor;
    }
    return _labColorLine;
}

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"挂号预约",@"电话预约"];
    }
    return _titleArray;
}

- (void)customButtons{
    for (int i = 0; i < self.titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0 +DeviceSize.width/2*i, 0 , DeviceSize.width/2, self.height - self.labLine.height);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:AppDefaultColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 +i;
        
        if (i == 0) {
             self.labGuaHao.left = btn.width - self.labGuaHao.width - 20;
            [btn addSubview:self.labGuaHao];
        }else{
            self.labDianHua.left = btn.width - self.labDianHua.width - 20;
            [btn addSubview:self.labDianHua];
        }
        [self addSubview:btn];
        
    }
}

- (UILabel *)labGuaHao{
    if (!_labGuaHao) {
        _labGuaHao = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 20, 20)];
        _labGuaHao.backgroundColor = [UIColor redColor];
        _labGuaHao.textColor = [UIColor whiteColor];
        _labGuaHao.font = [UIFont systemFontOfSize:13];
        _labGuaHao.textAlignment = NSTextAlignmentCenter;
        _labGuaHao.layer.cornerRadius = 10;
        _labGuaHao.layer.masksToBounds = YES;
    }
    return _labGuaHao;
}

- (UILabel *)labDianHua{
    if (!_labDianHua) {
        _labDianHua = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 20, 20)];
        _labDianHua.backgroundColor = [UIColor redColor];

        _labDianHua.textColor = [UIColor whiteColor];
        _labDianHua.font = [UIFont systemFontOfSize:13];
        _labDianHua.textAlignment = NSTextAlignmentCenter;
        _labDianHua.layer.cornerRadius = 10;
        _labDianHua.layer.masksToBounds = YES;
    }
    return _labDianHua;
}

- (void)btnAction:(UIButton *)btn{
    if (self.btnClickBlock) {
        self.btnClickBlock(btn.tag - 100);
    }
}

- (void)topButtonMenuSelectForIndex:(NSInteger)index{
    NSLog(@"查看%li",index);
    for (UIButton * btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn.tag == 100 +index) {
                [btn setTitleColor:AppDefaultColor forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:[UIColor colorWithHEX:0x333333] forState:UIControlStateNormal];
            }
        }
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.labColorLine.left = 0 + index *DeviceSize.width/2;
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
