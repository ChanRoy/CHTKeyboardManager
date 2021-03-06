//
//  CHTKeyboardManager.h
//  CHTKeyboardManager
//
//  Created by cht on 2017/3/22.
//  Copyright © 2017年 cht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 store the userInfo of keyboard notification
 */
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

/**
 manager keyboard behaviour
 */
@interface CHTKeyboardManager : NSObject

//showIndex: the index that the keyboard show notification post
@property (nonatomic, copy) void (^animateWhenKeyboardShow)(NSInteger showIndex, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement);

@property (nonatomic, copy) void (^animateWhenKeyboardHide)(CGFloat keyboardHeight);

@property (nonatomic, copy) void (^postKeyboardInfo)(CHTKeyboardManager *keyboardManager, CHTKeyboardInfo *keyboardInfo);

@end


