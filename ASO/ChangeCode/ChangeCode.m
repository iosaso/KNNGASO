//
// Created by admin on 2017/12/7.
//

#import "ChangeCode.h"
#import "../GeneralUtil.h"
#import <substrate.h>
#import <IOKit/IOKit.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import "CoreTelephony.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import <sys/sysctl.h>
#import <AdSupport/AdSupport.h>
#import <Security/Security.h>
#import <CoreLocation/CoreLocation.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "../ProcessMsgsnd.h"
#import "capstone.h"
#import "UIDevice+Extensions.h"
#import "../Constant.h"


char* FakeTime = NULL;




@implementation ChangeCode {

}

NSString *NG_Product = nil;
// 所处国家
NSString *NG_isoCountryCode = nil;

NSString *NG_SSID = nil;

NSString *NG_BSSID = nil;
//序列号
NSString *NG_searnalNumber = nil;
//MAC地址
NSString *NG_macAdress =nil;
//IDFA
NSString *NG_IDFA =nil;
//IDFV
NSString *NG_IDFV =nil;
//IMEI
NSString *NG_IMEI =nil;
//UDID
NSString *NG_UDID =nil;
//设备名
NSString *NG_deviceName =nil;
//运营商
NSString *NG_carrierOperator =nil;
//系统版本
NSString *NG_systemVersion =nil;
//手机种类
NSString *NG_phoneType =nil;
//手机国家码
NSString *NG_mobileCountryCode = nil;  // 默认  460
//手机网络码
NSString *NG_mobileNetworkCode =nil;   //默认 11
//SSIDDATA
NSString *NG_SSIDDATA =nil;
//蓝牙码
NSString *NG_BLUETOOTH =nil;
// 设备型号
NSString *NG_UNITTYPE =nil;
// 设备地域
NSString *NG_DEVICE_LOCATION =nil;
// 设备名
NSString *NG_DEVICE_NAME =nil;
// 设备单独地域
NSString *NG_DEVICE_SINGLENAME =nil;
// 设备硬件型号 HardwarePlatform
NSString *NG_DEVICE_HardwarePlatform =nil;
// 设备硬件模型
NSString *NG_DEVICE_HardwareModel =nil;
// 设备生产版本 ProductType
NSString *NG_DEVICE_ProductType =nil;
// ecid  处理器型号
NSString *NG_DEVICE_ecidData =nil;

// 进行获取当前的设备内容
NSString *NG_systemVersionWithNumber = nil;
NSString *NG_systemVersionWithNumber_two =nil;
NSString *NG_systemVersionWithEnglist = nil; // ng_vc








