//
//  AsoBase.m
//  NianGao_ASO
//
//  Created by admin on 2017/10/19.
//
//


#import "AsoBase.h"
//#import "CFNotificManager.h"
//#import <objc/runtime.h>
//#import <IOKit/IOKit.h>
//#import <UIKit/UIKit.h>
//#import "ProcessMsgsnd.h"
//#import "ProcessCmd.h"
//#import "GeneralUtil.h"
//#import "Constant.h"

@implementation AsoBase {
@private
    BOOL _isCoding;
    long _clickGetTime;
    BOOL _clickGetFirst;
    BOOL _isPrepareDownload;
    NSTimer *_timerAuto;
}


@synthesize isCoding = _isCoding;
@synthesize clickGetTime = _clickGetTime;
@synthesize clickGetFirst = _clickGetFirst;
@synthesize isPrepareDownload = _isPrepareDownload;
@synthesize timerAuto = _timerAuto;

- (id _Nullable)init {
    self = [super init];
    if(self) {


    }
    return self;
}
//
//- (BOOL)searchKeyword:(NSString *_Nonnull)keyWord {
//    if(!keyWord || [keyWord length] == 0){
//        return FALSE;
//    }
//
//    // 首先进行查找搜索Bar
//    id SearchBar = [self findSearchBar];
//    if(!SearchBar){
//        return  FALSE;
//     }
//    [SearchBar setText:keyWord];
//    [[SearchBar delegate] performSelector:@selector(searchBarSearchButtonClicked:) withObject:SearchBar];
//    return TRUE;
//}
/**
 * 对视图进行检索找到搜索条
 * */
//-(id)findSearchBar{
//    id RootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
//    if([RootViewController selectedIndex] != 3){
//        [RootViewController setSelectedIndex:3];
//    }
//    id Object = [[RootViewController viewControllers] objectAtIndexedSubscript:3];
//    id ViewControllers = [Object viewControllers];
//    if([ViewControllers count] >= 2){
//        [Object performSelector:@selector(popToRootViewControllerAnimated:) withObject:nil];
//    }
//    id Bar = [Object navigationBar];
//   // 进行迭代找到搜索按钮
//    id SearchBar = [self findSearchBarFromSuperView:Bar];
//    if(!SearchBar){
//        return nil;
//    }
//    id Delagate = [SearchBar delegate];
//    if(Delagate && [Delagate respondsToSelector:@selector(searchBarSearchButtonClicked:)]){
//        return SearchBar;
//    }
//    return nil;
//}
/**
 * 遍历过程
 * */
