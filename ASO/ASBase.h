//
// Created by admin on 2017/11/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include "AsoHeader.h"



@interface ASBase : NSObject

@property(nonatomic, assign) BOOL isCoding;

// 进行初始化相关方法
-(id _Nullable)init;

// 进行搜索当前
-(BOOL)searchKeyword:(NSString * _Nonnull)keyWord;


//发现下载按钮
-(id _Nullable )findDownloadButton;

//查找顶层视图
-(id _Nullable )findCollectionView:(UIView*  _Nonnull )view;

// 登录唤起
-(void)signIn;

//是否进入主页
-(BOOL)isEntrySubPage;

//登出所有账号
-(void)signOutAllAcount;

// 登出当前活跃账号
-(void)signOutActivateAccount;

// 获取点击点
- (void)getTouchPoint;


@end