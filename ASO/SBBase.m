//
// Created by admin on 2017/11/2.
//

#import "SBBase.h"
#import <objc/runtime.h>
#import "ProcessCmd.h"
#import "ProcessMsgsnd.h"
#import "ASManager.h"
#import <UIKit/UIKit.h>
#import "CFNotificManager.h"
#import "GeneralUtil.h"
#import "Constant.h"


@implementation SBBase {

}
-(void)launchAppStore:(NSString* _Nullable)keyWord  {
//    NSLog(@"keyWord = %@", keyWord);
//    [self launchApp:@"com.apple.AppStore"];
    NSString *str = [NSString stringWithFormat: [GeneralUtil convertHexStrToString:AUTO_SEARCH_URL],[keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    // 开启自动搜索
    //   [[ASManager instance] performSelector:@selector(autoSearch) withObject:nil afterDelay:0.5];
//    [CFNotificManager SendMessage:AUTO_SEARCH];

}

- (void)unLockScreen {

    id class =  NSClassFromString([GeneralUtil convertHexStrToString:SBLOCKSCREENMANAGER]);
    if ([class respondsToSelector:@selector(sharedInstance)]) {
        if ((BOOL)[[class performSelector:@selector(sharedInstance)] performSelector:@selector(isUILocked)]) {
            [[class performSelector:@selector(sharedInstance)] performSelector:@selector(unlockUIFromSource:withOptions:) withObject:[NSNumber numberWithInt:0] withObject:nil];
        }
    }
}

- (BOOL)isLockScreen {
    id class =  NSClassFromString([GeneralUtil convertHexStrToString:SBLOCKSCREENMANAGER]);
    if ([class respondsToSelector:@selector(sharedInstance)]) {

        return   (BOOL)[[class performSelector:@selector(sharedInstance)] performSelector:@selector(isUILocked)];
    }

    return FALSE;
}

- (void)uninstallDeb:(id _Nullable)deb {
    // 进行操作deb卸载 并进行输入 alpine 命令
    [NSString  stringWithFormat:@"dpkg -p %@ ",deb];
}

- (void)clearIconData:(id _Nullable)data {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 用来清除屏幕的 信息  /usr/bin/cleaR
        [[ProcessCmd shareInstance] runCustomCommand:@"/usr/bin/clear" withCmdArray:nil];

    });
}

- (void)clearIconCache:(id _Nonnull)cache {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 用来清除屏幕的 信息  /usr/bin/cleaR
        [[ProcessCmd shareInstance] runCustomCommand:@"/usr/bin/uicache" withCmdArray:nil];

    });
}

- (void)clearFile {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self removeContentsOfDirectory:[GeneralUtil convertHexStrToString:DELETE_ITUNESSTORE_DIR]];
    });
}


-(void)removeContentsOfDirectory:(NSString*)directory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:directory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        [fileManager removeItemAtPath:[directory stringByAppendingPathComponent:filename] error:NULL];
    }
}

- (void)RemoveIcon:(id _Nullable)icon {
    if (!icon) {
        return;
    }
    if ([icon length] == 0) {
        return;
    }
    id class = NSClassFromString([GeneralUtil convertHexStrToString:SBICONCONTROLLER]);
    if (![class respondsToSelector:@selector(sharedInstance)]) {
        return;
    }
    id mClass = [class performSelector:@selector(sharedInstance)];
    Class mC = object_getClass(mClass);
    Ivar mIvar = class_getInstanceVariable(mC, "_iconModel");
    id mClassFor = object_getIvar(mClass, mIvar);
    id mIden = [mClassFor performSelector:@selector(applicationIconForBundleIdentifier:) withObject:icon];
    if(mIden && [mClassFor respondsToSelector:@selector(removeIcon:)]){
        [object_getIvar(mClass, mIvar) performSelector:@selector(removeIcon:) withObject:mIden];
    }
}

- (void)RemoveIconForIdentifier:(id _Nullable)identifier {
    if (!identifier || ![identifier length] ) {
        return;
    }
    id class = NSClassFromString([GeneralUtil convertHexStrToString:SBICONCONTROLLER]);
    if (![class respondsToSelector:@selector(sharedInstance)]) {
        return;
    }

    id mClass = [class performSelector:@selector(sharedInstance)];
    Class mC = object_getClass(mClass);
    Ivar mIvar = class_getInstanceVariable(mC, "_iconModel");

    id mClassFor = object_getIvar(mClass, mIvar);
    if([mClassFor respondsToSelector:@selector(removeIcon:)]){
        [object_getIvar(mClass, mIvar) performSelector:@selector(removeIconForIdentifier:) withObject:identifier];
    }

}

