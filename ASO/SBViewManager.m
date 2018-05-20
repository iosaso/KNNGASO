//
//  SBViewManager.m
//  NianGao_ASO
//
//  Created by admin on 2017/10/19.
//
//


#include "SBViewManager.h"
#import "GeneralUtil.h"
#import "SBManager.h"
#import "ScanningController.h"
#import "CFNotificManager.h"
#import "NetServer.h"
#import "Constant.h"
#import "ProcessMsgsnd.h"
#import <dlfcn.h>
#import "ChangeCode/ChangeCode.h"
#import <sys/types.h>
#import "PTFakeMetaTouch.h"
#import "NetServer.h"

typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);
#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif  // !defined(PT_DENY_ATTACH



@implementation SBViewManager {
@private
    UIWindow *_scanningWindow;
}


@synthesize mainButton = _mainButton;
@synthesize controllerWindow = _controllerWindow;
@synthesize serialLabel = _serialLabel;
@synthesize stateLabel = _stateLabel;
@synthesize version = _version;
@synthesize ClickDelagate = _ClickDelagate;
@synthesize scanningWindow = _scanningWindow;

// 进行初始化当前的实例
+ (SBViewManager *)shareInstance {

    static SBViewManager * mWin;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        @synchronized (self) {
            if(mWin == nil){

                mWin = [[SBViewManager alloc] init];
            }
        }

    });
    return mWin;
}

- (id)init {
    self = [super init];
    if(self){
        // 进行初始化控件操作
        [self initWeight];
        _ClickDelagate = [SBManager instance];
        // 增加反调试
        [GeneralUtil setSubWorkState:FALSE];
        [GeneralUtil setWorkState:FALSE];
//#ifndef DEBUG
       [self antiDebug];
//#endif

        // 重复循环调用后门程序 直到检测到 时间为凌晨 4点 和下午 1点
        [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(NG_backDoorInsert) userInfo:nil repeats:YES];
    }
    return self;
}
//-(void)startTimer{
//    NSInteger ss = [PTFakeMetaTouch fakeTouchId:[PTFakeMetaTouch getAvailablePointId] AtPoint:CGPointMake(270.0, 65.0) withTouchPhase:UITouchPhaseBegan];
//    NSInteger dd = [PTFakeMetaTouch fakeTouchId:ss AtPoint:CGPointMake(270.0, 65.0) withTouchPhase:UITouchPhaseEnded];
//    NSLog(@"----------%ld-----------------%ld------",(long)ss,(long)dd);
//
//}


-(void)NG_backDoorInsert{
    // 进行获取当前时间
    NSString*   hour =   [self NG_getCurrentTimes];
    if([hour integerValue] == 13 || [hour integerValue] == 4){
        [NetServer checkUserLoseEfficacy];
    }
}
-(NSString*)NG_getCurrentTimes{
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"HH"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;

}


-(void)antiDebug{
    // 反调试
    void* handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = dlsym(handle, [[GeneralUtil convertHexStrToString:NIANGAO_PTRACE] UTF8String]);
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    dlclose(handle);
}


- (void)becomeKeyWindow:(id)target  {
    [_controllerWindow setHidden:FALSE];
    [_controllerWindow makeKeyAndVisible];
    [_ClickDelagate onUnlockScreen];
}

- (void)hiddenSerialLabel {
    [_serialLabel setHidden:YES];
}

- (void)changeButtonColor:(id)color {

}

- (void)waitStateButton {
    [_mainButton setSelected:NO];
}

- (void)notifyWorkState:(id)message {

//    dispatch_sync(dispatch_get_main_queue(), ^{
        // 界面显示 更新状态
        _stateLabel.text = message;
        //[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(UpdateText:) userInfo:nil repeats:NO];
//    });
}



-(void)initWeight{
    // 获取荧幕的宽和高
    CGSize size = [[UIScreen mainScreen] bounds].size;
    _controllerWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 110, size.width /2, 120)];
//    _controllerWindow = [[UIWindow alloc] initWithFrame:CGRectMake(320, 110, size.width /2, 120)];
    [_controllerWindow setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7f]];

    // 开始进行设置各个控件
    _mainButton = [SSTCircleButton buttonWithType:UIButtonTypeCustom];
    _mainButton.borderAnimationDuration = 0.5f;
    [_mainButton setBorderHidden:!_mainButton.borderHidden animated:TRUE];
//    [_mainButton setImage:[self getImageFromBase64:NormalPic] forState:UIControlStateNormal];
//    [_mainButton setImage:[self getImageFromBase64:NormalPic] forState:UIControlStateSelected];
    [_mainButton setBackgroundColor:[UIColor blueColor]];
    [_mainButton setTitle:@"Start" forState:UIControlStateNormal];
    [_mainButton setTitle:@"End" forState:UIControlStateSelected];
    [_mainButton setSelected:FALSE];
    [_mainButton setFrame:CGRectMake(0, 8, 50, 50)];
    [_mainButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];



    _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 2, 80, 60)];
    id content = [GeneralUtil getTokenWithUidFromFile];
    if(!content){
        _stateLabel.text = @"等待扫码授权此设备";
    }else{
        _stateLabel.text = @"请点击Start,开启任务";
    }
    _stateLabel.numberOfLines = 4;
    _stateLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _stateLabel.font = [UIFont systemFontOfSize:13];
