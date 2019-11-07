//
//  XESearchView.m
//  i84zcc
//
//  Created by 小二 on 2019/9/11.
//  Copyright © 2019年 小二. All rights reserved.
//

#import "XESearchView.h"

static const CGFloat cancelBtnWidth = 44.0;
static const NSTimeInterval kAnimateDuration = .25f;

@interface XESearchView ()<UITextFieldDelegate>
/** textField */
@property(nonatomic, strong) UITextField *textField;
/** 取消按钮 */
@property(nonatomic, strong) UIButton *cancelBtn;
/** 防止重复布局 */
@property(nonatomic, assign) BOOL isLayouted;
/** self的宽度 */
@property(nonatomic, assign) CGFloat selfWidth;

@end

@implementation XESearchView

- (instancetype)init {
    self = [super init];
    if(self) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self createUI];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                   name:UITextFieldTextDidChangeNotification
                                 object:nil];
}

- (void)createUI {
    [[NSNotificationCenter defaultCenter] addObserver:self
                            selector:@selector(textFieldDidChange:)
                                name:UITextFieldTextDidChangeNotification
                              object:nil];
    
    [self addSubview:self.cancelBtn];
    [self addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.height.centerY.equalTo(self);
        make.width.mas_equalTo(cancelBtnWidth);
    }];
}

- (void)layoutSubviews {
    if (_isLayouted) {
        return;
    }
    
    _textField.layer.cornerRadius = self.height/2;
    _textField.layer.masksToBounds = YES;
    _isLayouted = YES;
}

- (void)setShowsCancelButton:(BOOL)showsCancelButton {
    self.cancelBtn.hidden = YES;
}

- (NSString *)text {
    return self.textField.text;
}

- (void)setText:(NSString *)text {
    self.textField.text = text;
}

- (void)setPlaceholder:(NSString *)placeholder {
    self.textField.placeholder = placeholder;
}

- (NSString *)placeholder {
    return self.textField.placeholder;
}

#pragma mark - Public method
- (void)xe_becomeFirstResponder {
    [self.textField becomeFirstResponder];
}
- (void)xe_resignFirstResponder {
    [self.textField resignFirstResponder];
}

#pragma mark - Private method
- (void)setCancelBtnShow:(BOOL)isShow {
    if (self.cancelBtn.isHidden) {
        return;
    }
    
    CGFloat textFieldW = 0;
    if (isShow) {
        // 显示
        textFieldW = self.width - cancelBtnWidth;
    } else {
        //隐藏
        textFieldW = self.width;
    }
    CGRect rect = self.textField.frame;
    rect.size.width = textFieldW;
    
    [UIView animateWithDuration:kAnimateDuration animations:^{
        self.textField.width = textFieldW;
    }];
}

#pragma mark - Action
- (void)cancelAction:(UIButton *)btn {
    [self setCancelBtnShow:NO];
    
    [self.textField endEditing:YES];
    if ([self isDelegateExist:@selector(xe_searchViewCancelButtonClicked:)]) {
        [self.delegate xe_searchViewCancelButtonClicked:self];
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self xe_becomeFirstResponder];
    [self setCancelBtnShow:YES];
    if ([self isDelegateExist:@selector(xe_searchViewTextDidBeginEditing:)]) {
        [self.delegate xe_searchViewTextDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self xe_resignFirstResponder];
    [self setCancelBtnShow:NO];
    if ([self isDelegateExist:@selector(xe_searchViewTextDidEndEditing:)]) {
        [self.delegate xe_searchViewTextDidEndEditing:self];
    }
}

- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *textField = (UITextField *)[notification object];
    if (textField != self.textField) {
        return;
    }
    if ([self isDelegateExist:@selector(xe_searchView:textDidChange:)]) {
        [self.delegate xe_searchView:self textDidChange:textField.text];
    }
}

- (BOOL)isDelegateExist:(SEL)action {
    return (self.delegate && [self.delegate respondsToSelector:action]);
}

#pragma mark - getter/setter
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.tintColor = kMainColor;
        _textField.delegate = self;
        
        UIView *leftView = [UIView new];
        leftView.frame = CGRectMake(0, 0, 30, 33);
        leftView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *searchImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rollcall_search"]];
        searchImgView.frame = CGRectMake(10, 10, 14, 14);
        [leftView addSubview:searchImgView];
        
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.leftView = leftView;
    }
    return _textField;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _cancelBtn;
}


@end
