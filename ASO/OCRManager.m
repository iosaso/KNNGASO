//
// Created by admin on 2017/10/23.
//

#import "OCRManager.h"
#import "AsoManger.h"
#import "PTFakeMetaTouch.h"
#import "CFNotificManager.h"
#import "NetServer.h"
#import "GeneralUtil.h"
#import "Constant.h"


@class  CFNotificManager;


@implementation OCRManager {

@private
    NSString *_serialNumber;
    int _networkErrorOcrCount;
    int _ocrCount;
    int _ocrFrameRetryCount;
    CGImageSourceRef _gifSource;
    NSTimer *_timerAuto;
    int _index;
    BOOL _working;
    UIWebView *_webView;
    NSString *_imageUrl;
    NSData *_imageData;
    NSString *_id_;
    NSString *_userKey;
}


@synthesize serialNumber = _serialNumber;
@synthesize networkErrorOcrCount = _networkErrorOcrCount;
@synthesize ocrCount = _ocrCount;
@synthesize ocrFrameRetryCount = _ocrFrameRetryCount;
@synthesize gifSource = _gifSource;
@synthesize timerAuto = _timerAuto;
@synthesize index = _index;
@synthesize working = _working;
@synthesize webView = _webView;
@synthesize imageUrl = _imageUrl;
@synthesize imageData = _imageData;
@synthesize id_ = _id_;
@synthesize userKey = _userKey;

- (void)dealloc {
    [_serialNumber release];
    [_timerAuto release];
    [_webView release];
    [_imageUrl release];
    [_imageData release];
    [_id_ release];
    [_userKey release];
    [super dealloc];
}


+ (OCRManager *)sharedInstance {
//    NSLog(@"OCRManager 已经进入到当前的验证码识别");
    static OCRManager* mAso;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mAso = [[OCRManager alloc] init];
    });
    return mAso;
}


- (void)outImg:(id)img {
    UIImageView* mImage = [_webView viewWithTag:667];
    [mImage setImage:img];
}

- (void)outLog1:(id)a1 {

    UILabel* mview =   [_webView viewWithTag:1002];
    if (mview) {
        [mview setText: a1];
    }
}

- (void)outLog:(id)log {
    UILabel * mLabel= [_webView viewWithTag:102];
    [mLabel setText: log];
}

- (void)err:(id)err {
    [(UILabel*)[_webView viewWithTag:66 ] setText: err];
}

//- (void)notifCaptchaViewTimeout {
//    [self CaptchaViewTimeout];
//    // 进行重新请求
//    // 通知 超时
//    [[AsoManager sharedInstance] failByDes:@"验证码超时"];
//
//}

- (void)CaptchaViewTimeout {
    [self notifyCaptchaTimeout];
    // 进行通知进行重新请求


}

- (void)cancelCaptchaViewTimeout {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(CaptchaViewTimeout) object:nil];
}

- (void)notifyCaptchaTimeout {
    // 进行传递当前的数值
    [CFNotificManager SendMessage:ORM_TIME_OUT];
}

- (void)captchaTimeout {
    [self notifyCaptchaTimeout];
}
//
//- (void)autoCodeAction1:(id)a1 {
//    UILabel * mLabel = [_webView viewWithTag:104];
//    [self ok:[mLabel text]];
//}
//
//- (void)autoCodeAction:(id)action {
//    UILabel * mLabel = [_webView viewWithTag:104];
//    [self ok:[mLabel text]];
//}

