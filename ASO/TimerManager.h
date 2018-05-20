//
// Created by admin on 2017/10/26.
//
// 用来进行管理当前的定时操作的。

#import <Foundation/Foundation.h>
#include "AsoHeader.h"

@interface TimerManager : NSObject


@property(strong, nonatomic) NSTimer* _Nullable applicationTimer;
@property(strong, nonatomic) NSTimer* _Nullable appstoreTimer;
//@property(strong, nonatomic) NSTimer* _Nullable reSearchTimter;



-(id _Nullable)init;

+ (TimerManager * _Nullable)instance;


-(void)registApplicationTimer;


//
-(void)registAppStoreTimer;


-(void)cancelApplicationTimer;



-(void)cancelAppStoreTimer;


//
//-(void)registreSearchTimter;
//
//-(void)reSearchTimter;

@end