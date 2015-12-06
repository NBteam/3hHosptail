//
//  MyArchivesBaseTableViewCell.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/6.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "MyArchivesBaseTableViewCell.h"

@implementation MyArchivesBaseTableViewCell

- (void)customView{
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labLine1];
    [self.contentView addSubview:self.labName];
    [self.contentView addSubview:self.txtName];
    [self.contentView addSubview:self.labAge];
    [self.contentView addSubview:self.txtAge];
    [self.contentView addSubview:self.labMinZu];
    [self.contentView addSubview:self.txtMinZu];
    
    [self.contentView addSubview:self.labLine2];
    [self.contentView addSubview:self.labShenGao];
    [self.contentView addSubview:self.labXueYaUnit];
    [self.contentView addSubview:self.txtShenGao];
    [self.contentView addSubview:self.labXueYa];
    [self.contentView addSubview:self.txtXueYaDown];
    [self.contentView addSubview:self.labXueYaSymbol];
    [self.contentView addSubview:self.txtXueYaUp];
    
    [self.contentView addSubview:self.labLine3];
    [self.contentView addSubview:self.labOldTiZhong];
    [self.contentView addSubview:self.txtOldTiZhong];
    [self.contentView addSubview:self.labNowTiZhong];
    [self.contentView addSubview:self.txtNowTiZhong];

    
    

}

- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 12.5, DeviceSize.width -20, 15)];
        _labTitle.textColor = [UIColor colorWithHEX:0x333333];
        _labTitle.font = [UIFont systemFontOfSize:15];
        _labTitle.text = @"基本信息";
    }
    return _labTitle;
}

- (UILabel *)labLine1{
    if (!_labLine1) {
        _labLine1 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labTitle.bottom +10, DeviceSize.width -20, 0.5)];
        _labLine1.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine1;
}

- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labLine1.bottom +15, 0, 15)];
        _labName.textColor = [UIColor colorWithHEX:0x666666];
        _labName.font = [UIFont systemFontOfSize:15];
        _labName.text = @"姓名";
        CGSize size = [_labName.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, 15)];
        _labName.width = size.width;
    }
    return _labName;
}

- (UITextField *)txtName{
    if (!_txtName) {
        _txtName = [[UITextField alloc] initWithFrame:CGRectMake(self.labName.right +5, self.labLine1.bottom +7.5, DeviceSize.width/2 -self.labName.right -5 -2.5, 30)];
        //是否纠错
        _txtName.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtName.font = [UIFont systemFontOfSize:15];
        _txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtName.textColor = [UIColor colorWithHEX:0x666666];
        _txtName.textAlignment = NSTextAlignmentRight;
        _txtName.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtName.layer.borderWidth = 0.5;
        _txtName.layer.masksToBounds = YES;
        _txtName.layer.cornerRadius = 3;
        _txtName.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtName.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
         _txtName.leftViewMode = UITextFieldViewModeAlways;
        _txtName.rightViewMode = UITextFieldViewModeAlways;
    }
    return _txtName;
}

- (UILabel *)labAge{
    if (!_labAge) {
        _labAge = [[UILabel alloc] initWithFrame:CGRectMake(DeviceSize.width/2 +2.5, self.labLine1.bottom +15, 0, 15)];
        _labAge.textColor = [UIColor colorWithHEX:0x666666];
        _labAge.font = [UIFont systemFontOfSize:15];
        _labAge.text = @"年龄";
        CGSize size = [_labAge.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, 15)];
        _labAge.width = size.width;
    }
    return _labAge;
}