//-(id)findSearchBarFromSuperView:(id)view{
//
//        NSArray* mViews = [view subviews];
//
//        if (!(mViews != nil && ![mViews isKindOfClass:[NSNull class]] && mViews.count != 0))
//        {
//
//            return nil;
//        }
//        id mCurrentView = [mViews objectAtIndexedSubscript:0];
//        // 如果视图为nil时候
//        while (true) {
//
//            if (!mCurrentView) {
//
//                break;
//            }
//
//            if ([mCurrentView  isMemberOfClass:NSClassFromString([GeneralUtil convertHexStrToString:SKUISEARCHBAR])]){
//
//                return mCurrentView;
//            }
//            NSArray* mSubViews = [mCurrentView subviews];
//            if (!(mSubViews != nil && ![mSubViews isKindOfClass:[NSNull class]] && mSubViews.count != 0)) {
//
//                break;
//            }
//            mCurrentView = [mSubViews objectAtIndexedSubscript:0];
//        }
//        return nil;
//
//
//}
//
//- (void)launchAppStore:(NSString* _Nullable)keyWord {
//    // TODO 可能10系统不支持了，后期进行替换
////     [self launchApp:@"com.apple.AppStore"];
////    [self searchKeyword:[[ProcessMsgsnd getMessage] objectForKeyedSubscript:@"keyword"]];
////    //开发APPStore
//    NSString *str = [NSString stringWithFormat: [GeneralUtil convertHexStrToString:AUTO_SEARCH_URL],[keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//
//}
//
//
//- (void)unLockScreen {
//    id class =  NSClassFromString([GeneralUtil convertHexStrToString:SBLOCKSCREENMANAGER]);
//    if ([class respondsToSelector:@selector(sharedInstance)]) {
//        if ((BOOL)[[class performSelector:@selector(sharedInstance)] performSelector:@selector(isUILocked)]) {
//
//            [[class performSelector:@selector(sharedInstance)] performSelector:@selector(unlockUIFromSource:withOptions:) withObject:[NSNumber numberWithInt:0] withObject:nil];
//        }
//    }
//
//}
//
//- (BOOL)isLockScreen {
//    id class =  NSClassFromString([GeneralUtil convertHexStrToString:SBLOCKSCREENMANAGER]);
//    if ([class respondsToSelector:@selector(sharedInstance)]) {
//
//        return   (BOOL)[[class performSelector:@selector(sharedInstance)] performSelector:@selector(isUILocked)];
//    }
//
//    return FALSE;
//}
//
//- (void)uninstallDeb :(id)deb{
//    // 进行操作deb卸载 并进行输入 alpine 命令
//    [NSString  stringWithFormat:@"dpkg -p %@ ",deb];
//}
//
//- (void)clearIconData:(id)data {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 用来清除屏幕的 信息  /usr/bin/cleaR
//        [[ProcessCmd shareInstance] runCustomCommand:@"/usr/bin/clear" withCmdArray:nil];
//
//    });
//}
//
//- (void)clearIconCache:(id)cache {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // 用来清除屏幕的 信息  /usr/bin/cleaR
//        [[ProcessCmd shareInstance] runCustomCommand:@"/usr/bin/uicache" withCmdArray:nil];
//
//    });
//}
//
//- (void)clearFile {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        NSString * mItunCache = [NSString stringWithUTF8String:"/var/mobile/Library/Caches/com.apple.itunesstore"];
//        NSDirectoryEnumerator* mFIles = [[NSFileManager defaultManager] enumeratorAtPath:mItunCache];
//        while (TRUE){
//            id File = [mFIles nextObject];
//           if(!File){
//               break;
//           }
//            NSString *mFile = [mItunCache stringByAppendingPathComponent:File];
//            NSError * Error = nil;
//            [[NSFileManager defaultManager] removeItemAtPath:mFile error:&Error];
//        }
//    });
//}
//
//-(void)RemoveIcon:(id)icon {
//    if (!icon) {
//        return;
//    }
//    if ([icon length] == 0) {
//        return;
//    }
//    id class = NSClassFromString([GeneralUtil convertHexStrToString:SBICONCONTROLLER]);
//    if (![class respondsToSelector:@selector(sharedInstance)]) {
//        return;
//    }
//    id mClass = [class performSelector:@selector(sharedInstance)];
//    Class mC = object_getClass(mClass);
//    Ivar mIvar = class_getInstanceVariable(mC, "_iconModel");
//    id mClassFor = object_getIvar(mClass, mIvar);
//    id mIden = [mClassFor performSelector:@selector(applicationIconForBundleIdentifier:) withObject:icon];
//    if(mIden && [mClassFor respondsToSelector:@selector(removeIcon:)]){
//        [object_getIvar(mClass, mIvar) performSelector:@selector(removeIcon:) withObject:mIden];
//    }
//}
//
//- (void)RemoveIconForIdentifier:(id)identifier {
//    if (!identifier || ![identifier length] ) {
//        return;
//    }
//    id class = NSClassFromString(@"SBIconController");
//    if (![class respondsToSelector:@selector(sharedInstance)]) {
//        return;
//    }
//
//    id mClass = [class performSelector:@selector(sharedInstance)];
//    Class mC = object_getClass(mClass);
//    Ivar mIvar = class_getInstanceVariable(mC, "_iconModel");
//
//    id mClassFor = object_getIvar(mClass, mIvar);
//    if([mClassFor respondsToSelector:@selector(removeIcon:)]){
//        [object_getIvar(mClass, mIvar) performSelector:@selector(removeIconForIdentifier:) withObject:identifier];
//    }
//
//}
//
//-(void)UninstallApplicationFromDestop:(id)application {
//    if (!application) {
//        return;
//    }
//    if ([application length] == 0) {
//        return;
//    }
//
//    id isApp = [self  applicationIconForBundle:application];
//    if (!isApp) {
//        return;
//    }
//    id mApplication = [isApp performSelector:@selector(application)];
//    if (!mApplication) {
//        return;
//    }
//    id class = NSClassFromString(@"SBApplicationController");
//    if (![class respondsToSelector:@selector(sharedInstance)]) {
//        return;
//    }
//    id mClass = [class performSelector:@selector(sharedInstance)];
//    [mClass performSelector:@selector(uninstallApplication:) withObject:mApplication];
//}
//
//-(void)UninstallIconFromDestop:(id)icon {
//    if (!icon || [icon length] == 0) {
//        return;
//    }
//    id isApp = [self applicationIconForBundle:icon];
//    if (!isApp) {
//        return;
//    }
//    id class = NSClassFromString(@"SBIconController");
//    if (![class respondsToSelector:@selector(sharedInstance)]) {
//        return;
//    }
//    id mClass = [class performSelector:@selector(sharedInstance)];
//    if (![mClass respondsToSelector:@selector(uninstallIcon:)]) {
//        return;
//    }
//    [mClass performSelector:@selector(uninstallIcon:) withObject:isApp];
//}
//
//-(void)SBDeleteIconAlertItem_delete2:(id)a2 {
//    //TODO 未翻译成功
//
//
//}
//
//-(id)applicationIconForBundle:(id)bundleIdentifier {
//    if (!bundleIdentifier || [bundleIdentifier length] == 0 ) {
//        return nil;
//    }
//
//    id class = NSClassFromString(@"SBIconController");
//
//    if (![class respondsToSelector:@selector(sharedInstance)]) {
//        return nil;
//    }
//    id mClass = [class performSelector:@selector(sharedInstance)];
//    Class mC = object_getClass(mClass);
//    Ivar mIvar = class_getInstanceVariable(mC, "_iconModel");
//    id mIcon = [object_getIvar(mClass, mIvar) performSelector:@selector(applicationIconForBundleIdentifier:) withObject:bundleIdentifier];
//    return  mIcon;
//}
//
//-(void)launchApp:(id)app {
//    id class = NSClassFromString(@"SBIconController");
//    if (![class respondsToSelector:@selector(sharedInstance)]) {
//        return ;
//    }
//    id mClass = [class performSelector:@selector(sharedInstance)];
//    Class mC = object_getClass(mClass);
//    Ivar mIvar = class_getInstanceVariable(mC, "_iconModel");
//    id mIcon = [object_getIvar(mC, mIvar) performSelector:@selector(applicationIconForBundleIdentifier:) withObject:app];
//    [mClass performSelector:@selector(_launchIcon) withObject:mIcon];
//}
//
//- (void)setEnableWifi:(BOOL)wifi {
//    id class = NSClassFromString(@"SBWiFiManager");
//    if (![class respondsToSelector:@selector(sharedInstance)]) {
//        return ;
//    }
//    id mClass = [class performSelector:@selector(sharedInstance)];
//    [mClass performSelector:@selector(setWiFiEnabled:) withObject:[NSNumber numberWithBool:wifi]];
//}
//
//-(BOOL)isEnableWifi {
//
//    id class = NSClassFromString(@"SBWiFiManager");
//    if (![class respondsToSelector:@selector(sharedInstance)]) {
//        return FALSE;
//    }
//    id mClass = [class performSelector:@selector(sharedInstance)];
//    return (BOOL)[mClass performSelector:@selector(wiFiEnabled) ];
//}
//
//- (BOOL)changSerachTop:(id _Nonnull)top  {
//    if (!top)
//        return FALSE;
//    id content =[ProcessMsgsnd getMessage];
//    id appid  = [content objectForKeyedSubscript:@"appid"];
//
//    if (!appid)
//        return FALSE;
//    NSError *jsonError = nil;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:top options:NSJSONReadingMutableContainers error:&jsonError];
//    if (!dic){
//        return FALSE;
//    }
//
//    if (![dic objectForKeyedSubscript:@"pageData"])
//        return FALSE;
//    id mPageDate = [dic objectForKeyedSubscript:@"pageData"];
//    if (!mPageDate ) {
//        return FALSE;
//    }
//    if (![mPageDate objectForKey:@"bubbles"])
//        return FALSE;
//    id mBubbles = [mPageDate objectForKeyedSubscript:@"bubbles"];
//    if (!mBubbles ) {
//        return FALSE;
//    }
//    //id mComponentName = [mBubbles objectForKeyedSubscript:@"componentName"];
//    id mBubble = [mBubbles firstObject];
//
//    if (!mBubble ) {
//        return FALSE;
//    }
//    // 进行处理当前的调用顺序
//    id results = [mBubble objectForKeyedSubscript:@"results"];
//    if (!results ) {
//        return FALSE;
//    }
//    NSInteger mResultNumber = [results count];
//    if (mResultNumber < 3) {
//        return FALSE;
//    }
//    if (mResultNumber == 0) {
//        // 退出AppStore线程并重新开始
//
//        // 并显示log : 未找到此关键词中对应的应用
//        return FALSE;
//    }
//    if ([appid isEqualToString:[[results firstObject] objectForKeyedSubscript:@"id"]]) {
//        return TRUE;
//    }
//    NSInteger mLoop = 0;
//    // 开启循环比对  将对应内容进行更换 (稍后进行优化速度)
//    while (mLoop < [results count]) {
//        if ([appid isEqualToString:[[results objectAtIndexedSubscript:mLoop] objectForKeyedSubscript:@"id"]]) {
//            // 进行交换数据
//            [results exchangeObjectAtIndex:0 withObjectAtIndex:mLoop];
//            [top setData:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil]];
//            // 进行通知 成功请求到数据
//            [CFNotificManager SendMessage:TIMER_APPSTORE_SUCCESS];
//            return TRUE;
//        }
//        mLoop += 1;
//    }
//    return FALSE;
//}