- (void)addButton:(id)webview {
    if ([webview viewWithTag:102]) {
        UILabel * mLabel =  [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 60.0, 320.0, 30.0)]autorelease ];
        [mLabel setTextAlignment:1];
        [mLabel setTag:102];
        [webview  addSubview:mLabel];

    }


    if ([webview viewWithTag:1002]) {
        UILabel * mLabel =  [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 90.0, 320.0, 30.0)]autorelease ];
        [mLabel setTextAlignment:1];
        [mLabel setTag:1002];
        [webview  addSubview:mLabel];

    }

    if ([webview viewWithTag:103]) {
        UIImageView * mImage =  [[[UIImageView alloc] initWithFrame:CGRectMake(81.0, 110.0, 231.0, 53.0)]autorelease ];
        CALayer * mLayer  =[mImage layer];
        [mLayer setBorderColor:[[UIColor redColor] CGColor]];
        [mImage setTag:103];
        [webview  addSubview:mImage];

    }
}

- (void)EndOCR {
    UILabel * mLabel = [_webView viewWithTag:102];
    [self outLog:[NSString stringWithFormat:@"%@: 已点击下一步",[mLabel text]]];

    [PTFakeMetaTouch fakeTouchId:[PTFakeMetaTouch fakeTouchId:[PTFakeMetaTouch getAvailablePointId] AtPoint:CGPointMake(280.0, 40.0) withTouchPhase:UITouchPhaseBegan] AtPoint:CGPointMake(280.0, 40.0) withTouchPhase:UITouchPhaseEnded];
    //  object 的参数未知 暂时写为nil
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(CaptchaViewTimeout) object:nil];

    [self performSelector:@selector(CaptchaViewTimeout)  withObject:nil afterDelay:5];
}

- (void)fill:(id)fill {
    //  点击方位还不清楚  暂时设置为100  ，100  点
    [PTFakeMetaTouch fakeTouchId:[PTFakeMetaTouch fakeTouchId:
            [PTFakeMetaTouch getAvailablePointId] AtPoint:CGPointMake(70, 305) withTouchPhase:UITouchPhaseBegan] AtPoint:CGPointMake(70, 305) withTouchPhase:UITouchPhaseEnded];
    [_webView performSelector:@selector(stringByEvaluatingJavaScriptFromString:) withObject:[NSString stringWithFormat:@"fillCode('%@');",fill] afterDelay:0.5];
    [self performSelector:@selector(EndOCR) withObject:nil afterDelay:0.5];

}

- (void)ok:(id)ok {
    UILabel * mLabel = [_webView viewWithTag:102 ];
    [mLabel setText: ok];
    [self fill:ok];

}

- (void)formatCode:(id)code {
    if(!code){
        return;
    }

    NSString * mReplace = [code stringByReplacingOccurrencesOfString:@" " withString:@""];


    if (mReplace && ([mReplace length] >= 3)) {
        [self ok:[[mReplace retain] autorelease]];
    }else{
        [self outLog:[NSString stringWithFormat:@"验证码： %@错误", mReplace]];
        [self nextFrame];
    }

}

- (void)ocrImage {
    // 请求后端 进行网络请求
    [self outLog:@"开始识别"];
    if (_imageData) {
        // 开始base64加密  在转Url编码
        [NetServer sendIdentifyingCode:_imageData withBack:^(NSData *data, NSURLResponse *response, NSError *error) {
            if(error){
                [self err:[error localizedDescription]];
                _networkErrorOcrCount += 1;
                if(_networkErrorOcrCount < 4){
                    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(ocrImage) object:nil];
                    [self performSelector:@selector(ocrImage) withObject:nil afterDelay:0.5];
                    return ;
                }
                _networkErrorOcrCount = 0;
                [self captchaTimeout];
                return;
            }
            NSError *jsonErrorr = nil;
            //Json解析
            NSDictionary *mImageData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonErrorr];
            id errorMessage = [mImageData objectForKeyedSubscript:@"err"];
            if([errorMessage intValue] == 1){

                [self err:[mImageData objectForKeyedSubscript:@"msg"]];
                [self nextFrame];
                return ;
            }
            if([errorMessage intValue]){
                _working = NO;
                id msg = [mImageData objectForKeyedSubscript:@"msg"];
                [self err:msg];
                return;
            }else{
                _working = NO;

                id result = [mImageData objectForKeyedSubscript:@"result"];
                id code   = [result objectForKeyedSubscript:@"code"];
                [self formatCode:code];

                return ;
            }
        }];

    }else{

        [self getCodeImage];

    }

}



