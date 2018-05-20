//
// Created by admin on 2017/10/21.
//

#import "CFNotificManager.h"
#import "AsoManger.h"
#import "TimerManager.h"
#import "ProcessCmd.h"
#import "SBManager.h"
#import "ASManager.h"
#import "ProcessMsgsnd.h"
#import "SBViewManager.h"
#import "NetServer.h"

#ifndef CFNOTIFIC
#define CFNOTIFIC

#define TOUCH_DOWNLOAD_BUTTON CFSTR("getTouchPoint")

#define TIMER_APPSTORE CFSTR("appstoreSuccess")

#define TIMER_APPLICATION CFSTR("applicationSuccess")

#define UNINSTALL_APP CFSTR("UNINSTALL_APPLICATION")

#define Clear_CACHE CFSTR("Clear_CACHE_APP")

#define ORM_TIME CFSTR("ORM_TIME_OUT")

#define TIMER_APPLICATION_SB_REGIST CFSTR("TIMER_APPLICATION_SB_REGIST")

#define TIMER_APPSTORE_SB_REGIST CFSTR("TIMER_APPSTORE_SB_REGIST")

#define TIMER_APPSTORE_SB_STOP CFSTR("TIMER_APPSTORE_SB_STOP")

#define TIMER_APPLICATION_SB_STOP CFSTR("TIMER_APPLICATION_SB_STOP")

#define APPLICATION_SB_START_TASK CFSTR("APPLICATION_SB_START_TASK")

#define CMD_KILL_APPSTORE_NAME CFSTR("CMD_KILL_APPSTORE")

#define CMD_KILL_SPRINGBOARD_NAME CFSTR("CMD_KILL_SPRINGBOARD")

#define ACCOUNT_SIGNOUT_NAME CFSTR("ACCOUNT_SIGNOUT")

#define OPEN_APPSTORE_NAME CFSTR("OPEN_APPSTORE")

#define AUTO_SEARCH_NAME CFSTR("AUTO_SEARCH")

#define TEST_EXCHANGE_VALUE_NAME CFSTR("TEST_EXCHANGE_VALUE")

#define WORK_STATE_START_NAME CFSTR("WORK_STATE_START")

#define WORK_STATE_END_NAME CFSTR("WORK_STATE_END")

#define WINDOW_STATE_SHOW_NAME CFSTR("WINDOW_STATE_SHOW")

#define TASK_COMPLICATION_WITH_NET_REPORT_NAME CFSTR("TASK_COMPLICATION_WITH_NET_REPORT")

#define TIMER_APPLICATION_RESTARTTASK_NAME CFSTR("TIMER_APPLICATION_RESTARTTASK")


#endif








@implementation CFNotificManager {

}


+ (void)SendMessage:(MessageType)type withString:(NSString *)info {
    void *object;
    CFNotificationCenterRef center =
            CFNotificationCenterGetDarwinNotifyCenter();
    CFDictionaryRef userInfo;
    switch (type) {
        case WINDOW_STATE_SHOW:{
            // 进行存放当前的信息
            NSDictionary * dic1 = [[NSUserDefaults standardUserDefaults]persistentDomainForName:NSGlobalDomain];
            NSMutableDictionary * temDic = [NSMutableDictionary dictionaryWithDictionary:dic1];
            [temDic setObject:info forKey:@"WINDOW_STATE_SHOW"];
            [ProcessMsgsnd sendMessage:temDic];
            CFNotificationCenterPostNotification(center, WINDOW_STATE_SHOW_NAME, object,userInfo, true);
            break;
        }
        default:
            break;
    }


}


+ (void)SendMessage:(MessageType)type withInfo:(NSDictionary *)info {
    void *object;
    CFNotificationCenterRef center =
            CFNotificationCenterGetDarwinNotifyCenter();

    switch (type) {
        case TEST_EXCHANGE_VALUE:
            CFNotificationCenterPostNotification(center, TEST_EXCHANGE_VALUE_NAME, object,(__bridge CFDictionaryRef) info, true);

            break;

        default:
            break;
    }
}