+ (ChangeCode *)instance {
    static ChangeCode *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

/**
 *
 * 进行改码一一对应的写入
 * */
- (void)ng_changeCodeWithParam:(NSString *)NG_SSID
                     withBSSID:(NSString *)NG_BSSID
                      withIMEI:(NSString *)NG_IMEI
                      withIDFV:(NSString *)NG_IDFV
                      withIDFA:(NSString *)NG_IDFA
                   withSSIDDTA:(NSString *)NG_SSIDDATA
                 withMACadress:(NSString *)NG_MAC
             withSearnalNumber:(NSString *)NG_SEARNALNUMBER
                 withPhotoType:(NSString *)NG_PHOTO_TYPE
             withSystemVersion:(NSString *)NG_systemVersion
         withMobileCountryCode:(NSString *)NG_countryCode
                   withProduct:(NSString *)NG_Product
           withCarrierOperator:(NSString *)NG_carrierOperator
                 withBlueTooch:(NSString *)NG_BLUETOOCH
               withDeviceModel:(NSString *)NG_DEVICEMODEL
                      withUUID:(NSString *)NG_UUID

                    {

    //将对应的数据传递到domain中 进行保存操作
    NSDictionary * dic1 = [[NSUserDefaults standardUserDefaults]persistentDomainForName:NSGlobalDomain];
    NSMutableDictionary * temDic = [NSMutableDictionary dictionaryWithDictionary:dic1];
    // 进行遍历给对应的字典
     if(NG_MAC){
         [temDic setObject:NG_MAC forKey:@"NG_MAC_DATA"];
     }else{
         [temDic setObject:@"" forKey:@"NG_MAC_DATA"];
     }
     if(NG_BLUETOOCH){
         [temDic setObject:NG_BLUETOOCH forKey:@"NG_BLUETOOCH_DATA"];
     }else {
         [temDic setObject:@"" forKey:@"NG_BLUETOOCH_DATA"];
     }
     if(NG_SSID){
         [temDic setObject:NG_SSID forKey:@"NG_SSID_DATA"];
     }else {
         [temDic setObject:@"" forKey:@"NG_SSID_DATA"];
     }
    if(NG_BSSID){
        [temDic setObject:NG_BSSID forKey:@"NG_BSSID_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_BSSID_DATA"];
    } if(NG_IDFV){
        [temDic setObject:NG_IDFV forKey:@"NG_IDFV_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_IDFV_DATA"];
    } if(NG_IMEI){
        [temDic setObject:NG_IMEI forKey:@"NG_IMEI_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_IMEI_DATA"];
    } if(NG_IDFA){
        [temDic setObject:NG_IDFA forKey:@"NG_IDFA_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_IDFA_DATA"];
    }if(NG_SSIDDATA){
        [temDic setObject:NG_SSIDDATA forKey:@"NG_SSIDDATA_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_SSIDDATA_DATA"];
    }if(NG_SEARNALNUMBER){
        [temDic setObject:NG_SEARNALNUMBER forKey:@"NG_SEARNALNUMBER_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_SEARNALNUMBER_DATA"];
    }if(NG_PHOTO_TYPE){
        [temDic setObject:NG_PHOTO_TYPE forKey:@"NG_PHOTO_TYPE_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_PHOTO_TYPE_DATA"];
    }if(NG_systemVersion){
        [temDic setObject:NG_systemVersion forKey:@"NG_systemVersion_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_systemVersion_DATA"];
    }if(NG_countryCode){
        [temDic setObject:NG_countryCode forKey:@"NG_countryCode_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_countryCode_DATA"];
    }if(NG_Product){
        [temDic setObject:NG_countryCode forKey:@"NG_Product_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_Product_DATA"];
    }if(NG_carrierOperator){
        [temDic setObject:NG_carrierOperator forKey:@"NG_carrierOperator_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_carrierOperator_DATA"];
    }if(NG_DEVICEMODEL){
        [temDic setObject:NG_DEVICEMODEL forKey:@"NG_DEVICETYPE_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_DEVICETYPE_DATA"];
    }if(NG_UUID){
        [temDic setObject:NG_UUID forKey:@"NG_UUID_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_UUID_DATA"];
    }
     [ProcessMsgsnd sendMessage:temDic];
}



-(void)ng_changeCodeWithParam:(NSString *)NG_BLUADRESS
with_NG_BuildVersion:(NSString *)NG_BIILD_VERSION
        with_NG_ecid:(NSString *)NG_ECID
        with_NG_hardwareModel:(NSString *)NG_HARDWARE_MODEL
        with_NG_hardwarePlatform:(NSString *)NG_HAEDWARE_PLATFORM
        with_NG_idfa:(NSString *)NG_IDFA
        with_NG_imei:(NSString *)NG_IMEI
        with_NG_productType:(NSString *)NG_PEODUCt_TYPE
        with_NG_productVersion:(NSString *)NG_PEODUCt_VERSION
        with_NG_serialNumber:(NSString *)NG_SERIALNUMBER
        with_NG_UUID:(NSString *)NG_UUID
        with_NG_wifiAddress:(NSString *)NG_WIFIADRESS{
    //将对应的数据传递到domain中 进行保存操作
    NSDictionary * dic1 = [[NSUserDefaults standardUserDefaults]persistentDomainForName:NSGlobalDomain];
    NSMutableDictionary * temDic = [NSMutableDictionary dictionaryWithDictionary:dic1];
    // 进行遍历给对应的字典
    if(NG_WIFIADRESS){
        [temDic setObject:NG_WIFIADRESS forKey:@"NG_MAC_DATA"];
    }else{
        [temDic setObject:@"" forKey:@"NG_MAC_DATA"];
    }
    if(NG_BLUADRESS){
        [temDic setObject:NG_BLUADRESS forKey:@"NG_BLUETOOCH_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_BLUETOOCH_DATA"];
    }
    if(NG_IMEI){
        [temDic setObject:NG_IMEI forKey:@"NG_IMEI_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_IMEI_DATA"];
    }
    if(NG_IDFA){
        [temDic setObject:NG_IDFA forKey:@"NG_IDFA_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_IDFA_DATA"];
    }
    if(NG_SERIALNUMBER){
        [temDic setObject:NG_SERIALNUMBER forKey:@"NG_SEARNALNUMBER_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_SEARNALNUMBER_DATA"];
    }
    if(NG_PEODUCt_VERSION){
        [temDic setObject:NG_PEODUCt_VERSION forKey:@"NG_systemVersion_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_systemVersion_DATA"];
    }

    if(NG_BIILD_VERSION){
        [temDic setObject:NG_BIILD_VERSION forKey:@"NG_BUILD_VERSION"];
    }else {
        [temDic setObject:@"" forKey:@"NG_BUILD_VERSION"];
    }

    if(NG_PEODUCt_TYPE){
        [temDic setObject:NG_PEODUCt_TYPE forKey:@"NG_PRODUCT_TYPE_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_PRODUCT_TYPE_DATA"];
    }
    if(NG_HAEDWARE_PLATFORM){
        [temDic setObject:NG_HAEDWARE_PLATFORM forKey:@"NG_HARDWARE_PATFORM_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_HARDWARE_PATFORM_DATA"];
    }
    if(NG_HARDWARE_MODEL){
        [temDic setObject:NG_HARDWARE_MODEL forKey:@"NG_HARDWARE_MODEL_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_HARDWARE_MODEL_DATA"];
    }
    if(NG_ECID){
        [temDic setObject:NG_ECID forKey:@"NG_ECID_DATA"];
    }else {
        [temDic setObject:@"" forKey:@"NG_ECID_DATA"];
    }
    [ProcessMsgsnd sendMessage:temDic];

}


/**
 * 将domain中存储的参数，设置为当前需要改码的内容中
 *
 * */
- (void)ng_getDomainUserSettingsParams {
    id dic                          = [ProcessMsgsnd getMessage];
    if(!dic){
        return;
    }
    NSString *SSID                  = [dic objectForKeyedSubscript:@"NG_SSID_DATA"];
    NSString *BSSID                 = [dic objectForKeyedSubscript:@"NG_BSSID_DATA"];
    NSString *IMEI                  = [dic objectForKeyedSubscript:@"NG_IMEI_DATA"];
    NSString *IDFV                  = [dic objectForKeyedSubscript:@"NG_IDFV_DATA"];
    NSString *IDFA                  = [dic objectForKeyedSubscript:@"NG_IDFA_DATA"];
    NSString *SSIDDATA              = [dic objectForKeyedSubscript:@"NG_SSIDDATA_DATA"];
    NSString *MAC                   = [dic objectForKeyedSubscript:@"NG_MAC_DATA"];
    NSString *SEARNALNUMBER         = [dic objectForKeyedSubscript:@"NG_SEARNALNUMBER_DATA"];
    NSString *PHOTO_TYPE            = [dic objectForKeyedSubscript:@"NG_PHOTO_TYPE_DATA"];
    NSString *systemVersion         = [dic objectForKeyedSubscript:@"NG_systemVersion_DATA"];
    NSString *countryCode           = [dic objectForKeyedSubscript:@"NG_countryCode_DATA"];
    NSString *Product               = [dic objectForKeyedSubscript:@"NG_Product_DATA"];
    NSString *carrierOperator       = [dic objectForKeyedSubscript:@"NG_carrierOperator_DATA"];
    NSString *BLUETOOCH             = [dic objectForKeyedSubscript:@"NG_BLUETOOCH_DATA"];
    NSString *DeviceType            = [dic objectForKeyedSubscript:@"NG_DEVICETYPE_DATA"];
    NSString *UUID                  = [dic objectForKeyedSubscript:@"NG_UUID_DATA"];
    NSString *buildVersion          = [dic objectForKeyedSubscript:@"NG_BUILD_VERSION"];
    NSString *productType           = [dic objectForKeyedSubscript:@"NG_PRODUCT_TYPE_DATA"];
    NSString *hardwarePatform       = [dic objectForKeyedSubscript:@"NG_HARDWARE_PATFORM_DATA"];
    NSString *hardwareModel         = [dic objectForKeyedSubscript:@"NG_HARDWARE_MODEL_DATA"];
    NSString *ecidData              = [dic objectForKeyedSubscript:@"NG_ECID_DATA"];


    if(![GeneralUtil isBlankString:buildVersion]){
        NG_systemVersionWithEnglist = buildVersion;
    }
    if(![GeneralUtil isBlankString:productType]){
        NG_DEVICE_ProductType = productType;
    }
    if(![GeneralUtil isBlankString:hardwarePatform]){
        NG_DEVICE_HardwarePlatform = hardwarePatform;
    }
    if(![GeneralUtil isBlankString:hardwareModel]){
        NG_DEVICE_HardwareModel = hardwareModel;
    }
    if(![GeneralUtil isBlankString:ecidData]){
        NG_DEVICE_ecidData = ecidData;
    }
    if([GeneralUtil isBlankString:UUID]){
        NG_UDID =  [dic objectForKeyedSubscript:@"ng_UUID"];
    }else{
        NG_UDID = UUID;
    }
    //[GeneralUtil isBlankString:DeviceType]
    if([GeneralUtil isBlankString:DeviceType]){
        NG_UNITTYPE =  [dic objectForKeyedSubscript:@"ng_numberModel"];
    }else{
        NG_UNITTYPE = nil;
    }
    if([GeneralUtil isBlankString:BLUETOOCH]){
        NG_BLUETOOTH =  [dic objectForKeyedSubscript:@"ng_BluetoothAddress"];
    }else{
        NG_BLUETOOTH = BLUETOOCH;
    }
    if([GeneralUtil isBlankString:SSID]){
        // 如果未null的话 则将原机型替换
        NG_SSID =  [dic objectForKeyedSubscript:@"ng_SSID"];
    }else{
        NG_SSID  = SSID;
    }
    if([GeneralUtil isBlankString:BSSID]){
        // 如果未null的话 则将原机型替换
        NG_BSSID =  [dic objectForKeyedSubscript:@"ng_BSSID"];
    }else{
        NG_BSSID  = BSSID;
    }
    if([GeneralUtil isBlankString:IMEI]){
        // 如果未null的话 则将原机型替换
        NG_IMEI =  [dic objectForKeyedSubscript:@"ng_Imei"];
    }else{
        NG_IMEI  = IMEI;
    }
    if([GeneralUtil isBlankString:IDFV]){
        // 如果未null的话 则将原机型替换
        NG_IDFV =  [dic objectForKeyedSubscript:@"ng_identifierForVendor"];
    }else{
        NG_IDFV  = IDFV;
    }
    if([GeneralUtil isBlankString:SSIDDATA]){
        // 如果未null的话 则将原机型替换
        NG_SSIDDATA =  [dic objectForKeyedSubscript:@"ng_SSIDDATA"];
    }else{
        NG_SSIDDATA  = SSIDDATA;
    }
    if([GeneralUtil isBlankString:IDFA]){
        // 如果未null的话 则将原机型替换
        NG_IDFA =  [dic objectForKeyedSubscript:@"ng_advertisingIdentifier"];
    }else{
        NG_IDFA  = IDFA;
    }if([GeneralUtil isBlankString:MAC]){
        // 如果未null的话 则将原机型替换
        NG_macAdress =  [dic objectForKeyedSubscript:@"ng_macaddress"];
    }else{
        NG_macAdress  = MAC;
    }
    if([GeneralUtil isBlankString:SEARNALNUMBER]){
        // 如果未null的话 则将原机型替换
        NG_searnalNumber =  [dic objectForKeyedSubscript:@"ng_ServeralNumber"];
    }else{
        NG_searnalNumber  = SEARNALNUMBER;
    }
    if([GeneralUtil isBlankString:PHOTO_TYPE]){
        // 如果未null的话 则将原机型替换
        NG_phoneType =  [dic objectForKeyedSubscript:@"ng_advertisingIdentifier"];
    }else{
        NG_phoneType  = PHOTO_TYPE;
    }
    if([GeneralUtil isBlankString:systemVersion]){
        // 如果未null的话 则将原机型替换
        NG_systemVersion =  [dic objectForKeyedSubscript:@"ng_systemVersion"];
    }else{
        NG_systemVersion  = systemVersion;
    }
    if([GeneralUtil isBlankString:countryCode]){
        // 如果未null的话 则将原机型替换
        NG_isoCountryCode =  [dic objectForKeyedSubscript:@"ng_isoCountryCode"];
    }else{
        NG_isoCountryCode  = countryCode;
    }

    if([GeneralUtil isBlankString:Product]){
        // 如果未null的话 则将原机型替换
        NG_Product =  [dic objectForKeyedSubscript:@"ng_model"];
    }else{
        NG_Product  = Product;
    }
    if([GeneralUtil isBlankString:carrierOperator]){
        // 如果未null的话 则将原机型替换
        NG_carrierOperator =  [dic objectForKeyedSubscript:@"ng_carrierName"];
    }else{
        NG_carrierOperator  = carrierOperator;
    }

}

/**
 *
 * 保存设备原始码
 * */
- (void)ng_saveOrignDeviceInfo {
    // 保存前置空  避免内存中存在上次改码后的设备信息
    NG_Product = nil;
    NG_isoCountryCode = nil;
    NG_SSID = nil;
    NG_BSSID = nil;
    NG_searnalNumber = nil;
    NG_macAdress =nil;
    NG_IDFA =nil;
    NG_IDFV =nil;
    NG_IMEI =nil;
    NG_UDID =nil;
    NG_deviceName =nil;
    NG_carrierOperator =nil;
    NG_systemVersion =nil;
    NG_phoneType =nil;
    NG_mobileCountryCode = nil;  // 默认  460
    NG_mobileNetworkCode =nil;   //默认 11
    NG_SSIDDATA =nil;
    NG_BLUETOOTH =nil;
    NG_UNITTYPE =nil;
    NG_systemVersionWithNumber = nil;
    NG_systemVersionWithNumber_two =nil;
    NG_systemVersionWithEnglist = nil; // ng_vc
    // 进行保存初始化的数据
    UIDevice* device                                = [UIDevice currentDevice];
    NSString * model                                = [device model];
    NSString * localizedModel                       = [device localizedModel];
    NSString * systemVersion                        = [device systemVersion];
    NSString * name                                 = [device name];
    NSString * identifierForVendor                  = [[device identifierForVendor] UUIDString];
    NSString * advertisingIdentifier                = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    CTTelephonyNetworkInfo * ctTelephonyNetworkInfo = [[[CTTelephonyNetworkInfo alloc] init] autorelease];
    CTCarrier* ctCarrier                            = [ctTelephonyNetworkInfo subscriberCellularProvider];
    NSString * carrierName                          = [ctCarrier carrierName];
    NSString * mobileCountryCode                    = [ctCarrier mobileCountryCode]?[ctCarrier mobileCountryCode]:@"";
    NSString * mobileNetworkCode                    = [ctCarrier mobileNetworkCode]?[ctCarrier mobileNetworkCode]:@"";
    NSString * isoCountryCode                       = [ctCarrier isoCountryCode]?[ctCarrier isoCountryCode]:@"";
    NSString * currentRadioAccessTechnology         = [ctTelephonyNetworkInfo currentRadioAccessTechnology]?[ctTelephonyNetworkInfo currentRadioAccessTechnology]:@"";
    NSString * macaddress                           = [self macaddress];
    NSString * ServeralNumber                       = [GeneralUtil getServeral];
    NSString * UUID                                 = [GeneralUtil getUUID];
    NSString *BSSID = nil;
    NSString *SSID = nil;
    NSString *SSIDDATA = nil;
    // 获取BlueTooch 地址
    void *gestalt = dlopen("/usr/lib/libMobileGestalt.dylib", RTLD_GLOBAL | RTLD_LAZY);
    CFStringRef (*MGCopyAnswer)(CFStringRef) = (CFStringRef (*)(CFStringRef))(dlsym(gestalt, "MGCopyAnswer"));
    id blAddress                        =   CFBridgingRelease( MGCopyAnswer(CFSTR("BluetoothAddress")));
    id MN                               =   CFBridgingRelease( MGCopyAnswer(CFSTR("ModelNumber")));
    id RIF                              =   CFBridgingRelease( MGCopyAnswer(CFSTR("RegionInfo")));
    id iMEI                             =   CFBridgingRelease( MGCopyAnswer(CFSTR("InternationalMobileEquipmentIdentity")));
    NSString *BluetoothAddress          =   blAddress?blAddress:@"";
    NSString *ModelNumber               =   MN?MN:@"";
    NSString *RegionInfo                =   RIF?RIF:@"";
    // IMEI
    NSString *IMEI                      =   iMEI?iMEI:@"";
    // 进行获取当前的设备内容
    NSString *numberModel               =   [ModelNumber stringByAppendingString:RegionInfo];

    NSArray *ifs = (__bridge  id)CNCopySupportedInterfaces();

    for (NSString *ifname in ifs) {
        NSDictionary *info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
        if (info[@"BSSID"])
        {
            BSSID = info[@"BSSID"];

        }
        if (info[@"SSID"])
        {
            SSID = info[@"SSID"];

        }
        if (info[@"SSIDDATA"])
        {
//            SSIDDATA = info[@"SSIDDATA"];
            // 需要转化为NSData
            SSIDDATA = [[[NSString alloc] initWithData:info[@"SSIDDATA"] encoding:NSUTF8StringEncoding] autorelease];

        }
    }
//    NSLog(@"-------model = %@\n"
//            "-------localizedModel = %@\n"
//            "-------systemVersion = %@\n"
//            "-------name = %@\n"
//            "-------identifierForVendor = %@\n"
//            "-------advertisingIdentifier = %@\n"
//            "-------carrierName = %@\n"
//            "-------mobileCountryCode = %@\n"
//            "-------mobileNetworkCode = %@\n"
//            "-------isoCountryCode = %@\n"
//            "-------currentRadioAccessTechnology = %@\n"
//            "-------BSSID = %@\n"
//            "-------SSID = %@\n"
//            "-------SSIDDATA = %@\n"
//            "-------ServeralNumber = %@\n"
//            "-------UUID = %@\n"
//            "-------macaddress = %@\n"
//
//                    ,
//            model,localizedModel,systemVersion,name,identifierForVendor
//            ,advertisingIdentifier,carrierName,mobileCountryCode
//            ,mobileNetworkCode,isoCountryCode,currentRadioAccessTechnology,BSSID,SSID,SSIDDATA,ServeralNumber,UUID,macaddress);
    // 进行保存
    NSString *jsonString = nil;
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileDicPath = [docPath stringByAppendingPathComponent:[GeneralUtil convertHexStrToString:NG_SAVE_FileName]];
    NSDictionary *dic = @{
            @"ng_model":model,
            @"ng_localizedModel":localizedModel,
            @"ng_systemVersion":systemVersion,
            @"ng_name":name,
            @"ng_identifierForVendor":identifierForVendor,
            @"ng_advertisingIdentifier":advertisingIdentifier,
            @"ng_carrierName":carrierName,
            @"ng_mobileCountryCode":mobileCountryCode,
            @"ng_mobileNetworkCode":mobileNetworkCode,
            @"ng_isoCountryCode":isoCountryCode,
            @"ng_currentRadioAccessTechnology":currentRadioAccessTechnology,
            @"ng_macaddress":macaddress,
            @"ng_ServeralNumber":ServeralNumber,
            @"ng_UUID":UUID,
            @"ng_SSID":SSID,
            @"ng_SSIDDATA":SSIDDATA,
            @"ng_BSSID":BSSID,
            @"ng_BluetoothAddress":BluetoothAddress,
            @"ng_Imei":IMEI,
            @"ng_numberModel":numberModel,
    };


    NSError *error;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if(!jsonData){
        NSLog(@"----------ERROR------");
    } else{
        jsonString = [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
    }
    //将其转化为加密后的字符串
    NSString *aesString = [GeneralUtil AES128Encryption:[GeneralUtil convertHexStrToString:NG_SAVE_KEY] withContent:jsonString];
    // 进行请求 增加设备接口
    NSError *errorFile;
    // 将加密字符写入时执行的方法
   [aesString writeToFile:fileDicPath atomically:YES encoding:NSUTF8StringEncoding error:&errorFile];
}

/**
 *
 * 从domain中获取原始码
 * */
- (BOOL)ng_getOrignDeviceInfoFromSavedToDomain {

    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileDicPath = [docPath stringByAppendingPathComponent:[GeneralUtil convertHexStrToString:NG_SAVE_FileName]];
    // 进行读取文件路径
    NSError *errorFile;
    NSString * fileContent = [NSString stringWithContentsOfFile:fileDicPath encoding:NSUTF8StringEncoding error:&errorFile];
    if(!fileContent){
        return FALSE;
    }
    NSString * jsonString = [GeneralUtil AES128Deciphering:[GeneralUtil convertHexStrToString:NG_SAVE_KEY] withContent:fileContent];
    if(!jsonString){
        return FALSE;
    }

    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if(!dic){
        return FALSE;
    }
    //将对应的数据传递到domain中 进行保存操作
    NSDictionary * dic1 = [[NSUserDefaults standardUserDefaults]persistentDomainForName:NSGlobalDomain];
//    NSDictionary * temDic = [NSDictionary dictionaryWithDictionary:dic1];
    NSMutableDictionary * temDic = [NSMutableDictionary dictionaryWithDictionary:dic1];

    // 进行遍历给对应的字典
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [temDic setObject:obj?obj:@"" forKey:key];
    }];
    [ProcessMsgsnd sendMessage:temDic];
    return TRUE;
}


