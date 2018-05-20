//
// Created by admin on 2017/12/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SUPPORTS_IOKIT_EXTENSIONS    1
@interface UIDevice (Extensions)

- (NSString *) imei;
- (NSString *) serialnumber;
- (NSString *) backlightlevel;


@end