+ (void)SendMessage:(MessageType)type {
    void *object;
    CFDictionaryRef userInfo;
    CFNotificationCenterRef center =
            CFNotificationCenterGetDarwinNotifyCenter();

    switch (type){
        case TIMER_APPSTORE_SUCCESS:
            CFNotificationCenterPostNotification(center, TIMER_APPSTORE, object, userInfo, true);
            break;
        case TIMER_APPLICATION_SUCCESS:
            CFNotificationCenterPostNotification(center, TIMER_APPLICATION, object, userInfo, true);
            break;
        case TOUCH_CLICK_DOWNLOAD_BUTTON:
            CFNotificationCenterPostNotification(center, TOUCH_DOWNLOAD_BUTTON, object, userInfo, true);
            break;
        case UNINSTALL_APPLICATION:
            CFNotificationCenterPostNotification(center, UNINSTALL_APP, object, userInfo, true);
            break;
        case Clear_CACHE_APP:
            CFNotificationCenterPostNotification(center, Clear_CACHE, object, userInfo, true);
            break;
        case ORM_TIME_OUT:
            CFNotificationCenterPostNotification(center, ORM_TIME, object, userInfo, true);
            break;
        case TIMER_APPLICATION_SPRINGBOARD_REGISTER:
            CFNotificationCenterPostNotification(center, TIMER_APPLICATION_SB_REGIST, object, userInfo, true);
            break;
        case TIMER_APPSTORE_SPRINGBOARD_REGISTER:
            CFNotificationCenterPostNotification(center, TIMER_APPSTORE_SB_REGIST, object, userInfo, true);
            break;
        case TIMER_APPLICATION_SPRINGBOARD_STOP:
            CFNotificationCenterPostNotification(center, TIMER_APPSTORE_SB_STOP, object, userInfo, true);
            break;
        case TIMER_APPSTORE_SPRINGBOARD_STOP:
            CFNotificationCenterPostNotification(center, TIMER_APPLICATION_SB_STOP, object, userInfo, true);
            break;
        case APPLICATiON_START_TASK:
            CFNotificationCenterPostNotification(center, APPLICATION_SB_START_TASK, object, userInfo, true);
            break;
        case CMD_KILL_APPSTORE:
            CFNotificationCenterPostNotification(center, CMD_KILL_APPSTORE_NAME, object, userInfo, true);
            break;
        case CMD_KILL_SPRINGBOARD:
            CFNotificationCenterPostNotification(center, CMD_KILL_SPRINGBOARD_NAME, object, userInfo, true);
            break;
        case ACCOUNT_SIGNOUT:
            CFNotificationCenterPostNotification(center, ACCOUNT_SIGNOUT_NAME, object, userInfo, true);
            break;
        case OPEN_APPSTORE:
            CFNotificationCenterPostNotification(center, OPEN_APPSTORE_NAME, object, userInfo, true);
            break;
        case AUTO_SEARCH:
            CFNotificationCenterPostNotification(center, AUTO_SEARCH_NAME, object, userInfo, true);
            break;
        case WORK_STATE_START:
            CFNotificationCenterPostNotification(center, WORK_STATE_START_NAME, object, userInfo, true);
            break;
        case WORK_STATE_END:
            CFNotificationCenterPostNotification(center, WORK_STATE_END_NAME, object, userInfo, true);
            break;
        case TASK_COMPLICATION_WITH_NET_REPORT:
            CFNotificationCenterPostNotification(center, TASK_COMPLICATION_WITH_NET_REPORT_NAME, object, userInfo, true);
            break;
        case TIMER_APPLICATION_RESTARTTASK:
            CFNotificationCenterPostNotification(center, TIMER_APPLICATION_RESTARTTASK_NAME, object, userInfo, true);
            break;
        default:
            break;


    }




}


static  void getTouchPointCallBack(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
       [[ASManager instance] getTouchPoint];

}

static  void StopAppStoreTimer(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){

         [[TimerManager instance] cancelAppStoreTimer];
}

static  void StopApplicationTimer(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
        [[TimerManager instance] cancelApplicationTimer];

}

