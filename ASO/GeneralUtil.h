/**
 * 主要进行一些常用变量的封装，全部都为静态调用
 */
#import <Foundation/Foundation.h>
#include "AsoHeader.h"


#ifndef GENERALUTIL_ASO
#define GENERALUTIL_ASO

//#define GenerlUtil XXXXXX11


#define PRIVATE_KEY @"MIICXQIBAAKBgQC3NJP/6CIBlKIc883xGVzDbQRBP8FdyEOCqkialwQZXsLwR/iorwsckME/cPMk6JwgzMxnU6wKSIY5LRIpeB+J/41GWFyh5/+duf/NSl9UNrhCCWBnaGUtKjwINmz4rV0gkSLjsF1YUZpb/19cglBZquLSeGGP7QqFQOyCZR6uqQIDAQABAoGAFrxCpZ5kIfgVCizDYOk51tK/lW1ZDM9eeWeybOTS0GcvH+x+kkhuw5O/N6VHt0vanENuFmCO2BPZ/Fx4hYbvutWl/K3VnSZQqUZVe6+btydKbJn/iql+FHYVCAKdFTSor5GCz96rd5vzjnigvyx20LRSWZgA5esHB4vY3xVDAtECQQDczEy5i52g5CWbkwvr5HF1dl9oaHdtnWgDTMqat7nJyatjlXNHa82Cu5BgSO5fKUFhnoF6MoT/YbuOIemEXJBtAkEA1Gn2kqAyZLOLyrxkCatN7tFD2NXLv7TqwvsCkbIKbOmKEoCFjA+X+9BVk/gv9tV4cXX9QPY6zofQT/kPGapJrQJAMDmHAHeYBA4QkLw7PFh213r1N66pdw2MLDxXfBdowsQDZQq9VPocttMUo5MKTUqLdzDRgskJ92V3O4H4qOo2uQJBALOK2Xs4Y0ARL1DvClPN8zKwuXt3wx/IqUKj7pj996f1gtp+veMUby/O+fb3qnsmFwc4ZxdYyX42+BIQ//1+nYUCQQC/C0jnbuaaedXn2zrk/pc+59xYOA6Z/HMbayqKSaXGGdCJryqtaLBfAp8U0JjQhpHvrfVCLaGaYtsvrbHueM/Q"



#define PUBLIC_KEY @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3NJP/6CIBlKIc883xGVzDbQRBP8FdyEOCqkialwQZXsLwR/iorwsckME/cPMk6JwgzMxnU6wKSIY5LRIpeB+J/41GWFyh5/+duf/NSl9UNrhCCWBnaGUtKjwINmz4rV0gkSLjsF1YUZpb/19cglBZquLSeGGP7QqFQOyCZR6uqQIDAQAB"

#define GEN_TRUE @"true"
#define GEN_FALSE @"false"



#endif

@interface GeneralUtil :NSObject

// 卸载自身
+(void)NG_uninstallSelf;



// 获取序列号
+(id)getServeral;

// 获取IP地址
+(id) getIp;
// 获取UUID
+(id) getUUID;
// 获取设备类型
+(id) getDeviceType;

+(id)getDeviceId;
// 获取当前时间
+(id)getCurrentTime;

// 判断当前文件是否存在
+(BOOL) isAuthorize;
// 进行判断当前工作状态
+(BOOL)isWorking;
// 修改工作状态
+(void)setWorkState:(id)state;

// 进行生成授权文件 并增加当前文件内容
+(void) writeAuthorizeState:(id)state;


// 进行判断当前工作状态
+(BOOL)isSubWorking;
// 修改工作状态
+(void)setSubWorkState:(id)state;


// RSA 加密
+(NSString *)RSAEncryption:(NSString *)content;

// RSA 解密
+(NSString *)RSADeciphering:(NSString *)content;

// AES加密
+(NSString *)AES256Encryption:(NSString *)key withContent:(NSString *)content;

// AES 解密
+(NSString *)AES256Deciphering:(NSString *)key withContent:(NSString *)content;

// AES加密
+(NSString *)AES128Encryption:(NSString *)key withContent:(NSString *)content;

// AES 解密
+(NSString *)AES128Deciphering:(NSString *)key withContent:(NSString *)content;

//Base64  Base64DecodeString  Base64EncodeString
+(NSString *)Base64EncodeString:(NSString *)string;

+(NSString *)Base64DecodeString:(NSString *)string;
// 进行md5加密
+(NSString *)md5:(NSString *) input;
// 获取是间截
+(NSString *)getCurrentTimeStamp;
// 获取设备系统版本  数字
+(NSString *)getDeviceVersion;
// 获取设备硬件版本
+(NSString *)getMachineVersion;

// 将设备的Token和 uid进行保存
+(void)saveTokenWithUidToFile:(NSString *)content;
// 获取存储的Token信息
+(NSString *)getTokenWithUidFromFile;
// 二进制转字符串
+(NSString *)convertHexStrToString:(NSString *)str ;
// 判断是否为Null


+(BOOL) isBlankString:(NSString *)string ;








@end