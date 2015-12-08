//
//  HomeFunctionTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "HomeFunctionTableViewCell.h"

@implementation HomeFunctionTableViewCell

- (void)customView{
    NSArray *arrImg = @[@"th健康管理",@"th我要咨询",@"th健康日程",@"th我要预约"];
    NSArray *arrName = @[@"健康管理",@"我要咨询",@"健康日程",@"我要预约"];

    CGFloat f;
    CGFloat w = DeviceSize.width/4;
    if (DeviceSize.width >375) {
        f = (DeviceSize.width *86)/375;
    }else{
        f = 86;
    }
//    健康管理  #ff813c
//    我要咨询  #ff9358
//    健康日程  #ffae58
//    我要预约  #ffc658
    for (int i = 0; i <arrName.count; i++) {
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        view.frame = CGRectMake(w*i, 0, w, f);
        view.tag = 100 +i;
        [view addTarget:self action:@selector(btnAciton:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            view.backgroundColor = [UIColor colorWithHEX:0xff813c];
        }else if (i == 1){
            view.backgroundColor = [UIColor colorWithHEX:0xff9358];
        }else if (i == 2){
            view.backgroundColor = [UIColor colorWithHEX:0xffae58];
        }else{
            view.backgroundColor = [UIColor colorWithHEX:0xffc658];
        }
        
        [self.contentView addSubview:view];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((w -50)/2, (f -70)/2, 50, 50)];
        //img.backgroundColor = [UIColor whiteColor];
        img.image = [UIImage imageNamed:arrImg[i]];
        
        [view addSubview:img];
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, img.bottom +8, w, 12)];
        lab.textColor = [UIColor colorWithHEX:0xffffff];
        lab.font = [UIFont systemFontOfSize:12];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = arrName[i];
        
        [view addSubview:lab];
    }
}

- (void)btnAciton:(UIButton *)btn{
    if (self.HomefunctionBlock) {
        self.HomefunctionBlock(btn.tag - 100);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
