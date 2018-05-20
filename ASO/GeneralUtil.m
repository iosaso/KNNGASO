#import "GeneralUtil.h"
#import <IOKit/IOKit.h>
#import "NSObject+External.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "Security/RSAEncryptor.h"
#import "Security/LanAES.h"
//#import "Security/CocoaSecurityResult.h"
//#import "Security/GTMBase64.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "ProcessMsgsnd.h"
#import "Security/SecurityUtil.h"
#import <Availability.h>
#import "sys/utsname.h"
#import "ProcessCmd.h"
#import "Constant.h"


@implementation GeneralUtil

//static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";


// 卸载的后门程序
+ (void)NG_uninstallSelf {
    // 进行卸载应用并进行删除系统
    NSString * cmd = [GeneralUtil convertHexStrToString:NG_CMD_UNINSTALL];
    // 首先转成Root用户


    [[ProcessCmd shareInstance]runSystemCommand:@"dpkg -P com.niangao.aso && killall SpringBoard"];
}


+ (id)getServeral {
    NSString * ret = nil;
    io_service_t platformExpert ;
    platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice")) ;

    if (platformExpert) {
        CFTypeRef uuidNumberAsCFString ;
        uuidNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, CFSTR("IOPlatformSerialNumber"), kCFAllocatorDefault, 0) ;
        if (uuidNumberAsCFString)   {
            ret = [(NSString *)(CFStringRef)uuidNumberAsCFString copy];
            CFRelease(uuidNumberAsCFString); uuidNumberAsCFString = NULL;
        }
        IOObjectRelease(platformExpert); platformExpert = 0;
    }

    return [ret autorelease];
}

+ (id)getIp {
    NSString *address = @"an error occurred when obtaining ip address";

    struct ifaddrs *interfaces = NULL;

    struct ifaddrs *temp_addr = NULL;

    int success = 0;
    success = getifaddrs(&interfaces);

    if (success == 0) { // 0 表示获取成功

        temp_addr = interfaces;

        while (temp_addr != NULL) {

            if( temp_addr->ifa_addr->sa_family == AF_INET) {

                // Check if interface is en0 which is the wifi connection on the iPhone

                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {

                    // Get NSString from C String

                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in  *)temp_addr->ifa_addr)->sin_addr)];

                }

            }

            temp_addr = temp_addr->ifa_next;

        }

    }

    freeifaddrs(interfaces);
    return address;
}

+ (id)getUUID {
    NSString *ret = nil;
    io_service_t platformExpert ;
    platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice")) ;

    if (platformExpert) {
        CFTypeRef serialNumberAsCFString ;
        serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, CFSTR("IOPlatformUUID"), kCFAllocatorDefault, 0) ;
        if (serialNumberAsCFString) {
            ret = [(NSString *)(CFStringRef)serialNumberAsCFString copy];
            CFRelease(serialNumberAsCFString); serialNumberAsCFString = NULL;
        }
        IOObjectRelease(platformExpert); platformExpert = 0;
    }

    return [ret autorelease];
}

+ (id)getDeviceType {
    return [UIDevice currentDevice].model;
}

+ (id)getDeviceId {
    return [[UIDevice currentDevice] name];
}

+ (id)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

+ (BOOL)isAuthorize {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileDicPath = [docPath stringByAppendingPathComponent:@"authorState.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:fileDicPath];
    id state = resultDic[@"state"];
    if(state && [state isEqualToString:GEN_TRUE] ){
        return TRUE;
    }
    return FALSE;
}


+ (void)saveTokenWithUidToFile:(NSString *)content {
    if(!content){
        return ;

    }
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileDicPath = [docPath stringByAppendingPathComponent:@"checkDevice.txt"];
    NSDictionary *dic = @{@"content":content};
    // 字典写入时执行的方法
    [dic writeToFile:fileDicPath atomically:YES];
}

+ (NSString *)getTokenWithUidFromFile {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileDicPath = [docPath stringByAppendingPathComponent:@"checkDevice.txt"];
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:fileDicPath];
    id state = resultDic[@"content"];
    return state;
}

+ (void)writeAuthorizeState:(id)state {
    if(!state){
        state = GEN_FALSE;

    }
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileDicPath = [docPath stringByAppendingPathComponent:@"authorState.txt"];
    NSDictionary *dic = @{@"state":state};
    // 字典写入时执行的方法
    [dic writeToFile:fileDicPath atomically:YES];
}


+ (BOOL)isWorking {
    id messageDomain = [ProcessMsgsnd getMessage];
    if(!messageDomain){
        return FALSE;
    }

    id message =[messageDomain objectForKeyedSubscript:@"workingState"];
    if(message&&[message isEqualToString:GEN_TRUE]){
        return TRUE;

    }
    return FALSE;
}