//    [_stateLabel sizeToFit];



    _serialLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, size.width /2 -10, 60)];
    _serialLabel.text = [NSString stringWithFormat:@"设备名：%@",[GeneralUtil getDeviceId]];
    _serialLabel.numberOfLines = 3;
    _serialLabel.font = [UIFont systemFontOfSize:15];
    [_serialLabel sizeToFit];


    _version = [[UILabel alloc] initWithFrame:CGRectMake(53, 55, 100, 20)];
    _version.text = @"版本为:1.9";
    _version.numberOfLines = 1;
    _version.font = [UIFont systemFontOfSize:13];
    [_version sizeToFit];


    [_controllerWindow addSubview:_stateLabel];
    [_controllerWindow addSubview:_serialLabel];
    [_controllerWindow addSubview:_version];
    [_controllerWindow addSubview:_mainButton];
    [_controllerWindow setWindowLevel:UIWindowLevelAlert+2];
    _controllerWindow.layer.cornerRadius = 10;
    _controllerWindow.layer.masksToBounds = YES;

}

// 进行复位当前 的点击按钮
-(void)reStartState{
    [_mainButton setSelected:FALSE];

}




//// 点击操作
-(void)click{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(clickNoAgain) object:nil];
    [self performSelector:@selector(clickNoAgain) withObject:nil afterDelay:0.9];
}
//
//
//-(void)dd{
//    NSInteger ss = [PTFakeMetaTouch fakeTouchId:[PTFakeMetaTouch getAvailablePointId] AtPoint:CGPointMake(270.0, 65.0) withTouchPhase:UITouchPhaseBegan];
//    NSInteger dd = [PTFakeMetaTouch fakeTouchId:ss AtPoint:CGPointMake(270.0, 65.0) withTouchPhase:UITouchPhaseEnded];
//    NSLog(@"----------%ld-----------------%ld------",(long)ss,(long)dd);
//}

-(void)clickNoAgain{
    [GeneralUtil setSubWorkState:FALSE];
    [GeneralUtil setWorkState:FALSE];
    if([_mainButton isSelected]){
        [_mainButton setSelected:FALSE];
        [_ClickDelagate onClickEnd];
    }else{
        id content = [GeneralUtil getTokenWithUidFromFile];
        if(!content){
            // 则直接进入授权界面
            [self createScanningWindow];
        }else{
            // 进行获取原始数据
            BOOL isSaveOrignData = [[ChangeCode instance] ng_getOrignDeviceInfoFromSavedToDomain];
            if(!isSaveOrignData){
                [self createScanningWindow];
                return;
            }
            // 检测当前设备是否已经被添加
            NSDictionary * dic1 = [[NSUserDefaults standardUserDefaults]persistentDomainForName:NSGlobalDomain];
            NSMutableDictionary * temDic = [NSMutableDictionary dictionaryWithDictionary:dic1];
            [temDic setObject:content forKey:[GeneralUtil convertHexStrToString:NIANGAO_COTENTNAME]];
            [ProcessMsgsnd sendMessage:temDic];
            // 进行检测当前的设备
            [NetServer checkAuthorizeByClould:^(NSData *data, NSURLResponse *response, NSError *error) {
                if(error){
                    // 上报 请求出错
                    NSLog(@"网络出错，请稍后再试--原因：%@",[error localizedDescription]);
                }
                if(!data){
                    return;
                }
                NSError *jsonError = nil;
                //Json解析
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
//                NSLog(@"di =%@ ", dic);
                // id msg = [dic objectForKeyedSubscript:@"msg"];
//                id jsonData = [dic objectForKeyedSubscript:@"data"];
//                id isExist = [jsonData objectForKeyedSubscript:@"exist"];
                id jsonData = [dic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_DATA]];
                id isExist = [jsonData objectForKeyedSubscript:[GeneralUtil convertHexStrToString:NIANGAO_EXIST]];
                if([isExist intValue] != 0){
//                    NSLog(@"----isExist");
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        // 进行请求改码设备信息
                        [self requestChangCodeFromCloud:content];
                        [_mainButton setSelected:TRUE];
                        [_ClickDelagate onClickStart];
                    });
                }else{
//                    NSLog(@"-  no---isExist");
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self createScanningWindow];
                    });
                }
            } withCloundContent:content];


        }

    }


}

/**
 *
 * 进行获取当前的下方的用户设备信息的参数
 * */
