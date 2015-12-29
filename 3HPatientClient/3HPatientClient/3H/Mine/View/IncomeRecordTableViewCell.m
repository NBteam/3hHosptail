//
//  IncomeRecordTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/4.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "IncomeRecordTableViewCell.h"

@implementation IncomeRecordTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width -20, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

//赋值
- (void)confingWithModel:(IncomeRecordModel *)model{
    self.labTitle.attributedText = [self getLabelTitle:[NSString stringWithFormat:@"%@",model.addtime] Name:[NSString stringWithFormat:@"  %@",model.memo] Price:[NSString stringWithFormat:@"%@",model.total]];
}

- (NSMutableAttributedString *)getLabelTitle:(NSString *)title Name:(NSString *)name Price:(NSString *)price{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@",title,name,price]];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x999999] range:NSMakeRange(0,title.length)];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x333333] range:NSMakeRange(title.length,name.length)];
    
    [str addAttribute:NSForegroundColorAttributeName value:AppDefaultColor range:NSMakeRange(title.length +name.length,price.length)];
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
