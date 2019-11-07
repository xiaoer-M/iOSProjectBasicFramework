//
//  XECodeScanView.m
//  i84cpn
//
//  Created by 小二 on 2018/11/1.
//  Copyright © 2018年 5i84. All rights reserved.
//

#import "XECodeScanView.h"
#import <AVFoundation/AVFoundation.h>

@interface XECodeScanView ()<AVCaptureMetadataOutputObjectsDelegate>
///扫描框
@property (nonatomic, strong) UIImageView *scanBorderView;
///扫描线
@property (nonatomic, strong) UIImageView *scanLine;
///设备输入输出
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureInput *inputDevice;
@property (nonatomic, strong) AVCaptureMetadataOutput *ouput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@end

@implementation XECodeScanView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.scanBorderView];
    [self addSubview:self.scanLine];
    
    [self.scanBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(AdapterHeight(130));
        make.left.equalTo(self).offset(AdapterWidth(65));
        make.right.equalTo(self).offset(-AdapterWidth(65));
        make.height.mas_equalTo(AdapterHeight(220));
    }];
    
    [self.scanLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.scanBorderView);
        make.height.equalTo(@17);
    }];
    
    [self scanQRCode];
}

// 二维码扫码
- (void)scanQRCode {
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];

    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //    _device = [self cameraWithPosition:AVCaptureDevicePositionFront];
    _inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    _ouput = [[AVCaptureMetadataOutput alloc] init];
    [_ouput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    if ([_session canAddInput:_inputDevice]) [_session addInput:_inputDevice];

    if ([_session canAddOutput:_ouput])  [_session addOutput:_ouput];

    _ouput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];

    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.bounds;//SCREEN_BOUNDS;

    [self.layer insertSublayer:_previewLayer atIndex:0];
    [_session startRunning];

    [self startAnimated];
}

// 扫码动画
- (void)startAnimated {
    [_scanLine.layer removeAllAnimations];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.values = @[@(AdapterHeight(130)), @(AdapterHeight(350))];
    animation.duration = 1;
    [_scanLine.layer addAnimation:animation forKey:nil];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
// 扫码结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue = @"";
    if ([metadataObjects count] > 0){
        //停止扫描
        [_session stopRunning];
        [_scanLine.layer removeAllAnimations];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        if (self.block) {
            self.block(stringValue);
        }
    }
}

#pragma mark - getter/setter
- (UIImageView *)scanBorderView {
    if (!_scanBorderView) {
        _scanBorderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanCode"]];
    }
    return _scanBorderView;
}

- (UIImageView *)scanLine {
    if (!_scanLine) {
        _scanLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanLine"]];
    }
    return _scanLine;
}

@end
