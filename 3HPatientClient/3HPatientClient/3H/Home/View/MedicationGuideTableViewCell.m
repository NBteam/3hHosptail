//
//  MedicationGuideTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/7.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MedicationGuideTableViewCell.h"
@interface MedicationGuideTableViewCell()
@property (nonatomic, strong) NSArray *arr;
@end
@implementation MedicationGuideTableViewCell

- (void)customView{
    self.arr = @[@"剂量",@"次数",@"用药时间",@"服用方式",@"开始时间",@"结束时间"];
    [self.contentView addSubview:self.viewBack];
    [self.viewBack addSubview:self.labTitle];
    
    for (int i = 0; i<self.arr.count; i++) {
        UILabel *labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 35 +30*i, self.viewBack.width, 0.5)];
        labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
        [self.viewBack addSubview:labLine];
        
        UILabel *labT = [[UILabel alloc] initWithFrame:CGRectMake(10, labLine.bottom +8.5, 80, 13)];
        labT.textColor = [UIColor colorWithHEX:0x333333];
        labT.font = [UIFont systemFontOfSize:13];
        labT.text = self.arr[i];
        [self.viewBack addSubview:labT];
        
        UILabel *labD = [[UILabel alloc] initWithFrame:CGRectMake(labT.right , labLine.bottom +8.5, self.viewBack.width -20 -80, 13)];
        labD.textColor = [UIColor colorWithHEX:0x999999];
        labD.font = [UIFont systemFontOfSize:13];
        labD.textAlignment = NSTextAlignmentRight;
        labD.tag = 1000+i;
        [self.viewBack addSubview:labD];
    }
}

- (UIView *)viewBack{
    if (!_viewBack) {
        _viewBack = [[UIView alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width -20, 215)];
        _viewBack.backgroundColor = [UIColor colorWithHEX:0xffffff];
        _viewBack.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _viewBack.layer.borderWidth = 0.5;
    }
    return _viewBack;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, self.viewBack.width -10, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

//赋值
- (void)confingWithModel:(MessageListModel * )model{
    self.labTitle.text = model.name;
    UILabel *lab1 = (UILabel *)[self.viewBack viewWithTag:1000];
    lab1.text = model.use_level;
    UILabel *lab2 = (UILabel *)[self.viewBack viewWithTag:1001];
    lab2.text = model.use_num;
    UILabel *lab3 = (UILabel *)[self.viewBack viewWithTag:1002];
    lab3.text = model.use_time;
    UILabel *lab4 = (UILabel *)[self.viewBack viewWithTag:1003];
    lab4.text = model.use_method;
    UILabel *lab5 = (UILabel *)[self.viewBack viewWithTag:1004];
    lab5.text = model.start_time;
    UILabel *lab6 = (UILabel *)[self.viewBack viewWithTag:1005];
    lab6.text = model.end_time;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
