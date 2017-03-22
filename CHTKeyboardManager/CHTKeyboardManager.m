//
//  CHTKeyboardManager.m
//  CHTKeyboardManager
//
//  Created by cht on 2017/3/22.
//  Copyright © 2017年 cht. All rights reserved.
//

#import "CHTKeyboardManager.h"



@implementation CHTKeyboardInfo

- (CGFloat)height{
    
    return self.endFrame.size.height;
}

@end

#pragma mark - keyboard manager
@interface CHTKeyboardManager ()

@property (nonatomic, strong) CHTKeyboardInfo *keyboardInfo;

@property (nonatomic, assign) BOOL isObserverEnable;

@property (nonatomic, assign) NSInteger appearPostIndex;

@end

@implementation CHTKeyboardManager

- (void)dealloc{
    
    NSLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addObservers{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)handleKeyboardInfoWithNoti:(NSNotification *)noti isShow:(BOOL)isShow{
    
    NSDictionary *userInfo = noti.userInfo;
    
    NSTimeInterval animationDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    uint animationCurve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat currentHeight = endFrame.size.height;
    CGFloat previousHeight = _keyboardInfo? _keyboardInfo.height: 0;
    CGFloat heightIncrement = currentHeight - previousHeight;
    
    BOOL isSameAction = NO;
    if (_keyboardInfo) {
        
        isSameAction = (_keyboardInfo.isShow == isShow);
    }
    
    CHTKeyboardInfo *keyboardInfo = [[CHTKeyboardInfo alloc]init];
    keyboardInfo.animationDuration = animationDuration;
    keyboardInfo.animationCurve = animationCurve;
    keyboardInfo.beginFrame = beginFrame;
    keyboardInfo.endFrame = endFrame;
    keyboardInfo.heightIncrement = heightIncrement;
    keyboardInfo.isShow = isShow;
    keyboardInfo.isSameAction = isSameAction;
    self.keyboardInfo = keyboardInfo;
}

- (void)setKeyboardInfo:(CHTKeyboardInfo *)keyboardInfo{
    
    if (!keyboardInfo.isSameAction || keyboardInfo.heightIncrement != 0) {
        
        NSTimeInterval duration = keyboardInfo.animationDuration;
        uint curve = keyboardInfo.animationCurve;
        
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve << 16 animations:^{
            
            if (keyboardInfo.isShow) {
                
                if (self.animateWhenKeyboardAppear) {
                    
                    self.animateWhenKeyboardAppear(self.appearPostIndex, keyboardInfo.height, keyboardInfo.heightIncrement);
                }
                self.appearPostIndex += 1;
                
            }else{
                
                if (self.animateWhenKeyboardHide) {
                    
                    self.animateWhenKeyboardHide(keyboardInfo.height);
                }
                self.appearPostIndex = 0;
            }
            
        } completion:NULL];
        
        if (_postKeyboardInfo) {
            
            _postKeyboardInfo(self, keyboardInfo);
        }
    }
    _keyboardInfo = keyboardInfo;
}

#pragma mark - observer
- (void)keyboardWillShow:(NSNotification *)noti{
    
    NSLog(@"%s",__func__);
    [self handleKeyboardInfoWithNoti:noti isShow:YES];
}

- (void)keyboardWillChangeFrame:(NSNotification *)noti{
    
    NSLog(@"%s",__func__);
    [self handleKeyboardInfoWithNoti:noti isShow:YES];
}

- (void)keyboardWillHide:(NSNotification *)noti{
    NSLog(@"%s",__func__);
    [self handleKeyboardInfoWithNoti:noti isShow:NO];
}

- (void)keyboardDidHide:(NSNotification *)noti{
    NSLog(@"%s",__func__);
    _keyboardInfo = nil;
}

#pragma mark - setters

- (void)setIsObserverEnable:(BOOL)isObserverEnable{
    
    if (_isObserverEnable != isObserverEnable && isObserverEnable) {
        
        _isObserverEnable = isObserverEnable;
        [self addObservers];
    }
}

- (void)setAnimateWhenKeyboardAppear:(void (^)(NSInteger, CGFloat, CGFloat))animateWhenKeyboardAppear{
    
    _animateWhenKeyboardAppear = [animateWhenKeyboardAppear copy];
    
    self.isObserverEnable = YES;
}

- (void)setAnimateWhenKeyboardHide:(void (^)(CGFloat))animateWhenKeyboardHide{
    
    _animateWhenKeyboardHide = [animateWhenKeyboardHide copy];
    
    self.isObserverEnable = YES;
}

- (void)setPostKeyboardInfo:(void (^)(CHTKeyboardManager *, CHTKeyboardInfo *))postKeyboardInfo{
    
    _postKeyboardInfo = [postKeyboardInfo copy];
    
    self.isObserverEnable = YES;
}

@end


