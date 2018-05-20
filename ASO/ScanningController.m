//
// Created by admin on 2017/11/7.
//

#import "ScanningController.h"
#import "NetServer.h"
#import "GeneralUtil.h"
#import "Constant.h"
#import "ChangeCode/ChangeCode.h"
#ifndef ScanningController_name
#define ScanningController_name

#define PRE_FIX @"NianGao://"



#endif

@implementation ScanningController {
@private
    AVCaptureSession *_session;
    AVCaptureVideoPreviewLayer *_layer;
    UILabel *_promptLabel;
    SSTCircleButton *_exitButton;
    id <ScanningDelegate> _delegate;
    UILabel *_stateLabel;
    UIImageView *_logoImageView;
}

@synthesize session = _session;
@synthesize layer = _layer;
@synthesize promptLabel = _promptLabel;
@synthesize exitButton = _exitButton;
@synthesize delegate = _delegate;

@synthesize stateLabel = _stateLabel;
@synthesize logoImageView = _logoImageView;

- (id)init {
    self = [super init];
    if(self){

    }
    return self;
}




#pragma mark - AVCapture
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *code  = nil;
    for (AVMetadataObject *metadata in metadataObjects){
        if([metadata.type isEqualToString:AVMetadataObjectTypeQRCode ]){
            code = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
            break;
        }

    }

//    NSLog(@"code = %@", code);

    // 获取到的二维码结果进行比对，如果非年糕公司 则进行忽略  并继续
    if([code hasPrefix:PRE_FIX]){
        [_session stopRunning];

        // 进行请求对应的内容
        id needDecip = [code stringByReplacingOccurrencesOfString:PRE_FIX withString:@""];
        // 进行请求当前的内容


        // 进行保存当前设备的原始数据
        [[ChangeCode instance] ng_saveOrignDeviceInfo];
        // 进行请求注册设备
        [NetServer deviceIsAuthorizeByClould:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {

                NSLog(@"错误原因:%@",[error localizedDescription]);
                return;
            }
            NSError *jsonError = nil;
            //Json解析

//            NSLog(@"dic = %@",  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]  );

            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
//            NSLog(@"----------------dic----------------------- = %@", dic);

            id msg = [dic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:MSG]];
            id code = [dic objectForKeyedSubscript:[GeneralUtil convertHexStrToString:CODE]];

            if([code intValue] == 0 || [code intValue]  == 2 ){
                // 进行保存文件
                [GeneralUtil saveTokenWithUidToFile:needDecip];

                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self updateLabel:[NSString stringWithFormat:@"设备注册成功，云端提示为：%@，6s后自动关闭此页",msg]];
                    [self performSelector:@selector(onClickExitButton) withObject:nil afterDelay:6.0];

                });

            }else{
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self updateLabel:[NSString stringWithFormat:@"识别错误，原因为：%@",msg]];
                });

            }
        }  withCloundContent:needDecip];


    }

}

- (void)viewDidLoad {
    [super viewDidLoad];

//    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self addQBBtn];

    [self.view addSubview:self.initPromptLabel];
    [self.view addSubview:[self initIcon]];
    [self.view addSubview:self.initExitButton];

}

-(void)addQBBtn{

    //获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //初始化链接对象
    _session = [[AVCaptureSession alloc] init];
    //创建输入流
    NSError * error = nil;
    AVCaptureDeviceInput *input =  [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if(input){
        // 设置回话的输入设备
        [_session addInput:input];

    }else{
        NSLog(@"[error localizedDescription] = %@", [error localizedDescription]);

    }
    //创建输入流
    AVCaptureMetadataOutput *outpt  = [[AVCaptureMetadataOutput alloc] init];
    //设置代理 在主线程刷新
    [outpt setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    [_session addOutput:outpt];
    // 设置扫码支持的编码格式
    outpt.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
    _layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //设置相机扫描框的大小
    _layer.frame = CGRectMake(10, 170, 280, 200);

    [self.view.layer insertSublayer:_layer atIndex:0];
    //开始捕获
    [_session startRunning];

}


// 设置button的界面
-(UIButton *)initExitButton{
    _exitButton = [SSTCircleButton buttonWithType:UIButtonTypeCustom];
    _exitButton.borderAnimationDuration = 0.5f;
    [_exitButton setBorderHidden:!_exitButton.borderHidden animated:TRUE];
//    [_mainButton setImage:[self getImageFromBase64:NormalPic] forState:UIControlStateNormal];
//    [_mainButton setImage:[self getImageFromBase64:NormalPic] forState:UIControlStateSelected];
    [_exitButton setBackgroundColor:[UIColor blueColor]];
    [_exitButton setTitle:@"exit" forState:UIControlStateNormal];
    [_exitButton setSelected:NO];
    [_exitButton setFrame:CGRectMake(240, 10, 50, 50)];
    [_exitButton addTarget:self action:@selector(onClickExitButton) forControlEvents:UIControlEventTouchUpInside];
    return _exitButton;
}


-(void)onClickExitButton{
    [_session stopRunning];
    [_layer removeFromSuperlayer];
    _layer = nil;
    _session = nil;
    [_delegate onDestoryScanningWindow];
}


// 设置label界面
-(UILabel *)initPromptLabel{
    _promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 400, 250, 200)];
    _promptLabel.text = @"请登录年糕后台扫描专属于你的二维码， 来解锁此设备上的功能";
    _promptLabel.numberOfLines = 2;
    [_promptLabel sizeToFit];
    return _promptLabel;

}

// 设置图片image
-(UIImageView *)initIcon{
    //1：UIImageView自己独有的初始化方法
//    NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.jpg",NSHomeDirectory(),@"test"];
    UIImage *imgFromUrl3=[[[UIImage alloc]initWithContentsOfFile:@"Library/PreferenceLoader/Preferences/Logo.png"] autorelease];
    _logoImageView = [[[UIImageView alloc] initWithImage:imgFromUrl3] autorelease];
    //2：这里imageView1的frame如果不设置，imageView1的frame就会默认为image1的frame，（在image1的frame小于屏幕的情况下），根据需要设置
    _logoImageView.frame = CGRectMake(50, 20, 200, 100);//设置frame属性，从UIView继承过来的属性
    //3：用户交互属性
    _logoImageView.userInteractionEnabled = YES;//，默认是NO，如果需要加手势要设置为YES

    return _logoImageView;
}
// 显示当前操作是否成功的Label
-(void)updateLabel:(NSString *)text{
    _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 110, 250, 40)];
    _stateLabel.text = text;
    _stateLabel.textAlignment = NSTextAlignmentCenter;
    _stateLabel.numberOfLines = 2;
    [_stateLabel sizeToFit];
    [self.view addSubview:_stateLabel];
}



@end