//
//  XActionSheet.h
//  Demo2
//
//  Created by xlx on 15/7/29.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XActionSheet;
@protocol XActionSheetDelegate <NSObject>
@optional
-(void)actionSheet:(XActionSheet *)actionSheet buttonClick:(NSInteger)index;

@end
@interface XActionSheet : UIView

- (id)initWithTitleAndDesc:(NSString *)Title Desc:(NSString *)Desc;
- (void)addCancelButtonWithTitle:(NSString *)Title;
- (void)addButtonwithTitle:(NSString *)Title;
- (void)show;
- (void)showInAnimate;
- (void)close;
- (void)closeInAnimate;

/**
 *  设置取消按钮的背景颜色
 *
 *  @param color 颜色值
 */
- (void)setCancelButtonBackgroundColor:(UIColor *)color;

/**
 *  设置某个按钮的背景颜色
 *
 *  @param index 按钮的index
 *  @param color 颜色
 */
- (void)setButton:(NSUInteger) index backgroundColor:(UIColor *)color;

/**
 *  设置所有按钮的背景颜色
 *
 *  @param color 颜色
 */
- (void)setAllButtonsBackgroundColor:(UIColor *)color;

/**
 *  设置标题背景颜色
 *
 *  @param color 颜色
 */
- (void)setTitleBackgroundColor:(UIColor *)color;

@property (nonatomic, strong) UILabel *Title;
@property (nonatomic, strong) UILabel *Desc;
@property (nonatomic, strong) UIButton *CancelButton;
@property (nonatomic, strong) NSMutableArray<UIButton *> *btnArray;

@property (nonatomic, assign) id<XActionSheetDelegate>delegate;
@end
