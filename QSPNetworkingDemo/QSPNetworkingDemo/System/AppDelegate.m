//
//  AppDelegate.m
//  QSPNetworkingDemo
//
//  Created by QSP on 2018/6/22.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "AppDelegate.h"
#import "QSPNetworkingManager.h"
#import "MasterViewController.h"
#import "MainDefine.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //配置网络框架
    [self configNetworking];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *navCtr = [[UINavigationController alloc] initWithRootViewController:[[MasterViewController alloc] init]];
    self.window.rootViewController = navCtr;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)configNetworking {
    //创建网络配置对象，控制网络请求
    QSPNetworkingConfig *networkingConfig = [QSPNetworkingConfig networkingConfigWithBasePath:K_NetService_Base];
    
    //创建错误处理配置对象，处理网络、数据错误
    QSPErrorConfig *errorConfig = [QSPErrorConfig errorConfigWithNetworkingErrorPrompt:^(NSError *error, UIViewController *controller) {
        if (error.code == -999) {
            [LoadClass showMessage:K_NetRequestMessage_Cancel toView:self.window];
        }
        else if (error.code == -1001)
        {
            [LoadClass showMessage:K_NetRequestMessage_TimeOut toView:controller.view];
        }
        else
        {
            [LoadClass showMessage:K_NetRequestMessage_Failure toView:controller.view];
        }
    } dataErrorPrompt:^void(id responseObject, UIViewController *controller) {
        if (responseObject == nil || [responseObject isKindOfClass:[NSNull class]]) {
            [LoadClass showMessage:K_NetRequestMessage_NoData toView:controller.view];
        } else {
            if ([responseObject[@"status"] intValue] != 1) {
                NSString *message = responseObject[@"message"] ? responseObject[@"message"] : K_NetRequestMessage_Error;
                [LoadClass showMessage:message toView:controller.view];
            }
        }
    }];
    
    //创建加载处理配置对象，处理加载过程
    QSPLoadConfig *loadConfig = [QSPLoadConfig loadConfigWithLoadBegin:^(UIViewController *controller){
        [LoadClass beginLoadWithMessage:K_NetRequestMessage_Load toView:controller.view];
    } loadEnd:^(UIViewController *controller){
        [LoadClass endLoadFromView:controller.view];
    }];
    
    //配置网络框架
    [QSPNetworkingManager configWithNetworkingConfig:networkingConfig errorConfig:errorConfig loadConfig:loadConfig condictionOfSuccess:^BOOL(id responseObject) {
        return [responseObject[@"status"] integerValue] == 1;
    }];
}


@end
