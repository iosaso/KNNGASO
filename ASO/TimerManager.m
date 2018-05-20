//
// Created by admin on 2017/10/26.
//



#import "TimerManager.h"
#import "SBManager.h"

#ifndef TIMERMANAGER
#define TIMERMANAGER

#define APPLICATION_INTERVAL  220
#define APPSTORE_INTERVAL  20

#endif

SEL ApplicationTimerSelection = nil;
SEL AppStoreTimerSelection = nil;
SEL ReSearchTimterSelection = nil;



@implementation TimerManager {

@private
    NSTimer *_applicationTimer;
    NSTimer *_appstoreTimer;
}


@synthesize applicationTimer = _applicationTimer;
@synthesize appstoreTimer = _appstoreTimer;

+ (TimerManager *)instance {
    static TimerManager *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}
- (id)init {
    self = [super init];
    if(self){
        ApplicationTimerSelection = @selector(TimerOutEnd);
        AppStoreTimerSelection = @selector(TImerkillAppStore);
        // 进行设置初始化方式
        _appstoreTimer = nil;
        _applicationTimer = nil;
    }
    return self;
}

//
//- (void)registreSearchTimter {
//
//
//
//}
//
//- (void)reSearchTimter {
//
//}


- (void)registApplicationTimer {
//    NSLog(@"--------《registApplicationTimer》-----------");
    _applicationTimer = [NSTimer scheduledTimerWithTimeInterval:APPLICATION_INTERVAL target:self  selector:ApplicationTimerSelection userInfo:nil  repeats:NO];
}

- (void)registAppStoreTimer {
//    NSLog(@"--------《registAppStoreTimer》-----------");
    _appstoreTimer = [NSTimer scheduledTimerWithTimeInterval:APPSTORE_INTERVAL target:self  selector:AppStoreTimerSelection userInfo:nil  repeats:NO];
}


- (void)cancelApplicationTimer {
//    NSLog(@"--------《cancelApplicationTimer》-------准备取消----");
    if(_applicationTimer) {
        [_applicationTimer invalidate];
        _applicationTimer = nil;
//        NSLog(@"--------《cancelApplicationTimer》------取消成功-----");
    }
}

- (void)cancelAppStoreTimer {
//    NSLog(@"--------《cancelAppStoreTimer》-------准备取消----");
    if(_appstoreTimer) {
        [_appstoreTimer invalidate];
        _appstoreTimer = nil;
//        NSLog(@"--------《cancelAppStoreTimer》-----取消成功------");
    }
}

- (void)dealloc {
    [_applicationTimer release];
    [_appstoreTimer release];
    [super dealloc];
}
/**
 * 进行管理当前
 *
 * */
-(void)TimerOutEnd{
    _applicationTimer = nil;
//    NSLog(@"---《TimerManager》-----TimerOutEnd-----------");
    [[SBManager instance] reStartTaskWithTimour];

}
/**
 * 进行管理当前
 *
 * */
-(void)TImerkillAppStore{
    _appstoreTimer = nil;
//    NSLog(@"---《TimerManager》-----TImerkillAppStore-----------");
//    [[SBManager instance] reStartTaskWithTimour];
    [self performSelector:@selector(waitSecondTime) withObject:Nil afterDelay:2];

}


//
-(void)waitSecondTime{
    [[SBManager instance] reStartTaskWithTimour];
}
//
//
//-(void)waitReSearchTimer{
//    // 进行设置当前的重新搜索选项
//
//
//
//
//
//
//
//}



@end