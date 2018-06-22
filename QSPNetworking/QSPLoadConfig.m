//
//  QSPLoadConfig.m
//  VCHelper
//
//  Created by QSP on 2017/9/18.
//  Copyright © 2017年 JingBei. All rights reserved.
//

#import "QSPLoadConfig.h"

@implementation QSPLoadConfig

+ (instancetype)loadConfigWithLoadBegin:(QSPLoadBlock)loadBegin loadEnd:(QSPLoadBlock)loadEnd
{
    return [[self alloc] initWithLoadBegin:loadBegin loadEnd:loadEnd];
}
- (instancetype)initWithLoadBegin:(QSPLoadBlock)loadBegin loadEnd:(QSPLoadBlock)loadEnd
{
    if (self = [super init]) {
        self.loadBegin = loadBegin;
        self.loadEnd = loadEnd;
    }
    
    return self;
}

@end