//
//- (void)signIn {
//
//    id mSSAuthContextClass = NSClassFromString(@"SSAuthenticationContext");
//    [[[[NSClassFromString(@"SSAuthenticateRequest") alloc] performSelector:
//            @selector(initWithAuthenticationContext:) withObject:[mSSAuthContextClass
//            performSelector:@selector(contextForSignIn)]] autorelease] performSelector:@selector(start)];
//
//}
//
//- (void)signOutAllAcount {
//    [[NSClassFromString(@"SSAccountStore") defaultStore] performSelector:@selector(signOutAllAccounts)];
//}
//
//- (void)signOutActivateAccount {
//    id mActiveAccount =  [[NSClassFromString(@"SSAccountStore") defaultStore] performSelector:@selector(activeAccount)];
//    if (mActiveAccount) {
//        [[NSClassFromString(@"SSAccountStore") defaultStore] performSelector:@selector(signOutAccount:) withObject:mActiveAccount];
//
//    }
//}
//
//- (void)clearTempFile {
//    //TODO clearTempFile
//}
//
//- (void)deleteDownloadTempFile {
//    NSString *path; // 要列出来的目录
//    NSDirectoryEnumerator* mFile = [[NSFileManager defaultManager] enumeratorAtPath:@"/var/mobile/Media/Downloads"];
//
//    while((path=[mFile nextObject])!=nil){
//        id mRealDic = [@"/var/mobile/Media/Downloads" stringByAppendingPathComponent:path];
//        if ([mRealDic rangeOfString:@".sqlite"].location != NSNotFound)
//            [[NSFileManager defaultManager] removeItemAtPath:mRealDic error:nil];
//    }
//}

