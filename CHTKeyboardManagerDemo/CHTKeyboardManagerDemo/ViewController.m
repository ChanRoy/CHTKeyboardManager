//
//  ViewController.m
//  CHTKeyboardManagerDemo
//
//  Created by cht on 2017/3/22.
//  Copyright © 2017年 cht. All rights reserved.
//

#import "ViewController.h"
#import "CHTKeyboardManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordBottomConstraint;

@property (nonatomic, strong) CHTKeyboardManager *keyboardManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _keyboardManager = [[CHTKeyboardManager alloc]init];
    
    __weak typeof(self) weakSelf = self;
    _keyboardManager.animateWhenKeyboardShow = ^(NSInteger appearPostIndex, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement) {
        
        
        NSLog(@"Show --> appearPostIndex: %ld, keyboardHeight: %.2f, keyboardHeightIncrement: %.2f",appearPostIndex, keyboardHeight, keyboardHeightIncrement);
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.nameBottomConstraint.constant += keyboardHeightIncrement;
        strongSelf.passwordBottomConstraint.constant += keyboardHeightIncrement;
        
    };
    
    _keyboardManager.animateWhenKeyboardHide = ^(CGFloat keyboardHeight) {
        
        NSLog(@"hide -->keyboardHeight: %.2f",keyboardHeight);
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.nameBottomConstraint.constant -= keyboardHeight;
        strongSelf.passwordBottomConstraint.constant -= keyboardHeight;
    };
    
    _keyboardManager.postKeyboardInfo = ^(CHTKeyboardManager *keyboardManager, CHTKeyboardInfo *keyboardInfo) {
        
        NSLog(@"info -->keyboardHeight: %.2f",keyboardInfo.height);
    };
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
