//
//  QSPNetworkingConfig.h
//  QSPNetworkingDemo
//
//  Created by QSP on 2017/9/13.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface QSPNetworkingConfig : NSObject

/**
 超时时间（默认：15）
 */
@property (assign, nonatomic) NSTimeInterval timeoutInterval;

/**
 服务器地址
 */
@property (copy, nonatomic) NSString *basePath;

/**
 验证模式（默认：AFSSLPinningModeNone）
 */
@property (nonatomic, assign) AFSSLPinningMode SSLPinningMode;

/**
 本地绑定的证书（默认：nil）
 */
@property (nonatomic, strong) NSSet <NSData *> *pinnedCertificates;

/**
 是否允许无效证书（默认：NO）
 */
@property (nonatomic, assign) BOOL allowInvalidCertificates;

/**
 是否验证域名（默认：NO）
 */
@property (nonatomic, assign) BOOL validatesDomainName;

/**
 数据解析格式（默认：[NSSet setWithObjects:@"application/json",  @"text/json", @"text/javascript",@"text/html", @"text/plain", nil]）
 */
@property (copy, nonatomic) NSSet<NSString *> *acceptableContentTypes;

/**
 请求头设置字典（默认：[NSDictionary dictionaryWithObject:@"ios" forKey:@"request-type"]）
 */
@property (copy, nonatomic) NSDictionary<NSString *, NSString *> *HTTPHeaderDictionary;

/**
 以默认值创建一个配置实例

 @param basePath 服务器地址
 */
+ (instancetype)networkingConfigWithBasePath:(NSString *)basePath;

@end
