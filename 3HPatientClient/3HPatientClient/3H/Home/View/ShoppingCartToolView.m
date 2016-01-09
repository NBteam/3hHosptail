//
//  ShoppingCartToolView.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/27.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "ShoppingCartToolView.h"

@implementation ShoppingCartToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.labLine];
        [self addSubview:self.btnSelect];
        [self addSubview:self.btnSubmit];
        [self addSubview:self.labTitle];
    }
    return self;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0.5)];
        _labLine.backgroundColor = [UIColor colorWithHEX:0xcccccc];
        
    }
    
    return _labLine;
}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.btnSelect.right +10, 0, self.btnSubmit.left -self.btnSelect.right -30, 50)];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.textColor = AppDefaultColor;
        _labTitle.textAlignment = NSTextAlignmentRight;
        _labTitle.text = @"总计:0元";
        
    }
    
    return _labTitle;
}

- (UIButton *)btnSelect{
    if (!_btnSelect) {
        _btnSelect = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSelect.frame = CGRectMake(10, 0, 50, 50);
        [_btnSelect setImage:[UIImage imageNamed:@"3H-注册_选框"] forState:UIControlStateNormal];
        [_btnSelect setImage:[UIImage imageNamed:@"3H-注册_全选"] forState:UIControlStateSelected];
        _btnSelect.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btnSelect addTarget:self action:@selector(btnSelectClick) forControlEvents:UIControlEventTouchUpInside];
        [_btnSelect setTitle:@" 全选" forState:UIControlStateNormal];
        [_btnSelect setTitleColor:[UIColor colorWithHEX:0x888888] forState:UIControlStateNormal];
        _btnSelect.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _btnSelect;
}

- (void)btnSelectClick{
    if (self.btnSelectBlock) {
        self.btnSelectBlock();
    }
}

- (UIButton *)btnSubmit{
    if (!_btnSubmit) {
        _btnSubmit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSubmit.frame = CGRectMake(DeviceSize.width -60 -15, 10, 60, 30);

        _btnSubmit.titleLabel.font = [UIFont systemFontOfSize:14];
        [_btnSubmit addTarget:self action:@selector(btnSubmitClick) forControlEvents:UIControlEventTouchUpInside];
        [_btnSubmit setTitle:@"去结算" forState:UIControlStateNormal];
        [_btnSubmit setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
        _btnSubmit.backgroundColor = AppDefaultColor;
        _btnSubmit.layer.masksToBounds = YES;
        _btnSubmit.layer.cornerRadius = 5;
    }
    return _btnSubmit;
}

- (void)btnSubmitClick{
    if (self.btnSubmitBlock) {
        self.btnSubmitBlock();
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
