//
// Created by admin on 2017/11/2.
//

#import "ASBase.h"
#import "PTFakeMetaTouch.h"
#import "Constant.h"
#import "GeneralUtil.h"



NSInteger mDownloadTouchPoint_X;
NSInteger mDownloadTouchPoint_Y;

@implementation ASBase {

@private
    BOOL _isCoding;
}


@synthesize isCoding = _isCoding;

- (id _Nullable)init {
    self = [super init];
    if(self) {


    }
    return self;
}

- (BOOL)searchKeyword:(NSString *_Nonnull)keyWord {
    if(!keyWord || [keyWord length] == 0){
        return FALSE;
    }
    // 首先进行查找搜索Bar
    id SearchBar = [self findSearchBar];
    if(!SearchBar){
        return  FALSE;
    }
    [SearchBar setText:keyWord];
    [[SearchBar delegate] performSelector:@selector(searchBarSearchButtonClicked:) withObject:SearchBar];
    return TRUE;
}

/**
 * 对视图进行检索找到搜索条
 * */
-(id)findSearchBar{
    id RootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if([RootViewController selectedIndex] != 3){
        [RootViewController setSelectedIndex:3];
    }
    id Object = [[RootViewController viewControllers] objectAtIndexedSubscript:3];
    id ViewControllers = [Object viewControllers];
    if([ViewControllers count] >= 2){
        [Object performSelector:@selector(popToRootViewControllerAnimated:) withObject:nil];
    }
    id Bar = [Object navigationBar];
    // 进行迭代找到搜索按钮
    id SearchBar = [self findSearchBarFromSuperView:Bar];
    if(!SearchBar){
        return nil;
    }
    id Delagate = [SearchBar delegate];
    if(Delagate && [Delagate respondsToSelector:@selector(searchBarSearchButtonClicked:)]){
        return SearchBar;
    }
    return nil;
}
/**
 * 遍历过程
 * */
-(id)findSearchBarFromSuperView:(id)view{

    NSArray* mViews = [view subviews];

    if (!(mViews != nil && ![mViews isKindOfClass:[NSNull class]] && mViews.count != 0))
    {

        return nil;
    }
    id mCurrentView = [mViews objectAtIndexedSubscript:0];
    // 如果视图为nil时候
    while (true) {

        if (!mCurrentView) {

            break;
        }

        if ([mCurrentView  isMemberOfClass:NSClassFromString([GeneralUtil convertHexStrToString:SKUISEARCHBAR])]){

            return mCurrentView;
        }
        NSArray* mSubViews = [mCurrentView subviews];
        if (!(mSubViews != nil && ![mSubViews isKindOfClass:[NSNull class]] && mSubViews.count != 0)) {

            break;
        }
        mCurrentView = [mSubViews objectAtIndexedSubscript:0];
    }
    return nil;


}


- (id _Nullable)findDownloadButton {
    id mResult = nil;
    UIWindow * mKeyWindow       = [[UIApplication  sharedApplication] keyWindow];
    id mKeyController           = [mKeyWindow rootViewController];
    id mViewControllers         = [mKeyController viewControllers];
    if(!mViewControllers)
        return nil;
    id mSubController           = [mViewControllers objectAtIndexedSubscript:3];
    if (!mSubController)
    {
        return nil;
    }

    [mSubController popToRootViewControllerAnimated:NO];
    id mTopController = [mSubController topViewController];

    if (!mTopController){
        return nil;
    }

    id mSKUCollecionView = [self findCollectionView:[mTopController view]];

    if (!mSKUCollecionView) {
        return nil;
    }

    id mItem = [mSKUCollecionView cellForItemAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:0]];
    if (!mItem) {
        return nil;
    }
    NSArray* mViews = [[mItem contentView] subviews];

    if (!mViews) {
        return nil;
    }
    for (id subview in mViews) {
        if (![subview  isMemberOfClass:NSClassFromString([GeneralUtil convertHexStrToString:SKUIHORIZONTALLOCKUPVIEW])]){
            continue;
        }

        NSArray* mSView = [subview  subviews];

        if (!mSView) {
            break;
        }
        for (id sView in mSView) {
            if (![sView  isMemberOfClass:NSClassFromString([GeneralUtil convertHexStrToString:SKUIOFFERVIEW])]){
                continue;
            }

            NSArray* mSSView = [sView  subviews];

            if (!mSSView) {
                break;
            }
            for (id ssView in mSSView) {
                if (![ssView  isMemberOfClass:NSClassFromString([GeneralUtil convertHexStrToString:SKUIITEMOFFERBUTTON])]){
                    continue;
                }
                mResult = @{[GeneralUtil convertHexStrToString:BUTTON]:ssView,[GeneralUtil convertHexStrToString:VIEW]:subview};
                break;
            }
        }

    }

    return mResult;

}




