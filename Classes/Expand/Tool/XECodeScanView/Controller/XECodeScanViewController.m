//
//  XECodeScanViewController.m
//  i84cpn
//
//  Created by 小二 on 2018/11/1.
//  Copyright © 2018年 5i84. All rights reserved.
//

#import "XECodeScanViewController.h"
#import "XECodeScanView.h"

@interface XECodeScanViewController ()
///扫码View
@property (nonatomic, strong) XECodeScanView *codeScanView;

@end

@implementation XECodeScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Sweep", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

- (void)createUI {
    [self.view addSubview:self.codeScanView];
}

#pragma mark - getter/setter
- (XECodeScanView *)codeScanView {
    if (!_codeScanView) {
        _codeScanView = [[XECodeScanView alloc] init];
        Weak_Self;
        _codeScanView.block = ^(NSString *urlStr) {
            Strong_Self;
            if (sSelf.block) {
                sSelf.block(urlStr);
            }
            [sSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _codeScanView;
}

@end
