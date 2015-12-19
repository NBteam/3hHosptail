//
//  AddressView.m
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "AddressView.h"

@implementation AddressView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder{
    if (self == [super initWithFrame:frame]) {
//        [self addSubview:self.labLine1];
        [self addSubview:self.labTitle];
        [self addSubview:self.textDetail];
        [self addSubview:self.labLine2];
        self.labTitle.text = title;
        self.textDetail.placeholder = placeholder;
    }
    return self;
}
- (UILabel *)labLine1{
    if (!_labLine1) {
        _labLine1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0.5)];
        _labLine1.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine1;
}
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 45)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        
    }
    return _labTitle;
}
- (UITextField *)textDetail{
    if (!_textDetail) {
        _textDetail = [[UITextField alloc]initWithFrame:CGRectMake(self.labTitle.right + 10, self.labTitle.top, DeviceSize.width-self.labTitle.right-20, 45)];
        _textDetail.font = [UIFont systemFontOfSize:15];
    }
    return _textDetail;
}
- (UILabel *)labLine2{
    if (!_labLine2) {
        _labLine2 = [[UILabel alloc]initWithFrame:CGRectMake(0,self.labTitle.bottom , DeviceSize.width, 0.5)];
        _labLine2.backgroundColor = [UIColor colorWithHEX:0xcccccc];

    }
    return _labLine2;
}
@end
