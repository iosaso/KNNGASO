//
// Created by admin on 2017/11/2.
//

#import "ASManager.h"
#import "CFNotificManager.h"
#import "ProcessMsgsnd.h"
#import "OCRManager.h"
#import "SBManager.h"
#import "NetServer.h"
#import "GeneralUtil.h"
#import "Constant.h"
#import "ProcessCmd.h"

NSInteger findDownloadButtonTimeOut = 0;
NSInteger searchDownloadRetryNum = 0;
NSInteger clearAndRestartSearchNum = 0;
NSInteger downloadingTimeOut = 0;
NSInteger autoSearchTimeout = 0;

float globalInter = 0.5;


@implementation ASManager {

}
+ (ASManager *)instance {
    static ASManager *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (id _Nonnull)init {
    self = [super init];
    if (self){






    }
    return self;
}
BOOL  isFirstSearch =TRUE;
/**
 *
 * 排名优化
 *
 * */
- (BOOL)changSerachTop:(id _Nonnull)top {
    if (!top)
        return FALSE;
    NSDictionary<NSString *, id> * content =[ProcessMsgsnd getMessage];
    if (!content)
        return FALSE;
    id appid  = [content objectForKeyedSubscript:[GeneralUtil convertHexStrToString:appId_name]];
    if (!appid)
        return FALSE;
    NSError *jsonError = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:top options:NSJSONReadingMutableContainers error:&jsonError];
    if (!dic){
        return FALSE;
    }
//    NSLog(@"top = %@", dic);

    if (![dic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:PAGEDATA]])
        return FALSE;
    id mPageDate = [dic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:PAGEDATA]];
    if (!mPageDate ) {
        return FALSE;
    }
    if (![mPageDate objectForKey:[GeneralUtil convertHexStrToString:BUBBLES]])
        return FALSE;
    id mBubbles = [mPageDate objectForKeyedSubscript:[GeneralUtil convertHexStrToString:BUBBLES]];
    if (!mBubbles ) {
        return FALSE;
    }
    //id mComponentName = [mBubbles objectForKeyedSubscript:@"componentName"];
    id mBubble = [mBubbles firstObject];

    if (!mBubble ) {
        return FALSE;
    }
    // 进行处理当前的调用顺序
    id results = [mBubble objectForKeyedSubscript:[GeneralUtil convertHexStrToString:RESULTS]];
    if (!results ) {
        return FALSE;
    }
    NSInteger mResultNumber = [results count];
    if (mResultNumber < 3) {
        return FALSE;
    }

    if (mResultNumber == 0) {
        // 退出AppStore线程并重新开始

        // 并显示log : 未找到此关键词中对应的应用
        return FALSE;
    }
//   NSLog(@"[[results firstObject] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:ID] = %@", [[results firstObject] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:ID]]) ;
//    NSLog(@"---------changSerachTop----用户设定的：-%@-- ---第一个设定的为：---- %@-",appid  ,[[results firstObject] objectForKeyedSubscript:@"id"] );
    if ([appid isEqualToString:[[results firstObject] objectForKeyedSubscript:@"id"]]) {
        [self reStarToooooo];
        return TRUE;
    }
    NSInteger mLoop = 0;
    // 开启循环比对  将对应内容进行更换 (稍后进行优化速度)
    while (mLoop < [results count]) {
//   NSLog(@"-------------------content = %ld", (long)[appid isEqualToString:[[results objectAtIndexedSubscript:mLoop] objectForKeyedSubscript:@"id"]]);
        if ([appid isEqualToString:[[results objectAtIndexedSubscript:mLoop] objectForKeyedSubscript:@"id"]]) {
            // 进行交换数据
            [results exchangeObjectAtIndex:0 withObjectAtIndex:mLoop];
            [top setData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil]];
            // 进行通知 成功请求到数据  1155892339
            [self reStarToooooo];
            // 开启局部计时   如果未触发点击 则进行重新设置搜索




            return TRUE;
        }
        mLoop += 1;
    }
    return FALSE;
}

-(void)reStarToooooo{

    if(isFirstSearch) {
//                // 进行设置当前
        isFirstSearch = FALSE;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [CFNotificManager SendMessage:TIMER_APPSTORE_SUCCESS];
            [CFNotificManager SendMessage:TIMER_APPLICATION_SPRINGBOARD_REGISTER];
//            [CFNotificManager SendMessage:TOUCH_CLICK_DOWNLOAD_BUTTON];

        });
    }
}






/**
 *  开启下载按钮状态
 *
 *  根据状态进行响应操作
 *
 *  null 为需要进行点击的状态信号
 *
 *  3, 1, 0，2 为下载转圈状态
 *
 *  4 为设备上已经存在此应用  并可以打开的状态
 *
 *  8 为云状态 证明机器上并没有此应用 但已经增加到账户中
 *
 * */
