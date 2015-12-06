//
//  DiagnosisTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "DiagnosisTableViewCell.h"

@implementation DiagnosisTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDetail];
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width/2, 45)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
    }
    return _labTitle;
}

- (UILabel *)labDetail{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width/2 -30, 0, DeviceSize.width/2 +30 -10, 45)];
        _labDetail.textColor = [UIColor colorWithHEX:0x999999];
        _labDetail.font = [UIFont systemFontOfSize:13];
        _labDetail.textAlignment = NSTextAlignmentRight;
    }
    return _labDetail;
}

//赋值
- (void)confingWithModel:(NSDictionary *)model index:(NSUInteger)index{
    //    NSArray *arr = @[@"请输入药物名称",@"剂量",@"次数",@"用药时间",@"用药途径",@"开始时间",@"结束时间"];
    
    if (index==0) {
        self.labTitle.text = [NSString stringWithFormat:@"是否有过敏史:"];
        self.labDetail.text = [NSString stringWithFormat:@"%@",model[@"guomin"]];
    }else{
        self.labTitle.text = [NSString stringWithFormat:@"血型:"];
        self.labDetail.text = [NSString stringWithFormat:@"%@",model[@"blood_type"]];
    }
    
    if ([self.labDetail.text isEqualToString:@"未选择"]) {
        self.labDetail.textColor = [UIColor colorWithHEX:0x999999];
    }else{
        self.labDetail.textColor = [UIColor colorWithHEX:0x333333];
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