static  void UninstallApp(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
        [[SBManager instance] unInstallDownloadApp];

}
static  void ClearCache(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
       [[SBManager instance] deleteDownloadTempFile];

}
static  void OCRTimeOut(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
        [[AsoManager sharedInstance] failByDes:@"验证码超时异常"];

}
static  void Timer_Application_Start(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
        [[TimerManager instance] registApplicationTimer];

}
static  void Timer_Application_End(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
        [[TimerManager instance] cancelApplicationTimer];

}
static  void Timer_Appstore_Start(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
        [[TimerManager instance] registAppStoreTimer];

}
static  void Timer_Appstore_End(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
        [[TimerManager instance] cancelAppStoreTimer];

}
static  void Application_Start_TASK(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
        NSLog(@"执行了");
        [[AsoManager sharedInstance] getTask];
}
static  void Kill_APPSTORE(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
       [[ProcessCmd shareInstance] killAppStore];
}

static  void Kill_SPRINGBOARD(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
       [[ProcessCmd shareInstance] killSpringBoard];
}
static  void ACCOUNT_SIGNOUT_FUN(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
       [[ASManager instance] signOutAccount];
}
static  void OPEN_APPSTORE_FUN(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
       //[[SBManager instance] LaunchAppStore];
}
static  void AUTO_SEARCH_FUN(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
//       [[ASManager instance] autoSearch];
}
static  void TEST_EXCHANGE_VALUE_FUN(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
//       [[ASManager instance] autoSearch];

    NSLog(@"userInfo = %@", [(NSDictionary *)userInfo objectForKeyedSubscript:@"1"]);
    NSLog(@"object = %p", object);
    NSLog(@"name = %p", name);


}
static  void WORK_STATE_START_FUN(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){

        // 进行修改各状态需要的状态信息

}
static  void WORK_STATE_END_FUN(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){

        // 进行修改当前状态的信息



}
// 进行更改视图内容的调用
static  void WINDOW_STATE_SHOW_FUN(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
        // 进行修改当前状态的信息
        id message = [ProcessMsgsnd getMessage];
        id WINDOW_STATE_SHOW = [message objectForKeyedSubscript:@"WINDOW_STATE_SHOW"];


        if(!WINDOW_STATE_SHOW){
                return;
        }
        [[SBViewManager shareInstance] notifyWorkState:WINDOW_STATE_SHOW];
}
// 进行更改视图内容的调用
static  void TASK_COMPLICATION_WITH_NET_REPORT_FUN(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
        // 进行修改当前状态的信息
        [NetServer sendSuccessToCould];


}
static  void TIMER_APPLICATION_RESTARTTASK_FUN(CFNotificationCenterRef center,
        void *observer,
        CFStringRef name,
        const void *object,
        CFDictionaryRef userInfo){
        // 进行修改当前状态的信息
        [[AsoManager sharedInstance] performSelector:@selector(getTask) withObject:nil afterDelay:1.5];
}


