//
//  ReviewGuideTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ReviewGuideTableViewCell.h"
@interface ReviewGuideTableViewCell()
@property (nonatomic, strong) NSArray *arr;
@end
@implementation ReviewGuideTableViewCell

- (void)customView{
    self.arr = @[@"复查时间",@"复查医院"];
    [self.contentView addSubview:self.labTitle];
    
    for (int i = 0; i<self.arr.count; i++) {
        UILabel *labLine = [[UILabel alloc] initWithFrame:CGRectMake(10, 35 +30*i, self.labTitle.width, 0.5)];
        labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
        [self.contentView addSubview:labLine];
        
        UILabel *labT = [[UILabel alloc] initWithFrame:CGRectMake(10, labLine.bottom +8.5, 80, 13)];
        labT.textColor = [UIColor colorWithHEX:0x333333];
        labT.font = [UIFont systemFontOfSize:13];
        labT.text = self.arr[i];
        [self.contentView addSubview:labT];
        
        UILabel *labD = [[UILabel alloc] initWithFrame:CGRectMake(labT.right, labLine.bottom +8.5, DeviceSize.width -20 -80, 13)];
        labD.textColor = [UIColor colorWithHEX:0x999999];
        labD.font = [UIFont systemFontOfSize:13];
        labD.textAlignment = NSTextAlignmentRight;
        labD.tag = 2000+i;
        [self.contentView addSubview:labD];
    }
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceSize.width -20, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

//赋值
- (void)confingWithModel:(NSInteger )model{
    self.labTitle.text = @"复查项目名称";
    UILabel *lab1 = (UILabel *)[self.contentView viewWithTag:2000];
    lab1.text = @"2015-09-02 上午";
    UILabel *lab2 = (UILabel *)[self.contentView viewWithTag:2001];
    lab2.text = @"北三医院";

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
