//
// Created by admin on 2017/10/19.
//

#import "ProcessCmd.h"
#import "NSTask.h"
#import "GeneralUtil.h"
#import "Constant.h"
#import <stdio.h>
#import <string.h>
#import <termios.h>
#import <fcntl.h>
#import <sys/select.h>
#import <sys/wait.h>


@implementation ProcessCmd {

}
+ (ProcessCmd *_Nonnull)shareInstance {
    static ProcessCmd* mPro;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mPro = [[ProcessCmd alloc] init];
    });
    return mPro;
}

- (void)runSystemCommand:(NSString *_Nonnull)cmd {
    [[NSTask launchedTaskWithLaunchPath:@"/bin/sh" arguments:[NSArray arrayWithObjects:@"-c" ,cmd,nil]] waitUntilExit];
}

- (void)killSpringBoard {
    [self runSystemCommand:[GeneralUtil convertHexStrToString:CMD_KILL_SPRINGBOARD_NOTIFICATION]];
}

- (void)killAppStore {
    //关闭AppStore需要进行 同事杀死Itunes进程
    [self runSystemCommand:[GeneralUtil convertHexStrToString:CMD_KILL_ITUNESSTORED_NOTIFICATION]];
    [self runSystemCommand:[GeneralUtil convertHexStrToString:CMD_KILL_APPSTORE_NOTIFICATION]];


}

- (void)runCustomCommand:(NSString *_Nonnull)bin withCmdArray:(NSArray *_Nullable)array {
    [[NSTask launchedTaskWithLaunchPath:bin arguments:array] waitUntilExit];
}


- (void)runUninstallDeb {
}


@end