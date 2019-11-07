//
//  AdverDetailViewController.m
//  ELaw
//
//  Created by 伪装者 on 2018/7/21.
//  Copyright © 2018年 xe. All rights reserved.
//

#import "AdverDetailViewController.h"

@interface AdverDetailViewController ()<UIWebViewDelegate>
///webView加载html
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation AdverDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    [self createUI];
}

- (void)createUI {
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kStatusBarAndNavigationBarHeight);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    if (!self.adUrl) {
        self.adUrl = @"http://www.baidu.com";
    }
    NSString *encodedString = [self.adUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:encodedString]]];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD xe_showMessage:@""];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD xe_hideHUD];
    
    //下面这两行是去掉不必要的webview效果的(选中,放大镜)
    [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD xe_hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

#pragma mark - getter/setter
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.scalesPageToFit = NO;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}

@end
