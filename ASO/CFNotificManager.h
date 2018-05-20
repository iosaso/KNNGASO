//
// Created by admin on 2017/10/21.
//

#import <Foundation/Foundation.h>
#include "AsoHeader.h"
// 进行类别区分
typedef enum MESSAGE_TYPE{
    // Appstore 请求有数据
    TIMER_APPSTORE_SUCCESS = 0,
    // 刷榜 时间限制内成功
    TIMER_APPLICATION_SUCCESS = 1,
    // 触摸下载按钮事件
    TOUCH_CLICK_DOWNLOAD_BUTTON = 2,
    // 卸载应用时候进行
    UNINSTALL_APPLICATION = 3,
    // 进行清除应用缓存
    Clear_CACHE_APP = 4,
    // 验证码超时
    ORM_TIME_OUT =5,
    //总时间管理
    TIMER_APPLICATION_SPRINGBOARD_REGISTER = 6,
    //AppStore管理
    TIMER_APPSTORE_SPRINGBOARD_REGISTER = 7,
    //进行相关的操作选项
    TIMER_APPLICATION_SPRINGBOARD_STOP = 8,
    //进行相关的关闭选项
    TIMER_APPSTORE_SPRINGBOARD_STOP= 9,
    //进行设置开始任务
    APPLICATiON_START_TASK  = 10,
    //命令行杀死AppStore
    CMD_KILL_APPSTORE = 11,
    // 命令行杀死SpringBoard
    CMD_KILL_SPRINGBOARD = 12,
    // 进行登出账号操作
    ACCOUNT_SIGNOUT = 13,
    // 进行打开AppStore操作
    OPEN_APPSTORE = 14,
    // 进行自动化搜索设置
    AUTO_SEARCH = 15,
    // 测试传值使用
    TEST_EXCHANGE_VALUE = 16,
    // 设置当前的工作状态为开始
    WORK_STATE_START = 17,
    // 设置当前的工作状态为停止
    WORK_STATE_END = 18,
    // 进行更改视图的状态
    WINDOW_STATE_SHOW = 19,
    // 网络请求成功
    TASK_COMPLICATION_WITH_NET_REPORT =20,
    // 计时重新开启任务
    TIMER_APPLICATION_RESTARTTASK = 21

}MessageType;


@interface CFNotificManager : NSObject

// 不需要带参
+(void)SendMessage:(MessageType) type;

// 不需要带参
+(void)AddMessage:(MessageType)type;
// 需要带参
+(void)SendMessage:(MessageType) type withInfo:(NSDictionary *)info;
// 需要带参
+(void)SendMessage:(MessageType) type withString:(NSString *)info;





@end