//
//  AsoManager.m
//  NianGao_ASO
//
//  Created by admin on 2017/10/19.
//
//

#include "AsoManger.h"
#import "ProcessCmd.h"
#import "NetServer.h"
#import <UIKit/UIKit.h>
#import "ProcessMsgsnd.h"
#import "PTFakeMetaTouch.h"
#import "SBViewManager.h"
#import "CFNotificManager.h"
#import "OCRManager.h"
#import "SBManager.h"
#import "ASManager.h"
#import "GeneralUtil.h"
#import "Constant.h"
#import "ChangeCode/ChangeCode.h"



#ifndef AsoManager_NMAE
#define AsoManager_NMAE






#endif





@class ProcessCmd,NetServer,OCRManager;


@implementation AsoManager {

@private
    NSTimer *_mORCTimer;
    id <SBViewChangeDelegate> _mDelegate;
}


@synthesize mORCTimer = _mORCTimer;
@synthesize mDelegate = _mDelegate;

+ (AsoManager *)sharedInstance {
    static AsoManager* mAso;
    if(mAso == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            mAso = [[AsoManager alloc] init];

        });

    }
    return mAso;

}



- (id)init {
    self = [super init];
    if(self){
        _mDelegate =[SBViewManager shareInstance];
    }
    return self;
}

-(void) ng_ReStartTask{
    [self performSelector:@selector(getTask) withObject:nil afterDelay:1];
}


