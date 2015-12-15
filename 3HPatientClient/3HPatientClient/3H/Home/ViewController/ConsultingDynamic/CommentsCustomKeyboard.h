//
//  CommentsCustomKeyboard.h
//  3HPatientClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol HcCustomKeyboardDelegate <NSObject>

@required
-(void)talkBtnClick:(UITextView *)textViewGet;

@end

@interface CommentsCustomKeyboard : NSObject<UITextViewDelegate>

@property (nonatomic,assign) id<HcCustomKeyboardDelegate>mDelegate;
@property (nonatomic,strong)UIView *mBackView;
@property (nonatomic, strong) UILabel *labLine;
@property (nonatomic,strong)UIView *mTopHideView;
@property (nonatomic,strong)UITextView * mTextView;
@property (nonatomic,strong)UIView *mHiddeView;
@property (nonatomic,strong)UIViewController *mViewController;
@property (nonatomic,strong)UIButton *mTalkBtn;
@property (nonatomic) BOOL isTop;//用来判断评论按钮的位置
@property (nonatomic) BOOL isModify;//用来判断修改内容还是添加

//提示语
@property (nonatomic, strong) UILabel *labContent;
//点击回复 回调
@property (nonatomic, copy) void(^mTalkBtnBlock)(NSString * text);
+(CommentsCustomKeyboard *)customKeyboard;

-(void)textViewShowView:(UIViewController *)viewController customKeyboardDelegate:(id)delegate;
- (void)textDidChanged:(NSNotification *)notif;

@end
