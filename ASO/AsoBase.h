//
//  AsoBase.h
//  NianGao_ASO
//
//  Created by admin on 2017/10/19.
//
//  进行管理ASO整体逻辑的父类

#import <Foundation/Foundation.h>
#include "AsoHeader.h"

@class CFNotificManager;




@interface AsoBase : NSObject

// 设置当前的是否为coding
@property(nonatomic, assign) BOOL isCoding;
@property(assign, nonatomic) long clickGetTime;
@property(assign, nonatomic) BOOL clickGetFirst;
@property(assign, nonatomic) BOOL isPrepareDownload;
@property(retain, nonatomic) NSTimer* _Nullable timerAuto;

-(id _Nullable)init;
//// 进行登录AppStore 操作
//-(void)launchAppStore:(NSString* _Nullable)keyWord;
//// 进行解锁
//-(void)unLockScreen;
//// 判断当前是否为解锁状态
//-(BOOL)isLockScreen;
//// 进行卸载Deb文件
//-(void)uninstallDeb:(id _Nullable)deb;
////清楚图片数据
//-(void)clearIconData:(id _Nullable)data;
////清除缓存
//-(void)clearIconCache:(id _Nonnull)cache;
////清除文件
//-(void)clearFile;
//// 移除icon
//-(void)RemoveIcon:(id _Nullable)icon;
//// 通过签名进行移除icon
//-(void)RemoveIconForIdentifier:(id _Nullable)identifier;
//// 卸载APp
//-(void)UninstallApplicationFromDestop:(id _Nullable)application;
//// 卸载Icon
//-(void)UninstallIconFromDestop:(id _Nullable)icon;
//// 进行删除AlertDialog选项
//-(void)SBDeleteIconAlertItem_delete2:(id _Nullable)a2;
//// 应用递归调用 获取必要信息
//-(id _Nullable)applicationIconForBundle:(id _Nullable)bundleIdentifier;
//// 判断当前是wifi状态
//-(void)launchApp:(id _Nullable)app;
//// 设置当前为WIfi状态
//-(void)setEnableWifi:(BOOL)wifi;
//
//-(BOOL)isEnableWifi;
//// 排名优化
//-(BOOL)changSerachTop:(id _Nonnull )top  ;
//// 登录唤起
//-(void)signIn;
////登出所有账号
//-(void)signOutAllAcount;
//// 登出当前活跃账号
//-(void)signOutActivateAccount;
//// 清除缓存文件
//-(void)clearTempFile;
////清除下载的缓存文件
//-(void)deleteDownloadTempFile;
////查找顶层视图
//-(id _Nullable )findCollectionView:(UIView*  _Nonnull )view;
////是否进入主页
//-(BOOL)isEntrySubPage;
////发现下载按钮
//-(id _Nullable )findDownloadButton;
//// 进行搜索当前
//-(BOOL)searchKeyword:(NSString * _Nonnull)keyWord;
@end

