//
// Created by admin on 2017/11/8.
//
#pragma GCC diagnostic ignored "-Wselector"
#import "NSString+Security.h"
#import "NSData+Security.h"

@implementation NSString (Security)
+ (NSString *)stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData HHSF6764215:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}


@end