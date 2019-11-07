//
//  ZCLoginViewController.m
//  i84zcc
//
//  Created by 小二 on 2019/9/3.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "ZCLoginViewController.h"
#import "ZCLoginContentView.h"

#import "ZCLoginModel.h"
#import "ZCLoginTool.h"

@interface ZCLoginViewController ()<ZCLoginContentViewDelegate>
@property (nonatomic, strong) ZCLoginContentView *contentView;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;

@end

@implementation ZCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"Log In", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

- (void)createUI {
    [self.view addSubview:self.contentView];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - ZCLoginContentViewDelegate
- (void)contentView:(ZCLoginContentView *)view didChangeAccount:(NSString *)accountStr {
    self.account = accountStr;
}

- (void)contentView:(ZCLoginContentView *)view didChangePassword:(NSString *)passwordStr {
    self.password = passwordStr;
}

- (void)contentView:(ZCLoginContentView *)view didSelectLoginBtn:(UIButton *)sender {
    [ZCLoginTool loginAppWithAccount:_account password:_password success:^(id responseObject)  {
        NSInteger responseCode = [responseObject[@"_code"] integerValue];
        if (responseCode == 99999) {
            [MBProgressHUD xe_showSuccess:NSLocalizedString(@"Log In succeeded", nil)];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } error:^(NSError *error) {
    }];
}

#pragma mark - getter/setter
- (ZCLoginContentView *)contentView {
    if (!_contentView) {
        _contentView = [[ZCLoginContentView alloc] init];
        _contentView.delegate = self;
    }
    return _contentView;
}

@end