- (void)nextFrame {
    if(_webView && _gifSource){

        NSInteger mFrameNumber = CGImageSourceGetCount(_gifSource);
        if (mFrameNumber) {
            if (mFrameNumber < 4) {

                CGImageRef mImageRef =  CGImageSourceCreateImageAtIndex(_gifSource, _index, nil);
                [self outImg: [UIImage imageWithCGImage:mImageRef]];
                _imageData = UIImagePNGRepresentation([UIImage imageWithCGImage:mImageRef]);
                CFRelease(mImageRef);
                _index += 4;
                [self ocrImage];
            }else{
                _index = 3;
                _ocrCount -= 1;
                [self outLog:@"5次请求错误，刷新图片"];
                [_webView stringByEvaluatingJavaScriptFromString:@"updateCode();"];
            }
        }
    }

}

- (void)getCodeImage {
    if (_webView ) {
        if (_imageData) {
            CFRelease(_imageData);
            _imageData = nil;
        }
        [self outLog:@"取验证码"];

        // 错误转化  NSURL 和  NSString
        NSURL* mImageUrl = [NSURL URLWithString:_imageUrl];
        NSMutableURLRequest*   mImageRequest = [NSMutableURLRequest requestWithURL:mImageUrl cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5];
        [mImageRequest setHTTPMethod:@"GET"];

        [[[NSURLSession sharedSession] dataTaskWithRequest:mImageRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                [self err:[error localizedDescription]];
                _networkErrorOcrCount += 1;
                if(_networkErrorOcrCount >= 4){
                    _networkErrorOcrCount = 0;
                    [self captchaTimeout];

                }
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(getCodeImage) object:nil];
                return ;
            }
            _gifSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
            [self nextFrame];
        }] resume];
    }
}
NSInteger ocrNumber = 0;
- (void)ocr:(id)ocr {
    // 显示Log
    _webView = ocr;
    [self outLog1:[NSString stringWithFormat:@"第%@界面",[NSNumber numberWithInt:++ocrNumber]]];
    [self addButton:ocr];
    [self outLog:@"等待加载验证码"];
    //进行注入脚本代码
    //进行当前的脚本格式状态
    // 进行获取HTML中的空间和图片链接内容
    [_webView stringByEvaluatingJavaScriptFromString:
            [GeneralUtil convertHexStrToString:OCR_WEB_FUNCTION]];

}

- (void)codeUrlChangeNotify {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(CaptchaViewTimeout) object:nil];
    _ocrCount += 1;
    _index = 3;

    SEL mSelect;
    if (_ocrCount >= 4) {
        _ocrCount = 0;
        mSelect =@selector(captchaTimeout);
    }else{
        _ocrFrameRetryCount = 0;
        mSelect =@selector(getCodeImage);
    }
    [self performSelector:mSelect];
}

- (void)timerAction:(id)action {
    // 进行管理当前超时操作
    if (_webView) {

        NSString* mWebViewImageUrl = [_webView stringByEvaluatingJavaScriptFromString:@"getCodeImageUrl();"];
        if (!mWebViewImageUrl)
            return;
        if ([mWebViewImageUrl length] !=0
                && !_imageUrl ) {
            _imageUrl = mWebViewImageUrl;
            [self codeUrlChangeNotify];
        }
    }
}

- (id)init {
    self = [super init];
    if (self) {
        _working  = FALSE;
        _index = 3;
        _imageData = nil;
        _imageUrl = nil;
        _ocrFrameRetryCount = 0;
        _networkErrorOcrCount = 0;
        _ocrCount = 0;
        _timerAuto = [[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES] retain];
    }
    return self;
}


@end