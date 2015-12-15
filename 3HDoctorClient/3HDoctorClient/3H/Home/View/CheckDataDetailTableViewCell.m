//
//  CheckDataDetailTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "CheckDataDetailTableViewCell.h"
#import "UIButton+WebCache.h"
@implementation CheckDataDetailTableViewCell
- (void)customView{
    [self.contentView addSubview:self.labTitle];
    
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

//赋值
- (CGFloat)confingWithModel:(CheckDataDetailModel *)model{
    self.labTitle.text = @"报告单";
    NSLog(@"---------%li",model.pics.count);
    CGFloat f = (DeviceSize.width - 60)/3;
    CGFloat ff = 0.0;
    for (int i = 0; i<model.pics.count; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15 +(15 +f)*(i%3), self.labTitle.bottom +(f/4*3 +15)*(i/3), f, f/4*3);
        [btn sd_setImageWithURL:[NSURL URLWithString:model.pics[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        ff = btn.bottom +15;
        [self.contentView addSubview:btn];
    }
    if (model.pics.count == 0) {
        return self.labTitle.bottom;
    }else{
        return ff;
    }
}


- (void)btnAction:(UIButton *)button{
    
}
@end