//
//  LoadClass.m
//  QSPNetworkingDemo
//
//  Created by QSP on 2018/6/26.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "LoadClass.h"

@implementation LoadClass

+ (void)showMessage:(NSString *)msg toView:(UIView *)view {
    if (view) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:NO];
        [hud setMode:MBProgressHUDModeText];
        hud.label.text = msg;
        [hud hideAnimated:NO afterDelay:1.5];
    }
}
+ (void)beginLoadWithMessage:(NSString *)msg toView:(UIView *)view {
    if (view) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:nil];
        hud.label.text = msg;
    }
}
+ (void)endLoadFromView:(UIView *)view {
    if (view) {
        [MBProgressHUD hideHUDForView:view animated:nil];
    }
}

@end
