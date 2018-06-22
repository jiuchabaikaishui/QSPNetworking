//
//  QSPErrorConfig.h
//  VCHelper
//
//  Created by QSP on 2017/9/18.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QSPNetworkingDefine.h"

@interface QSPErrorConfig : NSObject

/**
 网络错误提示（默认无）
 */
@property (copy, nonatomic) QSPNetworkingErrorBlock networkingErrorPrompt;

/**
 数据错误提示（默认无）
 */
@property (copy, nonatomic) QSPDataErrorBlock dataErrorPrompt;

+ (instancetype)errorConfigWithNetworkingErrorPrompt:(QSPNetworkingErrorBlock)networkingErrorPrompt dataErrorPrompt:(QSPDataErrorBlock)dataErrorPrompt;
- (instancetype)initWithNetworkingErrorPrompt:(QSPNetworkingErrorBlock)networkingErrorPrompt dataErrorPrompt:(QSPDataErrorBlock)dataErrorPrompt;

@end