- (id _Nullable)findCollectionView:(UIView *_Nonnull)view {
    NSArray* mViews = [view subviews];

    if (!(mViews != nil && ![mViews isKindOfClass:[NSNull class]] && mViews.count != 0))
    {

        return nil;
    }
    id mCurrentView = [mViews objectAtIndexedSubscript:0];
    // 如果视图为nil时候
    while (true) {

        if (!mCurrentView) {

            break;
        }

        if ([mCurrentView  isMemberOfClass:NSClassFromString([GeneralUtil convertHexStrToString:SKUICOLLECTIONVIEW])]){

            return mCurrentView;
        }
        NSArray* mSubViews = [mCurrentView subviews];
        if (!(mSubViews != nil && ![mSubViews isKindOfClass:[NSNull class]] && mSubViews.count != 0)) {

            break;
        }
        mCurrentView = [mSubViews objectAtIndexedSubscript:0];
    }
    return nil;
}



- (void)signIn {




    id mSSAuthContextClass = NSClassFromString([GeneralUtil convertHexStrToString:SSAUTHENTICATIONCONTEXT]);
    [[[[NSClassFromString([GeneralUtil convertHexStrToString:SSAUTHENTICATEREQUEST]) alloc] performSelector:
            @selector(initWithAuthenticationContext:) withObject:[mSSAuthContextClass
            performSelector:@selector(contextForSignIn)]] autorelease] performSelector:@selector(start)];

}





- (BOOL)isEntrySubPage {
    id mRootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    id mSubController = [mRootViewController objectAtIndexedSubscript:3];
    id mSebContrNumber = [mSubController viewControllers];
    if ([mSebContrNumber count] != 1) {
        return true;
    }
    id mTopController = [mSubController topViewController];
    if (!mTopController) {
        return FALSE;
    }
    id mSKUICollectionView = [self findCollectionView:[mTopController view]];
    if (!mSKUICollectionView) {
        return FALSE;
    }
    id mDelage = [mSKUICollectionView delegate];
    if (![mDelage numberOfSectionsInCollectionView:mSKUICollectionView]
            || ![mDelage collectionView:mSKUICollectionView numberOfItemsInSection:0]) {
        return FALSE;
    }
    [mDelage collectionView:mSKUICollectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    return TRUE;
}





- (void)signOutAllAcount {
    [[NSClassFromString([GeneralUtil convertHexStrToString:SSACCOUNTSTORE]) defaultStore] performSelector:@selector(signOutAllAccounts)];
}



- (void)signOutActivateAccount {
    id SSAccountStore_name = [GeneralUtil convertHexStrToString:SSACCOUNTSTORE];
    id mActiveAccount =  [[NSClassFromString(SSAccountStore_name) defaultStore] performSelector:@selector(activeAccount)];
    if (mActiveAccount) {
        [[NSClassFromString(SSAccountStore_name) defaultStore] performSelector:@selector(signOutAccount:) withObject:mActiveAccount];

    }
}


- (void)getTouchPoint {
    // 进行按钮点击事件
    id mDic = [self findDownloadButton];
    if(!mDic)
        return;
    id view = [mDic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:BUTTON]];
    if(!view)
        return;
    UIWindow * window=[self lastWindow];
    CGRect rect=[view convertRect: [view bounds] toView:window];
    mDownloadTouchPoint_X = (NSInteger)(rect.origin.x+[view frame].size.width/2);
    mDownloadTouchPoint_Y =(NSInteger)(rect.origin.y+[view frame].size.height/2);
//    NSLog(@"---------------------mDownloadTouchPoint_X = %ld", (long)mDownloadTouchPoint_X);
//    NSLog(@"---------------------mDownloadTouchPoint_Y = %ld", (long)mDownloadTouchPoint_Y);
    // 进行获取当前的系统的版本
//    mDownloadTouchPoint_X = 320;
//    mDownloadTouchPoint_Y =110;
    NSInteger pointId = [PTFakeMetaTouch fakeTouchId:[PTFakeMetaTouch getAvailablePointId] AtPoint:CGPointMake(mDownloadTouchPoint_X,mDownloadTouchPoint_Y) withTouchPhase:UITouchPhaseBegan];
    [PTFakeMetaTouch fakeTouchId:pointId AtPoint:CGPointMake(mDownloadTouchPoint_X,mDownloadTouchPoint_Y) withTouchPhase:UITouchPhaseEnded];
}







// 获取屏幕尺寸的window
- (UIWindow *)lastWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {

        if ([window isKindOfClass:[UIWindow class]] &&
                CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))

            return window;
    }

    return [UIApplication sharedApplication].keyWindow;
}





@end