- (UITextField *)txtAge{
    if (!_txtAge) {
        _txtAge = [[UITextField alloc] initWithFrame:CGRectMake(self.labAge.right +5, self.labLine1.bottom +7.5, (DeviceSize.width/2 -10 -self.labAge.width*2 -15 -2.5)/2, 30)];
        //是否纠错
        _txtAge.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtAge.font = [UIFont systemFontOfSize:15];
        _txtAge.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtAge.textColor = [UIColor colorWithHEX:0x666666];
        _txtAge.textAlignment = NSTextAlignmentRight;
        _txtAge.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtAge.layer.borderWidth = 0.5;
        _txtAge.layer.masksToBounds = YES;
        _txtAge.layer.cornerRadius = 3;
        _txtAge.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtAge.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtAge.leftViewMode = UITextFieldViewModeAlways;
        _txtAge.rightViewMode = UITextFieldViewModeAlways;
    }
    return _txtAge;
}

- (UILabel *)labMinZu{
    if (!_labMinZu) {
        _labMinZu = [[UILabel alloc] initWithFrame:CGRectMake(self.txtAge.right +5, self.labLine1.bottom +15, 0, 15)];
        _labMinZu.textColor = [UIColor colorWithHEX:0x666666];
        _labMinZu.font = [UIFont systemFontOfSize:15];
        _labMinZu.text = @"民族";
        CGSize size = [_labMinZu.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, 15)];
        _labMinZu.width = size.width;
    }
    return _labMinZu;
}

- (UITextField *)txtMinZu{
    if (!_txtMinZu) {
        _txtMinZu = [[UITextField alloc] initWithFrame:CGRectMake(self.labMinZu.right +5, self.labLine1.bottom +7.5, self.txtAge.width, 30)];
        //是否纠错
        _txtMinZu.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtMinZu.font = [UIFont systemFontOfSize:15];
        _txtMinZu.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtMinZu.textColor = [UIColor colorWithHEX:0x666666];
        _txtMinZu.textAlignment = NSTextAlignmentRight;
        _txtMinZu.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtMinZu.layer.borderWidth = 0.5;
        _txtMinZu.layer.masksToBounds = YES;
        _txtMinZu.layer.cornerRadius = 3;
        _txtMinZu.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtMinZu.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtMinZu.leftViewMode = UITextFieldViewModeAlways;
        _txtMinZu.rightViewMode = UITextFieldViewModeAlways;
    }
    return _txtMinZu;
}

- (UILabel *)labLine2{
    if (!_labLine2) {
        _labLine2 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labName.bottom +15, DeviceSize.width -20, 0.5)];
        _labLine2.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine2;
}

- (UILabel *)labShenGao{
    if (!_labShenGao) {
        _labShenGao = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labLine2.bottom +15, 0, 15)];
        _labShenGao.textColor = [UIColor colorWithHEX:0x666666];
        _labShenGao.font = [UIFont systemFontOfSize:15];
        _labShenGao.text = @"身高";
        CGSize size = [_labMinZu.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, 15)];
        _labShenGao.width = size.width;
    }
    return _labShenGao;
}

- (UITextField *)txtShenGao{
    if (!_txtShenGao) {
        _txtShenGao = [[UITextField alloc] initWithFrame:CGRectMake(self.labShenGao.right +5, self.labLine2.bottom +7.5, (self.labXueYaUnit.left -5 -self.labShenGao.right -5 -self.labShenGao.width -15 -20)/3, 30)];
        //是否纠错
        _txtShenGao.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtShenGao.font = [UIFont systemFontOfSize:15];
        _txtShenGao.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"cm" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtShenGao.textColor = [UIColor colorWithHEX:0x666666];
        _txtShenGao.textAlignment = NSTextAlignmentRight;
        _txtShenGao.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtShenGao.layer.borderWidth = 0.5;
        _txtShenGao.layer.masksToBounds = YES;
        _txtShenGao.layer.cornerRadius = 3;
        _txtShenGao.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtShenGao.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtShenGao.leftViewMode = UITextFieldViewModeAlways;
        _txtShenGao.rightViewMode = UITextFieldViewModeAlways;
    }
    return _txtShenGao;
}