BOOL  isCanClick = TRUE;
BOOL  isHasDownloadApp = FALSE;
BOOL  isPredownload = TRUE;
NSInteger prepareDownloadTimeOut = 0;
- (void)startAutoDownload:(id)state {

//    NSLog(@"------------------------《state》---------------- 《 %ld》", (long)[state performSelector:@selector(state)]);
//    NSArray *downloadStateArray =@[@"1",@"2",@"1",@"0",@"0",@"0",@"0",@"4",@"3",@"3",@"3",@"5",@"0",@"3",@"3"];
//    NSLog(@"downloadStateArray = %@", downloadStateArray);
//    NSLog(@"当前的状态信息为： = %@",[downloadStateArray objectAtIndexedSubscript:(NSInteger)[state performSelector:@selector(state)]]);
    SEL Selection = @selector(startAutoDownload:);
    id mViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    id mViewControllers = [mViewController viewControllers];
    id Object = nil;
    long mNumber =  (long)[state performSelector:@selector(state)];
    if([mViewControllers count] >= 5 && [mViewController selectedIndex] >= 5){
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAutoDownload:) object:nil];
        [self performSelector:@selector(startAutoDownload:) withObject:nil afterDelay:3.0];
        [super setIsCoding:TRUE] ;
        return;
    }
    if([super isCoding]){
        [[OCRManager sharedInstance] cancelCaptchaViewTimeout];
        [super setIsCoding: FALSE];

    }

    if(findDownloadButtonTimeOut == 2 ){
        float IntervalTime = 0.0;
        findDownloadButtonTimeOut = 0;
        if(++searchDownloadRetryNum > 2){
            searchDownloadRetryNum = 0;
            NSInteger temp = clearAndRestartSearchNum++;

            if(temp){
                IntervalTime = 0.5;

            }else{

                [super signIn];
                IntervalTime = 5.0;
            }
            globalInter = IntervalTime;
            // 进行关闭操作
            [NSObject cancelPreviousPerformRequestsWithTarget:[SBManager instance] selector:@selector(reStartTaskWithWhy:) object:nil];

            [[SBManager instance] performSelector:@selector(reStartTaskWithWhy:) withObject:[GeneralUtil convertHexStrToString:STATE_NO_SUCESS_IN_TIME] afterDelay:IntervalTime];
            return;
        }
        Selection = @selector(autoSearch);
        Object = nil;
        isCanClick = TRUE;

    }else{

        id DownloadButton = [super findDownloadButton];
        if(DownloadButton){
            findDownloadButtonTimeOut = 0;
            clearAndRestartSearchNum = 0;
            id View = [DownloadButton objectForKeyedSubscript:[GeneralUtil convertHexStrToString:VIEW]];
            id Button = [DownloadButton objectForKeyedSubscript:[GeneralUtil convertHexStrToString:BUTTON]];
            Selection = @selector(startAutoDownload:);
            if(downloadingTimeOut != 40 ){
                switch(mNumber){
                    case 0:
                        if(isCanClick ){
                            float  Inter = 0;
                            if([Button performSelector:@selector(isShowingConfirmation)]){
                                Inter = 0.2;
                            }else{
                                [View performSelector:@selector(_showConfirmationAction:) withObject:Button afterDelay:0.2];
                                Inter = 0.5;
                            }
                            [self performSelector:@selector(onClickDownload) withObject:nil afterDelay:Inter];
                            if(isHasDownloadApp){
//                                NSLog(@"----------执行了-- 点击事件---2------");
                                isHasDownloadApp  = FALSE;
                                [self performSelector:@selector(onClickDownload) withObject:nil afterDelay:0.6];
                            }

                            isPredownload = FALSE;
                            isCanClick =FALSE;
                        }

                        globalInter = 1.0;
                        ++downloadingTimeOut;
                        // 开启计时  如果间隔2秒没有进入 0 则进行重新点击
                         if(downloadingTimeOut !=0 && downloadingTimeOut % 7 ==0){
                             isCanClick = TRUE;
                         }
                        break;
                    case 1:
                    case 5:
                        downloadingTimeOut = 0;
                        break;

                    case 2:
                    case 8:
//                    case 12:
//                    case 13:
                    case 10:
//                    case 30:
                        // prepareDownloadTimeOut = 0;
                        // 进行轮训此10 次后 进行
                        if(isPredownload&&!isHasDownloadApp){
                            isPredownload = FALSE;
                            isCanClick =TRUE;
                            isHasDownloadApp = TRUE;
                        }
                        if(++prepareDownloadTimeOut == 1 ){
//                            NSLog(@"--------进行下载----------");
                            Selection = @selector(compleDownload);
                            downloadingTimeOut = 0;
                            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:Selection object:nil];
                            [self performSelector:Selection withObject:nil afterDelay:3];
                            return;
                        }
                        break;
                    case 3:
                        downloadingTimeOut = 0;
//                        ++downloadingTimeOut;
//                        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:Selection object:nil];
//                        [self performSelector:Selection withObject:nil afterDelay:globalInter];
//                        return;
                        break;
                    case 4:
//                    case 10:
                    case 15:
                        isCanClick = FALSE;
                        isHasDownloadApp = TRUE;
                        //打开状态  进行卸载文件操作
                        //[CFNotificManager SendMessage:UNINSTALL_APPLICATION];
                        [self compleDownload];
                        downloadingTimeOut = 0;
                        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:Selection object:nil];
                        [self performSelector:Selection withObject:nil afterDelay:0.5];
                        return;
                    default:
                        return;
                }
            }else{
                downloadingTimeOut = 0;
                ++findDownloadButtonTimeOut;

            }
            [View performSelector:@selector(_buttonAction:) withObject:Button afterDelay:0.1];
            globalInter = 2.0;
            // [self performSelector:Selection withObject:nil afterDelay:globalInter];
        }

    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:Selection object:nil];
    [self performSelector:Selection withObject:nil afterDelay:globalInter];

}

