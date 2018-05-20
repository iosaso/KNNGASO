//
// Created by admin on 2017/11/2.
//

#import <Foundation/Foundation.h>
#include "AsoHeader.h"

@interface SBBase : NSObject

// 进行解锁
-(void)unLockScreen;
// 判断当前是否为解锁状态
-(BOOL)isLockScreen;

// 进行卸载Deb文件
-(void)uninstallDeb:(id _Nullable)deb;
//清楚图片数据
-(void)clearIconData:(id _Nullable)data;
//清除缓存
-(void)clearIconCache:(id _Nonnull)cache;
//清除文件
-(void)clearFile;
// 移除icon
-(void)RemoveIcon:(id _Nullable)icon;
// 通过签名进行移除icon
-(void)RemoveIconForIdentifier:(id _Nullable)identifier;
// 卸载APp
-(void)UninstallApplicationFromDestop:(id _Nullable)application;
// 卸载Icon
-(void)UninstallIconFromDestop:(id _Nullable)icon;
// 进行删除AlertDialog选项
-(void)SBDeleteIconAlertItem:(id _Nullable)bundlid;
// 应用递归调用 获取必要信息
-(id _Nullable)applicationIconForBundle:(id _Nullable)bundleIdentifier;
// 判断当前是wifi状态
-(void)launchApp:(id _Nullable)app;
// 清除缓存文件
-(void)clearTempFile;
//清除下载的缓存文件
-(void)deleteDownloadTempFile;
// 进行卸载文件操作
-(void)unInstallDownloadApp;
// 登录AppStore
-(void)launchAppStore:(NSString* _Nullable)keyWord;


@end