//
// Created by admin on 2017/11/2.
// 用来管理AppStore的相关操作   进行分开管理

#import <Foundation/Foundation.h>
#import "ASBase.h"
#include "AsoHeader.h"



@interface ASManager : ASBase

+ (ASManager *_Nullable)instance;


-(id _Nonnull)init;

// 排名优化
-(BOOL)changSerachTop:(id _Nonnull )top;

// 进行模拟点击下载 和 当前正在执行的相关操作
- (void)startAutoDownload :(id _Nullable)state;


// 进行登出账号
-(void)signOutAccount;


// 进行自动化搜索关键字
-(void)autoSearch;



@end