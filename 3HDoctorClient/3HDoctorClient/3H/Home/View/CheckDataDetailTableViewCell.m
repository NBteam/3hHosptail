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
    [self.contentView addSubview:self.bgView];
    
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.labTitle.bottom, DeviceSize.width, 0)];
        _bgView.backgroundColor = [UIColor colorWithHEX:0xffffff];
    }
    return _bgView;
}

//赋值
- (CGFloat)confingWithModel:(CheckDataDetailModel *)model{
    self.imagesArrays = [[NSMutableArray alloc] init];
    self.imgArray = [[NSMutableArray alloc] init];
    self.labTitle.text = @"报告单";
    NSLog(@"---------%li",model.pics.count);
    CGFloat f = (DeviceSize.width - 60)/3;
    CGFloat ff = 0.0;
    for (int i = 0; i<model.pics.count; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15 +(15 +f)*(i%3), (f/4*3 +15)*(i/3), f, f/4*3);
        [btn sd_setImageWithURL:[NSURL URLWithString:model.pics[i]] forState:UIControlStateNormal];
        [self.imgArray addObject:model.pics[i]];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        ff = btn.bottom +15;
        btn.tag = i;
        [self.imagesArrays addObject:btn];
        self.bgView.height = btn.bottom;
        [self.bgView addSubview:btn];
    }
    NSLog(@"%@",self.imgArray);
    NSLog(@"%@",self.imagesArrays);
    if (model.pics.count == 0) {
        return self.labTitle.bottom;
    }else{
        return self.bgView.bottom +15;
    }
    
    
}


- (void)btnAction:(UIButton *)button{
    
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self.bgView; // 原图的父控件
    browser.imageCount = self.imgArray.count; // 图片总数
    browser.currentImageIndex = button.tag;
    browser.delegate = self;
    [browser show];

}

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    NSLog(@"小兔%ld",index);
    return [self.imagesArrays[index] currentImage];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSLog(@"da兔%ld",index);
    NSString *urlStr = self.imgArray[index];
    return [NSURL URLWithString:urlStr];
}
@end