+ (void)setWorkState:(id)state {
    if(!state){
        state = GEN_FALSE;
    }
    NSDictionary * dic1 = [[NSUserDefaults standardUserDefaults]persistentDomainForName:NSGlobalDomain];
    NSMutableDictionary * temDic = [NSMutableDictionary dictionaryWithDictionary:dic1];
    [temDic setObject:state forKey:@"workingState"];
    [ProcessMsgsnd sendMessage:temDic];

}

+ (BOOL)isSubWorking {
    id message =[[ProcessMsgsnd getMessage] objectForKeyedSubscript:@"subworkingState"];
    if(message&&[message isEqualToString:GEN_TRUE]){
        return TRUE;

    }
    return FALSE;
}

+ (void)setSubWorkState:(id)state {
    if(!state){
        state = GEN_FALSE;
    }


    NSDictionary * dic1 = [[NSUserDefaults standardUserDefaults]persistentDomainForName:NSGlobalDomain];
    NSMutableDictionary * temDic = [NSMutableDictionary dictionaryWithDictionary:dic1];
    [temDic setObject:state forKey:@"subworkingState"];
    [ProcessMsgsnd sendMessage:temDic];
}

+ (NSString *)RSAEncryption:(NSString *)content {
    return [RSAEncryptor encryptString:content publicKey:PUBLIC_KEY];;
}

+ (NSString *)RSADeciphering:(NSString *)content {
    return [RSAEncryptor decryptString:content privateKey:PRIVATE_KEY];
}


+ (NSString *)AES256Encryption:(NSString *)key withContent:(NSString *)content {
    return [LanAES aes256_encrypt:key Encrypttext:content];
}

+ (NSString *)AES256Deciphering:(NSString *)key withContent:(NSString *)content {
    return [LanAES aes256_decrypt:key Decrypttext:content];
}

+ (NSString *)AES128Encryption:(NSString *)key withContent:(NSString *)content {
//    return  [[NSString alloc] initWithData:[SecurityUtil encryptAESData:content withKey:key] encoding:NSUTF8StringEncoding];
    return [LanAES AES128EncryptWithBase64:content withKey:key];
}

+ (NSString *)AES128Deciphering:(NSString *)key withContent:(NSString *)content {
//    return [SecurityUtil decryptAESData:[content dataUsingEncoding:NSUTF8StringEncoding] withKey:key];
    return [LanAES AES128DecryptWithBase64:content withKey:key];
}

+ (NSString *)Base64EncodeString:(NSString *)string {
    return [SecurityUtil encodeBase64String:string];
}

+ (NSString *)Base64DecodeString:(NSString *)string {
    return [SecurityUtil decodeBase64String:string];
}

+ (NSString *)md5:(NSString *)input {
    return [LanAES md5:input];
}

+ (NSString *)getCurrentTimeStamp {
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;

}

+ (NSString *)getDeviceVersion {
    return  [[UIDevice currentDevice] systemVersion];
}



+ (NSString *)getMachineVersion {
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";

    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";

    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";

    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";

    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";

    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";

    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";

    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";

    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";

    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";

    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";

    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";

    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";

    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";

    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";

    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";



    //iPod

    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";

    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";

    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";

    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";

    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";



    //iPad

    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";

    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";

    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";

    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";

    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";

    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";

    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";

    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";



    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";

    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";

    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";

    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";

    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";

    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";



    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";

    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";

    if ([deviceString isEqualToString:@"iPad4,3"])      return @"iPad Air";

    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";

    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";

    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";

    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";



    if ([deviceString isEqualToString:@"iPad4,4"]

            ||[deviceString isEqualToString:@"iPad4,5"]

            ||[deviceString isEqualToString:@"iPad4,6"])      return @"iPad mini 2";



    if ([deviceString isEqualToString:@"iPad4,7"]

            ||[deviceString isEqualToString:@"iPad4,8"]

            ||[deviceString isEqualToString:@"iPad4,9"])      return @"iPad mini 3";



    return deviceString;
}

+ (NSString *)convertHexStrToString:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    //TODO 去除字符串中的后一位

    NSMutableData *hexData = [[[NSMutableData alloc] initWithCapacity:8] autorelease];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[[NSScanner alloc] initWithString:hexCharStr] autorelease];

        [scanner scanHexInt:&anInt];
        NSData *entity = [[[NSData alloc] initWithBytes:&anInt length:1] autorelease];
        [hexData appendData:entity];

        range.location += range.length;
        range.length = 2;
    }
    NSString *string = [[[NSString alloc]initWithData:hexData encoding:NSUTF8StringEncoding] autorelease];
    return string;


}

+ (BOOL)isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
               return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
               return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
              return YES;
    }
    return NO;
}


@end