- (void)UninstallApplicationFromDestop:(id _Nullable)application {
    if (!application) {
        return;
    }
    if ([application length] == 0) {
        return;
    }

    id isApp = [self  applicationIconForBundle:application];
    if (!isApp) {
        return;
    }
    id mApplication = [isApp performSelector:@selector(application)];
    if (!mApplication) {
        return;
    }
    id class = NSClassFromString([GeneralUtil convertHexStrToString:SBAPPLICATIONCONTROLLER]);
    if (![class respondsToSelector:@selector(sharedInstance)]) {
        return;
    }
    id mClass = [class performSelector:@selector(sharedInstance)];
    [mClass performSelector:@selector(uninstallApplication:) withObject:mApplication];
}

- (void)UninstallIconFromDestop:(id _Nullable)icon {
    if (!icon || [icon length] == 0) {
        return;
    }
    id isApp = [self applicationIconForBundle:icon];
    if (!isApp) {
        return;
    }
    id class = NSClassFromString([GeneralUtil convertHexStrToString:SBICONCONTROLLER]);
    if (![class respondsToSelector:@selector(sharedInstance)]) {
        return;
    }
    id mClass = [class performSelector:@selector(sharedInstance)];
    if (![mClass respondsToSelector:@selector(uninstallIcon:)]) {
        return;
    }
    [mClass performSelector:@selector(uninstallIcon:) withObject:isApp];
}

- (void)SBDeleteIconAlertItem:(id _Nullable)bundlid {
    if(bundlid && [bundlid length] > 0){
//        id applicationBundle = [self applicationIconForBundle:bundlid];
//        if (applicationBundle){
//            id SBDeleteIconAlertItem = NSClassFromString([GeneralUtil convertHexStrToString:SBDELETEICONALERTITEM]);
//            id sb = [[[SBDeleteIconAlertItem alloc] performSelector:@selector(initWithIcon:) withObject:applicationBundle] autorelease];
//            [sb performSelector:@selector(alertView:clickedButtonAtIndex:) withObject:nil withObject:[NSNumber numberWithInteger:0]];
//        }
    }
}

- (id _Nullable)applicationIconForBundle:(id _Nullable)bundleIdentifier {
    if (!bundleIdentifier || [bundleIdentifier length] == 0 ) {
        return nil;
    }

    id class = NSClassFromString([GeneralUtil convertHexStrToString:SBICONCONTROLLER]);

    if (![class respondsToSelector:@selector(sharedInstance)]) {
        return nil;
    }
    id mClass = [class performSelector:@selector(sharedInstance)];
    Class mC = object_getClass(mClass);
    Ivar mIvar = class_getInstanceVariable(mC, "_iconModel");
    id mIcon = [object_getIvar(mClass, mIvar) performSelector:@selector(applicationIconForBundleIdentifier:) withObject:bundleIdentifier];
    return  mIcon;
}

- (void)launchApp:(id _Nullable)app {
    //    NSString *str = [NSString stringWithFormat: @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/search?mt=8&submit=edit&term=%@#software",[keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];



//    id class = NSClassFromString(@"SBIconController");
//    if (![class respondsToSelector:@selector(sharedInstance)]) {
//        return ;
//    }
    if(!app){
        return;
    }
//    id mClass = [class performSelector:@selector(sharedInstance)];
//    Class mC = object_getClass(mClass);
//    Ivar mIvar = class_getInstanceVariable(mC, "_iconModel");
//    id mIcon = [object_getIvar(mC, mIvar) performSelector:@selector(applicationIconForBundleIdentifier:) withObject:app];
//    [mClass performSelector:@selector(_launchIcon) withObject:mIcon];
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject * workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    [workspace performSelector:@selector(openApplicationWithBundleID:) withObject:app];
}

- (void)clearTempFile {
        // 进行删除对应的文件



}

- (void)deleteDownloadTempFile {
    NSString *path; // 要列出来的目录
    NSString *downloadDir = [GeneralUtil convertHexStrToString:DELETE_DOWNLOAD_DILR];
    NSDirectoryEnumerator* mFile = [[NSFileManager defaultManager] enumeratorAtPath:downloadDir];
    while((path=[mFile nextObject])!=nil){
        id mRealDic = [downloadDir stringByAppendingPathComponent:path];
        if ([mRealDic rangeOfString:[GeneralUtil convertHexStrToString:DELETE_DOWNLOAD_DILR_SQL]].location == NSNotFound)
            [[NSFileManager defaultManager] removeItemAtPath:mRealDic error:nil];
    }
}


- (void)unInstallDownloadApp {
    NSString * mBundle = [[ProcessMsgsnd getMessage] objectForKeyedSubscript:[GeneralUtil convertHexStrToString:bundleId_name]];
    if(!mBundle)
        return;
    [self SBDeleteIconAlertItem:mBundle];
    [self UninstallApplicationFromDestop:mBundle];
    [self UninstallIconFromDestop:mBundle];
    [self RemoveIconForIdentifier:mBundle];
    [self RemoveIcon:mBundle];
    [self clearFile];
}

@end