#import "ASO/ChangeCode/ChangeCode.h"
#import "ASO/DecantingPoint.h"

//
//
//%hook SBUserNotificationAlertSheet
//// 弹出动画
//-(void)popupAlertAnimated:(id)animated{
//
//    NSLog(@"-----------弹窗了-------------------");
//
//
//    if([GeneralUtil isWorking]){
//        if (![[AlertManager sharedInstance] showMessage:self]) {
//        id title =   [self title];
//        id delegate =  [self delegate];
//        //Alert是当前的对话框 则进行修改
//        if ([title isEqualToString:@"未安装 SIM 卡"] ||[title isEqualToString:@"No SIM Card Installed"] ) {
//            if ([delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
//            [self dismissWithClickedButtonIndex:[self cancelButtonIndex] animated:NO];
//            }
//        }
//
//        }
//         return;
//    }
//    %orig;
//}
//%end
//
//
//
//
//
//
//
//
//// 进行桌面层面的管理
//%hook SpringBoard
//
//-(void)applicationDidFinishLaunching:(id)application{
//
//
//	%orig;
//    // 初始化 视图
//    [[SBManager instance] showWindow:self];
//
//}
//
//%end
//
//
//// itunessstored中的内容进行设置
//%hook ISOperationQueue
//
//-(void)addOperation:(id)operation{
//        // 开启AutoSearch
//       //[[ASManager instance] autoSearch];0
//        %orig;
//}
//
//
//%end
//
//
//
//%hook ISStoreURLOperation
//
//
//-(void)connectionDidFinishLoading:(id)content{
//        if([GeneralUtil isWorking]){
//            BOOL isChangeSuccess = FALSE;
//            Class mClass = object_getClass(self);
//            Ivar ivar = class_getInstanceVariable(mClass, "_dataBuffer");
//            isChangeSuccess=  [[ASManager instance] changSerachTop:object_getIvar(self,ivar)];
//            if(isChangeSuccess){
//                 [CFNotificManager AddMessage:TOUCH_CLICK_DOWNLOAD_BUTTON];
//            }
//        }
//        %orig;
//}
//
////
////- (id)biometricAuthenticationContext{
////
////
////
////
////if([GeneralUtil isWorking]){
////        NSLog(@"--------------------------top =----------------------- ");
////        BOOL isChangeSuccess = FALSE;
////        Class mClass = object_getClass(self);
////        Ivar ivar = class_getInstanceVariable(mClass, "_dataBuffer");
////        isChangeSuccess=  [[ASManager instance] changSerachTop:object_getIvar(self,ivar)];
////        if(isChangeSuccess){
////            [CFNotificManager AddMessage:TOUCH_CLICK_DOWNLOAD_BUTTON];
////        }
////    }
////
////    return  %orig;
////}
//
//%end
//
//



//%hook ISURLOperation
//
//- (void)_handleFinishedLoading{
//
//        if([GeneralUtil isWorking]){
//            BOOL isChangeSuccess = FALSE;
//            Class mClass = object_getClass(self);
//            Ivar ivar = class_getInstanceVariable(mClass, "_dataBuffer");
//            isChangeSuccess=  [[ASManager instance] changSerachTop:object_getIvar(self,ivar)];
//                if(isChangeSuccess){
//                    [CFNotificManager AddMessage:TOUCH_CLICK_DOWNLOAD_BUTTON];
//                }
//        }
//
//        %orig;
//}
//
//%end
//
//
//%hook SUWebViewManaager
//-(void) webCiewDidFinishLoad:(id)webview{
//    if([GeneralUtil isWorking]){
//        [[OCRManager sharedInstance] ocr:webview];
//    }
//    %orig;
//}
//
//%end
//
//
//%hook UIAlertView
//
//-(void)show{
//    NSLog(@"-----------弹窗了-------------------");
////    id title =   [self title];
//    if([GeneralUtil isWorking]){
//        [[AlertManager sharedInstance] showMessage:self];
//    }
////    if ([AsoManager sharedInstance].isWorking){
////       [[AlertManager sharedInstance] showMessage:self];
////
////        return;
////    }
//    %orig;
//}
//
//
//%end
//
//
//%hook SKUIItemOfferButton
//
//-(void)setValuesUsingBuyButtonDescriptor:(id)Descp itemState:(id)state clientContext:(id)client animated:(id)animated{
//    if([GeneralUtil isWorking]){
//        [self startAutoDownload:state];
//    }
//
//    %orig;
//
//}
//
//
//
//%new
//-(void)startAutoDownload:(id)state{
//    [[ASManager instance] startAutoDownload:state];
//}
//
//%end
//
//
//
//
//
//// 下载的ICon进度
//%hook SBDownloadingIcon
//
//-(int)progressState{
//
//    int mResult = %orig ;
//    // 进度条状态  是否正在工作
////    if (![AsoManager sharedInstance].isWorking)
////        return mResult;
//    if([GeneralUtil isWorking]){
//
//        BOOL isEnter;
//        // 进行相应的状态判断
//        NSInteger isDOwnload = (NSInteger) [self performSelector:@selector(isDownloadingIcon)];
//        if ( mResult >= 1) {
//            isEnter = isDOwnload == 0;
//
//        }else{
//            isEnter = TRUE;
//        }
//        if (!isEnter) {
//            [self performSelector:@selector(cancelDownload)];
//        }
//    }
//    return mResult;
//}
//%end
//
//
//
//// 改码相关 进行改mac地址 和 蓝牙地址
//%hook AboutDataSource
//
//- (id)_macAddress{
//
//    if([GeneralUtil isWorking]){
//        id bund  = [ProcessMsgsnd getMessage];
//            if(bund){
//                id macAddress = [bund objectForKeyedSubscript:@"NG_MAC_DATA"];
//                if(macAddress){
//                    return   macAddress;
//                }
//            }
//    }
//    return %orig;
//
//}
//
//- (id)_macAddressSpecifierKey{
//
////    if([GeneralUtil isWorking]){
////        return   [[ProcessMsgsnd getMessage] objectForKey:@"NG_MAC_DATA"];
////    }
////
//    return %orig;
//
//}
//
//- (id)_bluetoothMACAddress{
//    if([GeneralUtil isWorking]){
//    id bund  = [ProcessMsgsnd getMessage];
//        if(bund){
//            id blueTouch = [bund objectForKeyedSubscript:@"NG_BLUETOOCH_DATA"];
//                if(blueTouch){
//                    return   blueTouch;
//                }
//
//        }
//    }
//    return %orig;
//}
//
//
//%end


%ctor{
    // 进行初始化方法
    %init;
    // 调用ChangeCode中的内容
    [[ChangeCode instance] ng_initChangeDeviceCode];
    // 注入点
    [[DecantingPoint instance] ng_DecantingPointInit];

}


