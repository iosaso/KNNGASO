//
// Created by admin on 2017/11/8.
//

#import <Foundation/Foundation.h>
#import "../AsoHeader.h"

@interface LanAES : NSObject

+(NSData *)AES256ParmEncryptWithKey:(NSString *)key Encrypttext:(NSData *)text;   //加密

+(NSData *)AES256ParmDecryptWithKey:(NSString *)key Decrypttext:(NSData *)text;   //解密

+(NSString *) aes256_encrypt:(NSString *)key Encrypttext:(NSString *)text;

+(NSString *) aes256_decrypt:(NSString *)key Decrypttext:(NSString *)text;

+ (NSString *)AES128EncryptWithBase64:(NSString *)plainText withKey:(NSString *)key;

+ (NSString *)AES128DecryptWithBase64:(NSString *)encryptText withKey:(NSString *)key;

+(NSString *)md5:(NSString *)content;
@end