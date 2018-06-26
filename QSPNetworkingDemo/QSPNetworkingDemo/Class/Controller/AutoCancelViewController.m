//
//  AutoCancelViewController.m
//  QSPNetworkingDemo
//
//  Created by QSP on 2018/6/26.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "AutoCancelViewController.h"
#import "QSPNetworkingManager.h"
#import "MainDefine.h"

@interface AutoCancelViewController ()

@end

@implementation AutoCancelViewController

#pragma mark - 控制器周期
- (void)dealloc {
    NSLog(@"---------------%@:%p销毁了！", NSStringFromClass(self.class), self);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自动取消请求";
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [QSPNetworkingManager getCall:K_NetService_Regeo parameters:K_NetService_RegeoParamery cancelDependence:weakSelf controller:weakSelf completion:^(BOOL success, id responseObject, NSError *error) {
            if (success) {
                [LoadClass showMessage:@"请求成功！" toView:weakSelf.view];
            }
        }];
        [weakSelf.navigationController popViewControllerAnimated:NO];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
