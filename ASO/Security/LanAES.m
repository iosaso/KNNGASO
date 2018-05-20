//
// Created by admin on 2017/11/8.
//

#import "LanAES.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSData+Security.h"
#import "GTMBase64.h"
#define gIv @"1234567890123456"
size_t const kKeySize = kCCKeySizeAES128;
NSString *const kInitVector = @"1234567890123456";

#import "CWAESEncryptData.h"

@implementation LanAES {

}
+ (NSString *)md5:(NSString *)content {
    const char *cStr = [content UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02X", digest[i]];
    }
    return result;
}


+ (NSString *)AES128EncryptWithBase64:(NSString *)plainText withKey:(NSString *)key {
    CWAESEncryptData *AESEncryptData = [[[CWAESEncryptData alloc] init] autorelease];
    AESEncryptData.sKey = key;
    AESEncryptData.sIv  = kInitVector;
    NSData *requData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSData *enECBData = [AESEncryptData encryptECBData:requData];
    return [enECBData base64EncodedStringWithOptions:0];
}

+ (NSString *)AES128DecryptWithBase64:(NSString *)encryptText withKey:(NSString *)key{
    CWAESEncryptData *AESEncryptData = [[[CWAESEncryptData alloc] init] autorelease];
    AESEncryptData.sKey = key;
    AESEncryptData.sIv  = kInitVector;
    NSData * AESData = [[[NSData alloc] initWithBase64EncodedString:encryptText options:0] autorelease];
    NSData *deECBData = [AESEncryptData decryptECBData:AESData];
    return [[NSString alloc] initWithData:deECBData encoding:NSUTF8StringEncoding];
}



+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key {

    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = contentData.length;

    // 为结束符'\0' +1
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;

    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
            kCCAlgorithmAES,
            kCCOptionPKCS7Padding,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding
            keyPtr,
            kKeySize,
            initVector.bytes,
            contentData.bytes,
            dataLength,
            encryptedBytes,
            encryptSize,
            &actualOutSize);

    if (cryptStatus == kCCSuccess) {
        // 对加密后的数据进行 base64 编码
        return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    free(encryptedBytes);
    return nil;
}

+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key {
// 把 base64 String 转换成 Data
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSUInteger dataLength = contentData.length;
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t decryptSize = dataLength + kCCBlockSizeAES128;
    void *decryptedBytes = malloc(decryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
            kCCAlgorithmAES,
            kCCOptionPKCS7Padding,
            keyPtr,
            kKeySize,
            initVector.bytes,
            contentData.bytes,
            dataLength,
            decryptedBytes,
            decryptSize,
            &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize] encoding:NSUTF8StringEncoding];
    }
    free(decryptedBytes);
    return nil;
}




+ (NSData*)convertHexStrToData:(NSString*)str {
    if (!str || [str length] ==0) {
        return nil;
    }

    NSMutableData *hexData = [[NSMutableData alloc]initWithCapacity:[str length]*2];
    NSRange range;
    if ([str length] %2==0) {
        range = NSMakeRange(0,2);
    } else {
        range = NSMakeRange(0,1);
    }
    for (NSInteger i = range.location; i < [str length]; i +=2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc]initWithString:hexCharStr];

        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc]initWithBytes:&anInt length:1];
        [hexData appendData:entity];

        range.location+= range.length;
        range.length=2;
    }
//    NSLog(@"hexdata: %@", hexData);
    return hexData;
}

//NSData转换为16进制
+ (NSString*)convertDataToHexStr:(NSData*)data {
    if (!data || [data length] ==0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc]initWithCapacity:[data length]/2];

    [data enumerateByteRangesUsingBlock:^(const void*bytes,NSRange byteRange,BOOL*stop) {
        unsigned char *dataBytes = (unsigned  char*)bytes;
        for (NSInteger i =0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] ==2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];

    return string;
}


+(NSData *)AES256ParmEncryptWithKey:(NSString *)key Encrypttext:(NSData *)text  //加密
{

    char keyPtr[kCCKeySizeAES256+1];

    bzero(keyPtr, sizeof(keyPtr));

    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [text length];

    size_t bufferSize = dataLength + kCCBlockSizeAES128;

    void *buffer = malloc(bufferSize);

    size_t numBytesEncrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,

            kCCOptionPKCS7Padding | kCCOptionECBMode,

            keyPtr, kCCBlockSizeAES128,

            NULL,

            [text bytes], dataLength,

            buffer, bufferSize,

            &numBytesEncrypted);

    if (cryptStatus == kCCSuccess) {

        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];

    }

    free(buffer);

    return nil;

}


+ (NSData *)AES256ParmDecryptWithKey:(NSString *)key Decrypttext:(NSData *)text  //解密

{

    char keyPtr[kCCKeySizeAES256+1];

    bzero(keyPtr, sizeof(keyPtr));

    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];

    NSUInteger dataLength = [text length];

    size_t bufferSize = dataLength + kCCBlockSizeAES128;

    void *buffer = malloc(bufferSize);

    size_t numBytesDecrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,

            kCCOptionPKCS7Padding | kCCOptionECBMode,

            keyPtr, kCCBlockSizeAES128,

            NULL,

            [text bytes], dataLength,

            buffer, bufferSize,

            &numBytesDecrypted);

    if (cryptStatus == kCCSuccess) {

        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];

    }

    free(buffer);

    return nil;

}


+(NSString *) aes256_encrypt:(NSString *)key Encrypttext:(NSString *)text

{

    const char *cstr = [text cStringUsingEncoding:NSUTF8StringEncoding];

    NSData *data = [NSData dataWithBytes:cstr length:text.length];

    //对数据进行加密

    NSData *result = [LanAES AES256ParmEncryptWithKey:key Encrypttext:data];



    //转换为2进制字符串

    if (result && result.length > 0) {



        Byte *datas = (Byte*)[result bytes];

        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];

        for(int i = 0; i < result.length; i++){

            [output appendFormat:@"%02x", datas[i]];

        }

        return output;

    }

    return nil;

}


+(NSString *) aes256_decrypt:(NSString *)key Decrypttext:(NSString *)text

{

    //转换为2进制Data

    NSMutableData *data = [NSMutableData dataWithCapacity:text.length / 2];

    unsigned char whole_byte;

    char byte_chars[3] = {'\0','\0','\0'};

    int i;

    for (i=0; i < [text length] / 2; i++) {

        byte_chars[0] = [text characterAtIndex:i*2];

        byte_chars[1] = [text characterAtIndex:i*2+1];

        whole_byte = strtol(byte_chars, NULL, 16);

        [data appendBytes:&whole_byte length:1];

    }



    //对数据进行解密

    NSData* result = [LanAES  AES256ParmDecryptWithKey:key Decrypttext:data];

    if (result && result.length > 0) {

        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];

    }

    return nil;

}

@end