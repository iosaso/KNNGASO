//
// Created by admin on 2017/10/20.
//

#import "ProcessMsgsnd.h"


@implementation ProcessMsgsnd {

}

+ (void)sendMessage:(NSDictionary *)message {
    //重设
    [[NSUserDefaults standardUserDefaults]setPersistentDomain:message forName:NSGlobalDomain];
    //同步
    [NSUserDefaults resetStandardUserDefaults];


}

+ (NSDictionary<NSString *, id> *)getMessage {
    return  [[NSUserDefaults standardUserDefaults]persistentDomainForName:NSGlobalDomain];
}

@end