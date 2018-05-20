//
// Created by admin on 2017/11/7.
// 二维码扫描的界面

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"
#import "circle/SSTCircleButton.h"
#import "ScanningDelegate.h"

#import <AVFoundation/AVFoundation.h>
#include "AsoHeader.h"


@interface ScanningController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>





@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layer;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) SSTCircleButton *exitButton;
@property (nonatomic, assign) id<ScanningDelegate> delegate;

-(id)init;






@end