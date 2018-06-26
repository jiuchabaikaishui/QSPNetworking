//
//  MasterViewController.m
//  QSPNetworkingDemo
//
//  Created by QSP on 2018/6/26.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "MasterViewController.h"
#import "QSPNetworkingManager.h"
#import "MasterCellModel.h"
#import "MainDefine.h"
#import "AutoCancelViewController.h"

@interface MasterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSArray<MasterCellModel *> *dataArr;

@end

@implementation MasterViewController

#pragma mark - 属性方法
- (NSArray<MasterCellModel *> *)dataArr {
    if (_dataArr == nil) {
        __weak typeof(self) weakSelf = self;
        _dataArr = @[
                     [MasterCellModel masterCellModel:^(MasterCellModel *model) {
                         model.title = @"get请求";
                     } andSelectedOption:^(UITableView *tableView, NSIndexPath *indexPath) {
                         [QSPNetworkingManager getCall:K_NetService_Regeo parameters:K_NetService_RegeoParamery cancelDependence:weakSelf controller:weakSelf completion:^(BOOL success, id responseObject, NSError *error) {
                             if (success) {
                                 [LoadClass showMessage:@"请求成功！" toView:weakSelf.view];
                             }
                         }];
                     }],
                     [MasterCellModel masterCellModel:^(MasterCellModel *model) {
                         model.title = @"post请求";
                     } andSelectedOption:^(UITableView *tableView, NSIndexPath *indexPath) {
                         [QSPNetworkingManager defaultCall:K_NetService_Regeo parameters:K_NetService_RegeoParamery cancelDependence:weakSelf controller:weakSelf completion:^(BOOL success, id responseObject, NSError *error) {
                             if (success) {
                                 [LoadClass showMessage:@"请求成功！" toView:weakSelf.view];
                             }
                         }];
                     }],
                     [MasterCellModel masterCellModel:^(MasterCellModel *model) {
                         model.title = @"使用参数配置对象发请求";
                     } andSelectedOption:^(UITableView *tableView, NSIndexPath *indexPath) {
                         QSPParameterConfig *config = [QSPParameterConfig parameterConfigWithParameters:K_NetService_RegeoParamery apiPath:K_NetService_Regeo cancelDependence:weakSelf controller:weakSelf completion:^(BOOL success, id responseObject, NSError *error) {
                             if (success) {
                                 [LoadClass showMessage:@"请求成功！" toView:weakSelf.view];
                             }
                         }];
                         config.type = QSPNetworkingTypeGET;
                         [QSPNetworkingManager callWithParameterConfig:config];
                     }],
                     [MasterCellModel masterCellModel:^(MasterCellModel *model) {
                         model.title = @"自动取消请求";
                     } andSelectedOption:^(UITableView *tableView, NSIndexPath *indexPath) {
                         AutoCancelViewController *nextCtr = [[AutoCancelViewController alloc] init];
                         [weakSelf.navigationController pushViewController:nextCtr animated:YES];
                     }],
                     [MasterCellModel masterCellModel:^(MasterCellModel *model) {
                         model.title = @"手动取消请求";
                     } andSelectedOption:^(UITableView *tableView, NSIndexPath *indexPath) {
                         QSPNetworkingObject *netObj = [QSPNetworkingManager defaultCall:K_NetService_Regeo parameters:K_NetService_RegeoParamery cancelDependence:weakSelf controller:weakSelf completion:^(BOOL success, id responseObject, NSError *error) {
                             if (success) {
                                 [LoadClass showMessage:@"请求成功！" toView:weakSelf.view];
                             }
                         }];
                         [netObj cancel];
                     }]
                    ];
    }
    
    return _dataArr;
}

#pragma mark - 控制器周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"请求示例";
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView = tableView;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = K_Identifier_MasterCell;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    MasterCellModel *model = [self.dataArr objectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MasterCellModel *model = [self.dataArr objectAtIndex:indexPath.row];
    if (model.selectedBolock) {
        model.selectedBolock(tableView, indexPath);
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
