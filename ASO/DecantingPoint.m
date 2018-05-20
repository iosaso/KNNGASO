//
// Created by admin on 2017/12/19.
//

#import "DecantingPoint.h"
#import <substrate.h>
#import "AsoManger.h"
#import <objc/runtime.h>
#import "AlertManager.h"
#import <UIKit/UIKit.h>
#import "CFNotificManager.h"
#import "OCRManager.h"
#import "SBManager.h"
#import "ASManager.h"
#import "GeneralUtil.h"
#import "ProcessMsgsnd.h"
#import "Constant.h"
#import "ChangeCode/ChangeCode.h"
#import "AlertManager/AlertManageByUsedVersionTenUp.h"

@implementation DecantingPoint {

}


+ (DecantingPoint *)instance {
    static DecantingPoint *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}




// MAC 地址
id	(*old_macAddress)();
id	 new_macAddress()
{
    if([GeneralUtil isWorking]){
        id bund  = [ProcessMsgsnd getMessage];
        if(bund){
            id macAddress = [bund objectForKeyedSubscript:@"NG_MAC_DATA"];
            if(macAddress){
                return   macAddress;
            }
        }

        id mac = [[ChangeCode instance] ng_getOrignDataSets] ;
        if(mac){
            id macAddress = [bund objectForKeyedSubscript:@"ng_macaddress"];
            if(macAddress){
                return   macAddress;
            }
        }


    }
    return old_macAddress();
}


// 蓝牙 地址
id	(*old_bluetoothMACAddress)();
id	 new_bluetoothMACAddress()
{
    if([GeneralUtil isWorking]){
        id bund  = [ProcessMsgsnd getMessage];
        if(bund){
            id blueTouch = [bund objectForKeyedSubscript:@"NG_BLUETOOCH_DATA"];
            if(blueTouch){
                return   blueTouch;
            }

        }

        id bu = [[ChangeCode instance] ng_getOrignDataSets] ;
        if(bu){
            id macAddress = [bund objectForKeyedSubscript:@"ng_BluetoothAddress"];
            if(macAddress){
                return   macAddress;
            }
        }
    }
    return old_bluetoothMACAddress();
}

id	(*old_macAddressSpecifierKey)();
id	 new_macAddressSpecifierKey()
{

    return old_macAddressSpecifierKey();
}


int	(*old_progressState)(id self, SEL _cmd);
int	 new_progressState(id self, SEL _cmd) {

    int mResult = old_progressState(self, _cmd);
    // 进度条状态  是否正在工作
//    if (![AsoManager sharedInstance].isWorking)
//        return mResult;
    if([GeneralUtil isWorking]){
        BOOL isEnter;
        // 进行相应的状态判断
        NSInteger isDOwnload = (NSInteger) [self performSelector:@selector(isDownloadingIcon)];
        if ( mResult >= 1) {
            isEnter = isDOwnload == 0;

        }else{
            isEnter = TRUE;
        }
        if (!isEnter) {
            [self performSelector:@selector(cancelDownload)];
        }
    }
    return mResult;
}


