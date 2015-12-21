//
//  ConsultingIsPhoneDescTableViewCell.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/9.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CustomTextView.h"
@interface ConsultingIsPhoneDescTableViewCell : BaseTableViewCell<UITextViewDelegate>

@property (nonatomic, strong) UIImageView *imgLogo;

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) CustomTextView *textView;



@end
