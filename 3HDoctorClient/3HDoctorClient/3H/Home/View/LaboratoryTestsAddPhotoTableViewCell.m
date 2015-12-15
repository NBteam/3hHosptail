//
//  LaboratoryTestsAddPhotoTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "LaboratoryTestsAddPhotoTableViewCell.h"

@implementation LaboratoryTestsAddPhotoTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.btnTakingPictures];
    //[self.contentView addSubview:self.img];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width/2, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"报告单";
    }
    return _labTitle;
}

- (UIButton *)btnTakingPictures{
    if (!_btnTakingPictures) {
        _btnTakingPictures = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTakingPictures.frame = CGRectMake(DeviceSize.width -35 -10, 0, 42, 45);
        [_btnTakingPictures setImage:[UIImage imageNamed:@"首页-患者中心-患者详情--检验及检查-检查-添加检查_相机"] forState:UIControlStateNormal];
        [_btnTakingPictures addTarget:self action:@selector(btnTakingPicturesAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnTakingPictures;
}

- (void)btnTakingPicturesAction{
    if (self.btnTakingBlock) {
        self.btnTakingBlock();
    }
}


- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom, DeviceSize.width -20, 250)];
        _img.backgroundColor = [UIColor grayColor];
        _img.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _img.layer.borderWidth = 0.5;
        
    }
    return _img;
}

//赋值
- (CGFloat)confingWithModel:(NSMutableArray *)array{
    CGFloat f = (DeviceSize.width - 60)/3;
    CGFloat ff = 0.0;
    for (int i = 0; i<array.count; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15 +(15 +f)*(i%3), self.labTitle.bottom +(f/4*3 +15)*(i/3), f, f/4*3);
        [btn setImage:array[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        ff = btn.bottom +15;
        [self.contentView addSubview:btn];
    }
    if (array.count == 0) {
        return self.labTitle.bottom;
    }else{
        return ff;
    }
}

- (void)btnAction:(UIButton *)button{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
