//
//  GetImageColor.h
//  111111
//
//  Created by 范英强 on 15/11/10.
//  Copyright (c) 2015年 fyq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GetImageColor : NSObject


//获取图片中单个点的颜色：
- (UIColor*) getPixelColorAtImage:(UIImage *)image;

@end
