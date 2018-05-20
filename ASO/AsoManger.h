//
//  AsoManger.h
//  NianGao_ASO
//
//  Created by admin on 2017/10/19.
//
//

#import "AsoBase.h"
#import "SBViewClickDelegate.h"
#import "SBViewChangeDelegate.h"
#include "AsoHeader.h"
@interface AsoManager : AsoBase


+(AsoManager *_Nullable)sharedInstance;




// 图片验证识别时候进行的Timer 如果超时则进行关闭应用
@property(nonatomic, assign) NSTimer *_Nullable mORCTimer;
@property(nonatomic, weak) id<SBViewChangeDelegate> _Nullable mDelegate;


-(id _Nullable)init;

-(void)clearAndRestartRequest;

-(void)restartRequestTask;

-(void)getTask;

-(void)failByDes:(NSString *_Nullable)des;





@end



