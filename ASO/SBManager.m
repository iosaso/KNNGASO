//
// Created by admin on 2017/10/27.
//

#import "SBManager.h"
#import "SBViewManager.h"
#import "CFNotificManager.h"
#import "ProcessCmd.h"
#import "ASManager.h"
#import "GeneralUtil.h"


@implementation SBManager {

}



+ (SBManager *)instance {
    static SBManager *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }


    return _instance;
}

- (id _Nullable)init {
    self = [super init];
    if (self){

    }
    return self;
}


- (void)onUnlockScreen {
    [super unLockScreen];
}

- (void)onClickStart {
    //进行点击开始按键
    [self getTask];
}

- (void)onClickEnd {
    [GeneralUtil setWorkState:GEN_FALSE];
    // 进行点击结束按键
    [self clearCache];
    [self clearAllTimer];
    [self clearDownloadFile];
    [self killAppStore];
   [[ASManager instance] signOutAccount];
    // 并且需要重启SprongBoard
    [self performSelector:@selector(KillSpringBoard) withObject:nil afterDelay:2];


}


- (void)getTask {
    [CFNotificManager SendMessage:APPLICATiON_START_TASK];
}


- (void)showWindow:(id)se {
    // 进行设置主界面
    [[SBViewManager shareInstance] becomeKeyWindow:se];
    //进行声明管理的方法
    [CFNotificManager AddMessage:TIMER_APPSTORE_SUCCESS];

    [CFNotificManager AddMessage:TIMER_APPLICATION_SUCCESS];

    [CFNotificManager AddMessage:ORM_TIME_OUT];

    [CFNotificManager AddMessage:Clear_CACHE_APP];

    [CFNotificManager AddMessage:UNINSTALL_APPLICATION];

    [CFNotificManager AddMessage:CMD_KILL_APPSTORE];

    [CFNotificManager AddMessage:CMD_KILL_SPRINGBOARD];

    [CFNotificManager AddMessage:ACCOUNT_SIGNOUT];

    [CFNotificManager AddMessage:APPLICATiON_START_TASK];

    [CFNotificManager AddMessage:WINDOW_STATE_SHOW];

    [self TimerManager];
}

- (void)TimerManager {
    [CFNotificManager AddMessage:TIMER_APPLICATION_SPRINGBOARD_REGISTER];

    [CFNotificManager AddMessage:TIMER_APPSTORE_SPRINGBOARD_REGISTER];

    [CFNotificManager AddMessage:TIMER_APPLICATION_SPRINGBOARD_STOP];

    [CFNotificManager AddMessage:TIMER_APPSTORE_SPRINGBOARD_STOP];

    [CFNotificManager AddMessage:TIMER_APPLICATION_RESTARTTASK];
}

- (void)clearCache {
   [super clearTempFile];
}

- (void)clearDownloadFile {
    [CFNotificManager SendMessage:UNINSTALL_APPLICATION];
    [super clearFile];

}

- (void)killAppStore {
    [CFNotificManager SendMessage:CMD_KILL_APPSTORE];
}

- (void)KillSpringBoard {
    [CFNotificManager SendMessage:CMD_KILL_SPRINGBOARD];
}


- (void)reStartTaskWithWhy:(NSString *_Nullable)why {
    if([GeneralUtil isSubWorking]) {
        [GeneralUtil setSubWorkState:GEN_FALSE];
        if (why) {
            [CFNotificManager SendMessage:WINDOW_STATE_SHOW withString:why];
        }
        [CFNotificManager SendMessage:ACCOUNT_SIGNOUT];
        [self clearAllTimer];
        [self killAppStore];
        [self performSelector:@selector(onClickStart) withObject:nil afterDelay:1.5];
    }
//    [CFNotificManager performSelector:@selector(SendMessage:) withObject:(id)APPLICATiON_START_TASK afterDelay:1.5];
}

- (void)reStartTaskWithTimour {
    if([GeneralUtil isSubWorking]){
        [GeneralUtil setSubWorkState:GEN_FALSE];
        [self changStateLabel:@"超时"];
        [CFNotificManager SendMessage:ACCOUNT_SIGNOUT];
        [self clearAllTimer];
        [self killAppStore];
        [self performSelector:@selector(onClickStart) withObject:nil  afterDelay:1.5];

    }

//    [CFNotificManager performSelector:@selector(SendMessage:) withObject:(id)APPLICATiON_START_TASK afterDelay:1.5];
}

-(void)changStateLabel:(NSString *)name{
    [CFNotificManager SendMessage:WINDOW_STATE_SHOW withString:name];
}


- (void)dealloc {

    [super dealloc];
}

/**
 * 进行清除所有Timer的超时检测
 * */
- (void)clearAllTimer {
    [CFNotificManager SendMessage:TIMER_APPLICATION_SPRINGBOARD_STOP];
    [CFNotificManager SendMessage:TIMER_APPSTORE_SPRINGBOARD_STOP];
}
/**
 * 进行清除AppStore 未刷新出内容的计时
 *
 *
 * 此处开启全局计时
 * */
- (void)clearCheckAppStoreTimer {
    [CFNotificManager SendMessage:TIMER_APPSTORE_SPRINGBOARD_STOP];
    [CFNotificManager SendMessage:TIMER_APPLICATION_SPRINGBOARD_REGISTER];
}




@end