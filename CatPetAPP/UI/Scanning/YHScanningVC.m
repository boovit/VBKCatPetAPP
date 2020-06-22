//
//  YHScanningVC.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/8.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "YHScanningVC.h"
#import <AVFoundation/AVFoundation.h>

#import "NSString+URL.h"
#import "YHChannelUtilTools.h"
#import "YHProjectMacro.h"

@interface YHScanningVC ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (strong,nonatomic)UIView *scanRegion;
@end

@implementation YHScanningVC
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScanView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startScanning];
}

-(void)initNavigationBar
{
    [super initNavigationBar];
    [self setNavBarTitle:@"扫描"];
}

#pragma mark - private
-(void)createScanView
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,
                                   AVMetadataObjectTypeEAN13Code,
                                   AVMetadataObjectTypeEAN8Code,
                                   AVMetadataObjectTypeUPCECode,
                                   AVMetadataObjectTypeCode39Code,
                                   AVMetadataObjectTypeCode39Mod43Code,
                                   AVMetadataObjectTypeCode93Code,
                                   AVMetadataObjectTypeCode128Code,
                                   AVMetadataObjectTypePDF417Code
                                   ];
    
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer addSublayer:_preview];
    CGRect rect = CGRectMake((YHScreen_width-220)/2,(YHScreen_height-220)/2,220,220);
    [_session startRunning];
    _output.rectOfInterest = [_preview metadataOutputRectOfInterestForRect:rect];
    //必须在startRunning之后调metadataOutputRectOfInterestForRect
    
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YHScreen_width, YHScreen_height)];
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.view addSubview:maskView];
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, YHScreen_width, YHScreen_height)];
    [rectPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake((YHScreen_width-220)/2,(YHScreen_height-220)/2, 220, 220) cornerRadius:1] bezierPathByReversingPath]];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = rectPath.CGPath;
    maskView.layer.mask = shapeLayer;
    
    self.scanRegion = [[UIView alloc] init];
    _scanRegion.layer.borderWidth = 1.0;
    _scanRegion.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:_scanRegion];
    [_scanRegion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(@(220));
    }];
}

-(void)startScanning
{
    if(_session && !_session.running){
        [_session startRunning];
    }
    _scanRegion.layer.borderColor = [UIColor redColor].CGColor;
}

#pragma mark - delegate
- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0){
        //停止扫描
        [_session stopRunning];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        NSDictionary * param = [stringValue urlParams];
        NSString *petID = [param objectForKey:@"id"];
        if ([stringValue hasPrefix:YHCatPetScheme] && __isStrNotEmpty(petID)) {
            _scanRegion.layer.borderColor = [UIColor greenColor].CGColor;
            [YHChannelUtilTools pushPetInfoVC:petID.integerValue navigation:self.navigationController];
        }else{
            _scanRegion.layer.borderColor = [UIColor redColor].CGColor;
            [YHShareUtil showToast:@"喵宠不认识噢!"];
            [_session startRunning];
        }
    }
}

@end
