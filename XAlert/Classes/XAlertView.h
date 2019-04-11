//
//  XAlertView.h
//  test
//
//  Created by xlx on 15/8/31.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import <UIKit/UIKit.h>

#define green_Color [UIColor colorWithRed:102.0/255.0 green:195.0/255.0 blue:165.0/255.0 alpha:1.0f]



@interface XAlertView : UIView

-(id)initWithTitleAndDesc:(NSString *)Title Desc:(NSString *)Desc;

-(void)addButtonWithTitle:(NSString *)title handler:(void(^)(void))handler;

-(void)setContainRect:(CGRect)rect;

-(void)showAnimation1;

-(void)showAnimation2;

@property (nonatomic, strong) UILabel *TitleLabel;
@property (nonatomic, strong) UILabel *DescLabel;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic,       ) CGFloat containViewHeight;


@end
