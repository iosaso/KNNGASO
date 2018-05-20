//
//  DestopTouch.h
//  DestopTouch
//
//  Created by admin on 2017/10/17.
//  Copyright © 2017年 admin. All rights reserved.
//
//


#import <UIKit/UIKit.h>

// In this header, you should import all the public headers of your framework using statements like #import <HJGameController/PublicHeader.h>
#import "PTFakeMetaTouch.h"

#ifdef DEBUG
#define RLog(fmt, ...)
#define DLog(fmt, ...) NSLog((@"PThelper   " fmt), ##__VA_ARGS__);
#else
#define DLog(fmt, ...)
#define RLog(fmt, ...) NSLog((@"PThelper   " fmt), ##__VA_ARGS__);
#endif