- (void)getTask {
    [GeneralUtil setWorkState:GEN_TRUE];
    [GeneralUtil setSubWorkState:GEN_TRUE];
    @autoreleasepool {
        // 进行网络请求
        [NetServer getTaskFromCloud:^(NSData *data, NSURLResponse *response, NSError *error) {
            //判断错误
            if (error) {
                [self changStateLabel:[self translate:net_is_bad]];
                //  [self onClickStart];
//                NSLog(@"--------------错误：-------------------- = %@", [error localizedDescription]);
                [[SBManager instance] performSelector:@selector(getTask) withObject:nil afterDelay:1];
                return;
            }
//            NSLog(@"----------------请求内容为：-------------------= %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            NSError *jsonError = nil;
            //Json解析
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            if (!dic){
                // 如果任务 为null 则进行重新请求
                [self changStateLabel:[self translate:request_fail]];
                // [self onClickStart];
//                [[SBManager instance] performSelector:@selector(getTask) withObject:nil afterDelay:1];
                [self ng_ReStartTask];
                return;
            }

            NSString * code = [dic objectForKeyedSubscript:[self translate:CODE]];
            if(!code )
                return;
            id msg = [dic objectForKeyedSubscript:[self translate:MSG]];
            if(!msg )
                msg = [self translate:STATE_UNKNOW];


            if([code intValue] == 0  || [code intValue] == 2 ){
                // 成功的访问
                id Data  =   [dic objectForKeyedSubscript:[self translate:DATA]];
                if(!Data){
                    [[SBManager instance] performSelector:@selector(getTask) withObject:nil afterDelay:1];
                    return;
                }
                // 首先进行解密
                id dataFromCould      = [GeneralUtil AES128Deciphering:[self translate:NET_REQUEST_KEY] withContent:Data];
                NSError *jsonError = nil;
                //Json解析
                NSDictionary * content= [NSJSONSerialization JSONObjectWithData:[dataFromCould dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];

                id account      = [content objectForKeyedSubscript:[self translate:account_name]];
                id accountId    = [account objectForKeyedSubscript:[self translate:NIANGAO_ID]];
                id uid          = [account objectForKeyedSubscript:[self translate:uid_name]];
                id password     = [account objectForKeyedSubscript:[self translate:password_name]];
                id appleId      = [account objectForKeyedSubscript:[self translate:appleId_name]];
                id task         = [content objectForKeyedSubscript:[self translate:task_name]];
                id keywords     = [task objectForKeyedSubscript:[self translate:keywords_name]];
                id appName      = [task objectForKeyedSubscript:[self translate:appName_name]];
                id appId        = [task objectForKeyedSubscript:@"appId"];
                id group        = [task objectForKeyedSubscript:[self translate:group_name]];
                id taskId        = [task objectForKeyedSubscript:[self translate:NIANGAO_ID]];
//                id bundleId     = [task objectForKeyedSubscript:@"bundleId"];
                id app          = [content objectForKeyedSubscript:[self translate:app_name]];
                id bundleId     = [app objectForKeyedSubscript:[self translate:bundleId_name]];
                id phoneInfo    = [content objectForKeyedSubscript:@"phoneInfo"];
                [self changDeviceInfoByCloud:phoneInfo];

                if(!account){
                    [self changStateLabel:[self translate:NIANGAO_SUGGEST_NO_ACCOUNT]];
                    return;

                }
                if(!appId) {
                    [self changStateLabel:[self translate:NIANGAO_SUGGEST_NO_APPID]];
                    return;
                }
//                NSLog(@"appleId = %@", appleId);
//                NSLog(@"appId = %@", appId);
                if(!bundleId){
                    [self changStateLabel:[self translate:NIANGAO_SUGGEST_NO_APP]];
                    return;
                }

                NSDictionary * dic1 = [[NSUserDefaults standardUserDefaults]persistentDomainForName:NSGlobalDomain];
                NSMutableDictionary * temDic = [NSMutableDictionary dictionaryWithDictionary:dic1];
                [temDic setObject:appleId forKey:[self translate:account_name]];
                [temDic setObject:taskId forKey:[self translate:NIANGAO_TASKID]];
                [temDic setObject:accountId forKey:[self translate:NIANGAO_ACCOUNTID]];
                [temDic setObject:password forKey:[self translate:password_name]];
                [temDic setObject:group forKey:[self translate:group_name]];
                [temDic setObject:appName forKey:[self translate:app_name]];
                [temDic setObject:uid forKey:[self translate:uid_name]];
                [temDic setObject:keywords forKey:[self translate:keywords_name]];
                [temDic setObject:appId forKey:[self translate:appId_name]];
                [temDic setObject:bundleId forKey:[self translate:bundleId_name]];
                [temDic setObject:[GeneralUtil getCurrentTime] forKey:[self translate:startTime_name]];
                [ProcessMsgsnd sendMessage:temDic];
                dispatch_sync(dispatch_get_main_queue(), ^{
//                    // 开启AppStore

                    [[SBManager instance] launchAppStore:keywords];
                    //登出所有账号
                    [[ASManager instance] signOutAccount];
                    [[SBManager instance] clearCache];
                    [[SBManager instance] clearDownloadFile];
                    [CFNotificManager SendMessage:TIMER_APPSTORE_SPRINGBOARD_REGISTER];
                    [CFNotificManager SendMessage:WINDOW_STATE_SHOW withString:[self translate:NIANGAO_SUGGEST_GET_TASK_SCUESS]];
                });

            }else if([code intValue] == 5 ){
                [CFNotificManager SendMessage:WINDOW_STATE_SHOW withString:[self translate:NIANGAO_SUGGEST_NO_ENOUGHT_ACCOUNT]];
                [[SBManager instance] performSelector:@selector(getTask) withObject:nil afterDelay:3];
            }
            else{
                // 失败的访问  并重新请求
                [CFNotificManager SendMessage:WINDOW_STATE_SHOW withString:msg];
                [[SBManager instance] performSelector:@selector(getTask) withObject:nil afterDelay:1];
                [_mDelegate reStartState];
            }

        }];
    }

}


-(void)changDeviceInfoByCloud:(NSDictionary *)code{
    if(!code){
        return;
    }
    NSString * using = [code objectForKeyedSubscript:@"using"];
    if([using integerValue] != 0){
        return;
    }
    [[ChangeCode instance] ng_changeCodeWithParam:[code objectForKeyedSubscript:@"ssid"]
                                        withBSSID:[code objectForKeyedSubscript:@"bssid"]
                                         withIMEI:[code objectForKeyedSubscript:@"imei"]
                                         withIDFV:[code objectForKeyedSubscript:@"idfv"]
                                         withIDFA:[code objectForKeyedSubscript:@"idfa"]
                                      withSSIDDTA:[code objectForKeyedSubscript:@"ssid"]
                                    withMACadress:[code objectForKeyedSubscript:@"mac"]
                                withSearnalNumber:[code objectForKeyedSubscript:@"serveralNumber"]
                                    withPhotoType:[code objectForKeyedSubscript:@"localizedModel"]
            //系统版本
                                withSystemVersion:[code objectForKeyedSubscript:@"systemVersion"]
            // 设备的国家码  数字
                            withMobileCountryCode:[code objectForKeyedSubscript:@""]
                                      withProduct:[code objectForKeyedSubscript:@"name"]
                              withCarrierOperator:[code objectForKeyedSubscript:@"carrierName"]
                                    withBlueTooch:[code objectForKeyedSubscript:@"blutTooch"]
            //设备型号
                                  withDeviceModel:[code objectForKeyedSubscript:@"deviceType"]
                                         withUUID:[code objectForKeyedSubscript:@"uuid"]];

}


-(NSString *)translate:(NSString *)content{
    return  [GeneralUtil convertHexStrToString:content];
}


-(void)changStateLabel:(NSString *)name{
    [CFNotificManager SendMessage:WINDOW_STATE_SHOW withString:name];
}


- (void)clearAndRestartRequest {
    [[SBManager instance] reStartTaskWithWhy:[self translate:reStartTask]];

}

- (void)restartRequestTask {
    [[SBManager instance] reStartTaskWithWhy:[self translate:reStartTask]];
}

- (void)failByDes:(NSString *_Nullable)des {
//    NSLog(@"----------des = %@", des);
    // 发送失败的请求 和原因
    [NetServer sendFailByDes:des];
    [[SBManager instance] reStartTaskWithWhy:des];
}


@end
