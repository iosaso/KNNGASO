//
// Created by admin on 2017/12/7.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

struct CTServerConnection
{
    int a;
    int b;
    CFMachPortRef myport;
    int c;
    int d;
    int e;
    int f;
    int g;
    int h;
    int i;
};

struct CTResult
{
    int flag;
    int a;
};

struct CTServerConnection * _CTServerConnectionCreate(CFAllocatorRef, void *, int *);
void _CTServerConnectionCopyMobileIdentity(struct CTResult *, struct CTServerConnection *, NSString **);