- (NSDictionary *)ng_getOrignDataSets {

    NSError *errorFile;
    NSString * fileContent = [NSString stringWithContentsOfFile:[GeneralUtil convertHexStrToString:NG_SAVE_File] encoding:NSUTF8StringEncoding error:&errorFile];
    if(!fileContent){
        return nil;
    }
    NSString * jsonString = [GeneralUtil AES128Deciphering:[GeneralUtil convertHexStrToString:NG_SAVE_KEY] withContent:fileContent];
    if(!jsonString){
        return nil;
    }

    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if(!dic){
        return nil;
    }
    return dic;
}


- (NSString *) macaddress
{

    int         mib[6];
    size_t       len;
    char        *buf;
    unsigned char    *ptr;
    struct if_msghdr  *ifm;
    struct sockaddr_dl *sdl;

    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;

    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }

    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }

    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }

    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];

    free(buf);

    return [outstring uppercaseString];
}

//进行截取当前的设备名 ME335
-(NSString *)InterceptDeviceWithName:(NSString *)name{
    if([GeneralUtil isBlankString:name]){
        return nil;
    }
    return [name substringWithRange:NSMakeRange(0, 5) ];;
}
// 进行截取出当前的设备地域 eg: J/A
-(NSString *)InterceptDeviceWithLocation:(NSString *)name{
    if([GeneralUtil isBlankString:name]){
        return nil;
    }
    return [name substringWithRange:NSMakeRange(5, [name length] - 5)];
}
// 进行获取当前的额设备 地区 eg: J
-(NSString *)InterceptDeviceWithSingleLocation:(NSString *)name{
    if([GeneralUtil isBlankString:name]){
        return nil;
    }
    return [name substringWithRange:NSMakeRange([name length] -3 ,1)];
}


