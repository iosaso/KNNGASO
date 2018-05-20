//
// Created by admin on 2017/10/19.
//

#import <Foundation/Foundation.h>
#include "AsoHeader.h"

@interface AlertManager : NSObject



+(AlertManager* _Nullable)sharedInstance;


-(BOOL)showMessage:(id _Nullable)message  ;

@end