- (UILabel *)labXueYaUnit{
    if (!_labXueYaUnit) {
        _labXueYaUnit = [[UILabel alloc] initWithFrame:CGRectMake(0, self.labLine2.bottom, 0, 45)];
        _labXueYaUnit.textColor = [UIColor colorWithHEX:0x888888];
        _labXueYaUnit.font = [UIFont systemFontOfSize:15];
        _labXueYaUnit.text = @"mmHg";
        CGSize size = [_labXueYaUnit.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, 15)];
        _labXueYaUnit.width = size.width;
        _labXueYaUnit.left = DeviceSize.width - _labXueYaUnit.width -10;
        
    }
    return _labXueYaUnit;
}

- (UILabel *)labXueYa{
    if (!_labXueYa) {
        _labXueYa = [[UILabel alloc] initWithFrame:CGRectMake(self.txtShenGao.right +5, self.labLine2.bottom +15, 0, 15)];
        _labXueYa.textColor = [UIColor colorWithHEX:0x666666];
        _labXueYa.font = [UIFont systemFontOfSize:15];
        _labXueYa.text = @"血压";
        CGSize size = [_labMinZu.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, 15)];
        _labXueYa.width = size.width;
    }
    return _labXueYa;
}

- (UITextField *)txtXueYaDown{
    if (!_txtXueYaDown) {
        _txtXueYaDown = [[UITextField alloc] initWithFrame:CGRectMake(self.labXueYa.right +5, self.labLine2.bottom +7.5, self.txtShenGao.width, 30)];
        //是否纠错
        _txtXueYaDown.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtXueYaDown.font = [UIFont systemFontOfSize:15];
        _txtXueYaDown.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"低" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtXueYaDown.textColor = [UIColor colorWithHEX:0x666666];
        _txtXueYaDown.textAlignment = NSTextAlignmentRight;
        _txtXueYaDown.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtXueYaDown.layer.borderWidth = 0.5;
        _txtXueYaDown.layer.masksToBounds = YES;
        _txtXueYaDown.layer.cornerRadius = 3;
        _txtXueYaDown.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtXueYaDown.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtXueYaDown.leftViewMode = UITextFieldViewModeAlways;
        _txtXueYaDown.rightViewMode = UITextFieldViewModeAlways;
    }
    return _txtXueYaDown;
}

- (UILabel *)labXueYaSymbol{
    if (!_labXueYaSymbol) {
        _labXueYaSymbol = [[UILabel alloc] initWithFrame:CGRectMake(self.txtXueYaDown.right +5, self.labLine2.bottom +15, 15, 15)];
        _labXueYaSymbol.textColor = [UIColor colorWithHEX:0x666666];
        _labXueYaSymbol.font = [UIFont systemFontOfSize:15];
        _labXueYaSymbol.text = @"/";
        _labXueYaSymbol.textAlignment = NSTextAlignmentCenter;
    }
    return _labXueYaSymbol;
}

- (UITextField *)txtXueYaUp{
    if (!_txtXueYaUp) {
        _txtXueYaUp = [[UITextField alloc] initWithFrame:CGRectMake(self.labXueYaSymbol.right +5, self.labLine2.bottom +7.5, self.txtShenGao.width, 30)];
        //是否纠错
        _txtXueYaUp.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtXueYaUp.font = [UIFont systemFontOfSize:15];
        _txtXueYaUp.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"高" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtXueYaUp.textColor = [UIColor colorWithHEX:0x666666];
        _txtXueYaUp.textAlignment = NSTextAlignmentRight;
        _txtXueYaUp.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtXueYaUp.layer.borderWidth = 0.5;
        _txtXueYaUp.layer.masksToBounds = YES;
        _txtXueYaUp.layer.cornerRadius = 3;
        _txtXueYaUp.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtXueYaUp.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtXueYaUp.leftViewMode = UITextFieldViewModeAlways;
        _txtXueYaUp.rightViewMode = UITextFieldViewModeAlways;
    }
    return _txtXueYaUp;
}

