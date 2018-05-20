#import "ASO/ChangeCode/ChangeCode.h"
#import "ASO/DecantingPoint.h"


%ctor{
    // 进行初始化方法
    %init;
    // 调用ChangeCode中的内容
    [[ChangeCode instance] ng_initChangeDeviceCode];
    // 注入点
    [[DecantingPoint instance] ng_DecantingPointInit];

}


