//
//  ZCLoginContentView.m
//  i84zcc
//
//  Created by 小二 on 2019/9/5.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "ZCLoginContentView.h"

static const CGFloat textFiledHeight = 40;
static const CGFloat loginBtnHeight = 44;

@interface ZCLoginContentView()
@property (nonatomic, strong) UIImageView *logoImgView;
@property (nonatomic, strong) UITextField *accountTF;
@property (nonatomic, strong) UITextField *passwordTF;
@property (nonatomic, strong) UIButton *loginBtn;

@end

@implementation ZCLoginContentView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.logoImgView];
    [self addSubview:self.accountTF];
    [self addSubview:self.passwordTF];
    [self addSubview:self.loginBtn];
    
    [self.logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(50);
        make.centerX.equalTo(self);
    }];
    
    [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImgView.mas_bottom).offset(50);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - (15*2), textFiledHeight));
    }];
    
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountTF.mas_bottom).offset(15);
        make.centerX.equalTo(self);
        make.size.equalTo(self.accountTF);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTF.mas_bottom).offset(30);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(loginBtnHeight);
        make.width.equalTo(self.passwordTF);
    }];
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField == _accountTF) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(contentView:didChangeAccount:)]) {
            [self.delegate contentView:self didChangeAccount:textField.text];
        }
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(contentView:didChangePassword:)]) {
            [self.delegate contentView:self didChangePassword:textField.text];
        }
    }
}

- (void)switchTouched:(UISwitch *)sw {
    _passwordTF.secureTextEntry = sw.isOn;
}

#pragma mark - getter/setter
- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    }
    return _logoImgView;
}

- (UITextField *)accountTF {
    if (!_accountTF) {
        _accountTF = [[UITextField alloc]init];
        _accountTF.backgroundColor = kvcBackgroundColor;
        // iOS13以后KVC设置方式会崩溃
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Please enter a user name", nil)
                                                                         attributes:@{NSForegroundColorAttributeName:kGrayColor,
                                                                                      NSFontAttributeName:kFont(14)}];
        _accountTF.attributedPlaceholder = attrString;
        _accountTF.clearButtonMode = YES;
        _accountTF.returnKeyType = UIReturnKeyNext;
        _accountTF.tintColor = kMainColor;
        [_accountTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        // 添加左侧视图
        _accountTF.leftViewMode = UITextFieldViewModeAlways;
        _accountTF.leftView = [self createTextFieldLeftViewWithImageName:@"login_account"];
    }
    return _accountTF;
}

- (UITextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.backgroundColor = kvcBackgroundColor;
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Please enter a password", nil)
                                                                         attributes:@{NSForegroundColorAttributeName:kGrayColor,
                                                                                      NSFontAttributeName:kFont(14)}];
        _passwordTF.attributedPlaceholder = attrString;
        _passwordTF.returnKeyType = UIReturnKeyDone;
        _passwordTF.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTF.secureTextEntry = YES;
        _passwordTF.tintColor = kMainColor;
        [_passwordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        // 添加左侧视图
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
        _passwordTF.leftView = [self createTextFieldLeftViewWithImageName:@"login_password"];
        
        // 添加右侧视图
        UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(0, 4.5, 46, 28)];
        switchBtn.on = YES;
        switchBtn.onTintColor = kMainColor;
        [switchBtn addTarget:self action:@selector(switchTouched:) forControlEvents:UIControlEventValueChanged];
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 56, textFiledHeight)];
        [rightView addSubview:switchBtn];
        
        _passwordTF.rightViewMode = UITextFieldViewModeAlways;
        _passwordTF.rightView = rightView;
    }
    return _passwordTF;
}

- (UIView *)createTextFieldLeftViewWithImageName:(NSString *)imageName {
    UIImageView * leftImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    leftImgView.frame = CGRectMake(10, 13, 14, 14);
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, textFiledHeight, textFiledHeight)];
    [leftView addSubview:leftImgView];
    return leftView;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton createButtonWithTitle:NSLocalizedString(@"Log In", nil) titleColor:[UIColor whiteColor] textFont:kBoldFont(18) backgroundColor:kMainColor target:^(UIButton * _Nonnull sender) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(contentView:didSelectLoginBtn:)]) {
                [self.delegate contentView:self didSelectLoginBtn:sender];
            }
        }];
        
        _loginBtn.layer.cornerRadius = loginBtnHeight/2;
        _loginBtn.layer.masksToBounds = YES;
    }
    return _loginBtn;
}

@end
