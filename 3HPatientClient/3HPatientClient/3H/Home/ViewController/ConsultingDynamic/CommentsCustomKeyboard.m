//
//  CommentsCustomKeyboard.m
//  3HPatientClient
//
//  Created by 范英强 on 15/12/15.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "CommentsCustomKeyboard.h"

//屏幕宽度
#define WIDTH_SCREEN [UIScreen mainScreen].applicationFrame.size.width
//屏幕高度
#define HEIGHT_SCREEN [UIScreen mainScreen].applicationFrame.size.height

#define mBackViewHEIGHT 163

@implementation CommentsCustomKeyboard
@synthesize mDelegate;

static CommentsCustomKeyboard *customKeyboard = nil;

+(CommentsCustomKeyboard *)customKeyboard
{
    @synchronized(self)
    {
        if (customKeyboard == nil)
        {
            customKeyboard = [[CommentsCustomKeyboard alloc] init];
        }
        return customKeyboard;
    }
}
+(id)allocWithZone:(struct _NSZone *)zone //确保使用者alloc时 返回的对象也是实例本身
{
    @synchronized(self)
    {
        if (customKeyboard == nil)
        {
            customKeyboard = [super allocWithZone:zone];
        }
        return customKeyboard;
    }
}
+(id)copyWithZone:(struct _NSZone *)zone //确保使用者copy时 返回的对象也是实例本身
{
    return customKeyboard;
}

-(void)textViewShowView:(UIViewController *)viewController customKeyboardDelegate:(id)delegate
{
    self.mViewController =viewController;
    self.mDelegate =delegate;
    self.isTop = NO;//初始化的时候设为NO
    //大背景
    self.mBackView =[[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, WIDTH_SCREEN, mBackViewHEIGHT)];
    NSLog(@"%p",self.mBackView);
    self.mBackView.backgroundColor =[UIColor colorWithHEX:0xffffff];
    [self.mViewController.view addSubview:self.mBackView];
    
    self.labLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DeviceSize.width, 0.5)];
    self.labLine.backgroundColor = [UIColor colorWithHEX:0xe7e7e7];
    [self.mBackView addSubview:self.labLine];
    
    self.mTextView =[[UITextView alloc]initWithFrame:CGRectMake(25, 16, WIDTH_SCREEN -50, 80)];
    self.mTextView.backgroundColor =[UIColor colorWithHEX:0xefefef];
    self.mTextView.delegate = self;
    self.mTextView.font=[UIFont systemFontOfSize:15];
    self.mTextView.layer.masksToBounds = YES;
    self.mTextView.layer.cornerRadius = 2;
    self.mTextView.layer.borderColor = [UIColor colorWithHEX:0xe7e7e7].CGColor;
    self.mTextView.layer.borderWidth = 0.5;
    self.mTextView.text = @"你怎么看?";
    self.mTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;;
    [self.mBackView addSubview:self.mTextView];
    
    [self.mBackView addSubview:self.labContent];
    self.mTalkBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.mTalkBtn setTitle:@"回复" forState:UIControlStateNormal];
    self.mTalkBtn.layer.masksToBounds = YES;
    self.mTalkBtn.layer.cornerRadius = 3;
    [self.mTalkBtn setTitleColor:[UIColor colorWithHEX:0xffffff] forState:UIControlStateNormal];
    self.mTalkBtn.backgroundColor = AppDefaultColor;
    self.mTalkBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.mTalkBtn addTarget:self action:@selector(forTalk) forControlEvents:UIControlEventTouchUpInside];
    self.mTalkBtn.frame =CGRectMake(DeviceSize.width -25 -80, mBackViewHEIGHT -35 -16, 80, 35);
    [self.mTalkBtn setTintColor:[UIColor blackColor]];
    [self.mBackView addSubview:self.mTalkBtn];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
}