//// ***********************************************以下为改码内容*****************************************************************


//char* FakeTime = NULL;


CFTypeRef
*(*old_IORegistryEntryCreateCFProperties)(
        io_registry_entry_t	entry,
        CFStringRef		key,
        CFAllocatorRef		allocator,
        IOOptionBits		options );


CFTypeRef *new_IORegistryEntryCreateCFProperties(
        io_registry_entry_t	entry,
        CFStringRef		key,
        CFAllocatorRef		allocator,
        IOOptionBits		options ){
    NSString *type = (__bridge NSString *)key;


    if(NG_searnalNumber && [type isEqualToString:@"IOPlatformSerialNumber"]){

        return (__bridge CFTypeRef *)NG_searnalNumber;
    }
    if(NG_IMEI && [type isEqualToString:@"device-imei"]){

        return (__bridge CFTypeRef *)NG_IMEI;
    }
    return old_IORegistryEntryCreateCFProperties(entry,key,allocator,options);
}

CFTypeRef
*(*old_IORegistryEntrySearchCFProperty)(
        io_registry_entry_t	entry,
        const io_name_t		plane,
        CFStringRef		key,
        CFAllocatorRef		allocator,
        IOOptionBits		options );
CFTypeRef
*new_IORegistryEntrySearchCFProperty(
        io_registry_entry_t	entry,
        const io_name_t		plane,
        CFStringRef		key,
        CFAllocatorRef		allocator,
        IOOptionBits		options ){

    NSString *type = (__bridge NSString *)key;
//    id ss = (__bridge id) old_IORegistryEntrySearchCFProperty(entry,plane,key,allocator,options);
//    NSLog(@"------------------------ <<<<new_IORegistryEntrySearchCFProperty>>>>--\n----------------<<< %@  >>>-------------\n---------------------<<<< %@ >>>>----------", type,ss);
//    NSLog(@"-----new_IORegistryEntrySearchCFProperty--------<<<< MAC >>>--------------- = %@", [[NSString alloc] initWithData:ss encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]);


    if(NG_searnalNumber &&[type isEqualToString:@"serial-number"]){

        return (__bridge CFTypeRef *)[NG_searnalNumber dataUsingEncoding:NSUTF8StringEncoding];
    }
    if(NG_IMEI &&[type isEqualToString:@"device-imei"]){

        return (__bridge CFTypeRef *)[NG_IMEI dataUsingEncoding:NSUTF8StringEncoding];
    }
// product-id   nsdata类型

// software-behavior


    return old_IORegistryEntrySearchCFProperty(entry,plane,key,allocator,options);
}

CFDictionaryRef __nullable
*(*old_CNCopyCurrentNetworkInfo)	(CFStringRef interfaceName)	__OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_1);


NSString *dd =nil;

CFDictionaryRef __nullable
*new_CNCopyCurrentNetworkInfo	(CFStringRef interfaceName)	__OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_1){
    // 修改SSID
    if(NG_SSID && NG_BSSID && NG_SSIDDATA){
        return (__bridge CFDictionaryRef *) [[@{@"SSID": NG_SSID, @"BSSID": NG_BSSID, @"SSIDDATA": [NG_SSIDDATA dataUsingEncoding:NSUTF8StringEncoding]} copy] autorelease];
    }
    return old_CNCopyCurrentNetworkInfo(interfaceName);
}

CFArrayRef __nullable
*(*old_CNCopySupportedInterfaces)	(void)			__OSX_AVAILABLE_STARTING(__MAC_10_8,__IPHONE_4_1);


CFArrayRef __nullable
*new_CNCopySupportedInterfaces	(void)			__OSX_AVAILABLE_STARTING(__MAC_10_8,__IPHONE_4_1){
    return old_CNCopySupportedInterfaces();
}

void *(*old_CTServerConnectionCopyMobileIdentity)(struct CTResult *, struct CTServerConnection *, NSString **);

void *new_CTServerConnectionCopyMobileIdentity(struct CTResult *result, struct CTServerConnection *connection, NSString **imi){
     old_CTServerConnectionCopyMobileIdentity(result,connection,imi);
    if(NG_IMEI){
        *imi = NG_IMEI;
        return  NG_IMEI;

    }

    return old_CTServerConnectionCopyMobileIdentity(result,connection,imi);

}



int	 *(*old_sysctlnametomib)(const char *, int *, size_t *);

int	*new_sysctlnametomib(const char *a, int *b, size_t *c){
    return old_sysctlnametomib(a,b,c);
}





int *(*old_uname)(struct utsname *);

int *new_uname(struct utsname *name){
    // 进行更改相关内容
    int* a = old_uname(name);

    if(NG_deviceName){
        strcpy(name->nodename, [NG_deviceName UTF8String]);
    }
    if(NG_phoneType){
        strcpy(name->machine, [NG_phoneType UTF8String]);
    }
    if(NG_systemVersionWithNumber_two){
        NSString * version = [NSString stringWithFormat:@"Darwin Kernel Version %@: Fri Feb 19 13:54:53 PST 2016; root:xnu-3248.41.4~28/RELEASE_ARM64_S5L8960X",NG_systemVersionWithNumber_two];
        strcpy(name->version, [version UTF8String]);
        strcpy(name->release, [NG_systemVersionWithNumber_two UTF8String]);
    }
    return a;

}

