
//
// Created by admin on 2017/12/7.
//

#import <Foundation/Foundation.h>
#import "../AsoHeader.h"

@interface ChangeCode : NSObject






-(void)ng_initChangeDeviceCode;

+ (ChangeCode *)instance;

// 进行改嘛的相关参数
-(void)ng_changeCodeWithParam:(NSString *)NG_SSID
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
                     withUUID:(NSString *)NG_UUID;

// 新版的改码

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
          with_NG_wifiAddress:(NSString *)NG_WIFIADRESS;





// 获取保存在domain中的用户需要设置的参数
-(void)ng_getDomainUserSettingsParams;

// 进行获取当前的共享目录数据
-(NSDictionary *)ng_getOrignDataSets;

// 进行保存原始设备信息 到文件中
-(void)ng_saveOrignDeviceInfo;

// 进行获取保存的设备信息  并将获取的原始设备信息保存到Domain中
-(BOOL)ng_getOrignDeviceInfoFromSavedToDomain;


// 进行获取当前的设备信息





@end