//
//  DiagnosisDetailEditorTableViewCell.m
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "MedicalHistoryDetailEditorTableViewCell.h"

@implementation MedicalHistoryDetailEditorTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labLine];
    [self.contentView addSubview:self.txtView];
    
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, DeviceSize.width/2, 35)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"病情描述:";
    }
    return _labTitle;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom, DeviceSize.width -20, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine;
}

- (CustomTextView *)txtView{
    if (!_txtView) {
        _txtView = [[CustomTextView alloc] initWithFrame:CGRectMake(10, self.labLine.bottom +10, DeviceSize.width -20, 200) placeholderFont:[UIFont systemFontOfSize:13] Color:[UIColor colorWithHEX:0x999999] Text:@"请输入患者的病例描述..."];
        _txtView.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtView.layer.borderWidth = 0.5;
    }
    return _txtView;
}



//赋值
- (CGFloat)confingWithModel:(NSString *)model{
    self.txtView.text = model;
    
    if (model.length ==0) {
        
    }else{
       self.txtView.placeholderLabel.text = @"";
    }
    
    
    return self.txtView.bottom +10;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