//
//int	 *(*old_sysctl)(int *, u_int, void *, size_t *, void *, size_t);
//int	*new_sysctl(int *a, u_int b, void * c, size_t * d, void * e, size_t f){
//    //[[NSString alloc] initWithCString:(const char*)char_arrayencoding:NSASCIIStringEncoding]
////    NSLog(@"----------------------------new_sysctl------------------------------------%@---",[NSString stringWithFormat:@"%s", (char*)c]);
//    const char * systemVersion;
//    NSString *device = nil;
//    if(!NG_IMEI ){
//        return  old_sysctl(a,b,c,d,e,f);
//    }
//
//    if(b != 2){
//        return  old_sysctl(a,b,c,d,e,f);
//    }
//    if(*a == 1){
//        if(a[1] == 65){
//            device = NG_IMEI;
//
//        }else{
//            if(a[1] == 2){
//                device = NG_IMEI;
//
//            }
//            else{
//                if(a[1] != 10){
//                    return  old_sysctl(a,2,c,d,e,f);
//                }
//                device = NG_IMEI;
//            }
//
//        }
//        systemVersion = [device UTF8String];
//        if(!c){
//            *d = strlen(systemVersion) +1;
//            return 0;
//        }
//        if(*d){
//            strncpy(c, systemVersion, *d);
//        }
//        return  old_sysctl(a,2,c,d,e,f);
//
//    }
//    if(*a != 6){
//        return  old_sysctl(a,2,c,d,e,f);
//
//    }
//    if(a[1] == 2){
//        systemVersion = [NG_IMEI UTF8String];
//    }
//    if(a[1] != 1){
//        return  old_sysctl(a,2,c,d,e,f);
//    }
//
//    systemVersion = [NG_IMEI UTF8String];
//    if(!c){
//        *d = strlen(systemVersion) + 1;
//        return 0;
//    }
//    if(*d){
//        strncpy(c, systemVersion, *d);
//        return 0;
//    }
//    return old_sysctl(a,b,c,d,e,f);
//}



//
//int	 *(*old_sysctlbyname)(const char *, void *, size_t *, void *, size_t);
//int	*new_sysctlbyname(const char * a, void *b, size_t *c, void *d, size_t e){
////    NSLog(@"------------------------------《new_sysctlbyname》-----------------------%@-- ",[[[NSString alloc] initWithUTF8String:a] autorelease]);
////    NSLog(@"----------------------------《new_sysctlbyname》------------------------------------%ld---",(long )*c);
//    if(!NG_deviceName || !NG_systemVersionWithNumber||!NG_systemVersionWithNumber_two){
//        return old_sysctlbyname(a,b,c,d,e);
//    }
//
//    const  char * deviceType ;
//
//    if(!a){
//        return old_sysctlbyname(a,b,c,d,e);
//    }
//    if(!strcmp(a, "hw.machine")){
//        deviceType = [NG_deviceName UTF8String];
//        if(!b){
//            return 0;
//        }
//
//        if(!*c){
//
//            old_sysctlbyname(a,b,c,d,e);
//            return 0;
//        }
//        // deviceIdentifier
//        strncpy(b,deviceType , *c);
//        return 0;
//
//    }
//    if(!strcmp(a, "hw.model")){
//        // deviceInternalName
//        deviceType =[NG_deviceName UTF8String];
//        if(b){
//            if(!*c){
//                return old_sysctlbyname(a,b,c,d,e);
//            }
//            strncpy(b, deviceType, *c);
//            return 0;
//        }
//        *c = strlen(deviceType) + 1;
//        return 0;
//    }
//
//    if(!strcmp(a, "kern.osrelease") && NG_systemVersionWithNumber ){
//
//        deviceType = [NG_systemVersionWithNumber UTF8String];
//    }
//    int version = strcmp(a, "kern.version");
//    if(!version|| !NG_systemVersionWithNumber_two){
//        return old_sysctlbyname(a,b,c,d,e);
//    }
//
//    if(b) {
//
//        deviceType = [[[NSString stringWithCString:b encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:NG_systemVersionWithNumber_two withString:NG_systemVersionWithNumber] UTF8String];
//        if (!*c) {
//            return old_sysctlbyname(a, b, c, d, e);
//        }
//        strncpy(b, deviceType, *c);
//    }
//    return old_sysctlbyname(a,b,c,d,e);
//}
//

NSString* (*old_mode)();


NSString* new_mode()
{
    NSString * mode =  old_mode();
    if(NG_Product){
        return NG_Product;
    }
    return mode;
}


NSString	*(*old_localizedModel)();


NSString *	 new_localizedModel()
{
    NSString * localizedModel =   old_localizedModel();

    if(NG_Product){
        return NG_Product;
    }

    return localizedModel;
}
NSString	*(*old_systemVersion)();


NSString *	 new_systemVersion()
{
    NSString * systemVersion =old_systemVersion();
    if(NG_systemVersion){
        return NG_systemVersion;
    }

    return systemVersion;
}


NSString	*(*old_name)();

NSString *	 new_name()
{
    NSString * name = old_name();
    if(NG_deviceName){
        return NG_deviceName;
    }
    return name;
}
NSUUID	*(*old_identifierForVendor)();


NSUUID *	 new_identifierForVendor()
{
    NSUUID * identifierForVendo = old_identifierForVendor();

    if(NG_IDFV){
        return [[[NSUUID alloc] initWithUUIDString:NG_IDFV] autorelease];
    }
    return identifierForVendo;
}
NSUUID	*(*old_advertisingIdentifier)(id self, SEL _cmd);


NSUUID *	 new_advertisingIdentifier(id self, SEL _cmd)
{
    NSUUID * identifierForVendo =  old_advertisingIdentifier(self,_cmd);

    if(NG_IDFA){
        return [[[NSUUID alloc] initWithUUIDString:NG_IDFA] autorelease];
    }
    return identifierForVendo;
}


NSString	*(*old_carrierName)();


NSString *	 new_carrierName()
{
    NSString *	 carrierName =  (*old_carrierName)();
    if(NG_carrierOperator){
        return NG_carrierOperator;
    }
    return carrierName;
}


NSString	*(*old_mobileCountryCode)();


NSString *	 new_mobileCountryCode()
{
    NSString *	 mobileCountryCode =  (*old_mobileCountryCode)();
    if(NG_mobileCountryCode){
        return NG_mobileCountryCode;
    }
    return mobileCountryCode;
}

NSString	*(*old_mobileNetworkCode)();


NSString *	 new_mobileNetworkCode()
{
    NSString *	 mobileCountryCode =  (*old_mobileNetworkCode)();
    if(NG_mobileNetworkCode){
        return NG_mobileNetworkCode;
    }
    return mobileCountryCode;
}

NSString	*(*old_isoCountryCode)();


NSString *	 new_isoCountryCode()
{
    NSString *	 mobileCountryCode =  (*old_isoCountryCode)();
    if(NG_isoCountryCode){
        return NG_isoCountryCode;
    }
    return mobileCountryCode;
}
NSString	*(*old_currentRadioAccessTechnology)();


NSString *	 new_currentRadioAccessTechnology()
{

    NSString *content = nil;
    if(old_currentRadioAccessTechnology()){
        content = NG_IMEI;

    }
    return content;
}



BOOL  (*old_UIApplicationDelegate)(id dd, SEL _cmd,UIApplication* application,  NSDictionary * launchOptions) NS_AVAILABLE_IOS(3_0);

BOOL new_UIApplicationDelegate(id dd, SEL _cmd,UIApplication* application,  NSDictionary * launchOptions) NS_AVAILABLE_IOS(3_0){

//    NSLog(@"-------------------------------------application = %@", application);
//    NSLog(@"-------------------------------------launchOptions = %@", launchOptions);
//
//    NSString *systemContent = nil;
//    id CFBundleIdentifier = [[[NSBundle mainBundle] infoDictionary] objectForKeyedSubscript:@"CFBundleIdentifier"];
//    NSString * sysVersion = [NG_systemVersion stringByReplacingOccurrencesOfString:@"." withString:@"_"];
//    if(CFBundleIdentifier && [CFBundleIdentifier isEqualToString:@"com.apple.mobilesafari"]){
//        systemContent = [NSString stringWithFormat:@"Mozilla/5.0 (%@; CPU iPhone OS %@ like Mac OS X) AppleWebKit/%@ (KHTML, like Gecko) Version/%@ Mobile/%@ Safari/%@",
//                NG_Product,sysVersion,@"602.1.50",@"10.0",NG_systemVersionWithEnglist,@"602.1"];
//
//    }else{
//        systemContent = [NSString stringWithFormat:@"Mozilla/5.0 (%@; CPU iPhone OS %@ like Mac OS X) AppleWebKit/%@ (KHTML, like Gecko) Mobile/%@",
//                        NG_Product,sysVersion,@"602.1.50",NG_systemVersionWithEnglist];
//    }
//
//    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":systemContent} ];
//    NSLog(@"----------------------------------------------------------");
    return (*old_UIApplicationDelegate)(dd , _cmd , application,launchOptions);

}




