//
// Created by admin on 2017/10/27.
//  进行管理Springboard的相关操作

#import <Foundation/Foundation.h>
#import "SBBase.h"
#import "SBViewClickDelegate.h"
#import "SBViewChangeDelegate.h"
#include "AsoHeader.h"


@interface SBManager : SBBase<SBViewClickDelegate>



+ (SBManager *_Nullable)instance;


// 获取任务
-(void)getTask;

// 界面展示
-(void)showWindow:(id _Nonnull)se;


// 时间管理
-(void)TimerManager;


// 清除各种缓存
-(void)clearCache;


// 清除下载文件 和卸载
-(void)clearDownloadFile;


// 杀死AppStore相关操作
-(void)killAppStore;

// 杀死SpringBoard
-(void)KillSpringBoard;

-(id _Nullable)init;

//清除所有Timer计时检测
- (void)clearAllTimer;

//清除AppStore的操作 并开启全局
- (void)clearCheckAppStoreTimer;



//进行重启任务相关展示
-(void)reStartTaskWithWhy:(NSString *_Nullable)why;


- (void)reStartTaskWithTimour;
@end