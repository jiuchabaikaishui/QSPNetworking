//
//  LoadClass.h
//  QSPNetworkingDemo
//
//  Created by QSP on 2018/6/26.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface LoadClass : NSObject

+ (void)showMessage:(NSString *)msg toView:(UIView *)view;
+ (void)beginLoadWithMessage:(NSString *)msg toView:(UIView *)view;
+ (void)endLoadFromView:(UIView *)view;

@end
