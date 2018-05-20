//
// Created by admin on 2017/11/8.
//
#pragma GCC diagnostic ignored "-Wselector"

#import "NSData+Security.h"
#import <Availability.h>



@implementation NSData (Security)

/**
 *  根据CCOperation，确定加密还是解密
 *
 *  @param operation kCCEncrypt -> 加密  kCCDecrypt－>解密
 *  @param key       公钥
 *  @param iv        偏移量
 *
 *  @return 加密或者解密的NSData
 */
- (NSData *)AES128Operation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv

{

    char keyPtr[kCCKeySizeAES128 + 1];

    memset(keyPtr, 0, sizeof(keyPtr));

    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];



    char ivPtr[kCCBlockSizeAES128 + 1];

    memset(ivPtr, 0, sizeof(ivPtr));

    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];



    NSUInteger dataLength = [self length];

    size_t bufferSize = dataLength + kCCBlockSizeAES128;

    void *buffer = malloc(bufferSize);



    size_t numBytesCrypted = 0;

    CCCryptorStatus cryptStatus = CCCrypt(operation,

            kCCAlgorithmAES128,

            kCCOptionPKCS7Padding|kCCOptionECBMode,

            keyPtr,

            kCCBlockSizeAES128,

            ivPtr,

            [self bytes],

            dataLength,

            buffer,

            bufferSize,

            &numBytesCrypted);

    if (cryptStatus == kCCSuccess) {

        return [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];

    }

    free(buffer);

    return nil;

}


- (NSData *)u43252352ru325:(NSString *)key iv:(NSString *)iv

{

    return [self AES128Operation:kCCEncrypt key:key iv:iv];

}


- (NSData *)U54353420632UI:(NSString *)key iv:(NSString *)iv

{

    return [self AES128Operation:kCCDecrypt key:key iv:iv];

}


+ (NSData *)HHSF6764215:(NSString *)string
{
    if (![string length]) return nil;

    NSData *decoded = nil;

#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0

    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)])
    {
        decoded = [[self alloc] initWithBase64Encoding:[string stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])]];
    }
    else

#endif

    {
        decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }

    return [decoded length]? decoded: nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    if (![self length]) return nil;

    NSString *encoded = nil;

#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0

    if (![NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)])
    {
        encoded = [self base64Encoding];
    }
    else

#endif

    {
        switch (wrapWidth)
        {
            case 64:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            }
            case 76:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
            }
            default:
            {
                encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
            }
        }
    }

    if (!wrapWidth || wrapWidth >= [encoded length])
    {
        return encoded;
    }

    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth)
    {
        if (i + wrapWidth >= [encoded length])
        {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }

    return result;
}

- (NSString *)HGAG538457
{
    return [self base64EncodedStringWithWrapWidth:0];
}




@end