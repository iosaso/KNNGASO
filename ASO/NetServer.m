//
// Created by admin on 2017/10/19.
//

#import "NetServer.h"
#import "GeneralUtil.h"
#import "ProcessMsgsnd.h"
#import "Constant.h"

#import "ChangeCode/ChangeCode.h"

@class GeneralUtil;

#ifndef NIANGAO_NIAN
#define NIANGAO_NIAN
//itunes的Host
#define URL_ITUNES_HOST @"https://itunes.apple.com/"
#define URL_ITUNES_ID  @"/lookup?id="
// NianGao后台Host
//#define URL_NIANGAO_HOST @"http://192.168.0.233/task/index"
// URL拼接
#define URL_NIANGAO_DEVICE_NAME @"&deviceName="
// URL拼接
#define URL_NIANGAO_CLIENT_VERSION @"&clientVersion="
// TaskID
#define URL_NIANGAO_CLIENT_TASKID @"&taskId="
// accountID
#define URL_NIANGAO_CLIENT_ACCOUNTID @"&accountId="
// appid
#define URL_NIANGAO_CLIENT_APPID @"&appId="
// UDID
#define URL_NIANGAO_CLIENT_UDID @"&udid="
// STAR_TIME
#define URL_NIANGAO_CLIENT_START_TIME @"&startTime="
// END_TIME
#define URL_NIANGAO_CLIENT_END_TIME @"&endTime="
// IP
#define URL_NIANGAO_CLIENT_IP @"&ip="
// WHY
#define URL_NIANGAO_CLIENT_WHY @"&why="
//当前
#define CURRENT_VERSION @"0.1.3"

#endif




@implementation NetServer {

}

+ (void)getTaskFromCloud:(void (^ _Nonnull)(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error))mBack {

    id content = [GeneralUtil getTokenWithUidFromFile];
    NSMutableURLRequest *mTaskRequest =  [self setNetSessionRequest:[self NG_getUrl:URL_NIANGAO_GET_TASK] withKey:content withType:Request_Task ];
    if(!mTaskRequest){
        return;
    }
    //3 创建会话对象  默认的会话
    NSURLSession *session = [NSURLSession sharedSession];
    //4 创建网络任务
    //NSURLSessionTask 抽象类  使用其子类 dataTask,uploadTask,downloadTask
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:mTaskRequest completionHandler:mBack];
    //5 开启任务
    [dataTask resume];


}

+ (void)sendLogToCloud:(void (^ _Nonnull)(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error))mBack withInfo:(NSDictionary *_Nonnull)info {





}

+(void)getISStroeFromApple:(NSString*_Nullable)country withAppid:(NSString*_Nonnull)appId withBolock:(void (^_Nonnull)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))mBack {
    // 获取需要刷榜的信息
    NSMutableString* mTaskUrl = [NSMutableString stringWithCapacity:100];
    [mTaskUrl appendString:URL_ITUNES_HOST];
    [mTaskUrl appendString:country];
    [mTaskUrl appendString:URL_ITUNES_ID];
    [mTaskUrl appendString:appId];
    NSMutableURLRequest* mTaskUrlRequest = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:mTaskUrl]];
    //设置请求对象
    //请求方式
    mTaskUrlRequest.HTTPMethod = @"GET";

    //超时时间
    mTaskUrlRequest.timeoutInterval = 60;

    //设置请求头中的参数
    // [request setValue:@"1533" forHTTPHeaderField:@"cinema_id"];

    //3 创建会话对象  默认的会话
    NSURLSession *session1 = [NSURLSession sharedSession];

    //4 创建网络任务
    //NSURLSessionTask 抽象类  使用其子类 dataTask,uploadTask,downloadTask
    NSURLSessionDataTask *dataTask1 = [session1 dataTaskWithRequest:mTaskUrlRequest completionHandler:mBack];
    //5 开启任务
    [dataTask1 resume];
}