- (UILabel *)labLine3{
    if (!_labLine3) {
        _labLine3 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labShenGao.bottom +15, DeviceSize.width -20, 0.5)];
        _labLine3.backgroundColor = [UIColor colorWithHEX:0xcccccc];
    }
    return _labLine3;
}

- (UILabel *)labOldTiZhong{
    if (!_labOldTiZhong) {
        _labOldTiZhong = [[UILabel alloc] initWithFrame:CGRectMake(10, self.labLine3.bottom +15, 0, 15)];
        _labOldTiZhong.textColor = [UIColor colorWithHEX:0x666666];
        _labOldTiZhong.font = [UIFont systemFontOfSize:15];
        _labOldTiZhong.text = @"病前体重";
        CGSize size = [_labOldTiZhong.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, 15)];
        _labOldTiZhong.width = size.width;
    }
    return _labOldTiZhong;
}

- (UITextField *)txtOldTiZhong{
    if (!_txtOldTiZhong) {
        _txtOldTiZhong = [[UITextField alloc] initWithFrame:CGRectMake(self.labOldTiZhong.right +10, self.labLine3.bottom +7.5,(DeviceSize.width -self.labOldTiZhong.right -10 -self.labOldTiZhong.width -30)/2, 30)];
        //是否纠错
        _txtOldTiZhong.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtOldTiZhong.font = [UIFont systemFontOfSize:15];
        _txtOldTiZhong.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"kg" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtOldTiZhong.textColor = [UIColor colorWithHEX:0x666666];
        _txtOldTiZhong.textAlignment = NSTextAlignmentRight;
        _txtOldTiZhong.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtOldTiZhong.layer.borderWidth = 0.5;
        _txtOldTiZhong.layer.masksToBounds = YES;
        _txtOldTiZhong.layer.cornerRadius = 3;
        _txtOldTiZhong.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtOldTiZhong.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtOldTiZhong.leftViewMode = UITextFieldViewModeAlways;
        _txtOldTiZhong.rightViewMode = UITextFieldViewModeAlways;
    }
    return _txtOldTiZhong;
}

- (UILabel *)labNowTiZhong{
    if (!_labNowTiZhong) {
        _labNowTiZhong = [[UILabel alloc] initWithFrame:CGRectMake(self.txtOldTiZhong.right +10, self.labLine3.bottom +15, 0, 15)];
        _labNowTiZhong.textColor = [UIColor colorWithHEX:0x666666];
        _labNowTiZhong.font = [UIFont systemFontOfSize:15];
        _labNowTiZhong.text = @"病前体重";
        CGSize size = [_labNowTiZhong.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(0, 15)];
        _labNowTiZhong.width = size.width;
    }
    return _labNowTiZhong;
}

- (UITextField *)txtNowTiZhong{
    if (!_txtNowTiZhong) {
        _txtNowTiZhong = [[UITextField alloc] initWithFrame:CGRectMake(self.labNowTiZhong.right +10, self.labLine3.bottom +7.5,self.txtOldTiZhong.width, 30)];
        //是否纠错
        _txtNowTiZhong.autocorrectionType = UITextAutocorrectionTypeNo;
        _txtNowTiZhong.font = [UIFont systemFontOfSize:15];
        _txtNowTiZhong.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"kg" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHEX:0x999999]}];
        _txtNowTiZhong.textColor = [UIColor colorWithHEX:0x666666];
        _txtNowTiZhong.textAlignment = NSTextAlignmentRight;
        _txtNowTiZhong.layer.borderColor = [UIColor colorWithHEX:0xcccccc].CGColor;
        _txtNowTiZhong.layer.borderWidth = 0.5;
        _txtNowTiZhong.layer.masksToBounds = YES;
        _txtNowTiZhong.layer.cornerRadius = 3;
        _txtNowTiZhong.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtNowTiZhong.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        _txtNowTiZhong.leftViewMode = UITextFieldViewModeAlways;
        _txtNowTiZhong.rightViewMode = UITextFieldViewModeAlways;
    }
    return _txtNowTiZhong;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