void   (*old_popupAlertAnimated)(id self, SEL _cmd,id animated);
void	new_popupAlertAnimated(id self, SEL _cmd,id animated) {
    if([GeneralUtil isWorking]){
        if (![[AlertManager sharedInstance] showMessage:self]) {
            id title =   [self title];
            id delegate =  [self delegate];
            //Alert是当前的对话框 则进行修改
            if ([title isEqualToString:@"未安装 SIM 卡"] ||[title isEqualToString:@"No SIM Card Installed"] ) {
                if ([delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
                    [self dismissWithClickedButtonIndex:[self cancelButtonIndex] animated:NO];
                }
            }

        }
        return;
    }
    old_popupAlertAnimated(self,_cmd,animated);

}


void	(*old_applicationDidFinishLaunching)(id self, SEL _cmd,id application);
void	 new_applicationDidFinishLaunching(id self, SEL _cmd,id application) {
    old_applicationDidFinishLaunching(self,_cmd,application);
    [[SBManager instance] showWindow:self];
}


void	(*old_addOperation)(id self, SEL _cmd,id content);
void	 new_addOperation(id self, SEL _cmd,id content) {
    old_addOperation(self,_cmd,content);
}




void	(*old_connectionDidFinishLoading)(id self, SEL _cmd,id content);
void	 new_connectionDidFinishLoading(id self, SEL _cmd,id content) {

    if([GeneralUtil isWorking]){
        BOOL isChangeSuccess = FALSE;
        Class mClass = object_getClass(self);
        Ivar ivar = class_getInstanceVariable(mClass, "_dataBuffer");
        isChangeSuccess=  [[ASManager instance] changSerachTop:object_getIvar(self,ivar)];
        if(isChangeSuccess){
            [CFNotificManager AddMessage:TOUCH_CLICK_DOWNLOAD_BUTTON];
        }
    }
    old_connectionDidFinishLoading(self,_cmd,content);

}


void	(*old_handleFinishedLoading)(id self, SEL _cmd);
void	 new_handleFinishedLoading(id self, SEL _cmd) {

    if([GeneralUtil isWorking]){
        BOOL isChangeSuccess = FALSE;
        Class mClass = object_getClass(self);
        Ivar ivar = class_getInstanceVariable(mClass, "_dataBuffer");
        isChangeSuccess=  [[ASManager instance] changSerachTop:object_getIvar(self,ivar)];
        if(isChangeSuccess){
            [CFNotificManager AddMessage:TOUCH_CLICK_DOWNLOAD_BUTTON];
        }
    }
    old_handleFinishedLoading(self,_cmd);

}



void	(*old_webCiewDidFinishLoad)(id self, SEL _cmd,id webview);
void	 new_webCiewDidFinishLoad(id self, SEL _cmd,id webview) {
    if([GeneralUtil isWorking]){
        [[OCRManager sharedInstance] ocr:webview];
    }
    old_webCiewDidFinishLoad(self,_cmd,webview);

}







void	(*old_show)(id self, SEL _cmd);
void	 new_show(id self, SEL _cmd) {
    if([GeneralUtil isWorking]){
        [[AlertManager sharedInstance] showMessage:self];
    }
    old_show(self,_cmd);
}




void	(*old_setValuesUsingBuyButtonDescriptor)(id self, SEL _cmd,id Descp,id state,id client,id animated);
void	 new_setValuesUsingBuyButtonDescriptor(id self, SEL _cmd,id Descp,id state,id client,id animated) {
    if([GeneralUtil isWorking]){
//        [self startAutoDownload:state];
        [[ASManager instance] startAutoDownload:state];
    }
    old_setValuesUsingBuyButtonDescriptor(self,_cmd,Descp,state,client,animated);

}
//
//void	(*old_popupAlertAnimated)(id self, SEL _cmd,id animated);
//void	 new_popupAlertAnimated(id self, SEL _cmd,id animated) {
//
//}
void	(*old_alertItem)(id self, SEL _cmd);
void	 new_alertItem(id self, SEL _cmd) {
    if([GeneralUtil isWorking]) {
        // 调用10的拦截弹出
        [[AlertManageByUsedVersionTenUp instance] handleAlertBySimulatedTouch:self];
    }
    old_alertItem(self,_cmd);
}







// 注入点的全部内容
- (void)ng_DecantingPointInit {
    // 进行获取混淆后的方法名
    NSString *SBUserNotificationAlertSheetString = [GeneralUtil convertHexStrToString:NG_DP_SBUserNotificationAlertSheet];
    NSString *SpringBoardString = [GeneralUtil convertHexStrToString:NG_DP_SpringBoard];
    NSString *ISOperationQueueString = [GeneralUtil convertHexStrToString:NG_DP_ISOperationQueue];
    NSString *ISStoreURLOperationString = [GeneralUtil convertHexStrToString:NG_DP_ISStoreURLOperation];
    NSString *ISURLOperationString = [GeneralUtil convertHexStrToString:NG_DP_ISURLOperation];
    NSString *SUWebViewManaagerString = [GeneralUtil convertHexStrToString:NG_DP_SUWebViewManaager];
    NSString *UIAlertViewString = [GeneralUtil convertHexStrToString:NG_DP_UIAlertView];
    NSString *SKUIItemOfferButtonString = [GeneralUtil convertHexStrToString:NG_DP_SKUIItemOfferButton];
    NSString *SBDownloadingIconString = [GeneralUtil convertHexStrToString:NG_DP_SBDownloadingIcon];
    NSString *AboutDataSourceString = [GeneralUtil convertHexStrToString:NG_DP_AboutDataSource];
    NSString *popupAlertAnimated = [GeneralUtil convertHexStrToString:NG_DP_popupAlertAnimated];
    NSString *applicationDidFinishLaunching = [GeneralUtil convertHexStrToString:NG_DP_applicationDidFinishLaunching];
    NSString *addOperation = [GeneralUtil convertHexStrToString:NG_DP_addOperation];
    NSString *connectionDidFinishLoading = [GeneralUtil convertHexStrToString:NG_DP_connectionDidFinishLoading];
    NSString *_handleFinishedLoading = [GeneralUtil convertHexStrToString:NG_DP_handleFinishedLoading];
    NSString *webCiewDidFinishLoad = [GeneralUtil convertHexStrToString:NG_DP_webCiewDidFinishLoad];
    NSString *show = [GeneralUtil convertHexStrToString:NG_DP_show];
    NSString *setValuesUsingBuyButtonDescriptor = [GeneralUtil convertHexStrToString:NG_DP_setValuesUsingBuyButtonDescriptor];
    NSString *progressState = [GeneralUtil convertHexStrToString:NG_DP_progressState];
    NSString *_macAddressSpecifierKey = [GeneralUtil convertHexStrToString:NG_DP_macAddressSpecifierKey];
    NSString *_bluetoothMACAddress = [GeneralUtil convertHexStrToString:NG_DP_bluetoothMACAddress];
    NSString *_macAddress = [GeneralUtil convertHexStrToString:NG_DP_macAddress];
    NSString *SBAlertControllerString = [GeneralUtil convertHexStrToString:NG_DP_SBAlertController];
    NSString *SBAlertController_alertItem = [GeneralUtil convertHexStrToString:NG_DP_alertItem];



    // 获取类名 [GeneralUtil convertHexStrToString:URI_JSON_deviceType]
    Class SBUserNotificationAlertSheet          = NSClassFromString(SBUserNotificationAlertSheetString);
    Class SpringBoard                           = NSClassFromString(SpringBoardString);
    Class ISOperationQueue                      = NSClassFromString(ISOperationQueueString);
    Class ISStoreURLOperation                   = NSClassFromString(ISStoreURLOperationString);
    Class ISURLOperation                        = NSClassFromString(ISURLOperationString);
    Class SUWebViewManaager                     = NSClassFromString(SUWebViewManaagerString);
    Class UIAlertView                           = NSClassFromString(UIAlertViewString);
    Class SKUIItemOfferButton                   = NSClassFromString(SKUIItemOfferButtonString);
    Class SBDownloadingIcon                     = NSClassFromString(SBDownloadingIconString);
    Class AboutDataSource                       = NSClassFromString(AboutDataSourceString);
    Class SBAlertController                     = NSClassFromString(SBAlertControllerString);



//    Class SBUserNotificationAlertSheet          = objc_getClass("SBUserNotificationAlertSheet");
//    Class SpringBoard                           = objc_getClass("SpringBoard");
//    Class ISOperationQueue                      = objc_getClass("ISOperationQueue");
//    Class ISStoreURLOperation                   = objc_getClass("ISStoreURLOperation");
//    Class ISURLOperation                        = objc_getClass("ISURLOperation");
//    Class SUWebViewManaager                     = objc_getClass("SUWebViewManaager");
//    Class UIAlertView                           = objc_getClass("UIAlertView");
//    Class SKUIItemOfferButton                   = objc_getClass("SKUIItemOfferButton");
//    Class SBDownloadingIcon                     = objc_getClass("SBDownloadingIcon");
//    Class AboutDataSource                       = objc_getClass("AboutDataSource");
    // 注册点
    MSHookMessageEx(SpringBoard, NSSelectorFromString(applicationDidFinishLaunching), (IMP)new_applicationDidFinishLaunching, (IMP*)&old_applicationDidFinishLaunching);
    MSHookMessageEx(ISOperationQueue, NSSelectorFromString(addOperation), (IMP)new_addOperation, (IMP*)&old_addOperation);
    MSHookMessageEx(ISStoreURLOperation, NSSelectorFromString(connectionDidFinishLoading), (IMP)new_connectionDidFinishLoading, (IMP*)&old_connectionDidFinishLoading);
    MSHookMessageEx(ISURLOperation, NSSelectorFromString(_handleFinishedLoading), (IMP)new_handleFinishedLoading, (IMP*)&old_handleFinishedLoading);
    MSHookMessageEx(SUWebViewManaager, NSSelectorFromString(webCiewDidFinishLoad), (IMP)new_webCiewDidFinishLoad, (IMP*)&old_webCiewDidFinishLoad);
    MSHookMessageEx(SBUserNotificationAlertSheet, NSSelectorFromString(popupAlertAnimated), (IMP)new_popupAlertAnimated, (IMP*)&old_popupAlertAnimated);
    MSHookMessageEx(UIAlertView, NSSelectorFromString(show), (IMP)new_show, (IMP*)&old_show);
    MSHookMessageEx(SKUIItemOfferButton, NSSelectorFromString(setValuesUsingBuyButtonDescriptor), (IMP)new_setValuesUsingBuyButtonDescriptor, (IMP*)&old_setValuesUsingBuyButtonDescriptor);
    MSHookMessageEx(SBDownloadingIcon, NSSelectorFromString(progressState), (IMP)new_progressState, (IMP*)&old_progressState);
    MSHookMessageEx(AboutDataSource, NSSelectorFromString(_macAddressSpecifierKey), (IMP)new_macAddressSpecifierKey, (IMP*)&old_macAddressSpecifierKey);
    MSHookMessageEx(AboutDataSource, NSSelectorFromString(_bluetoothMACAddress), (IMP)new_bluetoothMACAddress, (IMP*)&old_bluetoothMACAddress);
    MSHookMessageEx(AboutDataSource, NSSelectorFromString(_macAddress), (IMP)new_macAddress, (IMP*)&old_macAddress);
    MSHookMessageEx(SBAlertController, NSSelectorFromString(SBAlertController_alertItem), (IMP)new_alertItem, (IMP*)&old_alertItem);
//    MSHookMessageEx(SBUserNotificationAlertSheet, NSSelectorFromString(@"popupAlertAnimated:"), (IMP)new_popupAlertAnimated, (IMP*)&old_popupAlertAnimated);
//    MSHookMessageEx(SpringBoard, NSSelectorFromString(@"applicationDidFinishLaunching:"), (IMP)new_applicationDidFinishLaunching, (IMP*)&old_applicationDidFinishLaunching);
//    MSHookMessageEx(ISOperationQueue, NSSelectorFromString(@"addOperation:"), (IMP)new_addOperation, (IMP*)&old_addOperation);
//    MSHookMessageEx(ISStoreURLOperation, NSSelectorFromString(@"connectionDidFinishLoading:"), (IMP)new_connectionDidFinishLoading, (IMP*)&old_connectionDidFinishLoading);
//    MSHookMessageEx(ISURLOperation, NSSelectorFromString(@"_handleFinishedLoading"), (IMP)new_handleFinishedLoading, (IMP*)&old_handleFinishedLoading);
//    MSHookMessageEx(SUWebViewManaager, NSSelectorFromString(@"webCiewDidFinishLoad:"), (IMP)new_webCiewDidFinishLoad, (IMP*)&old_webCiewDidFinishLoad);
//    MSHookMessageEx(UIAlertView, NSSelectorFromString(@"show"), (IMP)new_show, (IMP*)&old_show);
//    MSHookMessageEx(SKUIItemOfferButton, NSSelectorFromString(@"setValuesUsingBuyButtonDescriptor:itemState:clientContext:animated:"), (IMP)new_setValuesUsingBuyButtonDescriptor, (IMP*)&old_setValuesUsingBuyButtonDescriptor);
//    MSHookMessageEx(SBDownloadingIcon, NSSelectorFromString(@"progressState"), (IMP)new_progressState, (IMP*)&old_progressState);
//    MSHookMessageEx(AboutDataSource, NSSelectorFromString(@"_macAddressSpecifierKey"), (IMP)new_macAddressSpecifierKey, (IMP*)&old_macAddressSpecifierKey);
//    MSHookMessageEx(AboutDataSource, NSSelectorFromString(@"_bluetoothMACAddress"), (IMP)new_bluetoothMACAddress, (IMP*)&old_bluetoothMACAddress);
//    MSHookMessageEx(AboutDataSource, NSSelectorFromString(@"_macAddress"), (IMP)new_macAddress, (IMP*)&old_macAddress);
}


@end