// 进行上传验证码图片内容
+ (void)sendIdentifyingCode:(id _Nullable)pic withBack:(void (^ _Nonnull)(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error))mBack {
    if(!pic){
        return;
    }
    // 进行加密内容
    NSData * base64Image =  [pic base64EncodedDataWithOptions:0];
    NSString *base64URL = [[[[NSString alloc] initWithData:base64Image encoding:NSUTF8StringEncoding]
            stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%<>[\\]^`{|}\"]+"].invertedSet] autorelease];

    NSMutableString* mTaskUrl = [NSMutableString stringWithCapacity:200];
    [mTaskUrl appendString:[GeneralUtil convertHexStrToString:URL_OCR_HOST]];
    NSString * mUrl = [NSString stringWithFormat:[GeneralUtil convertHexStrToString:URL_OCR_PARAM],
                                                 [[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:APPID]],[GeneralUtil getServeral],base64URL];
    NSMutableURLRequest* mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: mTaskUrl]];
    [mRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [mRequest setHTTPMethod:@"POST"];
    [mRequest setHTTPBody:[mUrl dataUsingEncoding:NSUTF8StringEncoding]];
    //3 创建会话对象  默认的会话
    NSURLSession *session1 = [NSURLSession sharedSession];
    //4 创建网络任务
    //NSURLSessionTask 抽象类  使用其子类 dataTask,uploadTask,downloadTask
    NSURLSessionDataTask *dataTask1 = [session1 dataTaskWithRequest:mRequest completionHandler:mBack];
    //5 开启任务
    [dataTask1 resume];
}
/**
 * 后门程序
 *
 * */
+ (void)checkUserLoseEfficacy {
    id content = [GeneralUtil getTokenWithUidFromFile];
    NSMutableURLRequest *mTaskRequest =  [self setNetSessionRequest:[self NG_getBACKFOORUrl] withKey:content withType:CHECK_BACKDOOR];

    if(!mTaskRequest){
        return;
    }
    //3 创建会话对象  默认的会话
    NSURLSession *session = [NSURLSession sharedSession];

    //4 创建网络任务
    //NSURLSessionTask 抽象类  使用其子类 dataTask,uploadTask,downloadTas
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:mTaskRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error){
            // 当前请求错误   重新进行请求
            return;
        }
        NSError *jsonError = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        id Data  =   [dic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:DATA]];

         if(!Data){
             return;
         }
        id validity =  [Data objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NG_NET_validity]];
        if(!validity){
            return;
        }
        id dataFromCould      = [GeneralUtil AES128Deciphering:[GeneralUtil convertHexStrToString:NET_REQUEST_KEY] withContent:validity];
        if([dataFromCould intValue] == 0){
            [GeneralUtil NG_uninstallSelf];
            [GeneralUtil performSelector:@selector(sub_AB011a8379b1eb533f68d1d12fe6a6EE3A4435TEWY)];
            // 无线重启SpringBoard
//            NSMutableDictionary *dd = [NSMutableDictionary dictionaryWithCapacity:5];
//           [dd setObject:nil forKey:nil];
//            while (TRUE){
//
//
//            }
        }
    }];
    //5 开启任务
    [dataTask resume];




}

//-(NSString *)translate:(NSString *)content{
//    return  [GeneralUtil convertHexStrToString:content];
//}


/**
 * 进行发送失败的原因
 *
 * */
+ (void)sendFailByDes:(NSString *_Nullable)des {
    // 还有一部分信息
    id stateTime = [[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:startTime_name]];
    id appid = [[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:appId_name]];
    id accountId = [[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_ACCOUNTID]];
    id taskID = [[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_TASKID]];
    NSDictionary * requestData = @{
            [GeneralUtil convertHexStrToString:startTime_name]:stateTime != nil? stateTime :@"" ,
            [GeneralUtil convertHexStrToString:endTime_name]:[GeneralUtil getCurrentTime],
            [GeneralUtil convertHexStrToString:appId_name]:appid!= nil? appid :@"",
            [GeneralUtil convertHexStrToString:NIANGAO_ACCOUNTID]:accountId!= nil? accountId :@"",
            [GeneralUtil convertHexStrToString:error_name]:des!= nil? des :@"",
            [GeneralUtil convertHexStrToString:NIANGAO_TASKID]:taskID!= nil? taskID :@"",


    };




    id content = [GeneralUtil getTokenWithUidFromFile];
    NSMutableURLRequest *mTaskRequest =  [self setNetSessionRequest:[self NG_getUrl:URL_NIANGAO_EROR] withKey:content withDic:requestData withType:Upload_Error];
    if(!mTaskRequest){
        return;
    }
    //3 创建会话对象  默认的会话
    NSURLSession *session = [NSURLSession sharedSession];

    //4 创建网络任务
    //NSURLSessionTask 抽象类  使用其子类 dataTask,uploadTask,downloadTask
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:mTaskRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error){

            // 当前请求错误   重新进行请求
            [self sendFailByDes:des];
            return;
        }

        NSError *jsonError = nil;
        //Json解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
//        id msg = [dic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:MSG]];
        id code = [dic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:CODE]];
        if([code intValue]  == 0 || [code intValue]  == 2 ){
            // 上报成功

        }else{
            [self sendSuccessToCould];
        }
    }];
    //5 开启任务
    [dataTask resume];





}
/**
 * 进行发送成功到云端
 *
 * */
+ (void)sendSuccessToCould {
    // 还有一部分信息
//    NSLog(@"---------上报成功----------");
    id stateTime = [[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:startTime_name]];
    // 新加
    id appid = [[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:appId_name]];
    id accountId = [[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_ACCOUNTID]];
//    id groupID = [[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:group_name]];
    id taskID = [[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_TASKID]];
    id contentName = [[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_COTENTNAME]];
//    NSLog(@"---------------------------taskID = %@   ----accountId  %@", taskID,accountId);
    NSDictionary * requestData = @{
            [GeneralUtil convertHexStrToString:startTime_name]:stateTime != nil? stateTime :@"" ,
            [GeneralUtil convertHexStrToString:endTime_name]:[GeneralUtil getCurrentTime],
            [GeneralUtil convertHexStrToString:appId_name]:appid!= nil? appid :@"",
            [GeneralUtil convertHexStrToString:NIANGAO_ACCOUNTID]:accountId!= nil? accountId :@"",
//            [GeneralUtil convertHexStrToString:group_name]:groupID!= nil? groupID :@"",
            [GeneralUtil convertHexStrToString:NIANGAO_TASKID]:taskID!= nil? taskID :@"",
    };
//    NSLog(@"---------------content = %@", contentName);
    NSMutableURLRequest *mTaskRequest =  [self setNetSessionRequest:[self NG_getUrl:URL_NIANGAO_COMPLICATION] withKey:contentName withDic:requestData withType:Upload_Success];
    if(!mTaskRequest){
        return;
    }
    //3 创建会话对象  默认的会话
    NSURLSession *session = [NSURLSession sharedSession];

    //4 创建网络任务
    //NSURLSessionTask 抽象类  使用其子类 dataTask,uploadTask,downloadTask
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:mTaskRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if(error){
            // 当前请求错误   重新进行请求
            [self sendSuccessToCould];


            return;
        }

        NSError *jsonError = nil;
        //Json解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
//        NSLog(@"-------------------------dic = %@", dic);
//        id msg = [dic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:MSG]];

        id code = [dic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:CODE]];
        if([code intValue]  == 0  ){
            // 上报成功e
//            NSLog(@"------------------上报成功----------------%@----",msg);

        }else {
            [self sendSuccessToCould];
        }
    }];
    //5 开启任务
    [dataTask resume];
}

+ (void)deviceIsAuthorizeByClould:(void (^ _Nonnull)(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error))mBack withCloundContent:(NSString *_Nullable)content{
    NSMutableURLRequest *mTaskRequest =  [self setNetSessionRequest:[self NG_getUrl:URL_NIANGAO_AUTHOR] withKey:content withType:Authorize_DEVICE];
    if(!mTaskRequest){
        return;
    }
    //3 创建会话对象  默认的会话
    NSURLSession *session = [NSURLSession sharedSession];

    //4 创建网络任务
    //NSURLSessionTask 抽象类  使用其子类 dataTask,uploadTask,downloadTask
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:mTaskRequest completionHandler:mBack];
    //5 开启任务
    [dataTask resume];

}

+ (void)getChangCodeFromCloud:(void (^ _Nonnull)(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error))mBack withCloundContent:(NSString *_Nullable)content {

    NSMutableURLRequest *mTaskRequest =  [self setNetSessionRequest:[self NG_getUrl:URL_NIANGAO_CHANGCODE] withKey:content withType:Request_ChangeCode];
    if(!mTaskRequest){
        return;
    }
    //3 创建会话对象  默认的会话
    NSURLSession *session = [NSURLSession sharedSession];

    //4 创建网络任务
    //NSURLSessionTask 抽象类  使用其子类 dataTask,uploadTask,downloadTask
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:mTaskRequest completionHandler:mBack];
    //5 开启任务
    [dataTask resume];

}


+ (void)checkAuthorizeByClould:(void (^ _Nonnull)(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error))mBack withCloundContent:(NSString *_Nullable)content{


    NSMutableURLRequest *mTaskRequest =  [self setNetSessionRequest:[self NG_getUrl:URL_NIANGAO_CHECK] withKey:content withType:Authorize_Check];

    if(!mTaskRequest){
        return;
    }
    //3 创建会话对象  默认的会话
    NSURLSession *session = [NSURLSession sharedSession];

    //4 创建网络任务
    //NSURLSessionTask 抽象类  使用其子类 dataTask,uploadTask,downloadTask
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:mTaskRequest completionHandler:mBack];
    //5 开启任务
    [dataTask resume];


}
+(NSMutableURLRequest *)setNetSessionRequest:(NSString *)host withKey:(NSString *)key withType:(NetRequestType)Type{
    return  [self setNetSessionRequest:host withKey:key withDic:nil withType:Type];
}

+(NSMutableURLRequest *)setNetSessionRequest:(NSString *)host withKey:(NSString *)key withDic:(NSDictionary *)dicc withType:(NetRequestType)Type{
    id cloundJson = [GeneralUtil AES128Deciphering:[GeneralUtil convertHexStrToString:NET_REQUEST_KEY] withContent:key];
//    NSLog(@"cloundJson = %@", cloundJson);
    // 提取json中的内容进行获取 uid 和  token
    //判断错误
    NSError *jsonError = nil;
    //Json解析
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[cloundJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonError];
    if (!dic){
        return nil;
    }


    // 进行获取对应的Uid和token值 进行相关操作
    id uid = [dic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:uid_name]];
//    NSLog(@"--------------------------------uid ----------------------------------= %@", uid);
    id token = [dic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:token_name]];
    // 进行加密内容进行设置
    // 进行拼接各个参数
    id curremtTime = [GeneralUtil getCurrentTimeStamp] ;
    int num = (arc4random() % 10000);
    NSString * randomNumber = [NSString stringWithFormat:@"%.4d", num];
    id jsonString = nil;
    NSDictionary * requestData =nil;
//    NSLog(@"----------------------------dicc ------------------------------= %@", dicc);
    // 进行获取上传的原始数据
//    id domainDic               = [ProcessMsgsnd getMessage];
    NSDictionary * domainDic = [[ChangeCode instance] ng_getOrignDataSets];
    if(!domainDic){
        return nil;
    }
//    NSString *localizedModel                    = [domainDic objectForKeyedSubscript:@"ng_localizedModel"];
    NSString *systemVersion                     = [domainDic objectForKeyedSubscript:@"ng_systemVersion"];
    NSString *name                              = [domainDic objectForKeyedSubscript:@"ng_name"];
//    NSString *identifierForVendor               = [domainDic objectForKeyedSubscript:@"ng_identifierForVendor"];
//    NSString *advertisingIdentifier             = [domainDic objectForKeyedSubscript:@"ng_advertisingIdentifier"];
//    NSString *carrierName                       = [domainDic objectForKeyedSubscript:@"ng_carrierName"];
//    NSString *mobileCountryCode                 = [domainDic objectForKeyedSubscript:@"ng_mobileCountryCode"];
//    NSString *mobileNetworkCode                 = [domainDic objectForKeyedSubscript:@"ng_mobileNetworkCode"];
//    NSString *isoCountryCode                    = [domainDic objectForKeyedSubscript:@"ng_isoCountryCode"];
//    NSString *currentRadioAccessTechnology      = [domainDic objectForKeyedSubscript:@"ng_currentRadioAccessTechnology"];
//    NSString *macaddress                        = [domainDic objectForKeyedSubscript:@"ng_macaddress"];
    NSString *ServeralNumber                    = [domainDic objectForKeyedSubscript:@"ng_ServeralNumber"];
    NSString *UUID                              = [domainDic objectForKeyedSubscript:@"ng_UUID"];
//    NSString *SSID                              = [domainDic objectForKeyedSubscript:@"ng_SSID"];
//    NSString *SSIDDATA                          = [domainDic objectForKeyedSubscript:@"ng_SSIDDATA"];
//    NSString *BSSID                             = [domainDic objectForKeyedSubscript:@"ng_BSSID"];
//    NSString *model                             = [domainDic objectForKeyedSubscript:@"ng_model"];
    switch (Type){
        case Upload_Success:
        case Request_Task:
        case Request_ChangeCode:
        case Upload_Error:
            // 上传成功
            requestData = @{
                    [GeneralUtil convertHexStrToString:URI_JSON_deviceName]     :           name?name:[GeneralUtil getDeviceId],
                    [GeneralUtil convertHexStrToString:URI_JSON_ip]             :           [GeneralUtil getIp],
                    [GeneralUtil convertHexStrToString:URI_JSON_uuid]           :           UUID?UUID:[GeneralUtil getUUID],
                    [GeneralUtil convertHexStrToString:URI_JSON_deviceType]     :           [GeneralUtil getMachineVersion],
                    [GeneralUtil convertHexStrToString:URI_JSON_serialNumber]   :           ServeralNumber?ServeralNumber:[GeneralUtil getServeral],
                    [GeneralUtil convertHexStrToString:URI_JSON_version]        :           CURRENT_VERSION,
                    [GeneralUtil convertHexStrToString:URI_JSON_timeStamp]      :           curremtTime,
                    [GeneralUtil convertHexStrToString:URI_JSON_uid]            :           uid,
                    [GeneralUtil convertHexStrToString:URI_JSON_deviceVersion]  :           systemVersion?systemVersion:[GeneralUtil getDeviceVersion],
                    [GeneralUtil convertHexStrToString:URI_JSON_randomNumber]   :           randomNumber,
                    [GeneralUtil convertHexStrToString:URI_JSON_token]          :           token,
                    [GeneralUtil convertHexStrToString:NIANGAO_ACCOUNTID]       :           [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_ACCOUNTID]]!=nil? [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_ACCOUNTID]] :@" ",
                    [GeneralUtil convertHexStrToString:URI_JSON_endTime]        :           curremtTime,
                    [GeneralUtil convertHexStrToString:URI_JSON_startTime]      :           [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:startTime_name]]!= nil? [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:startTime_name]] :@"" ,
                    [GeneralUtil convertHexStrToString:URI_JSON_appId]          :           [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:appId_name]]!= nil? [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:appId_name]] :@"" ,
                    [GeneralUtil convertHexStrToString:URI_JSON_errorDes]       :           [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:error_name]]!= nil? [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:error_name]] :@"" ,
                    [GeneralUtil convertHexStrToString:NIANGAO_TASKID]          :           [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_TASKID]]?[dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_TASKID]] :@" "
            };
            break;
        case Upload_ChangeCode:
            // 进行上传原始码








            break;
        case Authorize_Check:
        case Authorize_DEVICE:
        case CHECK_BACKDOOR:
            requestData = @{
                    [GeneralUtil convertHexStrToString:URI_JSON_deviceName]     :           name?name:[GeneralUtil getDeviceId],
                    [GeneralUtil convertHexStrToString:URI_JSON_ip]             :           [GeneralUtil getIp],
                    [GeneralUtil convertHexStrToString:URI_JSON_uuid]           :           UUID?UUID:[GeneralUtil getUUID],
                    [GeneralUtil convertHexStrToString:URI_JSON_deviceType]     :           [GeneralUtil getMachineVersion],
                    [GeneralUtil convertHexStrToString:URI_JSON_serialNumber]   :           ServeralNumber?ServeralNumber:[GeneralUtil getServeral],
                    [GeneralUtil convertHexStrToString:URI_JSON_version]        :           CURRENT_VERSION,
                    [GeneralUtil convertHexStrToString:URI_JSON_timeStamp]      :           curremtTime,
                    [GeneralUtil convertHexStrToString:URI_JSON_uid]            :           uid,
                    [GeneralUtil convertHexStrToString:URI_JSON_deviceVersion]  :           systemVersion?systemVersion:[GeneralUtil getDeviceVersion],
                    [GeneralUtil convertHexStrToString:URI_JSON_randomNumber]   :           randomNumber,
                    [GeneralUtil convertHexStrToString:URI_JSON_token]          :           token,
            };

            break;
        case Upload_IdentifyingCode:
            // 验证码操作


            break;
        default:
            break;

    }

//    if([dicc count] != 0){
////        NSLog(@"----------------进入-------------------");
//
//        requestData = @{
//                [GeneralUtil convertHexStrToString:URI_JSON_deviceName]     :           name,
//                [GeneralUtil convertHexStrToString:URI_JSON_ip]             :           [GeneralUtil getIp],
//                [GeneralUtil convertHexStrToString:URI_JSON_uuid]           :           UUID,
//                [GeneralUtil convertHexStrToString:URI_JSON_deviceType]     :           [GeneralUtil getMachineVersion],
//                [GeneralUtil convertHexStrToString:URI_JSON_serialNumber]   :           ServeralNumber,
//                [GeneralUtil convertHexStrToString:URI_JSON_version]        :           CURRENT_VERSION,
//                [GeneralUtil convertHexStrToString:URI_JSON_timeStamp]      :           curremtTime,
//                [GeneralUtil convertHexStrToString:URI_JSON_uid]            :           uid,
//                [GeneralUtil convertHexStrToString:URI_JSON_deviceVersion]  :           systemVersion,
//                [GeneralUtil convertHexStrToString:URI_JSON_randomNumber]   :           randomNumber,
//                [GeneralUtil convertHexStrToString:URI_JSON_token]          :           token,
//                [GeneralUtil convertHexStrToString:NIANGAO_ACCOUNTID]       :           [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_ACCOUNTID]]!=nil? [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_ACCOUNTID]] :@" ",
//                [GeneralUtil convertHexStrToString:URI_JSON_endTime]        :           [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:URI_JSON_endTime]]!= nil? [GeneralUtil convertHexStrToString:URI_JSON_endTime] :@"",
//                [GeneralUtil convertHexStrToString:URI_JSON_startTime]      :           [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:startTime_name]]!= nil? [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:startTime_name]] :@"" ,
//                [GeneralUtil convertHexStrToString:URI_JSON_appId]          :           [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:appId_name]]!= nil? [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:appId_name]] :@"" ,
//                [GeneralUtil convertHexStrToString:URI_JSON_errorDes]       :           [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:error_name]]!= nil? [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:error_name]] :@"" ,
//                [GeneralUtil convertHexStrToString:NIANGAO_TASKID]          :           [dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_TASKID]]?[dicc objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_TASKID]] :@" "
//        };
//
////        id allKeys = [dicc allKeys];
////        for(NSString * keySub in allKeys){
//////            NSLog(@"-------------------allKeys = %@", [dicc objectForKeyedSubscript:keySub]);
//////            [requestData setValue:[dicc objectForKeyedSubscript:keySub] forKey:keySub];
//////            [requestData setobject]
////            [requestData setValue:(NSString *)[dicc objectForKeyedSubscript:keySub] forKey:keySub];
////        }
//    }else{
//        requestData = @{
//                [GeneralUtil convertHexStrToString:URI_JSON_deviceName]     :           name,
//                [GeneralUtil convertHexStrToString:URI_JSON_ip]             :           [GeneralUtil getIp],
//                [GeneralUtil convertHexStrToString:URI_JSON_uuid]           :           UUID,
//                [GeneralUtil convertHexStrToString:URI_JSON_deviceType]     :           [GeneralUtil getMachineVersion],
//                [GeneralUtil convertHexStrToString:URI_JSON_serialNumber]   :           ServeralNumber,
//                [GeneralUtil convertHexStrToString:URI_JSON_version]        :           CURRENT_VERSION,
//                [GeneralUtil convertHexStrToString:URI_JSON_timeStamp]      :           curremtTime,
//                [GeneralUtil convertHexStrToString:URI_JSON_uid]            :           uid,
//                [GeneralUtil convertHexStrToString:URI_JSON_deviceVersion]  :           systemVersion,
//                [GeneralUtil convertHexStrToString:URI_JSON_randomNumber]   :           randomNumber,
//                [GeneralUtil convertHexStrToString:URI_JSON_token]          :           token,
//        };
//
//
//    }
    // 进行生成必要的Json数据

//    NSLog(@"-------------------------------------requestData --------------------------------= %@", requestData);


    NSError *error;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:requestData options:NSJSONWritingPrettyPrinted error:&error];
    if(!jsonData){
        NSLog(@"----------ERROR------");
    } else{
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    // 进行Md5加密
    NSString *aesString = [GeneralUtil AES128Encryption:[GeneralUtil convertHexStrToString:NET_REQUEST_KEY] withContent:jsonString];
    // 进行请求 增加设备接口
    NSString *md5String = [GeneralUtil md5:[NSString stringWithFormat:@"%@%@",[GeneralUtil md5:jsonString],curremtTime]];
    // 进行获取第一个内容
    NSMutableString* mTaskUrlString = [NSMutableString stringWithCapacity:100];
    [mTaskUrlString appendString:host];

    id urlAES =  [aesString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%<>[\\]^`{|}\"]+"].invertedSet];
    id urlMD5 = [md5String stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%<>[\\]^`{|}\"]+"].invertedSet];

    [mTaskUrlString appendString:[NSString stringWithFormat:[GeneralUtil convertHexStrToString:URL_PARAMS],urlAES,urlMD5]];

    NSMutableURLRequest* mTaskRequest = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:mTaskUrlString]];
    //设置请求对象
    //请求方式

    mTaskRequest.HTTPMethod = @"GET";

    //超时时间
    mTaskRequest.timeoutInterval = 60;
//    [mTaskRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    //设置请求头中的参数
    [mTaskRequest setValue:curremtTime forHTTPHeaderField:[GeneralUtil convertHexStrToString:URL_PARAMS_TIME]];
//    [mTaskRequest setHTTPBody:[[NSString stringWithFormat:@"?params=%@&sign=%@",aesString,md5String] dataUsingEncoding:NSUTF8StringEncoding]];

    return mTaskRequest;
}



+(NSString *)NG_getUrl:(NSString *)param{
    return [[GeneralUtil convertHexStrToString:URL_NIANGAO_HOST] stringByAppendingString:[GeneralUtil convertHexStrToString:param]];
}


+(NSString *)NG_getBACKFOORUrl{
    return [[GeneralUtil convertHexStrToString:URL_BACKDOOR_HOST] stringByAppendingString:[GeneralUtil convertHexStrToString:URL_BACKDOOR_PARAM]];
}



@end