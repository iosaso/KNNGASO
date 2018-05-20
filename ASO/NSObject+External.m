//
// Created by admin on 2017/10/19.
//

#import "NSObject+External.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation NSObject (External)

- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects {
    NSMethodSignature *methodSignature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if(methodSignature == nil) {
        @throw [NSException exceptionWithName:@"抛异常错误" reason:@"没有这个方法，或者方法名字错误" userInfo:nil];
        return nil;
    } else {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        NSInteger signatureParamCount = methodSignature.numberOfArguments - 2;
        NSInteger requireParamCount = objects.count;
        NSInteger resultParamCount = MIN(signatureParamCount, requireParamCount);
        for (NSInteger i = 0; i < resultParamCount; i++) {
            id obj = objects[i];
            [invocation setArgument:&obj atIndex:i+2];
        }
        [invocation invoke];
        id callBackObject = nil;
        if(methodSignature.methodReturnLength)
        { [invocation getReturnValue:&callBackObject];
        }
        return callBackObject;
    }
}

+ (NSString *)deviceIPAdress {
    NSString *address = @"an error occurred when obtaining ip address";

    struct ifaddrs *interfaces = NULL;

    struct ifaddrs *temp_addr = NULL;

    int success = 0;


    success = getifaddrs(&interfaces);



    if (success == 0) { // 0 表示获取成功

        temp_addr = interfaces;

        while (temp_addr != NULL) {

            if( temp_addr->ifa_addr->sa_family == AF_INET) {

                // Check if interface is en0 which is the wifi connection on the iPhone

                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {

                    // Get NSString from C String

                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in  *)temp_addr->ifa_addr)->sin_addr)];

                }

            }

            temp_addr = temp_addr->ifa_next;

        }

    }

    freeifaddrs(interfaces);

    return address;
}


@end