- (UILabel *)labContent{
    if (!_labContent) {
        _labContent = [[UILabel alloc] initWithFrame:CGRectMake(25, self.mTextView.bottom +16, DeviceSize.width -50 -15 -80, 35)];
        _labContent.font = [UIFont systemFontOfSize:13];
        _labContent.textAlignment = NSTextAlignmentRight;
        _labContent.attributedText = [self getLabNumber:@"140"];
        
    }
    return _labContent;
}

- (NSMutableAttributedString *)getLabNumber:(NSString * )labNumer{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"你还可以输入 %@ 字",labNumer]];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x888888] range:NSMakeRange(0,7)];
    [str addAttribute:NSForegroundColorAttributeName value:AppDefaultColor range:NSMakeRange(7,labNumer.length)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHEX:0x888888] range:NSMakeRange(labNumer.length+7,2)];
    return str;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.mTextView resignFirstResponder];
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
#pragma mark这是可以给初始值得
    //这是可以给初始值得
    self.mTextView.text = @"";
    
    return YES;
}

-(void)forTalk //评论按钮
{
    
    if (self.isTop ==NO)
    {
        [self.mTextView becomeFirstResponder];
    }
    else
    {
        [mDelegate talkBtnClick:self.mTextView];
        
        if (self.mTextView.text.length==0)
        {
            NSLog(@"内容为空");
        }
        else
        {
            [self.mTextView resignFirstResponder];
            if (self.mTalkBtnBlock) {
                self.mTalkBtnBlock(self.self.mTextView.text);
            }
        }
    }
    
}
-(void)hideView //点击屏幕其他地方 键盘消失
{
    NSLog(@"屏幕消失");
    [self.mTextView resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification*)notification //键盘出现
{
    self.isTop =YES;
    CGRect _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"%f-%f",_keyboardRect.origin.y,_keyboardRect.size.height);
    
    if (!self.mHiddeView)
    {
        self.mHiddeView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDTH_SCREEN,HEIGHT_SCREEN)];
        self.mHiddeView.backgroundColor =[UIColor blackColor];
        self.mHiddeView.alpha =0.0f;
        [self.mViewController.view addSubview:self.mHiddeView];
        
        UIButton *hideBtn =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        hideBtn.backgroundColor =[UIColor clearColor];
        hideBtn.frame = self.mHiddeView.frame;
        [hideBtn addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
        [self.mHiddeView addSubview:hideBtn];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.mHiddeView.alpha =0.4f;
        self.mBackView.frame =CGRectMake(0, HEIGHT_SCREEN-_keyboardRect.size.height-mBackViewHEIGHT -44, WIDTH_SCREEN, mBackViewHEIGHT);
        [self.mViewController.view bringSubviewToFront:self.mBackView];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardWillHide:(NSNotification*)notification //键盘下落
{
    self.isTop =NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.mBackView.frame=CGRectMake(0, HEIGHT_SCREEN, WIDTH_SCREEN, mBackViewHEIGHT);
        self.mHiddeView.alpha =0.0f;
    } completion:^(BOOL finished) {
        [self.mHiddeView removeFromSuperview];
        self.mHiddeView =nil;
        self.mTextView.text =@"你怎么看?"; //键盘消失时，恢复TextView内容
    }];
}

- (void)textDidChanged:(NSNotification *)notif //监听文字改变 换行时要更改输入框的位置
{
    
    NSInteger number = 140 -self.mTextView.text.length;
    self.labContent.attributedText = [self getLabNumber:[NSString stringWithFormat:@"%li",number]];
    
}

-(void)dealloc //移除通知
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
#define MY_MAX 140
    if ((textView.text.length - range.length + text.length) > MY_MAX)
    {
        NSString *substring = [text substringToIndex:MY_MAX - (textView.text.length - range.length)];
        NSMutableString *lastString = [textView.text mutableCopy];
        [lastString replaceCharactersInRange:range withString:substring];
        textView.text = [lastString copy];
        return NO;
    }
    else
    {
        return YES;
    }
}


@end
