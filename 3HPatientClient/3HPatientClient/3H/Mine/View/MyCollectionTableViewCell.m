//
//  MyCollectionTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MyCollectionTableViewCell.h"

@implementation MyCollectionTableViewCell


- (void)customView{
    [self.contentView addSubview:self.btnCollection];
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.imgStar];

}

- (UIButton *)btnCollection{
    if (!_btnCollection) {
        _btnCollection = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCollection.frame = CGRectMake(10, (70 -15)/2, 15, 15);
        [_btnCollection setImage:[UIImage imageNamed:@"我的-我的收藏_收藏-点击状态"] forState:UIControlStateSelected];
        [_btnCollection setImage:[UIImage imageNamed:@"我的-我的收藏_收藏-未点击状态"] forState:UIControlStateNormal];
        [_btnCollection addTarget:self action:@selector(btnCollectionAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnCollection;
}

- (void)btnCollectionAction{
    
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(self.btnCollection.right +10, 10, 60, 50)];
        _imgLogo.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _imgLogo.layer.borderWidth = 0.5;
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 10, DeviceSize.width - self.imgLogo.right -20, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UIImageView *)imgStar{
    if (!_imgStar) {
        _imgStar = [[UIImageView alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.labTitle.bottom +10, 116/2, 9)];
        _imgStar.image = [UIImage imageNamed:@"我的-我的收藏_心"];
    }
    return _imgStar;
}

//赋值
- (void)confingWithModel:(NSDictionary *)dic{
    self.imgLogo.backgroundColor = [UIColor whiteColor];
    self.labTitle.text = @"九康科技电子血压测量仪技电子血压测量仪技电子血压测量仪";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
