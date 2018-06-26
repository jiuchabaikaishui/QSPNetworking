//
//  MasterCellModel.h
//  QSPNetworkingDemo
//
//  Created by QSP on 2018/6/26.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MasterCellModel : NSObject

@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) void (^selectedBolock)(UITableView *tableView, NSIndexPath *indexPath);

+ (instancetype)masterCellModel:(void (^)(MasterCellModel *model))dataBlock andSelectedOption:(void (^)(UITableView *tableView, NSIndexPath *indexPath))selectedBlock;

@end