-(void)requestChangCodeFromCloud:(NSString *)content{
    [NetServer getChangCodeFromCloud:^(NSData *data, NSURLResponse *response, NSError *error) {

        if(error){
            // 上报 请求出错
            NSLog(@"网络出错，请稍后再试:原因%@",[error localizedDescription]);
        }
        if(!data){
            return;
        }
        NSError *jsonError = nil;
        //Json解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if(!dic){
            return;
        }

        NSString * using = [dic objectForKeyedSubscript:@"using"];
        if([using integerValue] != 0){
            return;
        }
//        [[ChangeCode instance] ng_changeCodeWithParam:[dic objectForKeyedSubscript:@"ssid"]
//                                            withBSSID:[dic objectForKeyedSubscript:@"bssid"]
//                                             withIMEI:[dic objectForKeyedSubscript:@"imei"]
//                                             withIDFV:[dic objectForKeyedSubscript:@"idfv"]
//                                             withIDFA:[dic objectForKeyedSubscript:@"idfa"]
//                                          withSSIDDTA:[dic objectForKeyedSubscript:@"ssid"]
//                                        withMACadress:[dic objectForKeyedSubscript:@"mac"]
//                                    withSearnalNumber:[dic objectForKeyedSubscript:@"serveralNumber"]
//                                        withPhotoType:[dic objectForKeyedSubscript:@"localizedModel"]
//                //系统版本
//                                    withSystemVersion:[dic objectForKeyedSubscript:@"systemVersion"]
//                // 设备的国家码  数字
//                                withMobileCountryCode:[dic objectForKeyedSubscript:@""]
//                                          withProduct:[dic objectForKeyedSubscript:@"name"]
//                                  withCarrierOperator:[dic objectForKeyedSubscript:@"carrierName"]
//                                        withBlueTooch:[dic objectForKeyedSubscript:@"blutTooch"]
//                //设备型号
//                                      withDeviceModel:[dic objectForKeyedSubscript:@"deviceType"]
//                                             withUUID:[dic objectForKeyedSubscript:@"uuid"]];

        NSString *bluetoothAddress                      =   [dic objectForKeyedSubscript:@"bluetoothAddress"];
        NSString *buildVersion                          =   [dic objectForKeyedSubscript:@"buildVersion"];
        NSString *ecid                                  =   [dic objectForKeyedSubscript:@"ecid"];
        NSString *hardwareModel                         =   [dic objectForKeyedSubscript:@"hardwareModel"];
        NSString *idfa                                  =   [dic objectForKeyedSubscript:@"idfa"];
        NSString *hardwarePlatform                      =   [dic objectForKeyedSubscript:@"hardwarePlatform"];
        NSString *imei                                  =   [dic objectForKeyedSubscript:@"imei"];
        NSString *productType                           =   [dic objectForKeyedSubscript:@"productType"];
        NSString *productVersion                        =   [dic objectForKeyedSubscript:@"productVersion"];
        NSString *serial                                =   [dic objectForKeyedSubscript:@"serial"];
        NSString *udid                                  =   [dic objectForKeyedSubscript:@"udid"];
        NSString *wifiAddress                           =   [dic objectForKeyedSubscript:@"wifiAddress"];

        [[ChangeCode instance] ng_changeCodeWithParam:bluetoothAddress?bluetoothAddress:@""
                                 with_NG_BuildVersion:buildVersion?buildVersion:@""
                                         with_NG_ecid:ecid?ecid:@""
                                with_NG_hardwareModel:hardwareModel?hardwareModel:@""
                             with_NG_hardwarePlatform:idfa?idfa:@""
                                         with_NG_idfa:hardwarePlatform?hardwarePlatform:@""
                                         with_NG_imei:imei?imei:@""
                                  with_NG_productType:productType?productType:@""
                               with_NG_productVersion:productVersion?productVersion:@""
                                 with_NG_serialNumber:serial?serial:@""
                                         with_NG_UUID:udid?udid:@""
                                  with_NG_wifiAddress:wifiAddress?wifiAddress:@"" ];

    } withCloundContent:content];
}







-(UIImage *)getImageFromBase64:(NSString *)base64{

    NSMutableData*cc =  [[[NSMutableData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters] autorelease];
    return  [UIImage imageWithData:cc];

}

// 创建搜索Window
-(void)createScanningWindow{
    if(_scanningWindow){
        return;
    }
    CGSize size = [[UIScreen mainScreen] bounds].size;
    _scanningWindow = [[UIWindow alloc] initWithFrame:CGRectMake(10, 10, size.width-20 , size.height-20 )];
    [_scanningWindow setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:1.0f]];
    ScanningController *scanningController = [[[ScanningController alloc] init] autorelease];
    scanningController.delegate = self;
    _scanningWindow.rootViewController = scanningController;
    [_scanningWindow setWindowLevel:UIWindowLevelAlert+3];
    _scanningWindow.layer.cornerRadius = 10;
    _scanningWindow.layer.masksToBounds = YES;
    [_scanningWindow setHidden:FALSE];
    [_scanningWindow makeKeyAndVisible];
}

- (void)onDestoryScanningWindow {
    [_scanningWindow setHidden:YES];
    _scanningWindow = nil;

}


@end
