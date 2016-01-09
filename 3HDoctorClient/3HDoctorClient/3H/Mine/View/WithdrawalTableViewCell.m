//
//  WithdrawalTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/26.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "WithdrawalTableViewCell.h"

@implementation WithdrawalTableViewCell


- (void)customView{
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.imgArrow];
    [self.contentView addSubview:self.labTitle];
    
}
- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, (45-30)/2, 30, 30)];
        _imgLogo.backgroundColor = AppDefaultColor;
        
    }
    return _imgLogo;
}
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.imgLogo.right + 10, 0, self.imgArrow.left -10, 45)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        
    }
    return _labTitle;
}

- (UIImageView *)imgArrow{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width - 19/2 - 10, (45 - 34/2)/2, 19/2, 34/2)];
        _imgArrow.image = [UIImage imageNamed:@"3H-首页_键"];
        
    }
    return _imgArrow;
}


//赋值
- (void)confingWithModel:(WithdrawaListModel *)model{
    [self.imgLogo sd_setImageWithURL:URL(model.bank_pic)];
    self.labTitle.attributedText = [self getName:model.bank_type AndAge:[NSString stringWithFormat:@"  (%@)",model.bank_info]];
}

- (NSMutableAttributedString *)getName:(NSString *)name AndAge:(NSString *)card{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",name,card]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x333333] range:NSMakeRange(0, name.length)];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x999999] range:NSMakeRange(name.length, card.length)];
    
    return str;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
