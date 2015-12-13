//
//  MainDiagnosticTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/13.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MainDiagnosticTableViewCell.h"

@implementation MainDiagnosticTableViewCell

- (void)customView{
    [self.contentView addSubview:self.imgArrow];
    [self.contentView addSubview:self.labTitle];
    
    
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.imgArrow.left -20, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UIImageView *)imgArrow{
    if (!_imgArrow) {
        _imgArrow = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceSize.width -17/2 -10, (45 -15)/2, 17/2, 15)];
        _imgArrow.image = [UIImage imageNamed:@"arrowImg"];
    }
    return _imgArrow;
}


//赋值
- (void)confingWithModel:(NSInteger )dic{
    self.labTitle.text = @"多米分综合征";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
