//
//  CheckDataTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "CheckDataTableViewCell.h"

@implementation CheckDataTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
    [self.contentView addSubview:self.labTime];
}

- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 80)];
//        _imgLogo.backgroundColor = [UIColor whiteColor];
        _imgLogo.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _imgLogo.layer.borderWidth = 0.5;
        
    }
    return _imgLogo;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, 13, DeviceSize.width -20 -self.imgLogo.right -10, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right +10, self.labTitle.bottom +10, DeviceSize.width -10 -self.imgLogo.right -10, 0)];
        _labDetail.textColor = [UIColor colorWithHEX:0x888888];
        _labDetail.font = [UIFont systemFontOfSize:12];
        _labDetail.numberOfLines = 2;
    }
    return _labDetail;
}

- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 100 - 20, 0, 12)];
        _labTime.textColor = [UIColor colorWithHEX:0x999999];
        _labTime.font = [UIFont systemFontOfSize:12];
    }
    return _labTime;
}

//赋值
- (void)confingWithModel:(CheckListModel *)dic{
    self.labTitle.text = dic.name;
    self.labDetail.text = dic.hospital
    ;
    [self.labDetail sizeToFit];
    self.labDetail.top = self.labTitle.bottom +10;
    if (!dic.pic) {
        [self.imgLogo sd_setImageWithURL:SD_IMG(dic.pics)];
    }else{
        [self.imgLogo sd_setImageWithURL:SD_IMG(dic.pic)];
    }
    
    self.labTime.text = dic.addtime;
    CGSize size = [self.labTime.text sizeWithFont:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(0, 12)];
    
    self.labTime.left = DeviceSize.width -size.width -10;
    self.labTime.width = size.width;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
