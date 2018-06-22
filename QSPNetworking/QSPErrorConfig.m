//
//  QSPErrorConfig.m
//  VCHelper
//
//  Created by QSP on 2017/9/18.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import "QSPErrorConfig.h"

@implementation QSPErrorConfig

+ (instancetype)errorConfigWithNetworkingErrorPrompt:(QSPNetworkingErrorBlock)networkingErrorPrompt dataErrorPrompt:(QSPDataErrorBlock)dataErrorPrompt
{
    return [[self alloc] initWithNetworkingErrorPrompt:networkingErrorPrompt dataErrorPrompt:dataErrorPrompt];
}
- (instancetype)initWithNetworkingErrorPrompt:(QSPNetworkingErrorBlock)networkingErrorPrompt dataErrorPrompt:(QSPDataErrorBlock)dataErrorPrompt
{
    if (self = [super init]) {
        self.networkingErrorPrompt = networkingErrorPrompt;
        self.dataErrorPrompt = dataErrorPrompt;
    }
    
    return self;
}

@end
