//
//  SBViewClickDelegate.h
//  NianGao_ASO
//
//  Created by admin on 2017/10/19.
//  进行触发点击事件进行的操作
//

#import <Foundation/Foundation.h>
#include "AsoHeader.h"


@protocol SBViewClickDelegate <NSObject>


-(void)onUnlockScreen;
// 开始
-(void)onClickStart;
// 结束
-(void)onClickEnd;

@end
