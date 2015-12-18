//
//  AddressView.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/18.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressView : UIView
@property (nonatomic, retain) UILabel * labTitle;
@property (nonatomic, retain) UITextField * textDetail;
@property (nonatomic, retain) UILabel * labLine1;
@property (nonatomic, retain) UILabel * labLine2;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder;
@end
