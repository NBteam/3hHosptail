//
//  GuideSearchView.h
//  11111
//
//  Created by kanzhun on 15/9/8.
//  Copyright (c) 2015年 kanzhun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideSearchView : UIView
@property (nonatomic,copy)void (^textChangeValue)(NSString * text);
@property (nonatomic,copy)void (^btnClickBlock)(void);
@property (nonatomic, strong) UITextField * textSearch;
- (instancetype)init;
- (void)textResignFirstResponder;
- (void)textBecomeFirstResponder;
- (void)setSearchText:(NSString *)text;
@end
