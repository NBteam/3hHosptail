//
//  AllHeadView.m
//  3HPatientClient
//
//  Created by 郑彦华 on 16/1/18.
//  Copyright © 2016年 fyq. All rights reserved.
//

#import "AllHeadView.h"
@interface AllHeadView()

@property (nonatomic, strong) NSArray *titleArray;

@end
@implementation AllHeadView

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
        _titleArray = @[@"待支付",@"待收货"];
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
        [self addSubview:btn];
        
    }
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

@end
