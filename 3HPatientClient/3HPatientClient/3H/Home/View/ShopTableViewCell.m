//
//  ShopTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/5.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShopTableViewCell.h"

@implementation ShopTableViewCell

- (void)customView{
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.customView1];
    [self.contentView addSubview:self.customView2];
}

- (ShopCustomView *)customView1{
    if (!_customView1) {
        _customView1 = [[ShopCustomView alloc] initWithFrame:CGRectMake(10, 1, DeviceSize.width/2 -15, 195)];
        UITapGestureRecognizer * customView1Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(customViewTapGesture:)];
        [_customView1 addGestureRecognizer:customView1Tap];
        _customView1.tag = 30000;
    }
    return _customView1;
}

- (ShopCustomView *)customView2{
    if (!_customView2) {
        _customView2 = [[ShopCustomView alloc] initWithFrame:CGRectMake(self.customView1.right +10, 1, DeviceSize.width/2 -15, 195)];
        UITapGestureRecognizer * customView2Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(customViewTapGesture:)];
        [_customView2 addGestureRecognizer:customView2Tap];
        _customView2.tag = 30001;
    }
    return _customView2;
}
- (void)customViewTapGesture:(UITapGestureRecognizer *)tap{
    if (self.customViewBlock) {
        self.customViewBlock(tap.view.tag - 30000);
    }
}
//赋值
- (void)confingWithModel:(GoodsListModel *)model indexRow:(NSInteger)row{
    if (row%2==0) {
        [self.customView1 confingWithModel:model];
    }else{
        [self.customView2 confingWithModel:model];
    }
}
- (void)hiddenItem{
    self.customView2.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