id <NSTextStorageDelegate>	(*old_currentRadioAccessTechnology_de)(id dd, SEL _cmd,id ss);


id <NSTextStorageDelegate> 	 new_currentRadioAccessTechnology_de(id dd, SEL _cmd,id ss)
{
    MSHookMessageEx([ss class], @selector(application:didFinishLaunchingWithOptions:), (IMP)new_UIApplicationDelegate, (IMP*)&old_UIApplicationDelegate);
    return old_currentRadioAccessTechnology_de(dd,_cmd,ss);
}

int  *(*old_UIApplicationMain)(int argc, char *argv[], NSString * __nullable principalClassName, NSString * __nullable delegateClassName);

int *new_UIApplicationMain(int argc, char *argv[], NSString * __nullable principalClassName, NSString * __nullable delegateClassName){
    MSHookMessageEx([UIApplication class], @selector(setDelegate:), (IMP)new_currentRadioAccessTechnology_de, (IMP*)&old_currentRadioAccessTechnology_de);
    return old_UIApplicationMain(argc,argv,principalClassName,delegateClassName);
}


Boolean
*(*old_SCNetworkReachabilityGetFlags)			(
        SCNetworkReachabilityRef	target,
        SCNetworkReachabilityFlags	*flags
)				__OSX_AVAILABLE_STARTING(__MAC_10_3,__IPHONE_2_0);

Boolean
*new_SCNetworkReachabilityGetFlags			(
        SCNetworkReachabilityRef	target,
        SCNetworkReachabilityFlags	*flags
)				__OSX_AVAILABLE_STARTING(__MAC_10_3,__IPHONE_2_0){
    *flags |= 0x40000u;
    return old_SCNetworkReachabilityGetFlags(target,flags);
}




static CFStringRef (*old_MGCA)(CFStringRef Key);
CFStringRef new_MGCA(CFStringRef Key){
    CFStringRef Ret=old_MGCA(Key);





    //设置Mac
    if(CFEqual(Key, CFSTR("gI6iODv8MZuiP0IA+efJCw"))
            || CFEqual(Key, CFSTR("WifiAddress"))){

        if(NG_macAdress){
            return (CFStringRef)NG_macAdress;
        }
    }
    //设置IMEI
//    if(CFEqual(Key,CFSTR( ""))){
//
//        return
//
//    }
    // 设置设备类型 iPhone
//    if(CFEqual(Key, CFSTR("device-name-localized"))
//            ||CFEqual(Key, CFSTR("DeviceClass"))
//            ||CFEqual(Key, CFSTR("DeviceName")) ){
//        if(NG_phoneType){
//            return (CFStringRef)NG_phoneType;
//        }
//
//
//    }
//    // 设备序列号
    if(CFEqual(Key, CFSTR("VasUgeSzVyHdB27g2XpN0g"))
            || CFEqual(Key, CFSTR("SerialNumber")) ){
//        NSLog(@"-----------《《《《《进入》》》》》-----------");
        if(NG_searnalNumber){
            return (CFStringRef)NG_searnalNumber;
        }

    }




    // 设备蓝牙
    if(CFEqual(Key, CFSTR("k5lVWbXuiZHLA17KGiVUAA"))
            ||CFEqual(Key, CFSTR("BluetoothAddress")) ){
        if(NG_BLUETOOTH){
            return (CFStringRef)NG_BLUETOOTH;
        }
//        NSLog(@"-----------《《《《《进入》》》》》-----------");
    }
    //唯一码 UUID
    if( CFEqual(Key,CFSTR("UniqueDeviceID") ) ){
        // 接是value
//        return CFBridgingRetain(@"3c71103a7002ce6800e40525d3f63377892c26c7");
//        NSLog(@"-----------《《《《《进入》》》》》-----------");
        if(NG_UDID){
            return (CFStringRef)NG_UDID;
        }
    }

//    if( CFEqual(Key,CFSTR("nFRqKto/RuQAV1P+0/qkBA") ) ){
//        //是data 一
//
//
//
//
//
//        NSLog(@"---------《《 nFRqKto/RuQAV1P+0/qkBA 》》----------------------Ret = %@", Ret);
//
//    }
//    if( CFEqual(Key,CFSTR("SIMTrayStatus") ) ){
//        //是data 一
//        NSLog(@"---------《《 SIMTrayStatus 》》----------------------Ret = %@", Ret);
//
//    }
//    if( CFEqual(Key,CFSTR("ModelNumber") ) ){
//        //是data 一
//
//        NSLog(@"---------《《 ModelNumber 》》----------------------Ret = %@", Ret);
//
//    }
//    if( CFEqual(Key,CFSTR("MLBSerialNumber") ) ){
//        //是data 一
//
//        NSLog(@"---------《《 MLBSerialNumber 》》----------------------Ret = %@", Ret);
//
//    }
//    if( CFEqual(Key,CFSTR("UniqueDeviceIDData") ) ){
//        //是data 一
//        NSLog(@"---------《《 UniqueDeviceIDData 》》----------------------Ret = %@", Ret);
//
//
//    }
//    if( CFEqual(Key,CFSTR("UniqueChipID") ) ){
//        //是data 一
//
//        NSLog(@"---------《《 UniqueChipID 》》----------------------Ret = %@", Ret);
//
//    }
//    if( CFEqual(Key,CFSTR("InverseDeviceID") ) ){
//        //是data 一
//
//        NSLog(@"---------《《 InverseDeviceID 》》----------------------Ret = %@", Ret);
//
//    }
//    if( CFEqual(Key,CFSTR("DiagData") ) ){
//        //是data 一
//        NSLog(@"---------《《 DiagData 》》----------------------Ret = %@", Ret);
//
//
//    }
//    if( CFEqual(Key,CFSTR("DieId") ) ){
//        //是data 一
//
//        NSLog(@"---------《《 DieId 》》----------------------Ret = %@", Ret);
//
//    }
//    if( CFEqual(Key,CFSTR("CPUArchitecture") ) ){
//        //是data 一
//        NSLog(@"---------《《 CPUArchitecture 》》----------------------Ret = %@", Ret);
//
//
//    }
//    if( CFEqual(Key,CFSTR("PartitionType") ) ){
//        //是data 一
//        NSLog(@"---------《《 PartitionType 》》----------------------Ret = %@", Ret);
//
//
//    }
//    if( CFEqual(Key,CFSTR("UserAssignedDeviceName") ) ){
//        //是data 一
//        NSLog(@"---------《《 UserAssignedDeviceName 》》----------------------Ret = %@", Ret);
//
//
//    }
//    if( CFEqual(Key,CFSTR("ActiveWirelessTechnology") ) ){
//        //是data 一
//        NSLog(@"---------《《 ActiveWirelessTechnology 》》----------------------Ret = %@", Ret);
//
//
//    }
//    if( CFEqual(Key,CFSTR("WifiAddressData") ) ){
//        //是data 一
//        NSLog(@"---------《《 WifiAddressData 》》----------------------Ret = %@", Ret);
//
//
//    }
//    if( CFEqual(Key,CFSTR("WifiVendor") ) ){
//        //是data 一
//
//        NSLog(@"---------《《 WifiVendor 》》----------------------Ret = %@", Ret);
//
//    }
    //设备的版本
    if(CFEqual(Key, CFSTR("BuildVersion")) ){
        //13F69
        if(NG_systemVersionWithEnglist){
            return (CFStringRef)NG_systemVersionWithEnglist;
        }

    }
    //设备生产版本
    if(CFEqual(Key, CFSTR("ProductVersion")) ){
        //9.3.2
        if(NG_systemVersion){
            return (CFStringRef)NG_systemVersion;
        }

    }
    //设备生产种类
    if(CFEqual(Key, CFSTR("ProductType")) ){
        //iPhone6,1
        if(NG_DEVICE_ProductType){
            return (CFStringRef)NG_DEVICE_ProductType;
        }

    }
    // 是否为平板
    if(CFEqual(Key, CFSTR("ipad")) ){
        //0


    }
    // 设备型号
    if(CFEqual(Key, CFSTR("ModelNumber")) ){
        //ME337
        if(NG_DEVICE_NAME){
            return (CFStringRef)NG_DEVICE_NAME;
        }
    }
    // 地域信息
    if(CFEqual(Key, CFSTR("RegionInfo")) ){
        //J/A
        if(NG_DEVICE_LOCATION){
            return (CFStringRef)NG_DEVICE_LOCATION;
        }

    }
    //设备所属国家
    if(CFEqual(Key, CFSTR("h63QSdBCiT/z0WU6rdQv6Q")) ){
        //J
        if(NG_DEVICE_SINGLENAME){
            return (CFStringRef)NG_DEVICE_SINGLENAME;
        }

    }
    // 设备名
    if(CFEqual(Key, CFSTR("UserAssignedDeviceName")) ){
        //Ggf
        if(NG_deviceName){
            return (CFStringRef)NG_deviceName;
        }
    }

    // 集合列表
//    if(CFEqual(Key, CFSTR("oPeik/9e8lQWMszEjbPzng")) ){
//        //Return Value:{
////        ArtworkDeviceIdiom = phone;
////        ArtworkDeviceProductDescription = "iPhone 5s";
////        ArtworkDeviceScaleFactor = 2;
////        ArtworkDeviceSubType = 568;
////        CompatibleDeviceFallback = 0;
////        DevicePerformanceMemoryClass = 1;
////        GraphicsFeatureSetClass = "MTL1,2";
////        GraphicsFeatureSetFallbacks = "GLES2,0";
//
//
//
//    }

//    // 未判定的
    if(CFEqual(Key, CFSTR("HWModelStr")) ){
        //N51AP

        if(NG_DEVICE_HardwareModel){
            return (CFStringRef)NG_DEVICE_HardwareModel;
        }
    }
    if(CFEqual(Key, CFSTR("HardwarePlatform")) ){
        //s5l8960x

        if(NG_DEVICE_HardwarePlatform){
            return (CFStringRef)NG_DEVICE_HardwarePlatform;
        }
    }
//
//    if(CFEqual(Key, CFSTR("eZS2J+wspyGxqNYZeZ/sbA")) ){
//
////        NSLog(@"-------------------名字:《  %@  》-----Return Value:《  %@  》---",  Key,[[NSString alloc] initWithData: hexStringToByte((NSString *)Ret) encoding:NSUTF8StringEncoding]);
////        NSLog(@"-------------------名字:《  %@  》-----Return Value:《  %@  》---",  Key,[[NSString alloc] initWithData: hexStringToByte((NSString *)Ret) encoding:NSUTF8StringEncoding]);
//
////        return (CFStringRef)@"<eadd9a1c d078a359 13ce228d d14bdedf c7ea3f5f>";
////        return (CFStringRef)@"<54724fa2 90d2>";
//
//    }
//    if(CFEqual(Key, CFSTR("jSDzacs4RYWnWxn142UBLQ")) ){
//
////        NSLog(@"-------------------名字:《  %@  》-----Return Value:《  %@  》---",  Key,[[NSString alloc] initWithData: hexStringToByte((NSString *)Ret) encoding:NSUTF8StringEncoding]);
//
////        return (CFStringRef)@"<eadd9a1c d078a359 13ce228d d14bdedf c7ea3f5f>";
////        return (CFStringRef)@"<54724fa2 90d2>";
//
//    }
//    if(CFEqual(Key, CFSTR("nFRqKto/RuQAV1P+0/qkBA")) ){
//
////        NSLog(@"-------------------名字:《  %@  》-----Return Value:《  %@  》---",  Key,[[NSString alloc] initWithData: hexStringToByte((NSString *)Ret) encoding:NSUTF8StringEncoding]);
//
////        return (CFStringRef)@"<eadd9a1c d078a359 13ce228d d14bdedf c7ea3f5f>";
//
//    }
//    if(CFEqual(Key,CFSTR( "oBbtJ8x+s1q0OkaiocPuog")) ){
//        //data
//
////        NSLog(@"-------------------名字:《  %@  》-----Return Value:《  %@  》---",  Key,[[NSString alloc] initWithData: hexStringToByte((NSString *)Ret) encoding:NSUTF8StringEncoding]);
//
//        return (CFStringRef)@"<80020000 70040000 46010000 00000040 00000000 05000000>";
//
//    }
//
//    if(CFEqual(Key,CFSTR( "nFRqKto/RuQAV1P+0/qkBA")) ){
//        //data
//
////        NSLog(@"-------------------名字:《  %@  》-----Return Value:《  %@  》---",  Key,[[NSString alloc] initWithData: hexStringToByte((NSString *)Ret) encoding:NSUTF8StringEncoding]);
////        return (CFStringRef)@"<eadd9a1c d078a359 13ce228d d14bdedf c7ea3f5f>";
////        return (CFStringRef)@"<eadd9a1c d078a359 13ce228d d14bdedf c7ea3f5f>";
//
//    }
//    if(CFEqual(Key,CFSTR( "TF31PAB6aO8KAbPyNKSxKA")) ){
//        //4903437917520
//
//
////        NSLog(@"-------------------名字:《  %@  》-----Return Value:《  %@  》---",  Key,[[NSString alloc] initWithData: hexStringToByte((NSString *)Ret) encoding:NSUTF8StringEncoding]);
//        return (CFStringRef)@"<4903437917520>";
//    }

//    NSLog(@"------------------转换后的内容为----------------- %@",[[NSString alloc] initWithData: hexStringToByte(@"eadd9a1c d078a359 13ce228d d14bdedf c7ea3f5f") encoding:NSUTF8StringEncoding] );

//    NSLog(@"---------------------------名字:《  %@\n  》------------------------------------------------------------------------------Return Value:《  %@  》",Key,Ret);
    return Ret;
}






