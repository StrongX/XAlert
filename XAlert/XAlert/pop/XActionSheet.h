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
-(void)buttonClick:(NSInteger)index;

@end
@interface XActionSheet : UIView

- (id)initWithTitleAndDesc:(NSString *)Title Desc:(NSString *)Desc;
- (void)addCancelButtonWithTitle:(NSString *)Title;
- (void)addButtonwithTitle:(NSString *)Title;
- (void)show;
- (void)showInAnimate;
- (void)close;
- (void)closeInAnimate;

@property (nonatomic, strong) UILabel *Title;
@property (nonatomic, strong) UILabel *Desc;
@property (nonatomic, strong) UIButton *CancelButton;
@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, assign) id<XActionSheetDelegate>delegate;
@end
