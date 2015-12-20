//
//  DiagnosisDetailEditorTableViewCell.h
//  3HDoctorClient
//
//  Created by 范英强 on 15/12/2.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CustomTextView.h"
@interface MedicalHistoryDetailEditorTableViewCell : BaseTableViewCell<UITextViewDelegate>

@property (nonatomic, strong) UILabel *labTitle;

@property (nonatomic, strong) UILabel *labLine;

@property (nonatomic, strong) CustomTextView *txtView;



//赋值
- (CGFloat)confingWithModel:(NSString *)model;

@end
