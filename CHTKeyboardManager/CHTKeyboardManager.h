//
//  CHTKeyboardManager.h
//  CHTKeyboardManager
//
//  Created by cht on 2017/3/22.
//  Copyright © 2017年 cht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CHTKeyboardInfo : NSObject

@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, assign) uint animationCurve;

@property (nonatomic, assign) CGRect beginFrame;

@property (nonatomic, assign) CGRect endFrame;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat heightIncrement;

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, assign) BOOL isSameAction;

@end

@interface CHTKeyboardManager : NSObject

@property (nonatomic, copy) void (^animateWhenKeyboardAppear)(NSInteger appearPostIndex, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement);

@property (nonatomic, copy) void (^animateWhenKeyboardHide)(CGFloat keyboardHeight);

@property (nonatomic, copy) void (^postKeyboardInfo)(CHTKeyboardManager *keyboardManager, CHTKeyboardInfo *keyboardInfo);

@end


