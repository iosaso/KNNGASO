//
// Created by admin on 2017/10/23.
//
// 此类用于验证码识别的相关配置


#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>
#import <UIKit/UIKit.h>
#include "AsoHeader.h"



@interface OCRManager : NSObject

@property(retain, nonatomic) NSString* serialNumber;
@property(assign, nonatomic) int networkErrorOcrCount;
@property(assign, nonatomic) int ocrCount;
@property(assign, nonatomic) int ocrFrameRetryCount;
@property(assign, nonatomic) CGImageSourceRef gifSource;
@property(retain, nonatomic) NSTimer* timerAuto;
@property(assign, nonatomic) int index;
@property(assign, nonatomic) BOOL working;
@property(retain, nonatomic) UIWebView* webView;
@property(retain, nonatomic) NSString* imageUrl;
@property(retain, nonatomic) NSData* imageData;
@property(retain, nonatomic) NSString* id_;
@property(retain, nonatomic) NSString* userKey;



+(OCRManager *)sharedInstance;
-(void)outImg:(id )img;
-(void)outLog1:(id)a1;
-(void)outLog:(id)log;
-(void)err:(id)err;
-(void)CaptchaViewTimeout;
-(void)cancelCaptchaViewTimeout;
-(void)notifyCaptchaTimeout;
-(void)captchaTimeout;
-(void)addButton:(id)webview;
-(void)EndOCR;
-(void)fill:(id)fill;
-(void)ok:(id)ok;
-(void)formatCode:(id)code;
-(void)ocrImage;
-(void)nextFrame;
-(void)getCodeImage;
-(void)ocr:(id)ocr;
-(void)codeUrlChangeNotify;
-(void)timerAction:(id)action;
-(id)init;



@end