// 进行初始化当前的设
- (void)ng_initChangeDeviceCode {
    // 获取当前是否为工作状态
    if([GeneralUtil isWorking]){
        [self ng_changeCode];
    }

}

-(void)ng_changeCode{
    //获取Bundid 只有Preference  SpringBoard 和 AppStore 和 ItunsStrore才可以进行改码
    NSString *bunId = [[NSBundle mainBundle] bundleIdentifier];

    // [GeneralUtil convertHexStrToString:NG_BUNID_Preferences]

    if(!bunId
        || !([bunId isEqualToString: [GeneralUtil convertHexStrToString:NG_BUNID_Preferences]]
        || [bunId isEqualToString:[GeneralUtil convertHexStrToString:NG_BUNID_AppStore]]
        || [bunId isEqualToString:[GeneralUtil convertHexStrToString:NG_BUNID_itunesstored]]
        || [bunId isEqualToString:[GeneralUtil convertHexStrToString:NG_BUNID_itunescloud]]
        || [bunId isEqualToString:[GeneralUtil convertHexStrToString:NG_BUNID_SpringBoard]]
        || [bunId isEqualToString:[GeneralUtil convertHexStrToString:NG_BUNID_springboard]])){
        return;
    }

    [self ng_getDomainUserSettingsParams];
    // 设置各个版本对应的内容
    NG_systemVersionWithNumber          = [self ng_changeDeviceVersion:NG_systemVersion];
    NG_systemVersionWithEnglist         = [self ng_changeDeviceVersionToSpec:NG_systemVersion];
    NG_systemVersionWithNumber_two      = [self ng_changeDeviceVersion:NG_systemVersionWithNumber];
    // 设备名字 eg:ME337
    NG_DEVICE_NAME                      = [self InterceptDeviceWithName:NG_UNITTYPE];
    // 设备定力位置  eg: J/A
    NG_DEVICE_LOCATION                  = [self InterceptDeviceWithLocation:NG_UNITTYPE];
    // 设备地理位置  eg: J
    NG_DEVICE_SINGLENAME                = [self InterceptDeviceWithSingleLocation:NG_UNITTYPE];
    // 设置 改码Hook内容
    MSHookFunction(&IORegistryEntryCreateCFProperty, &new_IORegistryEntryCreateCFProperties, (void**)&old_IORegistryEntryCreateCFProperties);
    MSHookFunction(&IORegistryEntrySearchCFProperty, &new_IORegistryEntrySearchCFProperty, (void**)&old_IORegistryEntrySearchCFProperty);
    MSHookFunction(&CNCopyCurrentNetworkInfo, &new_CNCopyCurrentNetworkInfo, (void**)&old_CNCopyCurrentNetworkInfo);
    MSHookFunction(&CNCopySupportedInterfaces, &new_CNCopySupportedInterfaces, (void**)&old_CNCopySupportedInterfaces);
    MSHookFunction(&SCNetworkReachabilityGetFlags, &new_SCNetworkReachabilityGetFlags, (void**)&old_SCNetworkReachabilityGetFlags);
    MSHookFunction(&_CTServerConnectionCopyMobileIdentity, &new_CTServerConnectionCopyMobileIdentity, (void**)&old_CTServerConnectionCopyMobileIdentity);
    MSHookFunction(&uname, &new_uname, (void**)&old_uname);
    MSHookFunction(&sysctlnametomib, &new_sysctlnametomib, (void**)&old_sysctlnametomib);
//////    MSHookFunction(&sysctlbyname, &new_sysctlbyname, (void**)&old_sysctlbyname);
//////    MSHookFunction(&sysctl, &new_sysctl, (void**)&old_sysctl);
    Class deviceClass = [UIDevice class];
    //NSSelectorFromString(@"currentRadioAccessTechnology")

    MSHookMessageEx(deviceClass, NSSelectorFromString(@"model"), (IMP)new_mode, (IMP*)&old_mode);
    MSHookMessageEx(deviceClass, NSSelectorFromString(@"localizedModel"), (IMP)&new_localizedModel, (IMP*)&old_localizedModel);
    MSHookMessageEx(deviceClass, NSSelectorFromString(@"systemVersion"), (IMP)new_systemVersion, (IMP*)&old_systemVersion);
    MSHookMessageEx(deviceClass, NSSelectorFromString(@"name"), (IMP)new_name, (IMP*)&old_name);
    MSHookMessageEx(deviceClass, NSSelectorFromString(@"identifierForVendor"), (IMP)new_identifierForVendor, (IMP*)&old_identifierForVendor);
    Class ASIdentifierManagerClass = objc_getClass("ASIdentifierManager");
    MSHookMessageEx(ASIdentifierManagerClass,NSSelectorFromString(@"advertisingIdentifier"), (IMP)new_advertisingIdentifier, (IMP*)&old_advertisingIdentifier);
    Class CTCarrierClass = objc_getClass("CTCarrier");
    MSHookMessageEx(CTCarrierClass, NSSelectorFromString(@"carrierName"), (IMP)new_carrierName, (IMP*)&old_carrierName);
    MSHookMessageEx(CTCarrierClass, NSSelectorFromString(@"mobileCountryCode"), (IMP)new_mobileCountryCode, (IMP*)&old_mobileCountryCode);
    MSHookMessageEx(CTCarrierClass, NSSelectorFromString(@"mobileNetworkCode"), (IMP)new_mobileNetworkCode, (IMP*)&old_mobileNetworkCode);
    MSHookMessageEx(CTCarrierClass, NSSelectorFromString(@"isoCountryCode"), (IMP)new_isoCountryCode, (IMP*)&old_isoCountryCode);
    Class CTTelephonyNetworkInfoClass = objc_getClass("CTTelephonyNetworkInfo");
    MSHookMessageEx(CTTelephonyNetworkInfoClass, NSSelectorFromString(@"currentRadioAccessTechnology"), (IMP)new_currentRadioAccessTechnology, (IMP*)&old_currentRadioAccessTechnology);
    MSHookFunction(&UIApplicationMain , &new_UIApplicationMain, (void**)&old_UIApplicationMain);
//

    void *Symbol = MSFindSymbol(MSGetImageByName("/usr/lib/libMobileGestalt.dylib"), "_MGCopyAnswer");
//    NSLog(@"MG: %p", Symbol);
    csh handle;
    cs_insn *insn;
    cs_insn BLInstruction;
    size_t count;
    unsigned long realMGAddress = 0;
    //MSHookFunction(Symbol,(void*)new_MGCA, (void**)&old_MGCA);
    if (cs_open(CS_ARCH_ARM64, CS_MODE_ARM, &handle) == CS_ERR_OK) {
        /*cs_disasm(csh handle,
                const uint8_t *code, size_t code_size,
                uint64_t address,
                size_t count,
                cs_insn **insn);*/
        count = cs_disasm(handle, (const uint8_t *) Symbol, 0x1000, (uint64_t) Symbol, 0, &insn);
        if (count > 0) {
            NSLog(@"Found %lu instructions", count);
            for (size_t j = 0; j < count; j++) {
                NSLog(@"0x%" PRIx64 ":\t%s\t\t%s\n", insn[j].address, insn[j].mnemonic, insn[j].op_str);
                if (insn[j].id == ARM64_INS_B) {
                    BLInstruction = insn[j];
                    sscanf(BLInstruction.op_str, "#%lx", &realMGAddress);
                    break;
                }
            }
            cs_free(insn, count);
        } else {
            NSLog(@"ERROR: Failed to disassemble given code!%i \n", cs_errno(handle));
        }
        cs_close(&handle);
    }
    //Now perform actual hook
    MSHookFunction((void *) realMGAddress, (void *) new_MGCA, (void **) &old_MGCA);

}



