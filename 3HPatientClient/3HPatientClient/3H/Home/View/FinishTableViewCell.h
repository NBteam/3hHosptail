//
//  FinishTableViewCell.h
//  3HPatientClient
//
//  Created by 郑彦华 on 15/12/22.
//  Copyright © 2015年 fyq. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface FinishTableViewCell : BaseTableViewCell

@property (nonatomic, retain) UILabel * labFirst;
@property (nonatomic, retain) UILabel * labSecond;
@property (nonatomic, retain) UILabel * labThird;
- (CGFloat )configWithModel:(id)model;
@end
