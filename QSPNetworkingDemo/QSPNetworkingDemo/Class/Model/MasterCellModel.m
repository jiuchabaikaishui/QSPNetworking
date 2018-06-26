//
//  MasterCellModel.m
//  QSPNetworkingDemo
//
//  Created by QSP on 2018/6/26.
//  Copyright © 2018年 Jingbeijinrong. All rights reserved.
//

#import "MasterCellModel.h"

@implementation MasterCellModel

+ (instancetype)masterCellModel:(void (^)(MasterCellModel *model))dataBlock andSelectedOption:(void (^)(UITableView *tableView, NSIndexPath *indexPath))selectedBlock {
    MasterCellModel *model = [[self alloc] init];
    model.selectedBolock = selectedBlock;
    if (dataBlock) {
        dataBlock(model);
    }
    
    return model;
}

@end
