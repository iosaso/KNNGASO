//
// Created by admin on 2017/11/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ScanningSuccessJump : UIViewController


/** 接收扫描的二维码信息 */
@property (nonatomic, copy) NSString *jump_URL;
/** 接收扫描的条形码信息 */
@property (nonatomic, copy) NSString *jump_bar_code;


@end