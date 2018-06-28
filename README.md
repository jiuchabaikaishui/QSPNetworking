# QSPNetworking
一个基于AFNetworking再次分装的网络框架，使得iOS中的网络请 求更加简单、灵活。


## 项目截图 
1.Demo首页 2.请求成功 3.请求取消

<img src="https://upload-images.jianshu.io/upload_images/3238517-e4be40f0d42cf38c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="40%" height="40%"><img src="https://upload-images.jianshu.io/upload_images/3238517-9ead22c85fa8c165.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="40%" height="40%">
<img src="https://upload-images.jianshu.io/upload_images/3238517-d7b0f0a8ce590b7f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="40%" height="40%">


## 安装

### CocoaPods
pod 'QSPNetworking'

### 手动安装
将QSPNetworking文件夹拽入工程项目中


## 使用示例

### 配置网络框架
此网络框架的配置需要QSPNetworkingConfig（网络配置对象）、QSPErrorConfig（错误处理配置对象）、QSPLoadConfig（加载处理配置对象）以及一个判断网络请求数据正确的block共同完成。
```
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
```

### 发送请求

#### 分装了如下三个方法来发送请求，分别为默认方式（post）、get方式、参数配置方式（可以通过配置对象配置各种适合自己的请求）。
```
+ (QSPNetworkingObject *)defaultCall:(NSString *)apiPath parameters:(NSDictionary *)parameters cancelDependence:(id)dependence controller:(UIViewController *)controller completion:(QSPCompletionBlock)completion;
+ (QSPNetworkingObject *)getCall:(NSString *)apiPath parameters:(NSDictionary *)parameters cancelDependence:(id)dependence controller:(UIViewController *)controller completion:(QSPCompletionBlock)completion;
+ (QSPNetworkingObject *)callWithParameterConfig:(QSPParameterConfig *)parameterConfig;
```

#### 发送一个get请求
```

        [QSPNetworkingManager getCall:K_NetService_Regeo parameters:K_NetService_RegeoParamery cancelDependence:weakSelf controller:weakSelf completion:^(BOOL success, id responseObject, NSError *error) {
            if (success) {
                [LoadClass showMessage:@"请求成功！" toView:weakSelf.view];
            }
        }];
        [weakSelf.navigationController popViewControllerAnimated:NO];
```

#### 取消请求说明
1. 手动取消：每发送一个请求都会返回一个QSPNetworkingObject，只需对该对象进行cancel操作就能取消此请求了。
2. 自动取消：发送请求的时候会要求设置一个cancelDependence的参数，这个参数就是自动取消请求的依赖对象，只要设置了此对象，请求在此对象销毁时如果还没有完成，那么就会取消这个请求。设置自动取消能够一定提高APP的性能。


## 框架的设计思想与优势

### 设计思想

QSPNetworking是通过配置文件QSPNetworkingConfig（网络配置对象）、QSPErrorConfig（错误处理配置对象）、QSPLoadConfig（加载处理配置对象）以及一个判断网络请求数据正确的block来对网络请求进行全局控制的；然而每一条具体的请求有可以通过QSPParameterConfig（参数配置对象）来进行具体控制。

### 优势

1. 基于上述的两层控制的设计思想，可以根据需求对其进行组合，非常灵活方便，能够减少很多重复啰嗦的代码。
2. 对请求的取消进行了封装，并且支持根据依赖对象进行自动取消操作。
