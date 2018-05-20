//
//  CWAESEncryptData.m
//  AES128Encrypt-objc
//
//  Created by kingly on 15/12/1.
//  Copyright © 2015年 kingly. All rights reserved.
//
/**
 * AES128 CBC
 * No Padding加密方式
 */

#import "CWAESEncryptData.h"
#import <CommonCrypto/CommonCryptor.h>

#define FBENCRYPT_ALGORITHM     kCCAlgorithmAES128
#define FBENCRYPT_BLOCK_SIZE    kCCBlockSizeAES128
#define FBENCRYPT_KEY_SIZE      kCCKeySizeAES128


@implementation CWAESEncryptData

/*＊
 *  AES128 + CBC + No Padding
 *
 *  @param data 要加密的原始数据
 *
 *  @return  加密后数据
 */
- (NSData*) encryptData:(NSData *)data{
    
    if (![self checkInfo]) {
        return data;
    }
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [_sKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [_sIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    NSUInteger diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    NSUInteger newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(NSUInteger i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,               //No padding
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return resultData;
    }
    free(buffer);
    return nil;
    
}
/*＊
 *  AES128 + CBC + No Padding
 *
 *  @param data 要解密的原始数据
 *
 *  @return  解密后数据
 */
- (NSData*) decryptData:(NSData *)data{
    
    if (![self checkInfo]) {
        return data;
    }
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [_sKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128 + 1];
    memset(ivPtr, 0, sizeof(ivPtr));
    [_sIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          0x0000,       //No padding
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return resultData;
    }
    free(buffer);
    return nil;
    
}

/**
 * 检查加密合法性
 */
-(BOOL) checkInfo{
    
    if (![self checkKey]) {
        return NO;
    }
    
    if (![self checkivKey]) {
        return NO;
    }
    return YES;
}
/**
 * 密钥长度是否合法
 */
-(BOOL) checkKey{
    
    BOOL succ = YES;
    NSData* keyData = [_sKey dataUsingEncoding:NSUTF8StringEncoding];
    if (keyData.length != 16) {
        NSLog(@"密钥长度不是16字节，请重新设置!");
        succ = NO;
    }
    return succ;
}

/**
 * 检查初始向量是否合法
 */
-(BOOL) checkivKey{
    
    BOOL succ = YES;
    NSData* ivData = [_sIv dataUsingEncoding:NSUTF8StringEncoding];
    if (ivData.length != 16) {
        NSLog(@"iv向量不是16字节，请重新设置!");
        succ = NO;
    }
    return succ;
}

/*＊
 *  AES128 + ECB + PKCS7
 *
 *  @param data 要加密的原始数据
 *
 *  @return  加密后数据
 */
- (NSData*)encryptECBData:(NSData* )data{
    
    if (![self checkKey]) {
        return data;
    }
    
    NSData* result = nil;
    NSData *key = [_sKey dataUsingEncoding:NSASCIIStringEncoding];
    // setup key
    unsigned char cKey[FBENCRYPT_KEY_SIZE];
    bzero(cKey, sizeof(cKey));
    [key getBytes:cKey length:FBENCRYPT_KEY_SIZE];
    
    // setup output buffer
    size_t bufferSize = [data length] + FBENCRYPT_BLOCK_SIZE;
    void *buffer = malloc(bufferSize);
    
    // do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          FBENCRYPT_ALGORITHM,
                                          kCCOptionECBMode|kCCOptionPKCS7Padding,
                                          cKey,
                                          FBENCRYPT_KEY_SIZE,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    } else {
        free(buffer);
        NSLog(@"[ERROR] failed to encrypt|CCCryptoStatus: %d", cryptStatus);
    }
    
    return result;
    
    
}

/*＊
 *  AES128 + ECB + PKCS7
 *
 *  @param data 要解密的原始数据
 *
 *  @return  解密后数据
 */
- (NSData*)decryptECBData:(NSData* )data{
    if (![self checkKey]) {
        return data;
    }
    NSData* result = nil;
    NSData *key = [_sKey dataUsingEncoding:NSASCIIStringEncoding];
    // setup key
    unsigned char cKey[FBENCRYPT_KEY_SIZE];
    bzero(cKey, sizeof(cKey));
    [key getBytes:cKey length:FBENCRYPT_KEY_SIZE];
    
    // setup output buffer
    size_t bufferSize = [data length] + FBENCRYPT_BLOCK_SIZE;
    void *buffer = malloc(bufferSize);
    
    // do decrypt
    size_t decryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          FBENCRYPT_ALGORITHM,
                                          kCCOptionECBMode|kCCOptionPKCS7Padding,
                                          cKey,
                                          FBENCRYPT_KEY_SIZE,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &decryptedSize);
    
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
    } else {
        free(buffer);
        NSLog(@"[ERROR] failed to decrypt| CCCryptoStatus: %d", cryptStatus);
    }
    
    return result;
}
/*＊
 *  AES256 + ECB + PKCS7
 *
 *  @param data 要加密的原始数据
 *
 *  @return  加密后数据
 */
- (NSData *)AES256EncryptWithData:(NSData* )data {
    // 'key' 必须是32字节 AES256,不足的用零补充
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr)); // 用零填充（填充）
    // fetch key data
    [_sKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    //块加密，输出的大小总是小于或等于输入大小加一块大小。
    //我们需要在这里添加一个块大小的原因
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //返回的NSData以缓冲区并将它释放自由
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //释放缓冲区;
    return nil;
}
/*＊
 *  AES256 + ECB + PKCS7
 *
 *  @param data 要解密的原始数据
 *
 *  @return  解密后数据
 */
- (NSData *)AES256DecryptWithData:(NSData* )data  {
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    // fetch key data
    [_sKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data  length];

    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [data bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

@end
