//
// Created by admin on 2017/10/19.
//

#import <Foundation/Foundation.h>
#include "AsoHeader.h"

@interface ProcessCmd : NSObject


+(ProcessCmd* _Nonnull)shareInstance;




-(void)runSystemCommand:(NSString* _Nonnull)cmd;

-(void)killSpringBoard;

-(void)killAppStore;

-(void)runCustomCommand:(NSString* _Nonnull)bin withCmdArray:(NSArray* _Nullable)array;

-(void)runUninstallDeb;

@end