+ (void)AddMessage:(MessageType)type {

    CFNotificationCenterRef center =
            CFNotificationCenterGetDarwinNotifyCenter();

    CFNotificationSuspensionBehavior behavior =
            CFNotificationSuspensionBehaviorDeliverImmediately;

    switch (type){
        case TIMER_APPSTORE_SUCCESS:
            CFNotificationCenterAddObserver(center, NULL, StopAppStoreTimer,
                    TIMER_APPSTORE, NULL, behavior);
            break;
        case TIMER_APPLICATION_SUCCESS:
            CFNotificationCenterAddObserver(center, NULL, StopApplicationTimer,
                    TIMER_APPLICATION, NULL, behavior);
            break;
        case TOUCH_CLICK_DOWNLOAD_BUTTON:
            CFNotificationCenterAddObserver(center, NULL, getTouchPointCallBack,
                    TOUCH_DOWNLOAD_BUTTON, NULL, behavior);
            break;
        case UNINSTALL_APPLICATION:
            CFNotificationCenterAddObserver(center, NULL, UninstallApp,
                    UNINSTALL_APP, NULL, behavior);
            break;
        case Clear_CACHE_APP:
            CFNotificationCenterAddObserver(center, NULL, ClearCache,
                    Clear_CACHE, NULL, behavior);
            break;
        case ORM_TIME_OUT:
            CFNotificationCenterAddObserver(center, NULL, OCRTimeOut,
                    ORM_TIME, NULL, behavior);
            break;
         case TIMER_APPLICATION_SPRINGBOARD_REGISTER:
            CFNotificationCenterAddObserver(center, NULL, Timer_Application_Start,
                    TIMER_APPLICATION_SB_REGIST, NULL, behavior);
            break;
        case TIMER_APPSTORE_SPRINGBOARD_REGISTER:
            CFNotificationCenterAddObserver(center, NULL, Timer_Appstore_Start,
                    TIMER_APPSTORE_SB_REGIST, NULL, behavior);
            break;
        case TIMER_APPLICATION_SPRINGBOARD_STOP:
            CFNotificationCenterAddObserver(center, NULL, Timer_Application_End,
                    TIMER_APPSTORE_SB_STOP, NULL, behavior);
            break;
        case TIMER_APPSTORE_SPRINGBOARD_STOP:
            CFNotificationCenterAddObserver(center, NULL, Timer_Appstore_End,
                    TIMER_APPLICATION_SB_STOP, NULL, behavior);
            break;
        case APPLICATiON_START_TASK:
            CFNotificationCenterAddObserver(center, NULL, Application_Start_TASK,
                    APPLICATION_SB_START_TASK, NULL, behavior);
            break;
        case CMD_KILL_APPSTORE:
            CFNotificationCenterAddObserver(center, NULL, Kill_APPSTORE,
                    CMD_KILL_APPSTORE_NAME, NULL, behavior);
            break;
        case CMD_KILL_SPRINGBOARD:
            CFNotificationCenterAddObserver(center, NULL, Kill_SPRINGBOARD,
                    CMD_KILL_SPRINGBOARD_NAME, NULL, behavior);
            break;
        case ACCOUNT_SIGNOUT:
            CFNotificationCenterAddObserver(center, NULL, ACCOUNT_SIGNOUT_FUN,
                    ACCOUNT_SIGNOUT_NAME, NULL, behavior);
            break;
        case OPEN_APPSTORE:
            CFNotificationCenterAddObserver(center, NULL, OPEN_APPSTORE_FUN,
                    OPEN_APPSTORE_NAME, NULL, behavior);
            break;
        case AUTO_SEARCH:
            CFNotificationCenterAddObserver(center, NULL,AUTO_SEARCH_FUN,
                    AUTO_SEARCH_NAME, NULL, behavior);
            break;
        case TEST_EXCHANGE_VALUE:
            CFNotificationCenterAddObserver(center, NULL,TEST_EXCHANGE_VALUE_FUN,
                    TEST_EXCHANGE_VALUE_NAME, NULL, behavior);
            break;
        case WORK_STATE_START:
            CFNotificationCenterAddObserver(center, NULL,WORK_STATE_START_FUN,
                    WORK_STATE_START_NAME, NULL, behavior);
            break;
        case WORK_STATE_END:
            CFNotificationCenterAddObserver(center, NULL,WORK_STATE_END_FUN,
                    WORK_STATE_END_NAME, NULL, behavior);
            break;
        case WINDOW_STATE_SHOW:
            CFNotificationCenterAddObserver(center, NULL,WINDOW_STATE_SHOW_FUN,
                    WINDOW_STATE_SHOW_NAME, NULL, behavior);
            break;
        case TASK_COMPLICATION_WITH_NET_REPORT:
            CFNotificationCenterAddObserver(center, NULL,TASK_COMPLICATION_WITH_NET_REPORT_FUN,
                    TASK_COMPLICATION_WITH_NET_REPORT_NAME, NULL, behavior);
            break;
        case TIMER_APPLICATION_RESTARTTASK:
            CFNotificationCenterAddObserver(center, NULL,TIMER_APPLICATION_RESTARTTASK_FUN,
                    TIMER_APPLICATION_RESTARTTASK_NAME, NULL, behavior);
            break;

        default:
            break;


    }
}






@end