/**
 * 进行更改当前设备的版本信息
 * */
-(NSString *)ng_changeDeviceVersion:(NSString *)version{
    if(!version){
        return nil;
    }
    if([version isEqualToString:@"6.1.6"]){
        return @"13.4.0";
    }
    if([version hasPrefix:@"6."]){
        return @"13.0.0";
    }
    if([version hasPrefix:@"7."]){
        return @"14.0.0";
    }
    if([version hasPrefix:@"8."]){
        return @"14.5.0";
    }
    if([version isEqualToString:@"9.3.3"] || [version isEqualToString:@"9.3.4"] || [version isEqualToString:@"9.3.5"]){
        return @"15.6.0";
    }
    if([version hasPrefix:@"9."]){
        return @"15.0.0";

    } if([version hasPrefix:@"10."]){
        return @"16.0.0";

    } if([version hasPrefix:@"10.1"]){
        return @"16.1.0";

    } if([version hasPrefix:@"10.2"]){
        return @"16.3.0";
    }
    return nil;
}


/**
 * 进行更改当前设备的版本版本信息转化为IOS公司特有的  VC为此数据
 * */
-(NSString *)ng_changeDeviceVersionToSpec:(NSString *)version{
    if(!version){
        return nil;
    }
    NSDictionary *DIC =@{@"6.0":@"10A403",
            @"6.0.1"    :@"10A523",
            @"6.0.2"    :@"10A551",
            @"6.1"      :@"10B141",
            @"6.1.1"    :@"10B145",
            @"6.1.2"    :@"10B146",
            @"6.1.3"    :@"10B329",
            @"6.1.4"    :@"10B350",
            @"6.1.5"    :@"10B400",
            @"6.1.6"    :@"10B500",
            @"7.0"      :@"11A465",
            @"7.0.1"    :@"11A470a",
            @"7.0.2"    :@"11A501",
            @"7.0.3"    :@"11B511",
            @"7.0.4"    :@"11B553",
            @"7.1"      :@"11D167",
            @"7.1.1"    :@"11D201",
            @"7.1.2"    :@"11D257",
            @"8.0"      :@"12A365",
            @"8.0.1"    :@"12A402",
            @"8.0.2"    :@"12A405",
            @"8.1"      :@"12B410",
            @"8.1.1"    :@"12B435",
            @"8.1.2"    :@"12B440",
            @"8.1.3"    :@"12B466",
            @"8.2"      :@"12D508",
            @"8.3"      :@"12F70",
            @"8.4"      :@"12H143",
            @"9.0"      :@"13A344",
            @"9.0.1"    :@"13A404",
            @"9.0.2"    :@"13A452",
            @"9.1"      :@"13B143",
            @"9.2"      :@"13C75",
            @"9.2.1"    :@"13D15",
            @"9.3"      :@"13E233",
            @"9.3.1"    :@"13E238",
            @"9.3.2"    :@"13F69",
            @"9.3.3"    :@"13G34",
            @"9.3.4"    :@"13G35",
            @"9.3.5"    :@"13G36",
            @"10.3.3"   :@"14G60",
            @"10.0.2"   :@"14A456",
            @"10.0.1"   :@"14A403",
            @"10.0.3"   :@"14A551",
            @"10.1"     :@"14B72c",
            @"10.1.1"   :@"14B150",
            @"10.2"     :@"14C92",
            @"10.2.1"   :@"14D27",
            @"10.3"     :@"14E277",
            @"10.3.1"   :@"14E304",
            @"10.3.2"   :@"14F89",
            @"11.0"     :@"15A372",
            @"11.0.1"   :@"15A402",
            @"11.0.2"   :@"15A421",
            @"11.0.3"   :@"15A432",
            @"11.1"     :@"15B93",
            @"11.1.1"   :@"15B202",
            @"11.1.2"   :@"15B202",
            @"11.2"     :@"15C114",
    };


    return [DIC objectForKeyedSubscript:version];



}

@end