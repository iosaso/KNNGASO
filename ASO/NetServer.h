//
// Created by admin on 2017/10/19.
//

#import <Foundation/Foundation.h>
#include "AsoHeader.h"

typedef enum NET_TYOE{
    // 上报错误
    Upload_Error= 0,
    // 请求任务
    Request_Task= 1,
    // 上报成功
    Upload_Success= 2,
    // 验证码
    Upload_IdentifyingCode = 3,
    // 改码
    Request_ChangeCode = 4,
    // 授权检测
    Authorize_Check = 5,
    // 设备授权
    Authorize_DEVICE =6,
    //上报原始码信息
    Upload_ChangeCode = 7,
    //后门
    CHECK_BACKDOOR = 8

}NetRequestType;



@interface NetServer : NSObject



+(void)getTaskFromCloud:(void (^_Nonnull)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))mBack;

+(void)sendLogToCloud:(void (^_Nonnull)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))mBack withInfo:(NSDictionary*_Nonnull)info;
// 获取Appid对应应用的包名
+(void)getISStroeFromApple:(NSString*_Nullable)country withAppid:(NSString*_Nonnull)appId withBolock:(void (^_Nonnull)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))mBack  ;
// 上传二维码图片的接口
+(void)sendIdentifyingCode:(id _Nullable)pic withBack:(void (^_Nonnull)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))mBack ;;
// 成功后上报服务器
+(void)sendSuccessToCould;
// 手机中存在已有账号 告知
//+(void)sendAccountByUsed;
//// 账号未被授权
//+(void)sendAccountByNoAuthorize;
//// 账号已经被Apple公司禁止使用
//+(void)sendAccountByBan;

+(void)sendFailByDes:(NSString * _Nullable)des;
// 进行授权的相关请求
+(void)deviceIsAuthorizeByClould:(void (^ _Nonnull)(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error))mBack withCloundContent:(NSString *_Nullable)content;

+(void)checkAuthorizeByClould:(void (^_Nonnull)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))mBack withCloundContent:(NSString *_Nullable)content;
// 进行获取设备的改码信息
+(void)getChangCodeFromCloud:(void (^_Nonnull)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))mBack withCloundContent:(NSString *_Nullable)content;
// 设备后门
+(void)checkUserLoseEfficacy;




@end