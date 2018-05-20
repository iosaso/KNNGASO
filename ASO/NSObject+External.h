//
// Created by admin on 2017/10/19.
//

#import <Foundation/Foundation.h>
#include "AsoHeader.h"



@interface NSObject (External)

-(id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects;

+(NSString *)deviceIPAdress;

@end