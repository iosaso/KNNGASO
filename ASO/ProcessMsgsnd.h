//
// Created by admin on 2017/10/20.
// 主要用于进程间进行传递消息使用

#import <Foundation/Foundation.h>
#include "AsoHeader.h"

@interface ProcessMsgsnd : NSObject

+(void)sendMessage:(NSDictionary * _Nullable)message;

+( NSDictionary<NSString *, id> *_Nullable)getMessage;


@end