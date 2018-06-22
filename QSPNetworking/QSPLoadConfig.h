//
//  QSPLoadConfig.h
//  VCHelper
//
//  Created by QSP on 2017/9/18.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QSPNetworkingDefine.h"

@interface QSPLoadConfig : NSObject

@property (copy, nonatomic) QSPLoadBlock loadBegin;
@property (copy, nonatomic) QSPLoadBlock loadEnd;

+ (instancetype)loadConfigWithLoadBegin:(QSPLoadBlock)loadBegin loadEnd:(QSPLoadBlock)loadEnd;
- (instancetype)initWithLoadBegin:(QSPLoadBlock)loadBegin loadEnd:(QSPLoadBlock)loadEnd;

@end
