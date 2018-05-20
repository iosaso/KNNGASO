//
//  SBViewChangeDelegate.h
//  NianGao_ASO
//
//  Created by admin on 2017/10/19.
//
//

#import <Foundation/Foundation.h>
#include "AsoHeader.h"


typedef enum {
    // 弹出超时状态
    TIMEOUT     = 0,
    // 弹出验证码超时
    TIMEOUT_OCR = 1,
    // 没有无线网
    NET_NO_WIFI = 2,
    // 当前账号无效
    ACCOUNT_BAD = 3,

}AlertType;

@protocol SBViewChangeDelegate <NSObject>


// 显示序列Label
-(void)hiddenSerialLabel;
// 关闭序列Label
//-(void)showSerialLable;

// 改变Button边框的颜色
-(void)changeButtonColor:(id)color;


// 返回等待状态
-(void)waitStateButton;

// 进行弹出响应内容展示
-(void)notifyWorkState:(id)message;

// 复位按钮
-(void)reStartState;

@end
