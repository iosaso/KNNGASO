//
//  SBViewManager.h
//  NianGao_ASO
//
//  Created by admin on 2017/10/19.
//  主要逻辑--》 进行读取perferecce的内容 进行判断当前设备是否已经生效  没有生效 展示序列号    生效则不展示
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "circle/SSTCircleButton.h"
#import "SBViewClickDelegate.h"
#import "SBViewChangeDelegate.h"
#import "ScanningDelegate.h"
#include "AsoHeader.h"


@interface SBViewManager : NSObject<SBViewChangeDelegate,ScanningDelegate>{


@private
    //点击的主界面
    SSTCircleButton* _mainButton;
    //展示序列号的
    UILabel * _serialLabel;
    //展示状态的label
    UILabel * _stateLabel;
    //展示当前版本
    UILabel * _version;
    //点击事件的委托
    id<SBViewClickDelegate> _ClickDelagate;
    //点击的Window
    UIWindow* window;
}


@property(atomic,strong)SSTCircleButton* mainButton;
@property(strong,atomic) UIWindow* controllerWindow;
@property(strong,atomic) UIWindow* scanningWindow;
@property(strong,atomic) UILabel * serialLabel;
@property(strong,atomic) UILabel * stateLabel;
@property(strong,atomic) UILabel * version;
@property(nonatomic, retain) id<SBViewClickDelegate> ClickDelagate;


+(SBViewManager*)shareInstance;

-(id)init;

-(void)becomeKeyWindow:(id)target;


@end