//
//- (id _Nullable)findCollectionView:(UIView *_Nonnull)view {
//
//    NSArray* mViews = [view subviews];
//
//    if (!(mViews != nil && ![mViews isKindOfClass:[NSNull class]] && mViews.count != 0))
//    {
//
//        return nil;
//    }
//    id mCurrentView = [mViews objectAtIndexedSubscript:0];
//    // 如果视图为nil时候
//    while (true) {
//
//        if (!mCurrentView) {
//
//            break;
//        }
//
//        if ([mCurrentView  isMemberOfClass:NSClassFromString(@"SKUICollectionView")]){
//
//            return mCurrentView;
//        }
//        NSArray* mSubViews = [mCurrentView subviews];
//        if (!(mSubViews != nil && ![mSubViews isKindOfClass:[NSNull class]] && mSubViews.count != 0)) {
//
//            break;
//        }
//        mCurrentView = [mSubViews objectAtIndexedSubscript:0];
//    }
//    return nil;
//}
//
//- (BOOL)isEntrySubPage {
//    id mRootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
//    id mSubController = [mRootViewController objectAtIndexedSubscript:3];
//    id mSebContrNumber = [mSubController viewControllers];
//    if ([mSebContrNumber count] != 1) {
//        return true;
//    }
//    id mTopController = [mSubController topViewController];
//    if (!mTopController) {
//        return FALSE;
//    }
//    id mSKUICollectionView = [self findCollectionView:[mTopController view]];
//    if (!mSKUICollectionView) {
//        return FALSE;
//    }
//    id mDelage = [mSKUICollectionView delegate];
//    if (![mDelage numberOfSectionsInCollectionView:mSKUICollectionView]
//            || ![mDelage collectionView:mSKUICollectionView numberOfItemsInSection:0]) {
//        return FALSE;
//    }
//    [mDelage collectionView:mSKUICollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    return TRUE;
//}
//
//- (id _Nullable)findDownloadButton {
//
//
//
//    id mResult = nil;
//
//    UIWindow * mKeyWindow       = [[UIApplication  sharedApplication] keyWindow];
//    id mKeyController           = [mKeyWindow rootViewController];
//    id mViewControllers         = [mKeyController viewControllers];
//    if(!mViewControllers)
//        return nil;
//    id mSubController           = [mViewControllers objectAtIndexedSubscript:3];
//    if (!mSubController)
//    {
//        return nil;
//    }
//
//    [mSubController popToRootViewControllerAnimated:NO];
//    id mTopController = [mSubController topViewController];
//
//    if (!mTopController){
//        return nil;
//    }
//
//    id mSKUCollecionView = [self findCollectionView:[mTopController view]];
//
//    if (!mSKUCollecionView) {
//        return nil;
//    }
//
//    id mItem = [mSKUCollecionView cellForItemAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
//    if (!mItem) {
//        return nil;
//    }
//    NSArray* mViews = [[mItem contentView] subviews];
//
//    if (!mViews) {
//        return nil;
//    }
//    for (id subview in mViews) {
//        if (![subview  isMemberOfClass:NSClassFromString(@"SKUIHorizontalLockupView")]){
//            continue;
//        }
//
//        NSArray* mSView = [subview  subviews];
//
//        if (!mSView) {
//            break;
//        }
//        for (id sView in mSView) {
//            if (![sView  isMemberOfClass:NSClassFromString(@"SKUIOfferView")]){
//                continue;
//            }
//
//            NSArray* mSSView = [sView  subviews];
//
//            if (!mSSView) {
//                break;
//            }
//            for (id ssView in mSSView) {
//                if (![ssView  isMemberOfClass:NSClassFromString(@"SKUIItemOfferButton")]){
//                    continue;
//                }
//                mResult = @{@"button":ssView,@"view":subview};
//                break;
//            }
//        }
//
//    }
//
//    return mResult;
//
//}

- (void)dealloc {
    [_timerAuto release];
    [super dealloc];
}


@end
