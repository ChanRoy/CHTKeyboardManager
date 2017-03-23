# CHTKeyboardManager
A tool to manager the changes of keyboard's frame on iOS devices

![CHTKeyboardManager](https://github.com/ChanRoy/CHTKeyboardManager/blob/master/CHTKeyboardManager.gif)

## Introduction

*A keyboard manager*

Reference: [KeyboardMan](https://github.com/nixzhu/KeyboardMan)

## Usage

Define a class `CHTKeyboardInfo` to save the infomation of keyboard animation.

```
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
```
You can use two block to make you changes on your views:

- SHOW:

```
//showIndex: the index that the keyboard show notification post
@property (nonatomic, copy) void (^animateWhenKeyboardShow)(NSInteger showIndex, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement);
```

- HIDE

```
@property (nonatomic, copy) void (^animateWhenKeyboardHide)(CGFloat keyboardHeight);
```

Also you can use this block to get all the infomation:

```
@property (nonatomic, copy) void (^postKeyboardInfo)(CHTKeyboardManager *keyboardManager, CHTKeyboardInfo *keyboardInfo);
```

## Example

1.declear

```
_keyboardManager = [[CHTKeyboardManager alloc]init];
__weak typeof(self) weakSelf = self;

```

2.define show block:

```
    _keyboardManager.animateWhenKeyboardShow = ^(NSInteger appearPostIndex, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement) {
        
        
        NSLog(@"Show --> appearPostIndex: %ld, keyboardHeight: %.2f, keyboardHeightIncrement: %.2f",appearPostIndex, keyboardHeight, keyboardHeightIncrement);
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.nameBottomConstraint.constant += keyboardHeightIncrement;
        strongSelf.passwordBottomConstraint.constant += keyboardHeightIncrement;
        
    };
```

3.define hide block:

```
_keyboardManager.animateWhenKeyboardHide = ^(CGFloat keyboardHeight) {
        
        NSLog(@"hide -->keyboardHeight: %.2f",keyboardHeight);
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.nameBottomConstraint.constant -= keyboardHeight;
        strongSelf.passwordBottomConstraint.constant -= keyboardHeight;
    };
```

4.define info block if you need:

```
_keyboardManager.postKeyboardInfo = ^(CHTKeyboardManager *keyboardManager, CHTKeyboardInfo *keyboardInfo) {
        
        NSLog(@"info -->keyboardHeight: %.2f",keyboardInfo.height);
    };

```

More detail see the `CHTKeyboardManagerDemo` project.

## Reference

#### [KeyboardMan](https://github.com/nixzhu/KeyboardMan) 

A Tool base on Swift.


