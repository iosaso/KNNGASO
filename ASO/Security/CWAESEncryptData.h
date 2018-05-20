//
//  CWAESEncryptData.h
//  AES128Encrypt-objc
//
//  Created by kingly on 15/12/1.
//  Copyright © 2015年 kingly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../AsoHeader.h"
@interface CWAESEncryptData : NSObject

@property (nonatomic,copy) NSString *sKey; //16位的字符串
@property (nonatomic,copy) NSString *sIv;  //16位的字符串


/*＊
 *  AES128 + CBC + No Padding
 *
 *  @param data 要加密的原始数据
 *
 *  @return  加密后数据
 */
- (NSData*) encryptData:(NSData *)data;
/*＊
 *  AES128 + CBC + No Padding
 *
 *  @param data 要解密的原始数据
 *
 *  @return  解密后数据
 */
- (NSData*) decryptData:(NSData *)data;

/*＊
 *  AES128 + ECB + PKCS7
 *
 *  @param data 要加密的原始数据
 *
 *  @return  加密后数据
 */
- (NSData*)encryptECBData:(NSData*)data;

/*＊
 *  AES128 + ECB + PKCS7
 *
 *  @param data 要解密的原始数据
 *
 *  @return  解密后数据
 */
- (NSData*)decryptECBData:(NSData*)data;
/*＊
 *  AES256 + ECB + PKCS7
 *
 *  @param data 要加密的原始数据
 *
 *  @return  加密后数据
 */
- (NSData *)AES256EncryptWithData:(NSData* )data;
/*＊
 *  AES256 + ECB + PKCS7
 *
 *  @param data 要解密的原始数据
 *
 *  @return  解密后数据
 */
- (NSData *)AES256DecryptWithData:(NSData* )data;

@end
