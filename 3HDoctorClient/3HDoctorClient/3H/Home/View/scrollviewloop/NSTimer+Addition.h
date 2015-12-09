//
//  NSTimer+Addition.h
//  NR
//
//  Created by 范英强 on 15/8/17.
//  Copyright (c) 2015年 范英强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

- (void)pauseTimer;
- (void)resumeTimer;

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