-(void)onClickDownload{
    [CFNotificManager SendMessage:TOUCH_CLICK_DOWNLOAD_BUTTON];
}



-(void)compleDownload{
//    NSLog(@"---------《compleDownload》-------------");

    isCanClick =TRUE;
    [[SBManager instance] clearDownloadFile];
    [[SBManager instance] deleteDownloadTempFile];
    [[SBManager instance] clearCache];
    [self deleteCacheFile];
    // [GeneralUtil convertHexStrToString:VIEW]
    [CFNotificManager SendMessage:WINDOW_STATE_SHOW withString:[GeneralUtil convertHexStrToString:NIANGAO_SUGGEST_TASK_SCUESS]];
    [CFNotificManager SendMessage:TIMER_APPSTORE_SPRINGBOARD_STOP];
    [CFNotificManager SendMessage:TIMER_APPLICATION_SPRINGBOARD_STOP];
//    [CFNotificManager SendMessage:TASK_COMPLICATION_WITH_NET_REPORT];
    [NetServer sendSuccessToCould];
    [CFNotificManager SendMessage:TIMER_APPLICATION_RESTARTTASK];
    [CFNotificManager SendMessage:CMD_KILL_APPSTORE];
    // 进行删除对应目录的缓存文件




}


-(void)deleteCacheFile{
    // 调用命令行进行删除
    [[ProcessCmd shareInstance] runSystemCommand:@"rm -rf /private/var/installd/Library/Caches/com.apple.mobile.installd.staging/"];
    [[ProcessCmd shareInstance] runSystemCommand:@"rm -rf /var/mobile/Library/Caches/com.apple.itunesstored/AppPlaceholders/"];
    // 同时进行删除AppStore的缓存我恩建 /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist
    [[ProcessCmd shareInstance] runSystemCommand:@"rm  /Library/Preferences/SystemConfiguration/preferences.plist"];
    [[ProcessCmd shareInstance] runSystemCommand:@"rm  /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist"];


}


-(void)hasCompleDownload{
//    NSLog(@"--------------hasCompleDownload----------------");
    [CFNotificManager SendMessage:TIMER_APPLICATION_RESTARTTASK];


}



//-(void)getTask{
//
//}


-(void)autoSearch{
//    NSLog(@"-----开启自动搜索 -------");

    SEL Selection = nil;
    float Interget = 0;
    if(autoSearchTimeout == 30){
        autoSearchTimeout = 0;
        // 重新进行开启请求任务
        [[SBManager instance] reStartTaskWithWhy:[GeneralUtil convertHexStrToString:STATE_RE_SEARCH]];
    }
    //进行搜索关键词
    if(![super searchKeyword:[[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:keywords_name]]]){
        isCanClick = TRUE;
        ++autoSearchTimeout;
        Selection =@selector(autoSearch);
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:Selection object:Nil];
        Interget = 0.5;
        [self performSelector:Selection withObject:nil afterDelay:Interget];
        return;
    }
//    // TODO 设置一个进行自动化搜索的Bool值进行管理
    Selection = @selector(startAutoDownload:);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:Selection object:[NSNumber numberWithInt:0]];
    Interget = 3.0;
    [self performSelector:Selection withObject:nil afterDelay:Interget];

}


// 整体账号登出
- (void)signOutAccount {
    [super signOutActivateAccount];
//    [super signOutAllAcount];
}



@end